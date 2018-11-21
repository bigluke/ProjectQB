<%-- 
	@JSP:apiInfo.jsp
	@DATE:
	@Author:우한결
	@Desc:

 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link href="${pageContext.request.contextPath}/lib/fullcalendar/bootstrap-fullcalendar.css"
	rel="stylesheet">


<style>
.fc-header-center h2{
	color:#424242;
}
</style>
<section id="main-content">
	<section class="wrapper site-min-height">
		<div class="col-lg-12 mt">
			<div class="row content-panel">
				<div style="text-align:center; margin:10px; padding:10px;">
					<h1>
						<a href="http://www.q-net.or.kr/crf021.do?id=crf02103&gSite=Q&gId=&CST_ID=CRF_Stns_06">큐넷 자격증 시험일정</a>
					</h1>
				</div>
				<!-- <div class="API_table_div"></div> -->
				<!-- <div id="calendar" style="background-color:#D8D8D8;">
				
				</div> -->
				<div class="col-lg-12 mt">

							<div id="calendar" class="has-toolbar" style="margin:10px; padding:10px;"></div>

				</div>
				<hr>
				<span style="margin:10px; padding:10px;">&#8226; 더 자세한 사항을 보고 싶다면 <a href="http://www.q-net.or.kr/crf021.do?id=crf02103&gSite=Q&gId=&CST_ID=CRF_Stns_06">큐넷 자격증 시험 일정</a>를 클릭하여 확인하세요</span>
			</div>
			<!-- row content-panel -->
		</div>
		<!-- col-lg-12 mt -->
	</section>
	<!-- wrapper site-min-height -->
</section>
<!-- main-content -->

<%-- javascript --%>
<input type="hidden" id="contextPath"
	value="${pageContext.request.contextPath}">

<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script
	src="${pageContext.request.contextPath}/lib/fullcalendar/fullcalendar.min.js"></script>
<script
	src="${pageContext.request.contextPath}/lib/calendar-conf-events.js"></script>
<script>
$(document).on("click", ".fc-button-content:eq(0)", function(){
	var text = $(".fc-header-title").children().eq(0).text();
	var thatYear = text.substring(0,4);
	var year = new Date().getFullYear();
	if(thatYear!=year){
		swal("알림",thatYear+"년 데이터는 서비스가 종료되었습니다.","info");
	}
});
$(document).on("click", ".fc-button-content:eq(1)", function(){
	var text = $(".fc-header-title").children().eq(0).text();
	var thatYear = text.substring(0,4);
	var year = new Date().getFullYear();
	if(thatYear!=year){			
		swal("알림",thatYear+"년 데이터는 서비스 업데이트 중입니다.","info");
	}
});
</script>