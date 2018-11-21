<%-- 
	@JSP:notice.jsp
	@DATE:2018-10-06
	@Author:우한결
	@Desc:강사, 학생 메인 페이지(스토리보드 17, 35 of 41)
 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="se" uri="http://www.springframework.org/security/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link href="${pageContext.request.contextPath}/css/notice.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/lib/gritter/css/jquery.gritter.css" />
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<style>
.th {
	text-align: center;
	font-size: 14px;
}
.subject{
	color:#063f54;
}
#subject{
	color:#063f54;
}
.noticebutton{
	background:#063f54;
}
</style>
<!-- 강사, 학생 - 메인페이지 (클래스 공지사항, 시험일정) -->

<section id="main-content">
	<section class="wrapper site-min-height">
		<div class="row mt">
			<div class="col-lg-12">
				<div class="row content-panel noticePageContent">
					<div class="panel-content">
						<div class="panel-heading">
							<header class="panel-heading wht-bg">
								<h4 class="gen-case" id="subject">
								<i class="fa fa-angle-right subject" ></i>&nbsp;&nbsp;&nbsp;공지사항</h4>
							</header>
						</div>
					
						<div class="panel-body">
					
							<table class="table table-inbox-notice table-hover" id="noticetable">
								<thead>
									<tr>
										<th class="th">글번호</th>
										<th class="th">제목</th>
										<th class="th">첨부파일</th>
										<th class="th">작성자</th>
										<th class="th">작성일</th>
									</tr>
								</thead>
								<tbody>
								<se:authorize access="hasRole('ROLE_ADMIN')">
									<c:forEach items="${notice}" var="notice">
										<tr class="notice_tr" onClick="location.href='noticeDetail.do?class_name=${notice.class_name}&notice_num=${notice.notice_num}&class_num=${class_num}'">
											<td class="notice_num">${notice.notice_num}</td>
											<td class="notice_name">${notice.notice_name}</td>
											<c:choose>
											<c:when test="${empty notice.notice_file1 && empty notice.notice_file2}">
											<td class="notice_file"></td>
											</c:when>
											<c:when test="${not empty notice.notice_file1 || not empty notice.notice_file2}">
											<td class="notice_file"><i class="fa fa-paperclip"></i></td>
											</c:when>
											</c:choose>
											<td class="notice_member_id">${notice.member_name} [${notice.member_id}]</td>
											<td class="notice_date">${notice.notice_date}</td>
										</tr>
									</c:forEach>
								</se:authorize>	
								<se:authorize access="hasRole('ROLE_TEACHER') or hasRole('ROLE_STUDENT')">
									<c:forEach items="${notice}" var="notice">
										<tr class="notice_tr" onClick="location.href='noticeDetail.do?class_name=${notice.class_name}&notice_num=${notice.notice_num}'">
											<td class="notice_num">${notice.notice_num}</td>
											<td class="notice_name">${notice.notice_name}</td>
											<c:choose>
											<c:when test="${empty notice.notice_file1 && empty notice.notice_file2}">
											<td class="notice_file"></td>
											</c:when>
											<c:when test="${not empty notice.notice_file1 || not empty notice.notice_file2}">
											<td class="notice_file"><i class="fa fa-paperclip"></i></td>
											</c:when>
											</c:choose>
											<td class="notice_member_id">${notice.member_name} [${notice.member_id}]</td>
											<td class="notice_date">${notice.notice_date}</td>
										</tr>
									</c:forEach>
								</se:authorize>	
								</tbody>
							</table>
							<div>
							<se:authorize access="hasRole('ROLE_TEACHER')">
								<button id="noticeWrite_btn" class="btn btn-theme noticebutton" value="${noticeCheck}">글쓰기</button>
							</se:authorize>	
							<se:authorize access="hasRole('ROLE_ADMIN')">
								<button id="noticeWrite_btnAdmin" class="btn btn-theme noticebutton" value="${class_name}">글쓰기</button>
							</se:authorize>	
							</div>
						</div><!-- panel-body -->
						
						
					</div><!-- panel-content -->
				</div><!-- row content-panel -->
				
				<div class="row content-panel noticePageContent">
					<div class="panel-content">
						<div class="panel-heading">
							<header class="panel-heading wht-bg">
								<h4 class="gen-case" id="subject">
								<i class="fa fa-angle-right subject"></i>&nbsp;&nbsp;&nbsp;시험 일정</h4>
							</header>
						</div>
						<div class="panel-body">
							<table class="table table-inbox-exam table-hover" id="noticetable2">
								<thead>
									<tr>
										<th class="th">시험번호</th>
										<th class="th">시험 이름</th>
										<th class="th">시험 시간</th>
										<th class="th">응시 대상</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${exam_info}" var="exam_info">
										<tr class="" onClick="location.href='examScheduleDetail.do?exam_info_num=${exam_info.exam_info_num}'">
											<td class="exam_info_num">${exam_info.exam_info_num }</td>
											<td class="exam_info_name">${exam_info.exam_info_name }</td>
											<td class="exam_info_date">${exam_info.exam_info_date }<br>
											${exam_info.exam_info_start } ~ ${exam_info.exam_info_end }<br>
											${exam_info.exam_info_time } 분</td>
											<td class="exam_info_member">${exam_info.exam_info_member }</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div><!-- /col-lg-12 -->
		</div><!-- /row mt -->
	</section><!-- /wrapper -->
</section> <!-- /main-content -->

<!-- gritter 스크립트 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/lib/gritter/js/jquery.gritter.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/lib/gritter-conf.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
    	
    	// 오늘 시험이 있는 경우 우측 하단에 gritter 팝업창 띄워줌
    	var exam_info_name;
    	var exam_info_date;
    	var exam_info_start;
    	var exam_info_end; 
        
    	var todayExamDto = ${todayExamDto};
    	$.each(todayExamDto, function(index, item){
    		exam_info_name = item.exam_info_name;
    		exam_info_date = item.exam_info_date;
    		exam_info_start = item.exam_info_start;
    		exam_info_end = item.exam_info_end;
    	});
        
        var unique_id = $.gritter.add({
            title: '오늘 시험이 있습니다!',
            text: exam_info_name,
            text2: exam_info_date + "  " + exam_info_start + " ~ " + exam_info_end, 
            image: '${pageContext.request.contextPath}/img/testIcon/testicon1.png',
            class_name: 'my-sticky-class'
          });
    
          return false;  
    });
</script>
<script>
	
	var class_num = ${class_num};
		
	$('#noticeWrite_btn').click(function(){
		var class_name2 = $('#noticeWrite_btn').val();
		location.href="noticeWrite.do?class_name=" + class_name2;
	});
	
	$('#noticeWrite_btnAdmin').click(function(){
		var adminClass_name = $('#noticeWrite_btnAdmin').val();
		location.href="noticeWrite.do?class_name=" + adminClass_name + "&class_num=" + class_num;
	});
	
</script>

<!-- /MAIN CONTENT -->
<!--main content end-->