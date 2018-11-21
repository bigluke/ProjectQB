<%-- 
	@JSP:examPaperDo.jsp
	@DATE:2018-10-12
	@Author:우한결
	@Desc:학생 시험보기 페이지(스토리보드 39 of 41)
 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpServletRequest"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="se"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link href="${pageContext.request.contextPath}/css/examPaperDo.css"
	rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<%-- <script
	src="${pageContext.request.contextPath}/lib/onet-js/examPaperDo.js"></script> --%>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.11.0/themes/smoothness/jquery-ui.css">
<script src="//ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
<script
	src="//ajax.googleapis.com/ajax/libs/jqueryui/1/jquery-ui.min.js"></script>
<script>
	//양회준 11-19 타이머, 프로그레스바 수정
	//	프로그레스바 script 부분
	//현재 날짜
	var exam_info_date = "${exam_info.exam_info_date}";
	var year= parseInt(exam_info_date.substr(0, 4));
	var month= parseInt(exam_info_date.substr(5, 7));
	var date= parseInt(exam_info_date.substr(8));
	//시험 시작 시간
	var exam_info_time_start = "${exam_info.exam_info_start}";
	var hour_ms_start = parseInt(exam_info_time_start.substr(0, 2));
	var minute_ms_start = parseInt(exam_info_time_start.substr(3, 5));
	var second_ms_start = parseInt(exam_info_time_start.substr(6));
	//시험 종료 시간
	var exam_info_time_end = "${exam_info.exam_info_end}";
	var hour_ms_end = parseInt(exam_info_time_end.substr(0, 2));
	var minute_ms_end = parseInt(exam_info_time_end.substr(3, 5));
	var second_ms_end = parseInt(exam_info_time_end.substr(6));
	//현시간, 시작시간, 종료시간
	var now = new Date();
	var dayStart = new Date(year,month-1,date,hour_ms_start,minute_ms_start,second_ms_start);
	var dayEnd = new Date(year,month-1,date,hour_ms_end,minute_ms_end,second_ms_end);	
	//남은 시간, 경과 시간, 시험시간 (ms단위)
	var remain_time = dayEnd-now;
	var lose_time = now-dayStart;
	var total_time = dayEnd-dayStart;
	
	var refresh_interval = 1000;
	var timer;

	function refresh_bar() {
		$("#progressbar1").progressbar({
			value : lose_time
		});
		lose_time += refresh_interval;
		if (total_time < (lose_time+3000)){
			clearInterval(timer);
		}
	}
	
	// 페이징 처리 위한 변수
 	var pageNo = 1;
	var rowPerPage = 4; 
	var totalRows = ${questionCount};	//	한 시험지의 전체 문제 개수 
	var totalPages = Math.ceil(totalRows / rowPerPage);
	
	
	// document.ready 시작 
	$(function() {
		
		// 페이징 처리 관련 script 
		if(totalRows > 4) {
			$('#nextPageSpan').append('<button class="btn btn-theme03" id="nextPageBtn">다음 페이지</button>');	
		} 
		
		$(document).on('click', '#nextPageBtn', function(){
			
			if($('#prevPageBtn').length == 0){
				$('#prevPageSpan').append('<button class="btn btn-theme03" id="prevPageBtn">이전 페이지</button>');	
			}
			
			if(pageNo != totalPages){
				$('#page'+pageNo).css("display", "none");
				pageNo += 1;
				$('#page'+pageNo).css("display", "block");
				
				if(pageNo == totalPages){
					$('#nextPageSpan').empty();
				}
			} 
		}); 
		
		 $(document).on('click', '#prevPageBtn', function(){
			
			if($('#nextPageBtn').length == 0){
				$('#nextPageSpan').append('<button class="btn btn-theme03" id="nextPageBtn">다음 페이지</button>');	
			}
			
			if(pageNo != 1){
				$('#page'+pageNo).css("display", "none");
				pageNo -= 1;
				$('#page'+pageNo).css("display", "block");
				
				if(pageNo == 1){
					$('#prevPageSpan').empty();
				}
			} 
		}); 
		
		
		// 프로그레스바 script
		$("#progressbar1").progressbar({
			max : total_time-3000,
			value : lose_time
		});
		timer = setInterval(refresh_bar, refresh_interval);
		
				
		// 문제 및 답지 체크 script 시작 
		// 문제 보기를 클릭했을 때 답안지에도 표시 
		$(document).on('click', 'input[type="radio"]', function(){
			//var oximg_v_class = "oximg_v_" + $(this).attr("id").substr(0, 6);
			
			var strArray = $(this).attr("id").split('_');
			var oximg_v_class = "oximg_v_" + strArray[0] + "_" + strArray[1];
			$("." + oximg_v_class).css("display", "none");

			var img_id = "img_" + $(this).attr("id");
			var ans_img_id = "ans_" + img_id;
			$('#' + img_id).css("display", "block");
			$('#' + ans_img_id).css("display", "block");
		});

		// 답안지를 클릭했을 때 문제 보기에도 표시 
		$(document).on('click', '.answer_choice', function(){
			var ques_num = $(this).find('img').attr('class').substr(15);
			/* console.log("ques_num img class : " + $(this).find('img').attr('class'));
			console.log("ques_num : " + ques_num);  */
			$("." + ques_num).css("display", "none"); // 이걸로 한 문제의 체크 이미지 전체를 지운다. 

			var img_ques_id = $(this).find('img').attr('id').substr(4);
			$("#" + img_ques_id).css("display", "block"); //  문제 보기에 체크 이미지 보이게  
			$(this).find('img').css("display", "block"); // 답지에 체크 이미지 보이게 
					
			// 답안지에서 체크했을 때 문제의 라디오 버튼 체크하기
			var answer_id2 = $(this).find('img').attr('id');	
			var radio_id = answer_id2.substr(8);
			$('#' + radio_id).attr('checked', 'checked');
		});

		// 단답형 답 문제지와 답지 동시에 입력하기 
		$(document).on('change', '.trd_div input[type="text"]', function(){
			var ques_num2 = $(this).attr('id')
			var _index = ques_num2.lastIndexOf("_");
			var ques_num = ques_num2.substr(0, _index);
			$("#" + ques_num).val($(this).val());
		}); 
		
		$(document).on('change', '.fst_div input[type="text"], .scd-div input[type="text"]', function(){
			var ques_num2 = $(this).attr('id').substr(0, 6);
			var ques_num = ques_num2 + "_answer";
			$("#" + ques_num).val($(this).val());
		});		
		
		
		// 제출 버튼 눌렀을 때 form 제출 (폼의 타깃을 부모창으로 설정해 controller에서 페이지 이동 경로 지정해줌)
	 	$('#examPaperSubmit').click(function(){
	 		var questionCount = ${questionCount};
	 		var checkUnSolved = 0; 
	 		
	 		console.log("questionCount : " + questionCount);
	 		
	 		for(var i = 0; i < questionCount; i++){   
	 			// console.log(i + " : " + $('input[name="student_answer['+i+'].student_answer_choice"]:checked').length);
	 			if($('input[name="student_answer['+i+'].student_answer_choice"]:checked').length == 0){
	 				var classVal = $('input[name="student_answer['+i+'].student_answer_choice"]').attr("class");
	 				if(classVal == "ques_choice_choice_answer") {
	 					checkUnSolved += 1;
	 				} 
	 			}	
	 		}
	 		if($('.ques_choice_short_answer').val() == "" || $('.ques_choice_short_answer').val() == null){
 				checkUnSolved += 1;
 			}
	 		if(checkUnSolved == 0){
	 			if(confirm("시험을 제출하시겠습니까?")){   	//	문제를 모두 풀었을 때 
					$('#answerForm').target = opener.name;
					$('#answerForm').submit();
	 	            if (opener != null) {
		                opener.insert = null;
		                self.close();
		            } 
				} else {
					return false;
				} 
	 		} else {
	 			if(confirm("문제를 모두 풀지 않았습니다. \n제출하시겠습니까? ")){
 					$('#answerForm').target = opener.name;
 					$('#answerForm').submit();
 					if (opener != null) {
 		                opener.insert = null;
 		                self.close();
 		            }
 				} else {
 					return false;
 				}
	 		}
		});  // 제출 버튼 눌렀을 때 스크립트 종료 부분
		
		// 시험 시간 5분 전 알람 
		setTimeout(function(){
			alert("시험이 5분 뒤에 제출됩니다. \n제출을 완료하여 주세요.");
		}, remain_time - 300000);
		
		// 시험 시간 완료되었을 경우 강제 제출
 		setTimeout(function(){
			alert("시험 시간이 완료되었습니다.\n시험을 제출하겠습니다.");
			$('#answerForm').target = opener.name;
			$('#answerForm').submit();
	            if (opener != null) {
                opener.insert = null;
                self.close();
            } 
		}, remain_time); 
		
		$('#examPaperExit').click(function(){
			if (opener != null) {
				opener.insert = null;
				self.close();
			}
		});
	});  // document.ready 종료 
