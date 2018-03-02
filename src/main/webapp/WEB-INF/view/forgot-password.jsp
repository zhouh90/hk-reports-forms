<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="common/tags.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>找回密码</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	
	<link href="${contextPath}/resources/login/css/font-awesome.min.css" rel="stylesheet" type="text/css">
	<link href="${contextPath}/resources/login/css/bootstrap.min.css" rel="stylesheet" type="text/css">
	<link href="${contextPath}/resources/login/css/bootstrap-theme.min.css" rel="stylesheet" type="text/css">
	<link href="${contextPath}/resources/login/css/templatemo_style.css" rel="stylesheet" type="text/css">	
</head>
<body class="templatemo-bg-gray">
	<div class="container">
		<div class="col-md-12">
			<h1 class="margin-bottom-15">Password Reset</h1>
			<form class="form-horizontal templatemo-forgot-password-form templatemo-container" id="reset-form" role="form" action="#" method="post">	
				<div class="form-group">
		          <div class="col-md-12">
		          	Please enter your email address that you registered in our website.
		          </div>
		        </div>
		        <div class="form-group">
		          <div class="col-md-12">
		            <input type="text" class="form-control" id="username" name="userName" placeholder="Your username">	            
		          </div>              
		        </div>	
		        <div class="form-group">
		          <div class="col-md-12">
		            <input type="text" class="form-control" id="email" name="email" placeholder="Your email">	            
		          </div>              
		        </div>
		        <div class="form-group">
		          <div class="col-md-12">
		            <input type="button" value="重置密码" class="btn btn-danger" onClick="resetPassword();">
                    <br><br>
		          </div>
		        </div>
		      </form>
		</div>
	</div>
	<script src="${contextPath}/resources/login/js/jquery.min.js"></script>
	<script src="${contextPath}/resources/login/js/bootstrap.min.js"></script>
	<script src="${contextPath}/resources/login/js/toast.js"></script>
	<script src="${contextPath}/resources/common/common.js"></script>
	<script type="text/javascript">
	function resetPassword(){
		showtoastFromDiv("reset-form","我才不会给你重置密码呢","inline-block",3000);
	}
	</script>
</body>
</html>