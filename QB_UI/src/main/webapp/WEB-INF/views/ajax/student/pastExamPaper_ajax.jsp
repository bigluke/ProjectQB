<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

	<!-- <div class="row content-panel exampaneldetail"> -->
		<form method="post" id="answerForm" target="examScheduleDetail">
			
			<c:set var="halfCount" value="${fn:length(questionList)/2}"/> <!-- 문제 전체 갯수의 반값, 지금은 총 6문제 중 3문제가 반이다 -->
			<c:set var="questionCount" value="0" />  <!-- 문제 하나가 업뎃 될 때마다 1씩 카운트 증가 -->
			
			<c:forEach var="question" items="${questionList}" varStatus="status">
				<c:if test="${questionCount == 0}">		
					<div class="col-lg-5 fst_div" id="examBox">
				</c:if> 
				<table class="questionTable">
					<tr class="questionTr">
						<td class="questionTd questionSpace">
							<div class="wrap">
								<img class="oximg_s"
									id="s_img_ques_${question.exam_question_seq}"
									src="${pageContext.request.contextPath}/img/oximg_s.png">
								<img class="oximg_o"
									id="o_img_ques_${question.exam_question_seq}"
									src="${pageContext.request.contextPath}/img/oximg_o.png">
							</div> <b>${question.exam_question_seq}. </b>
						</td>
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
												<img class="soximg_o"
													id="so_img_ques_${question.exam_question_seq}_${questionChoice.question_choice_num}"
													src="${pageContext.request.contextPath}/img/oximg_o.png">
											</div> ${questionChoice.question_choice_num})
										</td>
										<td><input type="radio"
											name="student_answer[${status.index}].student_answer_choice"
											id="ques_${question.exam_question_seq}_${questionChoice.question_choice_num}"
											value="${questionChoice.question_choice_num}"> 
											<label
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
							
							<c:set var="questionCount" value="${questionCount + 1}" />
						</c:when>
						<c:when test="${question.question_type eq '단답형'}">
							<tr class="ques_choice">
								<td class="questionTd"></td>
								<td><input type="text"
									id="ques_${question.exam_question_seq}"
									name="student_answer[${status.index}].student_answer_choice"
									readonly></td>
							</tr>
							<c:set var="questionCount" value="${questionCount + 1}" /> 
						</c:when>
					</c:choose>
				</table>
		<c:if test="${questionCount == halfCount || questionCount == halfCount + 0.5}"> 
	</div>
	<div class="col-lg-5 scd-div">
		</c:if> 
		</c:forEach>
	</div>

	</form>
