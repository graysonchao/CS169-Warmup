function errorMessage(errCode) {
	if (errCode == '-1') {
		return "Invalid username and password combination. Please try again.";
	}

	if (errCode == '-2') {
		return "This user name already exists. Please try again.";
	}

	if (errCode == '-3') {
		return "The user name should not be empty. Please try again.";
	}
}

function ajaxRequest(url, data) {
	$.ajax({
		type: 'POST',
		url: url,
		data: data,
		contentType: "application/json",
		success: success,
		failure: failure
	});
}

function success(data) {
	var errCode = data['errCode'];
	console.log(errCode);
	if (errCode == '1') {
		var count = data['count'];
		$('#msg').html(
			"Hello " + $('#user').val() + ", you have logged in " + count + " times."
		);
		var oldInnerHTML = $('.login.box.inner').html();
		$('.login.box.inner').html(
			"<div class='btn-box'>" +
			"<a class='logout btn' id='logout-btn' href='javascript:'>Logout</a>" +
			"</div>"
		);
		$('#logout-btn').click(function() {
			$('.login.box.inner').html(oldInnerHTML);
			reset();
		});

	} else {
		$('#msg').html(
			errorMessage(errCode)
		);
	}
}

/* This should never happen assuming an OK backend */
function failure(data) {
	$('#msg').html("An internal error occurred.");
}

/* Reset the DOM. */
function reset() {
	$('#msg').html("Please enter your credentials below.");

	/* Change me to your backend URL of choice. */
	var baseURL = "/";

	$('#login-btn').click(function() {
		var data = {
			'user': $('#user').val(),
			'password': $('#password').val()
		};
		ajaxRequest(baseURL + 'users/login', JSON.stringify(data));
	});

	$('#add-btn').click(function() {
		var data = {
			'user': $('#user').val(),
			'password': $('#password').val()
		};
		ajaxRequest(baseURL + 'users/add', JSON.stringify(data));
	});
}

$(document).ready(function() {
	reset();
});
