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

function loginClick() {
	var user = $('#user').val();
	var password = $('#password').val();

	$.ajax({
		type: 'POST',
		url: '/users/login',
		data: JSON.stringify({
			'user': user,
			'password': password
		}),
		contentType: "application/json",
		success: success,
		failure: failure
	});
}

function addClick() {
	var user = $('#user').val();
	var password = $('#password').val();

	$.ajax({
		type: 'POST',
		url: '/users/add',
		data: JSON.stringify({
			'user': user,
			'password': password
		}),
		contentType: "application/json",
		success: success,
		failure: failure
	});
}

function failure(data) {
	$('#msg').html("An internal error occurred.");
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

function reset() {
	$('#msg').html("Please enter your credentials below.");
	$('#login-btn').click(loginClick);
	$('#add-btn').click(addClick);
}

$(document).ready(function() {
	reset();
});
