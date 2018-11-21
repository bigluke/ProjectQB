<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta content="text/html; charset=UTF-8">
</head>
<body>
	<c:forEach items="${question }" var="question">
		<div class="questions">
			<div class="questionDiv col-lg-12 questionDiv_${question.question_num }">
				<div class="qnumdiv">
					<input type="checkbox" value="${question.question_num }"
						name="checkbox[]" class="hidden"/>
				</div>
				<!-- background img -->
				<img src="" class="check-img">
				<div class="col-lg-3 questionInfo">
					${question.md_category_name}<br> ${question.sm_category_name }<br>
					난이도: ${question.level_name}<br> 정답:
					${question.question_answer }<br>
					정답률:${question.question_correct_ratio}%<br> 출제자:
					${question.member_id }<br>
				</div>
				<div class="col-lg-9" id="questiontitle">
					<b>${question.question_name }</b><br> <br>
					<div class="questionImgDiv">
						<c:if test="${question.question_img  ne null }">
							<img
								src="${pageContext.request.contextPath}/upload/question/${question.question_img }"
								alt="NoImg" class="questionImg" />
							<!-- 문제에 이미지가 있다면 questionImgDiv 밑에 추가 -->
						</c:if>
					</div>
					<br>
					<div>
						<c:forEach items="${question_choice}" var="question_choice">
							<c:if test="${question_choice.question_num eq question.question_num}">
								<c:if test="${question_choice.question_choice_image ne null }">
									<p>${question_choice.question_choice_num})&nbsp; ${question_choice.question_choice_content} <br><img src="${pageContext.request.contextPath}/upload/question/${question_choice.question_choice_image}" alt="NoImg" class="questionChoiceImg" /></p>
								</c:if>
								<c:if test="${question_choice.question_choice_image eq null }">
									<p>${question_choice.question_choice_num})&nbsp; ${question_choice.question_choice_content}</p>
								</c:if>
							</c:if>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
	</c:forEach>
</body>
</html>