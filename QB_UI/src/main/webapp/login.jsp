<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE>
<html>

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="Dashboard">
<meta name="keyword"
	content="Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">
<title>Welcome BitCamp</title>

<!-- Favicons -->
<link href="img/favicon.png" rel="icon">
<link href="img/apple-touch-icon.png" rel="apple-touch-icon">

<!-- Bootstrap core CSS -->
<link href="lib/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!--external css-->
<link href="lib/font-awesome/css/font-awesome.css" rel="stylesheet" />

<!-- Custom styles for this template -->
<link href="css/style.css" rel="stylesheet">
<link href="css/style-responsive.css" rel="stylesheet">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</head>

<body>
	<div id="login-page">
		<div class="container">
		<c:url value="/login" var="loginurl"></c:url>
			<form class="form-login" action="${loginurl}" method="post">
				<h2 class="form-login-heading">LOGIN</h2>
				<div class="login-wrap">
					<label>ID</label> <input type="text" autocomplete="off" class="form-control"
						name="member_id" placeholder="아이디를 입력하세요" autofocus required>
					<br> <label>PASSWORD</label> <input type="password"
						class="form-control" name="member_pwd" placeholder="비밀번호를 입력하세요"
						required> <br>
					<label class="pull-right"><span>&nbsp; &nbsp; / &nbsp; &nbsp;</span> <a href="index/pwdSearch.do">
							<i class="fa fa-key"></i> 비밀번호 찾기</a>
					</label> <label class="pull-right"> <a href="index/idSearch.do"><i class="fa fa-user"></i>
							아이디 찾기</a>
					</label>

					<button class="btn btn-theme btn-block" type="submit">
						<i class="fa fa-unlock-alt"></i>&nbsp; 로그인
					</button>
					<br> <a href="index/memberjoin.do"><button type="button"
							class="btn btn-default btn-block">
							<i class="fa fa-sign-in"></i>&nbsp; 회원가입
						</button></a>
				</div>
			</form>
		</div>
	</div>
	<!-- js placed at the end of the document so the pages load faster -->
	<script src="lib/jquery/jquery.min.js"></script>
	<script src="lib/bootstrap/js/bootstrap.min.js"></script>
	<!--BACKSTRETCH-->
	<!-- You can use an image of whatever size. This script will stretch to fit in any screen size.-->
	<script type="text/javascript" src="lib/jquery.backstretch.min.js"></script>
	<script>
		$.backstretch(["img/bg-test6.jpg","img/bg-test1.jpg","img/bg-test9.jpg"], {
			duration : 3000, fade:750
		});

		<c:choose>
		<c:when test="${param.result eq '0'}">
		swal("아이디 혹은 비밀번호가 틀렸습니다.", "", "error");
		</c:when>
		</c:choose>
			
        history.replaceState({}, null, location.pathname);
	</script>

</body>

</html>