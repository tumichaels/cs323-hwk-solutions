$(document).ready(function(){
  // Hide protected roles
  $('#addUsers').live('click', function(){
    $("#role_id option[value='10']").remove(); // Shopper
    $("#role_id option[value='11']").remove(); // Auditor
    $("#role_id option[value='3']").remove(); // Student
    $("#role_id option[value='4']").remove(); // Teacher
    $("#role_id option[value='9']").remove(); // Instructor
  });
  // --------------------------------------------
  // change the text in the Syllabus tool
  if($('body').is('.syllabus')){
    var newSyllabusDetails = '<p>Please click the \'Edit\' link at the top of this page and publish your course site for your syllabus to become available via Yale\'s <a href=\"https://students.yale.edu/ocs/\">Online Course Selection</a> (OSC) and <a href=\"https://courses.yale.edu/\">Yale Course Search</a>. <strong>Please Note:</strong> it may take up to two (2) hours for your syllabus to appear in these systems.</p><p>Please visit our Canvas @ Yale documentation to find out more about <a href=\"http://help.canvas.yale.edu/m/55452/l/649314-how-do-i-post-my-syllabus-in-canvas\">posting your syllabus</a> and <a href=\"http://help.canvas.yale.edu/m/55452/l/649335-how-do-i-publish-unpublish-my-canvas-course\">publishing your course</a>. For additional support, please email <a href=\"mailto:canvas@yale.edu\">canvas@yale.edu</a>.</p>';
    var oldSyllabusDetails = document.getElementById('course_syllabus_details');
    oldSyllabusDetails.innerHTML = newSyllabusDetails;
  }
});