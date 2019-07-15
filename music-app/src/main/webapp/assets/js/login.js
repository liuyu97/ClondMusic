$(function() {
	

	// 弹出登陆框
	var login = $(".loginButton");
	var input = $(".text");
	var loginView = $(".login");
	login.click(function() {
		loginView.css("display", "block")
		console.log(1);
	})

	var delDef;
	input.focus(function() {
		varDef = $(this).val()
		$(this).val("")
	})
	input.blur(function() {
		if ($(this).val() == "") {
			$(this).val(varDef)
		} else {
			varDef = $(this).val()
			$(this).val(varDef)
		}
	})

	// 登陆的form表单验证
	$("form").validate({
		rules : {
			userNumber : {
				required : true,
				minlength : 5
			},
			account : {
				required : true,
				minlength : 5
			},
			password : {
				required : true,
				minlength : 5
			},
			pwd : {
				required : true,
				minlength : 5
			},
			pwd2 : {
				required : true,
				minlength : 5,
				equalTo : "#pd"
			}

		},
		messages : {
			userNumber : {
				required : "用户名不能为空",
				minlength : "用户名不能少于5个字符"
			},
			account : {
				required : "用户名不能为空",
				minlength : "用户名不能少于5个字符"
			},
			password : {
				required : "密码不能为空",
				minlength : "密码不能少于5个字符"
			},
			pwd : {
				required : "密码不能为空",
				minlength : "密码不能少于5个字符"
			},
			pwd2 : {
				required : "密码不能为空",
				minlength : "密码不能少于5 个字符",
				equalTo : "两次密码不一致"
			}
		}
	})

	// 注册按钮
	$(".button:first").click(function() {
		$(".login-top:first").css("display", "none")
		$(".sign").css("display", "block")
		$(".signPage").css("display", "block")
		$("table:first").css("display", "none")

	})

	// 登陆关闭
	$(".close").click(function() {
		$(".login").css("display", "none")
	})
	
	
	
})


