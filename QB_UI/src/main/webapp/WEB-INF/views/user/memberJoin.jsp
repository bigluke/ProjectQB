<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link href="${pageContext.request.contextPath}/css/Memberjoin.css"
	rel="stylesheet">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<div id="login-page">
	<div class="container">
		<form class="form-signup" action="insertmember.do" method="post" id="joinform">
			<h2 class="form-login-heading">회원 가입</h2>
			<div class="login-wrap">
				<label>ID</label> <input type="text" autocomplete="off" class="form-control"
					placeholder="아이디를 입력해주세요(최소 5글자)" autofocus name="member_id" id="member_id"
					onblur="confirmId()">
				<div id="iddiv"></div>
				<label>PASSWORD</label> <input type="password" class="form-control"
					placeholder="비밀번호를 입력해주세요" name="member_pwd" id="member_pwd"
					onblur="confirmPwd()">
				<div id="pwddiv"></div>
				<label>CHECK PASSWORD</label> <input type="password"
					class="form-control" placeholder="비밀번호를 한번 더 입력해주세요" autofocus
					id="member_pwd_check" onblur="confirmPwd2()">
				<div id="pwdcheckdiv"></div>
				<label>클래스 선택</label> <select class="form-control" name="class_name" id="class_name">
					<c:forEach items="${classList}" var="classList">
                         <option value="${classList.class_name}">${classList.class_name}</option>
                    </c:forEach>
				</select> <br> <label>이름</label> <input type="text" autocomplete="off"
					class="form-control" placeholder="이름을 입력해주세요"
					pattern="([a-z, A-Z, 가-힣]){2,}" autofocus name="member_name" id="member_name"
					required>
				<label>E-mail</label><br> <input type="text" autocomplete="off"
					class="form-control authText" placeholder="이메일을 입력해주세요"
					name="member_email" id="mailto">
				<button type="button" class="btn btn-theme authBtn" id="mailtoBtn">
					<i class="fa fa-envelope"></i> 인증번호 전송
				</button>
				<br> <br> <label>인증번호 입력</label> 
				<input type="text" class="form-control" autocomplete="off" placeholder="인증번호를 입력해주세요" id="textmail" autofocus>
				<br> <label>휴대전화</label> <input type="text" autocomplete="off" class="form-control" placeholder="휴대폰 번호를 입력해주세요" pattern="01([0|1|6|7|8|9]?)([0-9]{3,4})([0-9]{4})" autofocus name="member_phone" required>
				<div>('-'를 제외한 숫자만 입력하세요.)</div>



				<button class="btn btn-theme btn-block" type="button" onclick="check()">
					<i class="fa fa-sign-in"></i> 회원 가입
				</button>
				<a class="pull-right"
					href="${pageContext.request.contextPath}/login.jsp">로그인 페이지</a>

			</div>
			<!-- Modal -->
			<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog"
				tabindex="-1" id="myModal" class="modal fade">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-hidden="true">&times;</button>
							<h4 class="modal-title">Forgot Password ?</h4>
						</div>
						<div class="modal-body">
							<p>Enter your e-mail address below to reset your password.</p>
							<input type="text" name="email" placeholder="Email"
								autocomplete="off" class="form-control placeholder-no-fix">
						</div>
						<div class="modal-footer">
							<button data-dismiss="modal" class="btn btn-default"
								type="button">Cancel</button>
							<button class="btn btn-theme" type="button">Submit</button>
						</div>
					</div>
				</div>
			</div>
			<!-- modal -->
		</form>
	</div>
</div>
<!-- js placed at the end of the document so the pages load faster -->

<!--BACKSTRETCH-->
<!-- You can use an image of whatever size. This script will stretch to fit in any screen size.-->

