if (
  ENV.current_user_roles.indexOf("admin") < 1 ||
  ENV.current_user_roles.indexOf("teacher") < 1
) {
  $(document).ready(function() {
    $(".Grader").hide();
    $('[aria-label="Graders"]').hide();
  });
}

var element = document.getElementById("add_people_modal");
var in_dom = document.body.contains(element);
var observer = new MutationObserver(function(mutations) {
  if (document.body.contains(element)) {
    in_dom = true;
  } else if (in_dom) {
    in_dom = false;
  }
});
observer.observe(document.body, { childList: true });

$(document).ready(function() {
  // TOA confirmation
  $(".button_box.ic-Login-confirmation__actions").before(
    '<a href="http://canvas.yale.edu/canvas-terms-use-faq" target="_blank">Questions about the Terms of use?</a>'
  );

  // Hide settings for Librarian, Grader, and ULA roles
  targetedRoles = ["Grader", "Librarian", "ULA"];
  var runOnce = false;
  var runHideAccessToken = false;
  var domain = window.location.hostname;
  var courseUnlockDomain =
    "https://l7cu833b48.execute-api.us-east-1.amazonaws.com/PROD";
  var courseID = Number(ENV.COURSE_ID);
  var userID = Number(ENV.current_user_id);
  var jsonURL =
    "https://" +
    domain +
    ":443/api/v1/courses/" +
    courseID +
    "/enrollments?user_id=" +
    userID;
  var allowAccessTokenURL =
    "https://" +
    domain +
    ":443/api/v1/users/" +
    userID +
    "/custom_data/admin?ns=edu.yale.canvas";
  var listAcctAdminsURL =
    "https://" + domain + ":443/api/v1/accounts/1/admins?user_id[]=" + userID;
  var userRoles = [];
  var allowAccessToken = false;
  var isRootAccountAdmin = false;
  var hideStuff = function() {
    runOnce = true;
    // everywhere
    $("div#course_show_secondary").hide();
    $("a.module_progressions_link").hide();
    $("button.offline_web_export").hide();
    $("button.add_module_link").hide();

    // if you're on the Settings or Details Page
    if (
      /^\/courses\/\d+\/settings$/.test(window.location.pathname) ||
      /^\/courses\/\d+\/details$/.test(window.location.pathname)
    ) {
      $("div#tab-details").hide();
      $("li#course_details_tab").hide();
      $("li#sections_tab").hide();
      $("li#feature_flags_tab").hide();
      $("a[href*='statistics'").hide();
      $("a#course_calendar_link").hide();
      $("a[href*='confirm_action?event=conclude'").hide();
      $("a[href*='confirm_action?event=delete'").hide();
      $("a.copy_course_link").hide();
      $("a.import_content").hide();
      $("a[href*='content_exports'").hide();
      $("a.reset_course_content_button").hide();
      $("a.validator_link").hide();
    }
  };

  var hideAccessToken = function() {
    runHideAccessToken = true;
    if (/^\/profile\/settings$/.test(window.location.pathname)) {
      $("a.add_access_token_link").hide();
    }
  };

  var getEnrollments = $.getJSON(jsonURL, function(data) {
    for (var i = 0; i < data.length; i++) {
      userRoles.push(data[i].role);
    }
  });

  var getAllowAccessToken = $.getJSON(allowAccessTokenURL, function(data) {
    if (data.data != null) {
      allowAccessToken = data.data.allowAccessToken;
    }
  });

  var getListAcctAdmins = $.getJSON(listAcctAdminsURL, function(data) {
    $.each(data, function(i, user) {
      if (user.role === "AccountAdmin") {
        isRootAccountAdmin = true;
      }
    });
  });

  if (ENV.current_user_roles.indexOf("admin") < 1) {
    getEnrollments.done(function() {
      // For each item in the UserRole array,
      for (var i = 0; i < userRoles.length; i++) {
        if (runOnce === false) {
          // For each item in the Targeted Roles array,
          for (var j = 0; j < targetedRoles.length; j++) {
            var targetedRole = targetedRoles.indexOf(userRoles[i]);
            if (targetedRole != -1 && runOnce === false) {
              hideStuff();
            }
          }
        }
      }
    });
  }

  getListAcctAdmins.always(function() {
    if (!isRootAccountAdmin) {
      getAllowAccessToken.always(function() {
        if (!allowAccessToken) {
          if (!runHideAccessToken) {
            hideAccessToken();
          }
        }
      });
    }
  });

  // ALLY Configuration
  window.ALLY_CFG = {
    baseUrl: "https://prod.ally.ac",
    clientId: 34
  };
  $.getScript(ALLY_CFG.baseUrl + "/integration/canvas/ally.js");

  // Modify TurnItIn Pledge
  $(".turnitin_pledge")
    .parent()
    .replaceWith(
      '<label class="checkbox"><input type="checkbox" class="turnitin_pledge" name="turnitin_pledge" value="1">By checking this box, you acknowledge that:<ul><li>Your paper will be shared with Turnitin to generate a similarity report, which your instructor and/or you can view to help you use sources more effectively in your writing.</li><li>Your paper may be stored for comparison against future papers submitted at Yale. Your paper will not be stored as part of the larger Turnitin student database and so will not be used to check the originality of papers submitted at other universities. Turnitin does not acquire any rights to your paper. </li><li>When you first attempt to view your similarity report, you will be prompted to accept the <a href="https://api.turnitin.com/api/lti/1p0/user/static_eula?lang=en_us">Turnitin End User License Agreement (EULA)</a>. This agreement is between you, the individual user (not the university), and Turnitin, LLC, the company that licenses the tool to the university for integration through Canvas. Please read the entire Turnitin EULA carefully.</li><li>If you choose NOT to accept the Turnitin EULA, you will not be able to view the similarity report; however, your course instructor will still be able to view the report.</li></ul><p>Please review the available <a href="https://poorvucenter.yale.edu/using-sources">resources on writing from the Poorvu Center for Teaching and Learning</a>, the <a href="http://help.canvas.yale.edu/m/55452/l/1120483-turnitin-assignment-settings-options">Turnitin Assignment Setting Options</a>, and speak to your instructor if you have any questions or concerns.</p><p>If you would like further information, please contact the Poorvu Center at <a href="mailto:askpoorvucenter@yale.edu">askpoorvucenter@yale.edu</a>.</p></label>'
    );

  //***Begin SignUp Tool Configuration
  //1) move Sign Up Tool after Calendar in Global Nav
  $("#context_external_tool_3015_menu_item").insertAfter(
    $("#global_nav_calendar_link").parent()
  );

  //hide public course & syllabus visibility on course settings page
  if (onPage(/\/courses\/\d+\/settings/)) {
    $('#Syllabus option[value="public"]').hide();
    $('#course_course_visibility option[value="public"]').hide();
  }

  //2) point course summary Scheduler links to Sign Up Tool LTI
  // $(window).on('load', function() {
  // 	$(".detail_list tr[class^='syllabus_'] td[class^='name'] a").prop("href","/accounts/1/external_tools/3015?launch_type=global_navigation");
  // });
  //***End SignUp Tool Configuration

  //***Begin People Tool Configuration
  function onPage(rex, fn, fnfail) {
    "use strict";
    var match = location.pathname.match(rex);
    if (typeof fn !== "undefined" && match) {
      return fn();
    }
    if (typeof fnfail !== "undefined" && !match) {
      return fnfail();
    }
    return match ? match : false;
  }
  // always use IIFE, to isolate code from global scope
  (function() {
    "use strict";

    // only run this code on the conversations page
    if (/^\/courses\/\d+\/users$/.test(window.location.pathname)) {
      $("#role_id option[value=3]").remove();
      $("#role_id option[value=10]").remove();
      $("#role_id option[value=11]").remove();
      $("#role_id option[value=4]").remove();
      $("#role_id option[value=9]").remove();
      $("#role_id option[value=7]").remove();
      if(!ENV.permissions.manage_students) {
        $("#role_id option[value=12]").remove();
        $("#role_id option[value=5]").remove();
        $("#role_id option[value=26]").remove();
        $("#role_id option[value=32]").remove();
        $("#role_id option[value=35]").remove();
        $("#role_id option[value=6]").remove();
      }

      const addPeopleModal = function(mtx, obs) {
        let watchResults = document.querySelector(
          'span > span > span > span > div[role="presentation"] > ul[role="listbox"]'
        );
        // the result list is available
        if (watchResults) {
          //Remove roles from "Add People" screen within a course
          //student
          $("#3").remove();
          //shopper
          $("#10").remove();
          //auditor
          $("#11").remove();
          //teacher
          $("#4").remove();
          //instructor
          $("#9").remove();
          //observer
          $("#7").remove();
          if(!ENV.permissions.manage_students) {
            //guest instructor
            $("#12").remove();
            //ta
            $("#5").remove();
            //grader
            $("#26").remove();
            //ula
            $("#32").remove();
            //accessibility support
            $("#35").remove();
            //designer
            $("#6").remove();
          }
        }
      };

      // wait for the modal to be open
      const watchForModal = function() {
        const uiDialog = function(mtx, obs) {
          let pplMdl = document.getElementById("add_people_modal");
          let editCourseRole = document.getElementById("edit_roles");
          // the modal is found
          if (pplMdl) {
            const defaultRole = document.getElementById(
              "peoplesearch_select_role"
            );
            if (defaultRole.value === "Student" || defaultRole.value === "Teacher") {
              defaultRole.value = "";
            }
            if (
              $("#add_people_modal").length == 1 &&
              $("#addPeople-yaleDirLink").length == 0
            ) {
              //Change "Login Id" to "NetID" on "Add People" screen within a course
              $('[for="peoplesearch_radio_unique_id"] span:nth-child(2)').text(
                "NetID or LoginID"
              );

              //Hide "SIS ID" on "Add People" screen within a course
              $('[for="peoplesearch_radio_sis_user_id"]').hide();
              //Add Yale Directory Link on "Add People" screen within a course
              $(
                ".addpeople__peoplesearch fieldset:nth-child(2) div:first"
              ).append(
                "<div id='addPeople-yaleDirLink' style='float: right;'><a href='https://directory.yale.edu' target='_blank'>Yale Directory</a></div>"
              );
              $("#peoplesearch_select_role").css({
                border: "2px solid red",
                "border-radius": "4px"
              });
              var roleWarning =
                "<h6 id='addPeople-yaleRoleWarning'>Please select a role to continue</h6>";
              $(
                '[for="peoplesearch_select_role"] span:first span:first'
              ).append(roleWarning);
            }
            if (
              $("#peoplesearch_select_role").val() === "" ||
              $(
                ".addpeople__peoplesearch fieldset:nth-child(2) textarea"
              ).val() === ""
            ) {
              $("#addpeople_next").hide();
            } else {
              $("#addpeople_next").show();
            }

            //hide/show next button based on role select

            if (
              $("#peoplesearch_select_role").val() === "" ||
              $(
                ".addpeople__peoplesearch fieldset:nth-child(2) textarea"
              ).val() === ""
            ) {
              $("#addpeople_next").hide();
            } else {
              $("#addpeople_next").show();
            }
            if ($("#peoplesearch_select_role").val() === "") {
              $("#peoplesearch_select_role").css({
                border: "2px solid red",
                "border-radius": "4px"
              });
              $("#addPeople-yaleRoleWarning").show();
            } else {
              $("#peoplesearch_select_role").css({
                border: "",
                "border-radius": ""
              });
              $("#addPeople-yaleRoleWarning").hide();
            }
            // add people modal opened, stop watching document.body
            //obs.disconnect();
            // watch the add people modal instead
            const observer = new MutationObserver(addPeopleModal);
            observer.observe(document.body, {
              childList: true,
              subtree: true
            });
          }
        };

        // watch document.body for modal
        const observer = new MutationObserver(uiDialog);
        observer.observe(document.body, {
          childList: true,
          subtree: true,
          attributes: true
        });
      };

      // start when the user clicks the compose button
      watchForModal();
    }
  })();
  //***End People Tool Configuration

  //check if date is in past
  function isPastDate(inputDate) {
    if (inputDate === null) {
      return true;
    }
    var currentDate = new Date();
    var targetDate = new Date(inputDate);
    return currentDate > targetDate;
  }

  function getCookie(name) {
    return document.cookie.split(";").reduce(function(a, c) {
      const d = c.trim().split("=", 2);
      return d[0] === name ? decodeURIComponent(d[1]) : a;
    }, "");
  }

  /*
	Start Course Unlock/Lock
	*/
  if (onPage(/\/courses\/\d+\/settings/)) {
    const spinner =
      '<div id="status_box" style="text-align: center;"> <img alt="Loading" src="https://du11hjcvx0uqb.cloudfront.net/br/dist/images/ajax-loader-small-5ae081ad76.gif"></div>';
    //validation variables
    var isYACAcct = true;
    var isTermConcluded = false;
    var isCourseConcluded = false;
    //current date + 1 week
    var futureDate = new Date();
    futureDate.setDate(futureDate.getDate() + 7);
    var unlockData = {
      restrict_enrollments_to_course_dates: true,
      end_at: futureDate.toISOString(),
      courseId: courseID
    };
    var lockData = {
      restrict_enrollments_to_course_dates: false,
      end_at: "null",
      courseId: courseID
    };
    lockData.authenticity_token = getCookie("_csrf_token");
    unlockData.authenticity_token = getCookie("_csrf_token");
    //API URLs
    var listCoursesInAcctURL =
      "https://" +
      domain +
      ":443/api/v1/accounts/sis_account_id:YAC/courses?search_term=" +
      courseID;
    var getSingleCourseURL =
      "https://" +
      domain +
      ":443/api/v1/courses/" +
      courseID +
      "?include[]=term";
    //API Calls
    var fetchCoursesInAcct = $.getJSON(listCoursesInAcctURL, function(data) {
      if (data.length > 0) {
        isYACAcct = true;
      }
    });
    var fetchSingleCourse = $.getJSON(getSingleCourseURL, function(data) {
      isTermConcluded = isPastDate(data.term.end_at);
      isCourseConcluded = isPastDate(data.end_at);
    });

    function handleUnlockClick() {
      $("#course-unlockbutton").replaceWith(spinner);
      fetch(courseUnlockDomain, {
        method: "PUT", // or 'PUT'
        body: JSON.stringify(unlockData),
        headers: {
          "Content-Type": "application/json"
        }
      })
        .then(res => location.reload())
        .catch(error => console.error("Error:", error));
    }

    function handleLockClick() {
      $("#course-lockbutton").replaceWith(spinner);
      fetch(courseUnlockDomain, {
        method: "PUT", // or 'PUT'
        body: JSON.stringify(lockData),
        headers: {
          "Content-Type": "application/json"
        }
      })
        .then(res => location.reload())
        .catch(error => console.error("Error:", error));
    }

    //check if course is in YAC account
    fetchCoursesInAcct.always(function() {
      if (isYACAcct) {
        fetchSingleCourse.always(function() {
          if (isTermConcluded) {
            if (isCourseConcluded) {
              $(
                '<a id="course-unlockbutton" class="Button Button--link Button--link--has-divider Button--course-settings validator_link"> <i class="icon-unlock"></i>Unlock Course</a>'
              ).insertBefore("#right-side .summary");
              document
                .getElementById("course-unlockbutton")
                .addEventListener("click", handleUnlockClick, false);
            } else {
              $(
                '<a id="course-lockbutton" class="Button Button--link Button--link--has-divider Button--course-settings validator_link"> <i class="icon-lock"></i>Lock Course</a>'
              ).insertBefore("#right-side .summary");
              document
                .getElementById("course-lockbutton")
                .addEventListener("click", handleLockClick, false);
            }
          }
        });
      }
    });
  }
  /*
	End Course Unlock/Lock
	*/
});