</script>
</head>
<body>
	<div class="col-lg-12 mt">
		<div id="timerblock">
			<h3 class="mb exampaneldetailsubject">
				<i class="fa fa-angle-right"></i> ${exam_info.exam_info_name}
			</h3>
			<h4 id="remainTime">남은 시간: ${exam_info.exam_info_time}</h4>
		</div>
		<div id="progressbar1"></div>
		<hr>
		<div class="panel-body">
			<div class="row content-panel exampaneldetail">

				<!-- 페이징 처리 변수 설정 -->
				<c:set var="totalRows" value="${questionCount}" />
				<fmt:parseNumber var="totalPages"
					value="${(questionCount / 4)+(1-((questionCount / 4)%1))%1}"
					integerOnly="true" />
				<c:set var="lastPageQuestion" value="${totalRows % 4}" />
				<c:if test="${lastPageQuestion == 0}">
					<c:set var="lastPageQuestion" value="4" />
				</c:if>


				<c:set var="pageCount" value="1" />
				<!-- 문제 하나가 한 페이지에 set 될 때마다 1씩 카운트 증가 -->
				<c:set var="pageNum" value="1" />
				<!-- 하나의 페이지 표시 -->

				<form method="post" id="answerForm" target="examScheduleDetail">
					<c:forEach var="question" items="${questionList}"
						varStatus="status">

						<c:if test="${pageCount == 1}">
							<div id="page${pageNum}" class="pageDiv">
								<div class="col-lg-5 fst_div" id="examBox">
						</c:if>

						<!-- 문제 하나 -->
						<table class="questionTable">
							<input type="hidden"
								name="student_answer[${status.index}].member_id"
								value="${pageContext.request.userPrincipal.name}">
							<input type="hidden"
								name="student_answer[${status.index}].exam_info_num"
								value="${exam_info.exam_info_num}">
							<input type="hidden"
								name="student_answer[${status.index}].question_num"
								value="${question.question_num}">
							<input type="hidden"
								name="student_answer[${status.index}].exam_question_seq"
								value="${question.exam_question_seq}">
							<tr class="questionTr">
								<td class="questionTd questionSpace"><b>${question.exam_question_seq}.
								</b></td>
								<td class="questionSpace"><b>${question.question_name}
										&nbsp;&nbsp;(${question.exam_question_score}점)</b></td>
							</tr>
							<c:if test="${not empty question.question_img}">
								<!-- 이미지 있으면 추가 -->
								<tr class="ques_choice">
									<td class="questionTd"></td>
									<td><img class="question_img"
										src="${pageContext.request.contextPath}/img/${question.question_img}"></td>
								</tr>
							</c:if>
							<c:choose>
								<c:when test="${question.question_type eq '객관식'}">
									<c:forEach var="questionChoice" items="${questionChoiceList}">
										<c:if
											test="${questionChoice.question_num eq question.question_num}">
											<tr class="ques_choice">
												<td class="questionTd">
													<div class="wrap">
														<img
															class="oximg_v oximg_v_ques_${question.exam_question_seq}"
															id="img_ques_${question.exam_question_seq}_${questionChoice.question_choice_num}"
															src="${pageContext.request.contextPath}/img/oximg_v.png">
													</div> ${questionChoice.question_choice_num})
												</td>
												<td><input type="radio"
													name="student_answer[${status.index}].student_answer_choice"
													id="ques_${question.exam_question_seq}_${questionChoice.question_choice_num}"
													class="ques_choice_choice_answer"
													value="${questionChoice.question_choice_num}"> <label
													for="ques_${question.exam_question_seq}_${questionChoice.question_choice_num}">${questionChoice.question_choice_content}</label>
												</td>
											</tr>
											<c:if test="${questionChoice.question_choice_image ne null}">
												<tr>
													<td colspan="2"><img class="answer_choice_image"
														src="${pageContext.request.contextPath}/img/${questionChoice.question_choice_image}"></td>
												</tr>
											</c:if>
										</c:if>
									</c:forEach>
									<%-- <c:set var="questionCount" value="${questionCount + 1}" /> --%>
								</c:when>
								<c:when test="${question.question_type eq '단답형'}">
									<tr class="ques_choice">
										<td class="questionTd"></td>
										<td><input type="text"
											id="ques_${question.exam_question_seq}"
											class="ques_choice_short_answer"
											name="student_answer[${status.index}].student_answer_choice"></td>
									</tr>
									<%-- <c:set var="questionCount" value="${questionCount + 1}" /> --%>
								</c:when>
							</c:choose>
						</table>
						<!-- 문제 하나 끝 -->

						<c:choose>
							<c:when test="${pageNum ne totalPages}">
								<c:if test="${pageCount == 2}">
			</div>
			<div class="col-lg-5 scd-div">
				</c:if>
				<c:choose>
					<c:when test="${pageCount ne 4 }">
						<c:set var="pageCount" value="${pageCount + 1}" />
						<!-- 한 페이지 당 문제 갯수 카운트 하나 업, 여기서 업뎃됐다 -->
					</c:when>
					<c:when test="${pageCount == 4}">
			</div>
			<!-- scd-div 닫는 div -->
		</div>
		<!-- page 닫는 div  -->
		<c:set var="pageCount" value="1" />
		<c:set var="pageNum" value="${pageNum +1}" />
		</c:when>
		</c:choose>
		</c:when>

		<c:when test="${pageNum eq totalPages}">
			<!-- 마지막 페이지일때 -->
			<c:choose>
				<c:when test="${pageCount ne lastPageQuestion}">
					<c:if test="${pageCount == 2}">
	</div>
	<div class="col-lg-5 scd-div">
		</c:if>
		<c:set var="pageCount" value="${pageCount + 1}" />
		<!-- 한 페이지 당 문제 갯수 카운트 하나 업, 여기서 업뎃됐다 -->
		</c:when>
		<c:when test="${pageCount eq lastPageQuestion}">
			<c:choose>
				<c:when test="${pageCount == 1 || pageCount == 2}">
	</div>
	<!-- fst-div 닫는 div -->
	<div class="col-lg-5 scd-div"></div>
	</div>
	<!-- page 닫는 div  -->
	</c:when>
	<c:when test="${pageCount == 3 || pageCount == 4}">
		</div>
		<!-- scd-div 닫는 div -->
		</div>
		<!-- page 닫는 div  -->
	</c:when>
	</c:choose>
	</c:when>
	</c:choose>
	</c:when>
	</c:choose>
	</c:forEach>
	</form>

	<div class="col-lg-2 trd_div">
		<!-- OMR 시작 div -->
		<table class="tg">
			<tr>
				<th class="tg-baqh qname" colspan="6">답안지</th>
			</tr>
			<c:forEach var="question" items="${questionList}">
				<tr>
					<td class="tg-baqh qnumber">${question.exam_question_seq}</td>
					<c:choose>
						<c:when test="${question.question_type eq '객관식'}">
							<c:set var="count" value="0" />
							<c:forEach var="questionChoice" items="${questionChoiceList}"
								varStatus="status">
								<c:if
									test="${questionChoice.question_num eq question.question_num}">
									<td class="tg-baqh answer_choice">
										<div class="wrap">
											<img
												class="answer_oximg_v oximg_v_ques_${question.exam_question_seq}"
												id="ans_img_ques_${question.exam_question_seq}_${questionChoice.question_choice_num}"
												src="${pageContext.request.contextPath}/img/oximg_v.png">
										</div> ${questionChoice.question_choice_num} <c:set var="count"
											value="${count+1 }" />
									</td>
								</c:if>
							</c:forEach>
							<c:forEach begin="${count}" end="4">
								<td class="tg-baqh qname"></td>
							</c:forEach>
						</c:when>
						<c:when test="${question.question_type eq '단답형'}">
							<td class="tg-baqh answer_choice" colspan="5"><input
								type="text" id="ques_${question.exam_question_seq}_answer"></td>
						</c:when>
					</c:choose>
				</tr>
			</c:forEach>
		</table>
		<br>
	</div>
	</div>

	<div>
		<div class="col-lg-10 pastExamBtnDiv">
			<span id="prevPageSpan"></span> <span id="nextPageSpan"></span>
		</div>
		<div class="col-lg-2 pastExamBtnDiv2">
			<se:authorize access="hasRole('ROLE_TEACHER')">
				<button class="btn btn-theme03 exampaneldetailBtn"
					id="examPaperExit">창 닫기</button>
			</se:authorize>
			<se:authorize access="hasRole('ROLE_STUDENT')">
				<button class="btn btn-theme03 exampaneldetailBtn"
					id="examPaperSubmit">제출하기</button>
			</se:authorize>
		</div>
	</div>


	</div>
	</div>

	<script>
		//남은시간 변화	
		var remainPrint;
		var remainTime;
		//남은 시간 생성 함수
		function msToTime() {
			var now = new Date();
			var dday = new Date(year, month - 1, date, hour_ms_end,
					minute_ms_end, second_ms_end);
			var remainTime = dday - now;

			var seconds = parseInt((remainTime / 1000) % 60), minutes = parseInt((remainTime / (1000 * 60)) % 60), hours = parseInt((remainTime / (1000 * 60 * 60)) % 24);

			hours = (hours < 10) ? "0" + hours : hours;
			minutes = (minutes < 10) ? "0" + minutes : minutes;
			seconds = (seconds < 10) ? "0" + seconds : seconds;

			remainPrint = hours + ":" + minutes + ":" + seconds;
			$("#remainTime").html(remainPrint);

			//남은 제한시간 0보다 작을 경우 종료
			if (remainTime < 0) {
				clearInterval(interv);
			}
		}
		//남은 시간 생성 함수 반복실행
		var interv = window.setInterval("msToTime()", 1000);
	</script>

</body>
</html>