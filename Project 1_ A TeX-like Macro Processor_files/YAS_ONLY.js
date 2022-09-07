$().ready(function() {
	var button = undefined;
	
	var doWork = function() {
		//button.hide();
	
		var domain = window.location.hostname;
		var isRootAccountAdmin = false;
		var userID = Number(ENV.current_user_id);
		if (ENV.current_user_roles.indexOf("admin") !== -1 ) {
			var listAcctAdminsURL = "https://" + domain + ":443/api/v1/accounts/1/admins?user_id[]=" + userID;

			var getListAcctAdmins = $.getJSON( listAcctAdminsURL, function( data ) {
					$.each(data, function(i,user){
						if(user.role === "AccountAdmin" || user.role === "SubAccount Admin"){
							isRootAccountAdmin = true;
						}
					});
				
					if (isRootAccountAdmin === true) {
						button.show();
					}
				});
			}	
	}
	
	var findButton = function() {
		setTimeout(function() {
			button = $('[aria-label="Create new course"]');
			if (!button || !button.length) {
				findButton();
			}
			else {
				doWork();
			}
		}, 100);	
	}
	
	findButton();
});