<script>
$.backstretch(["${pageContext.request.contextPath}/img/bg-test6.jpg","${pageContext.request.contextPath}/img/bg-test1.jpg","${pageContext.request.contextPath}/img/bg-test9.jpg"], {
	duration : 3000, fade:750
});
</script>
<script>
	var idcheck = false;
	var pwdcheck = false;
	var pwdcheck2 = false;
	var mailcheck = false;
	
	var mailtonumber;
	
	$('#mailtoBtn').click(function() {
		
			
			$.ajax({
				type : 'post',
				url : '${pageContext.request.contextPath}/index/mail.do',
				data : {
					mailto : $('#mailto').val(),
					command : "join",
					member_id : $('#member_id').val()
				},
				success : function(data) {
					/* alert(data); *///메일인증 확인 알럿
					swal({
						title:"인증번호를 발송하였습니다.",
						icon:"info",
						button:"Confirm"
					});
					mailtonumber = data;
					mailcheck = true;
				},
				error : function(error) {
					swal({
						  title: "인증 메일 전송 실패",
						  icon: "warning"
					});
					console.log(error);
					console.log(error.status);
				}
			});

		
	});

	function confirmId() {
		var val = $("#member_id").val();
		var iddiv = $("#iddiv");
		
		if (val == "") {
			iddiv.html("아이디를 입력해주세요");
			iddiv.css("color","green");
			idcheck = false;

		}else if(val.length < 5){
			iddiv.html("최소 5글자 이상 입력해주세요");
			iddiv.css("color","red");
			idcheck = false;
		}else {
			$.ajax({
				url : 'joinCheckId.do',
				data : {
					'member_id' : val
				},
				dataType : 'json',
				success : function(data) {
					if (data.result == true) {
						iddiv.html("사용가능한 아이디 입니다.");
						iddiv.css("color","blue");
						idcheck = true;
					} else {
						iddiv.html("사용 불가능한 아이디 입니다.");
						iddiv.css("color","red");
						idcheck = false;
					}
				}
			});
		}
	}
	function confirmPwd() {
		var pwd = $("#member_pwd");
		var pwddiv = $("#pwddiv");

		var p1 = /[0-9]/;
		var p2 = /[a-zA-Z]/;
		var p3 = /[~!@#$%^&*()]/;

		if (!p1.test(pwd.val()) || !p2.test(pwd.val()) || !p3.test(pwd.val())
				|| pwd.val().length < 8) {

			pwddiv.html("비밀번호는 8자 이상 숫자, 영문자, 특수문자를 포함해야 합니다.");
			pwddiv.css("color","red");
			pwdcheck = false;
		} else {
			pwddiv.html("안전");
			pwddiv.css("color","blue");
			pwdcheck = true;

		}
	}
	function confirmPwd2() {
		var pwd = $("#member_pwd");
		var pwdcheck = $("#member_pwd_check");
		var pwdcheckdiv = $("#pwdcheckdiv");

		if (pwd.val() != pwdcheck.val()) {
			pwdcheckdiv.html("비밀번호가 일치하지 않습니다.");
			pwdcheckdiv.css("color","red");
			pwdcheck2 = false;
		} else {
			pwdcheckdiv.html("일치");
			pwdcheckdiv.css("color","blue");
			pwdcheck2 = true;
		}

	}
	function check() {

		var pwd = $("#member_pwd");
		var mailnumber = $("#textmail");

		if (idcheck == false) {
			$("#iddiv").html("아이디 오류(최소 5자이상/중복확인)");
			$("#iddiv").css("color","red");
			$("#member_id").focus();

			return false;
		}else if (pwdcheck == false || pwdcheck2 == false) {
			$("#member_pwd").focus();
			swal({
				  title: "비밀번호 형식이 맞지 않습니다.",
				  icon: "warning"
			});
			return false;
		}else if(mailcheck == false){
			swal({
				  title: "메일인증을 해주세요.",
				  icon: "warning"
			});
			$("#textmail").focus();
			return false;
		}else if(mailnumber.val() != mailtonumber){
			swal({
				  title: "인증번호가 일치하지 않습니다.",
				  icon: "warning"
			});
			$("#textmail").focus();
			return false;
		}
		else {
			swal({
				  title: "회원가입 하시겠습니까?",
				  buttons: true,
				  
				}).then((willDelete) => {
				  if (willDelete) {
					  swal({
					       title: "등록이 완료되었습니다.",
						   text: "",
						   icon:"success"
						}).then(function() {
							 $("#joinform").submit();
					});
				  } else {
				  }
			});
		}
	}
</script>