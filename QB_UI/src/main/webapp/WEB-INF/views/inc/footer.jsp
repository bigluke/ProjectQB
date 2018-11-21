<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="se"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<!--footer start-->
<footer class="site-footer">
	<se:authorize access="hasRole('ROLE_ADMIN')">
		<c:set var="ats" value="admin" />
	</se:authorize>
	<se:authorize access="hasRole('ROLE_TEACHER')">
		<c:set var="ats" value="teacher" />
	</se:authorize>
	<se:authorize access="hasRole('ROLE_STUDENT')">
		<c:set var="ats" value="student" />
	</se:authorize>
	<div class="text-center">
		<p>
			&copy; <strong>Team OneT</strong> of 비트캠프 서초 자바109기<br>
		</p>
		<a href="index.html#" class="go-top"> <i class="fa fa-angle-up"></i>
		</a> <a href="${pageContext.request.contextPath}/${ats }/aboutUs.do"> <i
			class="fa fa-gittip"></i><span>오시는 길</span>
		</a>
	</div>
</footer>
<!--footer end-->



<!-- 웹 소켓 사용해서 현재 몇개의 쪽지가 도착했는지 구해오기. -->

<script type="text/javascript">
	var socket = null;
	function send_message() {

		websocket = new WebSocket("ws://" + document.domain
				+ ":8090/qb/count.do");

		socket = websocket;

		websocket.onopen = function(evt) {
			console.log("connect");
			onOpen(evt);
		};
		websocket.close = function(evt) {
			onClolse(evt);
			console.log('disconnect');
		}
		websocket.onmessage = function(evt) {
			console.log('messge:' + evt);
			onMessage(evt);
		};
		websocket.onerror = function(evt) {
			onError(evt);
		};
	}
	function onOpen(evt) {
		websocket.send("${username}");
	}
	function Close(evt) {
		websocket.close();
	}
	function onMessage(evt) {
		console.log("evt.data: " + evt.data);
		$('#message2').html(evt.data);
	}
	function onError(evt) {

	}
</script>
<script>
	$(document).ready(function() {
		send_message();
	});
</script>
