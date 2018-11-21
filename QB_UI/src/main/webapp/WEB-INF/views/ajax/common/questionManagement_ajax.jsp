<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<% pageContext.setAttribute("newLineChar", "\n"); %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 

<c:if test="${fn:length(question) eq 0}">
	<div class="emptydata">
		<img src="${pageContext.request.contextPath}/img/empty-question.png" class="img-empty">
		<h1>등록된 문제가 없습니다.</h1>
	</div>
</c:if>
	<c:forEach items="${question }" var="question">
		<div class="myQuestions">
			<div
				class="questionDiv col-lg-12 questionDiv_${question.question_num }">
				
				<div class="col-lg-2">
					
					${question.md_category_name}<br> ${question.sm_category_name }<br>
					난이도: ${question.level_name}<br> 
					정답률:${question.question_correct_ratio}%<br> 출제자:
					${question.member_id }<br>
				</div>
				<div class="col-lg-9">
					<b>${fn:replace(question.question_name, newLineChar, "<br/>")}</b><br> <br>
					<div class="questionImgDiv">
					<!-- 문제에 이미지가 있다면 questionImgDiv 밑에 추가 -->
						<c:if test="${question.question_img ne null }">
							<img
								src="${pageContext.request.contextPath}/img/${question.question_img}"
								alt="questionImg" class="questionImg" />
						</c:if>
					</div>
					<div>
						
							<p>정답:  ${question.question_answer } </p>
						<br>
					
						<c:forEach items="${question_choice}" var="question_choice">
							<c:if
								test="${question_choice.question_num eq question.question_num}">
								<div class="col-lg-6 QCdiv">
								<p>${question_choice.question_choice_num}. &nbsp;&nbsp; ${question_choice.question_choice_content}</p>
									<c:if test="${question_choice.question_choice_image ne null }">
										<img
										src="${pageContext.request.contextPath}/img/${question_choice.question_choice_image}"
										alt="choiceImg" class="choiceImg" />
										<!-- 문제에 이미지가 있다면 questionImgDiv 밑에 추가 -->
									</c:if>
								</div>
							</c:if>
						</c:forEach>
					</div>
				</div>
				<div class="col-lg-1">
					<button type="button" id="updateMyQuestionBtn" name="updateMyQuestionBtn" 
					class="btn btn-theme buttonGroup updateMyQuestionBtn"
					value="${question.question_num}">
					<i class="fa fa-pencil"></i> 수정</button>
					
					<button type="button" id="deleteMyQuestionBtn" name="deleteMyQuestionBtn"
					class="btn btn-theme04 buttonGroup deleteMyQuestionBtn"
					value="${question.question_num}">
					<i class="fa fa-trash-o"></i> 삭제</button>
					
				</div>
			</div>
		</div>
		<div class="col-lg-12">
			<hr>
		</div>
	</c:forEach>
