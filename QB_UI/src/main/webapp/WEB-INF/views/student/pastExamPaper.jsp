<%-- 
	@JSP:pastExamPaper.jsp
	@DATE:2018-10-25
	@Author:김현이 
	@Desc:학생 지난시험지보기 페이지
 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpServletRequest"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link href="${pageContext.request.contextPath}/css/pastExamPaper.css"
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

 	var pageNo = 1;
	var rowPerPage = 4;
	var begin = (pageNo - 1) * rowPerPage + 1;	// 문제의 시작 rownum, 1부터 시작한다 
	var totalRows = ${questionCount};	//	한 시험지의 전체 문제 개수  
	var totalPages = Math.ceil(totalRows / rowPerPage);
	
	var memberId;//line 34?
	// document.ready 시작 
	$(function() {		
		memberId=$('#member_id').val();//member_id 값 대입
		if(totalRows > 4) {
			$('#nextPageSpan').append('<button class="btn btn-theme03" id="nextPageBtn">다음 페이지</button>');	
		}
		
		student_answer_status = "all";		//	전체 문제 보기, 틀린 문제만 보기 
		pastExamPaperView(student_answer_status, "question");
		pastExamPaperView(student_answer_status, "answerSheet");
		
		$(document).on('click', '#nextPageBtn', function(){
			if(pageNo < totalPages){
				if($('#prevPageBtn').length == 0){
					$('#prevPageSpan').append('<button class="btn btn-theme03" id="prevPageBtn">이전 페이지</button>');	
				} 
				pageNo += 1;			
				begin = (pageNo - 1) * rowPerPage + 1;	 
				pastExamPaperView(student_answer_status, "question");
				
				if(pageNo == totalPages){
					$('#nextPageSpan').empty();
				} 
			} 
		});  // nextPageBtn 이벤트 종료 
		

		$(document).on('click', '#prevPageBtn', function(){
			if(pageNo < totalPages || pageNo == totalPages){
				if($('#nextPageBtn').length == 0){
					$('#nextPageSpan').append('<button class="btn btn-theme03" id="nextPageBtn">다음 페이지</button>');	
				}
				pageNo -= 1;
				begin = (pageNo - 1) * rowPerPage + 1;	 
				pastExamPaperView(student_answer_status, "question");
				if(pageNo == 1){
					$('#prevPageSpan').empty();
				}
			} 
		});
		
		$('#wrongQuestionBtn').click(function() {
			
			if(student_answer_status == "all"){
				
				if(${wrongQuestionCount} < 4 || ${wrongQuestionCount} == 4) {   
					$('#nextPageSpan').empty();	
				} else { 
					if($('#nextPageBtn').length == 0){
						$('#nextPageSpan').append('<button class="btn btn-theme03" id="nextPageBtn">다음 페이지</button>');	
					}
				}
				
				student_answer_status = "wrong";
				pageNo = 1;
				$('#prevPageSpan').empty();
				
				begin = (pageNo - 1) * rowPerPage + 1;
				totalRows = ${wrongQuestionCount};
				totalPages = Math.ceil(totalRows / rowPerPage);
				
				pastExamPaperView(student_answer_status, "question");
				pastExamPaperView(student_answer_status, "answerSheet");
				searchStudentAnswer(student_answer_status);
				
				$("#wrongQuestionBtn").text("전체 문제 보기");
				
			} else if (student_answer_status == "wrong") {
				
				if(${questionCount} < 4 || ${questionCount} == 4) {
					$('#nextPageSpan').empty();	
				} else { 
					if($('#nextPageBtn').length == 0){
						$('#nextPageSpan').append('<button class="btn btn-theme03" id="nextPageBtn">다음 페이지</button>');	
					}
				}
				
				student_answer_status = "all";
				pageNo = 1;
				$('#prevPageSpan').empty();
				
				begin = (pageNo - 1) * rowPerPage + 1;
				totalRows = ${questionCount}; 
				totalPages = Math.ceil(totalRows / rowPerPage);
				
				pastExamPaperView(student_answer_status, "question");
				pastExamPaperView(student_answer_status, "answerSheet");
				searchStudentAnswer(student_answer_status);
				
				$("#wrongQuestionBtn").text("틀린 문제만 보기");
			}
		});	//	wrongbtn 이벤트 종료 

	}); // document.ready 종료
	
	
	
	// 문제 가져오는 ajax + 답안지 가져오는 ajax 
	function pastExamPaperView(student_answer_status, question_answerSheet){
		$.ajax({
			url : "pastExamPaperView.do",
			type : 'post',
			data : {
					'exam_info_num' : <%=request.getParameter("exam_info_num")%>,
					'member_id' : memberId,
					'student_answer_status' : student_answer_status,
					'question_answerSheet' : question_answerSheet,
					'begin' : begin,
					'rowPerPage' : rowPerPage 				// 여기에서 페이징 관련 정보를 보내줌
			},
			dataType : "html",
			success : function(data) {
				
				if(question_answerSheet == "question"){
					$('#examSpan').html(data);	
				} else if (question_answerSheet == "answerSheet"){
					$('#answerSpan').html(data);
				}
				searchStudentAnswer(student_answer_status); 	// 학생 답안지 가져오는 ajax 
			}
		});
	}

	// 학생 답안지 가져오는 ajax 
	function searchStudentAnswer(student_answer_status) {
		$.ajax({
			url : "searchStudentAnswer.do",
			type : 'get',
			data : {
				'exam_info_num' : <%=request.getParameter("exam_info_num")%>,
				'member_id' : memberId,
				'student_answer_status' : student_answer_status
			},
			success : function(data) {
				$.each(data, function(index, entry) {

					var img_id = "img_ques_" + data[index].exam_question_seq
							+ "_" + data[index].student_answer_choice; // img_ques_5_3
					var ans_id = "ans_" + img_id; // ans_img_ques_5_3

					// 학생이 선택한 답의 보기 체크 - 객관식 
					$('#' + img_id).css("display", "block");
					$('#' + ans_id).css("display", "block");

					if (data[index].student_answer_status == 1) { // 학생이 푼 문제가 정답인 경우 

						// 문제번호에 o 
						var ques_id = "o_img_ques_"
								+ data[index].exam_question_seq;
						$('#' + ques_id).css("display", "block");

						// 답안지 문제번호에 o 
						$('#ans_o_img_ques_' + data[index].exam_question_seq)
								.css("display", "block");

						// 주관식란에 학생이 작성한 답 
						$('#ques_' + data[index].exam_question_seq).val(
								data[index].student_answer_choice);
						$('#ques_' + data[index].exam_question_seq + "_answer")
								.val(data[index].student_answer_choice);

					} else if (data[index].student_answer_status == 0) { // 학생이 푼 문제가 오답인 경우 

						// 문제번호에 x 
						var ques_id = "s_img_ques_"
								+ data[index].exam_question_seq;
						$('#' + ques_id).css("display", "block");

						// 답안지 문제번호에 x
						$('#ans_s_img_ques_' + data[index].exam_question_seq)
								.css("display", "block");

						// 문제에 정답 보기 체크 
						var ques_ans_id = "so_img_ques_"
								+ data[index].exam_question_seq + "_"
								+ data[index].question_answer;
						$('#' + ques_ans_id).css("display", "block");

						//답안지 정답 보기 체크 
						$(
								'#o_ans_img_ques_'
										+ data[index].exam_question_seq + '_'
										+ data[index].question_answer).css(
								"display", "block");

						// 주관식란에 학생이 작성한 답 + 정답
						var short_answer = data[index].student_answer_choice
								+ "  (정답 : " + data[index].question_answer
								+ ")";
						$('#ques_' + data[index].exam_question_seq).val(
								short_answer);
						$('#ques_' + data[index].exam_question_seq + "_answer")
								.val(short_answer);
					}
				});
			}
		});
	} 
</script>
</head>
<body>
<input type="hidden" id="member_id" value='<%=request.getParameter("member_id")%>'>	
	<div class="col-lg-12 mt">
		<div id="timerblock">
			<h3 class="mb exampaneldetailsubject">
				<i class="fa fa-angle-right"></i> ${exam_info.exam_info_name}
			</h3>
		</div>
		<div id="progressbar1"></div>
		<hr>
		<div class="panel-body" id="pastExamPaperPanel">
		
			<div id="pastExamQuestion">
				<div class="row content-panel exampaneldetail">
					<span id="examSpan"></span><!-- 문제 표기 -->
					<span id="answerSpan"></span><!-- 답안지 표기 -->
				</div>
			</div>
			
		</div>
		<div>
			<div class="col-lg-10 pastExamBtnDiv">
				<span id="prevPageSpan"></span>
				<span id="nextPageSpan"></span>
			</div>
			<div class="col-lg-2 pastExamBtnDiv2">
				<button class="btn btn-theme03" id="wrongQuestionBtn">틀린 문제만 보기</button>
			</div>
		</div>
	</div>
	</div>
</body>
</html>