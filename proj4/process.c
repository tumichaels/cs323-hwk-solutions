//
// Spec / setup questions here:
//
// 1. i am supposed to include process.h right?
// 2. what exactl does main.c do again?
//
// 3. how do I actually run a unix command?


// spec notes here:
//
// 1. someone has written a parser for me, according to rules in spec
// 2. based off of those rules, I need to implement a whole bunch of
//    shell functions
//
// By doing DUMP_TREE=1 ./Bash, you can enter testing mode where the cmd
// tree is dumped before doing anything
//
// you can also set DUMP_TREE_AGAIN for more information after
// processing the cmd
//
//
// okay so I need to understand the strutcture of the cmdlist struct
// 1. basic level is simple
//	simples are literal commands, like "cd directory_name"
//	the one wrinkle to simples is that they include redirects
//	    redirects are things like: "fake_command >> file_name"
//	this means I am first going to figure out simple shell commands
//	then I will also need to figure out redirects

// functions with errors to handle:
//	chdir(), 
//	execvp(),   +
//	fork(), 
//	open(),	    +
//	pipe(), 
//	getcwd(), 
//	getwd()

#include "parse.h"
#include "process.h"

// TODO: cd, pushd, popd need to be done
//	 note that my current error handling breaks these!
// TODO: fix parent logic???
int process_simple(const CMD *cmdList){
	pid_t pid;
	int child_status;
	
	pid = fork();
	if (pid == 0) {
		if (cmdList->fromType == RED_IN){
			int new_stdin_fd = open(cmdList->fromFile, O_RDONLY);
			if (new_stdin_fd == -1) {
				int err = errno;
				perror(cmdList->argv[0]);
				exit(err);
			}
			close(STDIN_FILENO);
			dup2(new_stdin_fd, STDIN_FILENO);
			// closing the file to be safe, unnecessary?
			close(new_stdin_fd); 
		} 
		else if (cmdList->fromType == RED_IN_HERE){
			// in this case the input is in the buffer cmdList->fromFile
			char fileName[7+6+1];
			strcpy(fileName, "mytemp-XXXXXX");
			int new_stdin_fd = mkstemp(fileName);

			// write contents of cmdList->fromFile to tmp file
			int len = strlen(cmdList->fromFile);
			write(new_stdin_fd, cmdList->fromFile, len);
			lseek(new_stdin_fd, 0L, SEEK_SET); // rewind to start of file

			// do file descriptor magic
			close(STDIN_FILENO);
			dup2(new_stdin_fd, STDIN_FILENO);
			close(new_stdin_fd);
			unlink(fileName);
		} 

		if (cmdList->toType == RED_OUT) {
			// mode could also just be set to 0744
			int new_stdout_fd = open(cmdList->toFile, O_CREAT | O_WRONLY | O_TRUNC, S_IRWXU | S_IRGRP | S_IROTH);
			if (new_stdout_fd == -1) {
				int err = errno;
				perror(cmdList->argv[0]);
				exit(err);
			}
			close(STDOUT_FILENO);
			dup2(new_stdout_fd, STDOUT_FILENO);
			close(new_stdout_fd);
		} 
		else if (cmdList->toType == RED_OUT_APP) {
			int new_stdout_fd = open(cmdList->toFile, O_CREAT | O_WRONLY | O_APPEND, S_IRWXU | S_IRGRP | S_IROTH);
			if (new_stdout_fd == -1) {
				int err = errno;
				perror(cmdList->argv[0]);
				exit(err);
			}
			close(STDOUT_FILENO);
			dup2(new_stdout_fd, STDOUT_FILENO);
			close(new_stdout_fd);
		}

		// don't need to support redir of standard error
		// else if (cmdList->toType == RED_ERR) {
		// }
		// else if (cmdList->toType == RED_ERR_APP) {
		// }

		// set local variables
		for (int i = 0; i < cmdList->nLocal; i++) {
			setenv(cmdList->locVar[i], cmdList->locVal[i], 1);
		}

		execvp(cmdList->argv[0], cmdList->argv);
		int err = errno;
		perror(cmdList->argv[0]);
		exit(err);
	}
	else {
		// update wait logic 
		// you need the status of the kids somehow
		waitpid(pid, &child_status, 0);
		child_status = STATUS(child_status);

		int length = snprintf(NULL, 0,"%d", child_status);
		char stat[length + 1];
		sprintf(stat, "%d", child_status);
		setenv("?", stat, 1); 
	}
	return child_status;
}

int process_pipe(const CMD *cmdList) {
	// the idea is essentially to create a pipe, then call fork
	int p[2], leftpid, rightpid;
	int f_status = 0;
	pipe(p);

	// for now, I'm assuming everything in a pipe is just a simple 
	
	// will need to change exit after things

	// left tree will always exist
	// could be a simple or a subcmd
	if ((leftpid = fork()) == 0) {
		dup2(p[1], STDOUT_FILENO);
		// child doesn't need additional access to pipe
		// dup2 means it thinks that the pipe is stdout!
		close(p[0]);
		close(p[1]);
		
		int s = process(cmdList->left);
		exit(s);
		// you need this exit call so things don't overlap from fork
	}
	else if ((rightpid = fork()) == 0) {
		//TODO: check right node exists
		// note the AST leans left, as in the rightside
		// of a pipe is always writing to stdout
	
		dup2(p[0], STDIN_FILENO);
		close(p[0]);
		close(p[1]);
			
		int s = process(cmdList->right);
		exit(s);
	}
	else {
		// parent of both left and right
		// never uses pipe, but still has references
		close(p[0]);
		close(p[1]);

		int l_status, r_status;
		waitpid(leftpid, &l_status, 0);
		l_status = STATUS(l_status);
		waitpid(rightpid, &r_status, 0);
		r_status = STATUS(r_status);

		if (l_status)
			f_status = l_status;
		if (r_status)
			f_status = r_status;
		if (f_status) {
			int length = snprintf(NULL, 0,"%d", f_status);
			char stat[length + 1];
			sprintf(stat, "%d", f_status);
			setenv("?", stat, 1); 
		} else 
			setenv("?", "0", 1);
	}

	return f_status;
}

// not returning raw status value, but the complete one

int process(const CMD *cmdList) {
	int out = 0;
	switch (cmdList->type) {

		case SIMPLE:
			out = process_simple(cmdList);
			break;

		case PIPE:
			out = process_pipe(cmdList);
			break;

		case SEP_AND:
			out = process(cmdList->left);
			if (out == 0)
				out = process(cmdList->right);
			break;

		case SEP_OR:
			out = process(cmdList->left);
			if (out != 0)
				out = process(cmdList->right);
			break;

		// this needs to be looked at
		case SEP_END:
			out = process(cmdList->left);
			if (cmdList->right)
				out = process(cmdList->right);
			break;

		default:
			break;
	}
	return out;
}
