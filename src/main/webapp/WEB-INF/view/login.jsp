<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="common/tags.jsp"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>登录界面</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link href="${contextPath}/resources/login/css/font-awesome.min.css" rel="stylesheet" type="text/css">
		<link href="${contextPath}/resources/login/css/bootstrap.min.css" rel="stylesheet" type="text/css">
		<link href="${contextPath}/resources/login/css/bootstrap-theme.min.css" rel="stylesheet" type="text/css">
		<link href="${contextPath}/resources/login/css/templatemo_style.css" rel="stylesheet" type="text/css">
	</head>
	<body class="templatemo-bg-gray">
		<div class="container">
			<div class="col-md-12">
				<h1 class="margin-bottom-15">用 户 登 录</h1>
				<form class="form-horizontal templatemo-container templatemo-login-form-1 margin-bottom-30" id="login-form" role="form" action="#" method="post">				
			        <div class="form-group">
			          <div class="col-xs-12">		            
			            <div class="control-wrapper">
			            	<label for="username" class="control-label fa-label"><i class="fa fa-user fa-medium"></i></label>
			            	<input type="text" class="form-control" id="userName" name="userName" placeholder="Username">
			            </div>		            	            
			          </div>              
			        </div>
			        <div class="form-group">
			          <div class="col-md-12">
			          	<div class="control-wrapper">
			            	<label for="password" class="control-label fa-label"><i class="fa fa-lock fa-medium"></i></label>
			            	<input type="password" class="form-control" id="passWord" name="passWord" placeholder="Password">
			            </div>
			          </div>
			        </div>
			        <div class="form-group">
			          <div class="col-md-8">
			          	<div class="control-wrapper">
			            	<label for="captcha" class="control-label fa-label"><i class="fa fa-pencil fa-medium"></i></label>
			            	<input type="text" class="form-control" id="captcha" name="captcha" placeholder="Captcha">
			            </div>
			          </div>
			          <div class="col-md-4">
						<img id="captchaImage" alt="" src="${contextPath}/captcha" style="width:100px;height:30px;">
			          </div>
			        </div>
			        <div class="form-group">
			          <div class="col-md-12">
		             	<div class="checkbox control-wrapper">
		                	<label>
		                  		<input type="checkbox" id="remember-account"> 记住用户名密码
	                		</label>
		              	</div>
			          </div>
			        </div>
			        <div class="form-group">
			          <div class="col-md-12">
			          	<div class="control-wrapper">
			          		<input type="button" value="登录" class="btn btn-info" onClick="return doLogin();">
			          		<a href="${contextPath}/forgot_password" class="text-right pull-right">忘记密码?</a>
			          	</div>
			          </div>
			        </div>
			        <hr>
			      </form>
			      <div class="text-center">
			      	<a href="mailto:zhouhao@chinazyjr.com?cc=zhushoudu@chinazyjr.com&subject=用户账号申请" class="templatemo-create-new">Create new account(人工审核) <i class="fa fa-arrow-circle-o-right"></i></a>	
			      </div>
			</div>
		</div>
		<script src="${contextPath}/resources/login/js/jquery.min.js"></script>
		<script src="${contextPath}/resources/login/js/bootstrap.min.js"></script>
		<script src="${contextPath}/resources/login/js/toast.js"></script>
		<script src="${contextPath}/resources/common/common.js"></script>
		<script src="${contextPath}/resources/common/canvas-particle.js"></script>
		<script type="text/javascript">
		$(document).ready(function() {
	    	//监听docuemnt的onkeydown事件看是不是按了回车键
	    	$(document).keydown(function(event){
	    		event = event ? event : window.event;
	    		if (event.keyCode === 13){
	    			doLogin();
	    		}
	    	});
		});

		$('#captchaImage').click(function() {//点击刷新验证码
			$('#captchaImage').attr("src", "${contextPath}/captcha?timestamp=" + (new Date()).valueOf());
		});
		
		window.onload = function() {
			initFormData();
			initBGImage();
		}

		function initFormData(){
			var userNameValue = getCookieValue("userName");
			var passWordValue = getCookieValue("passWord");
			var isRemember = getCookieValue("remember-account");
			console.log("isRemember:"+isRemember);
			if(isRemember == 'true'){
				if(typeof(userNameValue) != 'undefind' && userNameValue != '' && typeof(passWordValue) != 'undefind' && passWordValue != ''){
					$("#userName").val(userNameValue);
					$("#passWord").val(passWordValue);
					$("#remember-account").attr("checked", true);
				}
			}else{
				$("#userName").val('');
				$("#passWord").val('');
				$("#remember-account").attr("checked", false);
			}
		}

		function initBGImage(){
			var config = {
				vx : 4,
				vy : 4,
				height : 2,
				width : 2,
				count : 100,
				color : "121, 162, 185",
				stroke : "100, 200, 180",
				dist : 6000,
				e_dist : 20000,
				max_conn : 10
			}
			CanvasParticle(config);
		}

		function doLogin() {
			var userName = $('#userName').val();
			var passWord = $('#passWord').val();
			var validateCode = $('#captcha').val();
			var isRemember = $('#remember-account').is(':checked');
			addCookie("remember-account",isRemember,7,"/");
			if (!userName) {
				$('#userName').focus();
				showtoastFromDiv("login-form","账号不能为空","inline-block",3000);
				return;
			}
			if (!passWord) {
				$('#passWord').focus();
				showtoastFromDiv("login-form","密码不能为空","inline-block",3000);
				return;
			}
			if (!validateCode) {
				$('#validateCode').focus();
				showtoastFromDiv("login-form","验证码不能为空","inline-block",3000);
				return;
			}
			showtoastFromDiv("login-form","正在登录,请稍后...","inline-block",500);
			$.ajax({  
                cache: true,  
                type: "POST",  
                url:"${contextPath}/doLogin",  
                data:$('#login-form').serialize(),// 你的formid  
                async: false,  
                error: function(request) {  
                    showtoastFromDiv("请求服务器失败，请重新登录！","inline-block");
                },  
                success: function(data) {
                	if (!data) {
                		showtoastFromDiv("login-form","系统未知错误，请重新登录重试！","inline-block",3000);
                		//错误后刷新验证码
            	    	$('#captcha').val('');
            	    	$('#captchaImage').attr("src", "${contextPath}/captcha?timestamp=" + (new Date()).valueOf());
                	} else {
                		if (!data.errorInfo) {//成功登录
                    		if(isRemember){
								addCookie("userName", userName, 7, "/");
								addCookie("passWord", passWord, 7, "/");
                            }
                    		location.href = "${contextPath}/home";
                    	} else {
                    		showtoastFromDiv("login-form",data.errorInfo,"inline-block",3000);
                    		//错误后刷新验证码
                    		$('#captcha').val('');
                	    	$('#captchaImage').attr("src", "${contextPath}/captcha?timestamp=" + (new Date()).valueOf());
                    	}
                	}
                }  
            });
			return false; // 必须返回false，否则表单会自己再做一次提交操作，并且页面跳转
		}
		</script>
	</body>
</html>