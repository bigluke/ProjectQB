<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link href="${pageContext.request.contextPath}/css/FindIdPwd.css" rel="stylesheet">






<div id="login-page">
	<div class="container">
		<form class="form-login2" action="${pageContext.request.contextPath}/index/pwdSearch.do" method="post" onsubmit="return authNumberCheck()">
			<h2 class="form-login-heading">비밀번호 찾기</h2>
			<div class="login-wrap">
				<input type="text" id="member_id" name="member_id" class="form-control" placeholder="아이디를 입력해주세요" autofocus required><br>
				<input type="text" id="member_email" name="member_email" class="form-control authText" placeholder="이메일을 입력해주세요" required>
				<button type="button" class="btn btn-theme authBtn" id="mailtoBtn"><i class="fa fa-envelope"></i> 인증번호&nbsp;전송</button><br><br>
				<input type="text" id="ok" class="form-control" placeholder="인증번호 입력" required><br> 
				<button type="submit" class="btn btn-theme confirm" ><i class="fa fa-unlock"></i>&nbsp;확인</button>
				<hr>
			
			<div id="remember">
				<a class="" href="${pageContext.request.contextPath}/login.jsp"> &nbsp;&nbsp;&nbsp;&nbsp;<i class="fa fa-home"></i> 로그인 페이지 </a>&nbsp;&nbsp;/&nbsp;&nbsp; 
				<a class="" href="${pageContext.request.contextPath}/index/idSearch.do"><i class="fa fa-user"></i> 아이디 찾기 </a>
			</div>
			</div>
			<br>
		</form>
	</div>
	
	</div>

<!-- js placed at the end of the document so the pages load faster -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<script>
	
	$.backstretch(["${pageContext.request.contextPath}/img/bg-test6.jpg","${pageContext.request.contextPath}/img/bg-test1.jpg","${pageContext.request.contextPath}/img/bg-test9.jpg"], {
		duration : 3000, fade:750
	});
	
	var mailtoNum;
	var result;
	
	$('#mailtoBtn').click(function(){
		var member_id = $('#member_id').val();
		var member_email = $('#member_email').val();
		if(member_id =="" || member_id == null){
			swal({
		    	title:"ID를 입력해주세요",
		    	text:"ID 미입력시 비밀번호를 찾을 수 없습니다",
		    	icon:"info",
		    }); 
		}else if(member_email == "" || member_email == null){
			swal({
		    	title:"Email을 입력해주세요",
		    	text:"Email 미입력시 비밀번호를 찾을 수 없습니다.",
		    	icon:"info",
		    });
		}else{
		$.ajax({
			type : 'post',
            url : '${pageContext.request.contextPath}/index/mail.do',
            data : {
            	mailto:$('#member_email').val(),
            	command:"findId",
            	member_id:member_id
            	},
            success : function(data) {
            	swal({
			    	title:"EMAIL로 인증번호가 발송되었습니다.",
			    	icon:"info",
			    	button:"Confirm",
			    });    
            	mailtoNum=data;
            	this.mailtoNum=mailtoNum;
            },
            error : function(error) {
            	swal("에러","error","warning");
               console.log(error);
               console.log(error.status);
            }
            
         });
		}
	});
	
	/* 인증번호가 틀렸을 때 유효성 */
	function authNumberCheck(){
		var ok = $('#ok').val();
		console.log(ok)
		if(mailtoNum == ok){
			return true;
		}else{
			swal({
		    	title:"인증번호가 유효하지 않습니다.",
		    	text:"다시 시도해주세요",
		    	icon:"warning",
		    	button:"Confirm",
		    });
			$('#ok').focus();
			return false;
		}
	}
	
	var result = "${result}";
	if(result != "" && result == "true"){
		swal({
	    	title:"임시 비밀번호가 해당 EMAIL로 발송되었습니다.",
	    	text: "확인 후 로그인해주세요",
	    	icon:"info",
	    	button:"Confirm",
	    }).then(function(){
	    	location.href="http://localhost:8090/qb/"
	    });
	}else if(result == "false"){
		swal({
	    	title:"유효하지 않은 정보입니다.",
	    	text:"정보 확인 후 다시 시도해주세요",
	    	icon:"warning",
	    	button:"Confirm",
	    });
	}
	
	 history.replaceState({}, null, location.pathname);
	
	
	
</script>

