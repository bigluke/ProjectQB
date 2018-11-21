<%--
	@JSP:studentInfo.jsp
	@DATE:2018-10-11
	@Author:양회준
	@Desc:학생 & 성적 관리(스토리보드 20 of 41)	
 --%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="${pageContext.request.contextPath}/css/studentInfo.css" rel="stylesheet">
<section id="main-content">
	<section class="wrapper site-min-height">
		<div class="row mt">
			<div class="col-lg-12">
				<div class="row content-panel">
					<%-- 탭 머리 시작 --%>
					<div class="panel-heading">
						<ul class="nav nav-tabs nav-justified">
          					<li class="active">
            					<a data-toggle="tab" href="#studentInfo">학생정보</a>
          					</li>
          					<li>
            					<a data-toggle="tab" href="#studentChart">학생 개인 성적확인</a>
          					</li>
          					<li>
            					<a data-toggle="tab" href="#classChart">클래스 통계</a>
          					</li>
        				</ul>
					</div><!-- panel-heading -->
					<%-- 탭 머리 종료 --%>
					
					<%-- 탭 본문 영역 시작--%>
					<div class="panel-body">
						<div class="tab-content">
							<%-- 학생 정보 탭 시작 --%>
							<div id="studentInfo" class="tab-pane active">
								<div class="row">
								<%-- 학생 목록 시작 --%>
								<div class="col-lg-2">
									<section class="panel">
										<div class="panel-body">																					
											<table id="studentList1" class="table table-hover">
												<h4>${studentList[0].class_name}</h4>
									                <thead>
									                  <tr>
									                    <th id="studentListTh"><i class="fa fa-bullhorn">&nbsp;</i>학생목록</th>
									                  </tr>
									                </thead>
									                <tbody>									                
												<c:forEach items="${studentList}" var="studentList">												
								                  <tr>
								                    <td id="${studentList.member_id}" class="studentListMembers">
								                      <img src=""
															class="img-circle" width="25"> ${studentList.member_name}
								                    </td>
								                   </tr>												
												</c:forEach>
											</tbody>
											</table>
										</div>
									</section>
								</div>
								<%-- 학생 목록 끝 --%>
								
								
								<%-- 선택 학생 정보 영역 시작 --%>
								<div class="col-lg-10">
									<h3 id="studentListName">&nbsp;&nbsp;${studentList[0].member_name}(${studentList[0].member_id})</h3>
									<h4 id="studentListEmail">이메일 : ${studentList[0].member_email}</h4>
									<h4 id="studentListPhone">핸드폰 : ${studentList[0].member_phone}</h4>

										<!-- page start-->
										<div class="tab-pane" id="chartjs">
											<div class="row mt">
												<%--각 시험 성적 바 차트 --%>
												<div class="col-lg-6">
													<div class="content-panel">
														<h4>
															<i class="fa fa-angle-right"></i> 각 시험 성적
														</h4>
														<div id="divline1" class="panel-body text-center">
															<canvas id="line1" height="300" width="400"></canvas>
														</div>
													</div>
												</div>
											
											<%-- 반/학생 평균 선 차트 --%>
											<div class="col-lg-6">
												<div class="content-panel">
													<h4>
														<i class="fa fa-angle-right"></i> 반/학생 평균 비교
													</h4>
													<div id="divbar1" class="panel-body text-center">
														<canvas id="bar1" height="300" width="400"></canvas>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<%-- 선택 학생 정보 영역 끝 --%>
								
								
								</div><!-- row -->
							</div><!-- studentInfo -->
							<%-- 학생 정보 탭 끝 --%>
							
							<%-- 학생 개인 성적확인 탭 시작 --%>
						<div id="studentChart" class="tab-pane">
							<div class="row">
								<!-- 학생목록 시작-->
								<div class="col-lg-2">
									<section class="panel">
										<div class="panel-body">
											<table id="studentList2" class="table table-hover">
												<h4 id="tab2_className">${studentList[0].class_name}</h4>
									                <thead>
									                  <tr>
									                    <th id="studentListTh"><i class="fa fa-bullhorn">&nbsp;</i>학생목록</th>
									                  </tr>
									                </thead>
									                <tbody>									                
												<c:forEach items="${studentList}" var="studentList">												
								                  <tr>
								                    <td id="${studentList.member_id}" class="tab2studentListMembers">
								                      <img src=""
															class="img-circle" width="25"> ${studentList.member_name}
								                    </td>
								                   </tr>
								                </c:forEach>
											</tbody>
											</table>
										</div>
									</section>
								</div>
								<!-- 학생목록 끝-->
								<!-- 학생 개인성적 리스트 시작-->
								<div class="col-lg-10 unread">
									<section class="panel">
										<header class="panel-heading wht-bg">
											<h4 class="gen-case">
												<span id="tab2_studentName">${studentList[0].member_name}(${studentList[0].member_id})</span>
												<form action="#" class="pull-right mail-src-position">
													<div class="input-append">
														<input type="text" id="searchExamValue"class="form-control "
															placeholder="검색어를 입력하세요">
													</div>
												</form>
											</h4>
										</header>
										<div class="panel-body minimal">
											<div class="table-inbox-wrap" id="search-append">											
												<%-- <c:forEach items="${studentExamScoreInfo}" var="studentExamScoreInfo">
													<div class="col-lg-12 deleteline">
														<div class="div-left">
															<img src="" class="testIcon">
														</div>
														<div class="exam_info_name">
															<h4>
																<strong>${studentExamScoreInfo.exam_info_name}</strong>																
															</h4>				
															<p>
																&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class="fa fa-tag"></i>&nbsp;&nbsp;
																<c:forEach items="${studentExamScoreInfo.smCtgrName}" var="test">${test}&nbsp;&nbsp;</c:forEach>
															</p>
															<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 시험 날짜 :
																${studentExamScoreInfo.exam_info_date } ( ${studentExamScoreInfo.exam_info_start}~${studentExamScoreInfo.exam_info_end })</p>
																
														</div>
														<div class="div-right">
															<button type="button" id="pastExamBtn"class="btn btn-theme mt pastExamBtn" value="${studentExamScoreInfo.exam_info_num }">성적확인</button>																
															<button type="button" id="ExamCommentBtn"class="btn btn-theme mt ExamCommentBtn" value="">평가등록</button>
														</div>
													</div>
												</c:forEach> --%>
											</div>
										</div>
									</section>
								</div>
								<!-- 학생 개인성적 리스트 끝 -->
							</div>
							<!-- /row -->
						</div>
						<%-- 학생 개인 성적 탭 끝 --%>
						
						<%-- 클래스 통계 탭 시작 --%>
						<div id="classChart" class="tab-pane">
							<h3><i class="fa fa-angle-right"></i> ${studentList[0].class_name}</h3>
							<div class="row">
								<%-- 클래스 학생 표/차트 시작 --%>
								<div class="col-lg-12">	
										<div class="row">
										
											<%-- 반평균 막대 차트 --%>
											<div class="col-lg-6">
												<div class="content-panel pnHeight">
													<h4 id="classChartName">
														<i class="fa fa-angle-right"></i> 각 시험 평균 및 표준편차
													</h4>
													<div class="btn-group pull-right">
														<select id="selectChart" class="form-control selectChart" name="selectChart">
															<option value="classAvgStd">각 시험 평균 및 표준편차</option>
															<option value="classAvg">각 시험 평균</option>															
															<option value="classStd">각 시험 표준편차</option>																
														</select>
													</div>
													<div id="divbar2" class="panel-body text-center">
														<canvas id="bar2" height="200"></canvas>
													</div>
												</div>
											</div>
											<%-- 반 등수 표 --%>
											<div class="col-lg-6">
												<div class="content-panel pnHeight">
													<h4>
														<i class="fa fa-angle-right"></i> 시험별 반 등수
													</h4>
													<div class="btn-group pull-right">
														<select id="searchExam" class="form-control searchControl"
																name="searchExam">
															<option value="0" >시험 목록</option>		
															<c:forEach items="${classChart}" var="classChart">
																<option value="${classChart.exam_info_num}">${classChart.exam_info_name}</option>		
															</c:forEach>
														</select>
													</div>
													<br><br>
													<div class="panel-body text-center">
														<div class="table-inbox-wrap">
															<table id="classRankTable"
																class="table table-bordered table-striped table-condensed">
																<thead>
																	<tr>
																		<th>이름</th>									
																		<th>순위</th>
																	</tr>
																</thead>
															</table>
														</div>
													</div>
												</div>
											</div>
										</div>
										
										<div class="row mt">
											<%-- 점수별 학생 분포 차트 --%>
											<div class="col-lg-12">
												<div class="content-panel">
													<h4>
														<i class="fa fa-angle-right"></i> 점수별 학생 분포
													</h4>
													<div class="btn-group pull-right">
														<select id="searchSpread" class="form-control searchControl"
																name="searchSpread">
															<option value="">시험 목록</option>		
															<c:forEach items="${classChart}" var="classChart">
																<option value="${classChart.exam_info_num }">${classChart.exam_info_name}</option>		
															</c:forEach>
														</select>
													</div>
													<div id="divline2" class="panel-body">
														<canvas id="line2" height="300"></canvas>
													</div>
												</div>
											</div>
										</div>
										
										<div class="row mt">
											<%-- 학생별 성적표 시작--%>
											<div class="col-lg-12">
												<div class="content-panel">
													<h4>
														<i class="fa fa-angle-right"></i> 학생별 성적표
													</h4>
													<div class="panel-body text-center">
														<table id="studentPerGrade" class="display" style="width: 100%">
															<thead>
																<tr>
																	<th>학생 이름</th>
																		<c:forEach items="${classChart}" var="subject">
																		<th id="${subject.exam_info_name}">${subject.exam_info_name}</th>
																		</c:forEach>
																	<th>평균</th>
																</tr>
															</thead>
															<tbody>
																<c:forEach items="${studentExamScoreList}" var="tablelist">
																<tr>
																	<td>${tablelist.member_name}</td>
																	<c:forEach items="${classChart}" var="subjectScore" varStatus="chk">
																	<td>
																	<c:set var="score" value="-1"/>
																		<c:forEach items="${tablelist.score_list}" var="inner" varStatus="innerchk">																		
																		<c:if test="${classChart[chk.index].exam_info_name eq inner.key}">																			
																			${inner.value}
																			<c:set var="score" value="${inner.value}"/>
																		</c:if>
																		</c:forEach>
																	<c:if test="${score==-1}">미응시대상</c:if>	
																	</td>
																	</c:forEach>
																	<td>${tablelist.avg_score}</td>
																</tr>
																</c:forEach>
															</tbody>
														</table>
													</div>
												</div>
											</div>
											<%-- 학생별 성적표 끝--%>
										</div>
								</div>
								<%-- 클래스 학생 표/차트 끝 --%>
							</div>
							<!-- /row -->
							</div>
							<%-- 클래스 통계 탭 끝 --%>
						
						</div> <!-- tab-content -->
					</div> <!-- panel-body -->
				</div><!-- /row content-panel-->
			</div><!-- /col-lg-12 -->
		</div><!-- /row mt -->
	</section><!-- /wrapper -->
</section><!-- /MAIN CONTENT -->
<%--ChartJS--%>
<%--ChartJS CDN--%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
<%--ChartJS 차트 경로--%>
<script src="${pageContext.request.contextPath}/lib/onet-js/studentInfo.js" type="text/javascript"></script>
<!-- SweetAlert CDN -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
$(".studentListMembers").each(function(){
	var name = $(this).text().trim();
	var code=name.charCodeAt(1)%13;
	var img=$(this).children();	
	for(var i=0;i<14;i++){
		switch(code){
			case i: img.attr("src","${pageContext.request.contextPath}/img/portrait/portrait"+i+".png"); break;
		}
	}
});
$(".tab2studentListMembers").each(function(){
	var name = $(this).text().trim();
	var code=name.charCodeAt(1)%13;
	var img=$(this).children();	
	for(var i=0;i<14;i++){
		switch(code){
			case i: img.attr("src","${pageContext.request.contextPath}/img/portrait/portrait"+i+".png"); break;
		}
	}
});


$(document).ready(function(){
	 $('a[data-toggle="tab"]').on( 'shown.bs.tab', function (e) {
	        $.fn.dataTable.tables( {visible: true, api: true} ).columns.adjust();
	    } );
	 
	//차트 데이터 담을 배열
	var chartStudentDatas = new Array();
	var chartStudentRanks = new Array();
	var chartClassDatas = new Array();
	var chartClassStudentDatas = new Array();
	var chartLabels = new Array();
	var chartStudentLabels = new Array();
	var spreadScore;
	//시험번호
	var examInfoNum = "${classChart[0].exam_info_num}<c:if test='${classChart[0].exam_info_num==null}'>0</c:if>";
	var examInfoName = "${classChart[0].exam_info_name}";
	
	//학생목록 배열에 jstl값 담기
	<c:forEach items="${studentChart}" var="studentChart">
		chartStudentDatas.push("${studentChart.score_chart_score}");
		chartStudentLabels.push("${studentChart.exam_info_name}");
		chartClassStudentDatas.push("${studentChart.class_chart_avg}");	
		chartStudentRanks.push("${studentChart.score_chart_rank}");
	</c:forEach>
	<c:forEach items="${classChart}" var="classChart">
		chartLabels.push("${classChart.exam_info_name}");
		chartClassDatas.push("${classChart.class_chart_avg}");
	</c:forEach>
	
	
	//학생&성적관리 학생목록 데이터 담은 배열
	var studentArr= new Array();
	//학생목록 배열에 jstl값 담기		
	<c:forEach items="${studentList}" var="studentList">
		var json=new Object();
		json.member_id="${studentList.member_id}";
		json.member_email="${studentList.member_email}";
		json.member_name="${studentList.member_name}";
		json.member_phone="${studentList.member_phone}";
		json.class_name="${studentList.class_name}";
		studentArr.push(json);
	</c:forEach>
	var memberId=studentArr[0].member_id;
	var memberName=studentArr[0].member_name;
	var className=studentArr[0].class_name;
	//tab2AjaxData
	var tab2AjaxData="";
	//tab2AjaxData 가져오기 함수
  	function tab2Ajax(){
		$.ajax({
			type:"post",
			url:"studentExamScoreInfo.do",
			data:{
				"member_id":memberId,
				"class_name":className
				},
			datatype:"json",
			success:function(data, status){

				tab2AjaxData=data;
				var studentExamScoreSrc = "";
				$("#search-append").empty();
				$(data).each(function(index, element){
					var smCtgr="";
					$(element.smCtgrName).each(function(index, name){ //소분류 추출
						smCtgr += name+'&nbsp;&nbsp;';
					});
					studentExamScoreSrc += '<div class="col-lg-12 deleteline">';
					studentExamScoreSrc += '<div class="div-left"><img src="" class="testIcon"></div>';
					studentExamScoreSrc += '<div class="exam_info_name">';
					studentExamScoreSrc += '<h4><strong>'+element.exam_info_name+'</strong></h4>';
					studentExamScoreSrc += '<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class="fa fa-tag"></i>&nbsp;&nbsp'+smCtgr+'</p>';				
					studentExamScoreSrc += '<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 시험 날짜 : '+element.exam_info_date+'('+element.exam_info_start+'~'+element.exam_info_end+')';
					studentExamScoreSrc += '<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class="fa fa-comment-o"></i> </span><span class="comment">'+element.score_chart_comment+'</p>';
					studentExamScoreSrc += '</div>';
					studentExamScoreSrc += '<div class="div-right">';
					studentExamScoreSrc += '<button type="button" id="pastExamBtn"class="btn btn-theme mt pastExamBtn" value="'+element.exam_info_num+'">성적확인</button>';
					studentExamScoreSrc += '<button type="button" id="ExamCommentBtn"class="btn btn-theme mt ExamCommentBtn" value="">평가등록</button>';
					studentExamScoreSrc += '</div></div>';
				});
				$("#search-append").append(studentExamScoreSrc);	
				$(".testIcon").each(function(){
					var testIcon = $(this);	
					var code= testIcon.parents().children('.exam_info_name').children('h4').children('strong').eq(0).text().charCodeAt(1)%6;
					for(var i=0;i<6;i++){
						switch(code){
							case i: testIcon.attr("src","${pageContext.request.contextPath}/img/testIcon/exam"+i+".png"); break;
						}
					}
				});
			},
			error:function(error, status){
				
			}
		});
	}
	
	$(document).on('click', '.ExamCommentBtn', function(){
		$(this).parent().prev().children().eq(3).children().eq(1).text();
		var text = $(this).parent().prev().children().eq(3).children().eq(1).text();
		var examInfoNum=$(this).prev().val();
		
		var getAreaStart =$("#tab2_studentName").text().indexOf("(");
		var getAreaEnd =$("#tab2_studentName").text().indexOf(")");
		var memberId=$("#tab2_studentName").text().substring(getAreaStart+1, getAreaEnd);
		
		swal({
			text: '평가를 입력해 주세요.',
			content: {
				element:"input",
				attributes:{value:text}
				},
				buttons:['취소','등록!']
			})
			.then(name => {				
  				if (!name) throw null; 
  				$(this).parent().prev().children().eq(3).children().eq(1).text(name);
  				return fetch('studentInfoCommentUpdate.do?member_id='+memberId+'&exam_info_num='+examInfoNum+'&score_chart_comment='+name);
  			})  			
  			.then(result => {
  			  return result;
  			})		 
  			.then(result => {
			 
			if (!result) {
				return swal("등록이 실패되었습니다.");
			} 
  			  swal({
  			    title: "등록 성공",
  			    text: "답변 등록이 성공했습니다.",
  			    icon: "success",
  			  });
  			})
  			.catch(err => {
  			  if (err) {
  			    swal("등록 실패", "The AJAX request failed!", "error");
  			  } else {
  			    swal.stopLoading();
  			    swal.close();
  			  }
  			});
		})
	/* 양회준 11.5 코멘트 관련 끝*/
	
	//tab2AjaxData 가져오기 실행
	tab2Ajax();	
	//첫 화면 차트	
	functionChart();
	//점수분포 차트
	spreadChart();
	
	$('#studentList1').DataTable({
		"ordering": false,
		"scrollY":"390px",
		"scrollCollapse": false,
		"paging": false,
		"searching": false,
		"language": {
            "url": "//cdn.datatables.net/plug-ins/1.10.19/i18n/Korean.json"
        }
	});
	$('#studentList2').DataTable({
		"ordering": false,
		"scrollY":"390px",
		"scrollCollapse": false,
		"paging": false,
		"searching": false,
		"language": {
            "url": "//cdn.datatables.net/plug-ins/1.10.19/i18n/Korean.json"
        }
	});
	var rankTable=$('#classRankTable').DataTable({
		"ordering": false,
		"scrollY":"220px",
		"scrollCollapse": false,
		"paging": false,
		"searching": false,
		"language": {"url": "//cdn.datatables.net/plug-ins/1.10.19/i18n/Korean.json"},
        "processing":true,
		"ajax": {
           method: "post",
           url:"classRank.do",
			data:{"exam_info_num":function(){ return examInfoNum}},
           dataSrc:"",
           xhrFields: {withCredentials: true}
		},
		"columns":
			[
			{data: "member_name" },
			{data: function(data){
				if(data.score_chart_rank==0){
					return "미응시";
				}else{
					return data.score_chart_rank;
				}
				}
			}
			]
	});	
	
	var studentPerGrade=$('#studentPerGrade').DataTable({
		"ordering":true,
		"paging": true,
		"searching": true,
		"LengthChange" : true,
		"lengthMenu": [[10,30,-1],[10,30,"All"]],
		"language": {"url": "//cdn.datatables.net/plug-ins/1.10.19/i18n/Korean.json"},		
		dom: 'Bfrtlip',//DataTables 출력기능 및 옵션 위치설정
        buttons:[
        	{
                extend: 'copyHtml5',
                exportOptions: {
                    columns: [':visible' ]
                }
            },
        	{
	            extend:'excelHtml5',
	            exportOptions:{
	            	columns:[':visible']
	            	}
            },
        	{
	        	extend:'pdfHtml5',
	        	exportOptions:{
	        		columns:[':visible']
	        		}
        	},
        	'colvis'
        ]
	})
	
	//학생 목록 선택 이벤트-tab1
	$(".studentListMembers").click(function(){		
		//가져온 차트데이터 담을 배열(학생점수, 반평균, 과목)	
		chartStudentDatas = [];
		chartStudentRanks=[];
		chartClassDatas = [];
		chartClassStudentDatas = [];
		chartStudentLabels = [];
		chartLabels = [];		
		//클릭한 목록의 학생이름 가져오기 & 출력
		var memberName=$(this).text().trim();
		//학생 목록의 인덱스 가져오기
		var memberIndex=$(".studentListMembers").index(this);
		
		$("#studentListName").text(memberName+"("+studentArr[memberIndex].member_id+")");
				
		//선택한 학생의 이메일과 핸드폰 값 가져와 출력하기
		$("#studentListEmail").text("이메일 : "+studentArr[memberIndex].member_email);
		$("#studentListPhone").text("핸드폰 : "+studentArr[memberIndex].member_phone);
		//ajax 차트 요청할 parameter
		memberId=studentArr[memberIndex].member_id;
		className=studentArr[memberIndex].class_name;
		//비동기 실행
		
		$.ajax({
			type:"post",
			url:"studentChartInfo.do",
			data:{"member_id":memberId,
				"class_name":className
				},
			datatype:"json",
			global: false,
			success:function(data, status){
				//넘어온 map객체의 학생차트정보
				$(data.studentName).each(function(index, element){					
					chartStudentDatas.push(element.score_chart_score);
					chartStudentRanks.push(element.score_chart_rank);
					chartStudentLabels.push(element.exam_info_name);
					chartClassStudentDatas.push(element.class_chart_avg);
				});
				//넘어온 map객체의 클래스차트정보
				$(data.className).each(function(index, element){
					chartLabels.push(element.exam_info_name);
					chartClassDatas.push(element.class_chart_avg);					
				});
				$("#bar1").remove();
				$("#divbar1").append('<canvas id="bar1" height="300" width="400"></canvas>');
				$("#line1").remove();
				$("#divline1").append('<canvas id="line1" height="300" width="400"></canvas>');
				
				functionChart();
			},
			error:function(error, status){

			}
		});
		
	});
	//학생목록 이벤트 종료
	
	//학생 목록 선택 이벤트-tab2
	
	$(".tab2studentListMembers").click(function(){		
		$("#tab2studentListMembers").val("");
		//학생 목록의 인덱스 가져오기
		var memberIndex=$(".tab2studentListMembers").index(this);
		//클릭한 목록의 학생이름 가져오기 & 출력
		var memberName=$(this).text().trim();
		var className=$("#tab2_className").text().trim();
		$("#tab2_studentName").text(memberName+"("+studentArr[memberIndex].member_id+")");
		//학생 목록의 인덱스 가져오기
		var memberIndex=$(".tab2studentListMembers").index(this);
		//ajax 시험 정보 요청할 parameter
		memberId=studentArr[memberIndex].member_id;
		className=studentArr[memberIndex].class_name;
		
		tab2Ajax();
	});
	
	//학생목록 이벤트 종료
	$("#searchExamValue").keyup(function(){
		$("#search-append").empty();
		var inputKey=$("#searchExamValue").val();
		var studentExamScoreSrc="";
		$(tab2AjaxData).each(function(index, element){
			var smCtgr="";
			if(element.exam_info_name.match(inputKey) || element.smCtgrName.toString().match(inputKey) ||
					element.exam_info_date.match(inputKey)){//시험명, 소분류, 날짜 검색
				$(element.smCtgrName).each(function(index, name){ //소분류 추출
					smCtgr += name+'&nbsp;&nbsp;';
				});	
				studentExamScoreSrc += '<div class="col-lg-12 deleteline">';
				studentExamScoreSrc += '<div class="div-left"><img src="" class="testIcon"></div>';
				studentExamScoreSrc += '<div class="exam_info_name">';
				studentExamScoreSrc += '<h4><strong>'+element.exam_info_name+'</strong></h4>';
				studentExamScoreSrc += '<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class="fa fa-tag"></i>&nbsp;&nbsp'+smCtgr+'</p>';				
				studentExamScoreSrc += '<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 시험 날짜 : '+element.exam_info_date+'('+element.exam_info_start+'~'+element.exam_info_end+')';
				studentExamScoreSrc += '<p><i class="fa fa-comment-o"></i> </span><span class="comment">'+element.score_chart_comment+'</p>';
				studentExamScoreSrc += '</div>';
				studentExamScoreSrc += '<div class="div-right">';
				studentExamScoreSrc += '<button type="button" id="pastExamBtn"class="btn btn-theme mt pastExamBtn" value="'+element.exam_info_num+'">성적확인</button>';
				studentExamScoreSrc += '<button type="button" id="ExamCommentBtn"class="btn btn-theme mt ExamCommentBtn" value="">평가등록</button>';
				studentExamScoreSrc += '</div></div>';
			}
		});		
		$("#search-append").append(studentExamScoreSrc);
		$(".testIcon").each(function(){
			var testIcon = $(this);	
			var code= testIcon.parents().children('.exam_info_name').children('h4').children('strong').eq(0).text().charCodeAt(1)%6;
			for(var i=0;i<6;i++){
				switch(code){
					case i: testIcon.attr("src","${pageContext.request.contextPath}/img/testIcon/exam"+i+".png"); break;
				}
			}
		});
	})
		
	/*지난 시험지 보기*/

	$(document).on('click', '#pastExamBtn', function(){	//	ajax로 가져온 버튼이 안 먹을 때 click 이벤트		
		var now = new Date().getTime();  //  현재 시간을 timestamp으로 계산
		var examEndTime = $(this).parent().prev().children().eq(2).text().trim();	//	시험 종료 시간을 timestamp 으로 계산		
		var EndDate = examEndTime.substr(8,10);		
		var EndTime = examEndTime.substr(-9, 8);
		
		var year = EndDate.substr(0,4);
		var month = EndDate.substr(5,2);
		var day = EndDate.substr(8,2);
		var hour = EndTime.substr(0, 2);
		var minute = EndTime.substr(3, 2);
		var examEndTimeTs = new Date(year, month-1, day, hour, minute).getTime();
		
		 if( examEndTimeTs < now ){   // 지난 시험 열람 가능
			var getAreaStart =$("#tab2_studentName").text().indexOf("(");
			var getAreaEnd =$("#tab2_studentName").text().indexOf(")");
			var getId=$("#tab2_studentName").text().substring(getAreaStart+1, getAreaEnd);
			var popUrl = "pastExamPaper.do?exam_info_num=" + $(this).val()+"&member_id="+getId;
			var popOption = "width=1000px, resizable=no, location=no, left=50px, top=100px";
			window.open(popUrl, "지난 시험보기",popOption);	
		   } else if ( examEndTimeTs > now ){	//	시험 응시 시간이 지나지 않았다면 열람 불가능
			swal("\n시험 시간이 종료되고 열람이 가능합니다.");
		 }   
	});
	
	//첫화면 차트
	function functionChart(){
		//각 시험 석차 선 차트 시작	
		var ctx = document.getElementById('line1').getContext('2d');
		ctx.canvas.height = $('#divline1').height();
		ctx.canvas.width = $('#divline1').width();
		var myBarChart = new Chart(ctx, {
		    type: 'line',
		    data: {
		      labels: chartStudentLabels,
		      datasets: [
		        {
		          label: "학생 등수",
		          backgroundColor: '#ffa366',
		          borderColor: '#ffa366',
		          fill:false,
		          lineTension : 0,
		          data: chartStudentRanks
		        }
		      ]
		    },
		    options:{
		      layout: {
		          padding: {
		              left: 10,
		              right: 10,
		              top: 10,
		              bottom: 10
		          }
		      },
		      scales: {
			    	 xAxes: [{
			    	     ticks: {
			    	       callback: function(value) {
			    	         if (value.length > 4) {
			    	          	return value.substr(0, 4) + '...'; //차트라벨 4글자 이후에 ... 처리
			    	        	} else {
			    	           	return value
			    	        	}
			    	        },
			    	      }
			    	    }],
		    	
		         yAxes: [{
		         ticks: {
		             reverse: true
		         }
		     }] 
		       },
		       tooltips: {
		    	    enabled: true,
		    	    mode: 'label',
		    	    callbacks: {
		    	      title: function(tooltipItems, data) {
		    	        var idx = tooltipItems[0].index;
		    	        return data.labels[idx];
		    	      }
		    	    }
		    	  },		       
		    }
		});
		//각 시험 석차 선 차트 끝
		
		//반/학생 평균 바 차트 시작
		var ctx = document.getElementById('bar1').getContext('2d');
		ctx.canvas.height = $('#divbar1').height();
		ctx.canvas.width = $('#divbar1').width();
		var chart = new Chart(ctx, {
		  type: 'bar',
		  data: {
		      labels: chartStudentLabels,
		      datasets: [
		        {
		          label: "반 평균 성적",
		          backgroundColor: 'rgb(255, 99, 132)',
		          borderColor: 'rgb(255, 99, 132)',
		          data: chartClassStudentDatas,
		      },
		      {
		          label: "학생 성적",
		          backgroundColor: 'rgb(122, 99, 132)',
		          borderColor: 'rgb(122, 99, 132)',
		          fill : false,
		          lineTension : 0,
		          data: chartStudentDatas,
		        }
		      ]
		    },
		    options: {
		        scale: {
		            ticks: {
		              beginAtZero:true,
		                min:0,
		                max:100
		            }
		        },
		        layout: {
		            padding: {
		                left: 10,
		                right: 10,
		                top: 10,
		                bottom: 10
		            }
		        },
		        scales: {
			    	 xAxes: [{
			    	     ticks: {
			    	       callback: function(value) {
			    	         if (value.length > 4) {
			    	          	return value.substr(0, 4) + '...'; //차트라벨 4글자 이후에 ... 처리
			    	        	} else {
			    	           	return value
			    	        	}
			    	        },
			    	      }
			    	    }],
		          yAxes: [{
		           ticks: {
		               max: 100,
		               min: 0,
		               stepSize: 10
		           }
		       }]
		         },
			       tooltips: {
			    	    enabled: true,
			    	    mode: 'label',
			    	    callbacks: {
			    	      title: function(tooltipItems, data) {
			    	        var idx = tooltipItems[0].index;
			    	        return data.labels[idx];
			    	      }
			    	    }
			    	  },		         
		        
		    }
		});
		//반/학생 평균 선 차트 끝
	}
	//첫화면 차트
	
	//클래스 통계화면 첫 차트 시작
		var stdDatas = new Array();
		<c:forEach items="${std}" var="std">
			stdDatas.push(Math.round(${std}*100)/100);
		</c:forEach>
		
		var classChart = document.getElementById('bar2').getContext('2d');
		var myBarChart = new Chart(classChart, {
			type: 'bar',
			data: {
				labels: chartLabels,
				datasets: [
					{
						label: "각 시험 표준편차",
						yAxisID: 'std',
						backgroundColor: 'rgb(169, 99, 132)',
						borderColor: 'rgb(169, 99, 132)',
						data: stdDatas,
						fill:false,
						lineTension:0,
						type:'line'						
					},
					{
						label: "각 시험 평균",
						yAxisID: 'avg',
						backgroundColor: 'rgb(255, 99, 132)',
						borderColor: 'rgb(255, 99, 132)',
						data: chartClassDatas
					}
				
				]
			},
			options:{
				layout: {
					padding: {
						left: 10,
						right: 10,
						top: 10,
						bottom: 30
					}
				},
				scales: {
			    	 xAxes: [{
			    	     ticks: {
			    	       callback: function(value) {
			    	         if (value.length > 4) {
			    	          	return value.substr(0, 4) + '...'; //차트라벨 4글자 이후에 ... 처리
			    	        	} else {
			    	           	return value
			    	        	}
			    	        },
			    	      }
			    	    }],
			    	    yAxes: [
							{
								id:'std',
								type:'linear',
								position:'right',
								ticks: {
									max: 30,
									min: 0,
									stepSize: 10
								}
							},
							{
							id:'avg',
							type:'linear',
							position:'left',
							ticks: {
								max: 100,
								min: 0,
								stepSize: 20
							}
						}]
				},
			       tooltips: {
			    	    enabled: true,
			    	    mode: 'label',
			    	    callbacks: {
			    	      title: function(tooltipItems, data) {
			    	        var idx = tooltipItems[0].index;
			    	        return data.labels[idx];
			    	      }
			    	    }
			    	  }			
			}
		});
	 //클래스 통계화면 첫 차트 끝
	
	// 시험문제 목록 선택 시작
	$("#searchExam").change(function() {
		$("#searchExam option:selected").each(function () {
			examInfoNum=$("#searchExam option:selected").val();
			rankTable.ajax.reload();
		});
	});
	// 각 시험 차트 선택
	
	$("#selectChart").change(function() {
		$("#selectChart option:selected").each(function () {
			var examchart=$("#selectChart option:selected").val();
			var title=$("#classChartName");
			$("#bar2").remove();
			$("#divbar2").append('<canvas id="bar2" height="200"></canvas>');
			if(examchart=="classAvg"){//각 시험 평균
				title.html("<i class='fa fa-angle-right'></i> 각 시험 평균");
				var classChart = document.getElementById('bar2').getContext('2d');
				var myNewChart = new Chart(classChart, 
						{ type: 'bar',
							data: {
								labels: chartLabels,
								datasets: [
									{
										label: "각 시험 평균",
										backgroundColor: 'rgb(255, 99, 132)',
										borderColor: 'rgb(255, 99, 132)',
										data: chartClassDatas
									}
								]
							},
							options:{
								layout: {
									padding: {
										left: 10,
										right: 10,
										top: 10,
										bottom: 30
									}
								},
								scales: {
							    	 xAxes: [{
							    	     ticks: {
							    	       callback: function(value) {
							    	         if (value.length > 4) {
							    	          	return value.substr(0, 4) + '...'; //차트라벨 4글자 이후에 ... 처리
							    	        	} else {
							    	           	return value
							    	        	}
							    	        },
							    	      }
							    	    }]
								},
							       tooltips: {
							    	    enabled: true,
							    	    mode: 'label',
							    	    callbacks: {
							    	      title: function(tooltipItems, data) {
							    	        var idx = tooltipItems[0].index;
							    	        return data.labels[idx];
							    	      }
							    	    }
							    	  }			
							}});
			}else if(examchart=="classStd"){//각 시험 표준편차
				title.html("<i class='fa fa-angle-right'></i> 각 시험 표준편차");
				var classChart = document.getElementById('bar2').getContext('2d');
				var myNewChart = new Chart(classChart, { 
					type: 'line', 
					data: {
						labels: chartLabels,
						datasets: [
							{
								label: "각 시험 표준편차",
								backgroundColor: 'rgb(169, 99, 132)',
								borderColor: 'rgb(169, 99, 132)',
								data: stdDatas,
								fill:false,
								lineTension:0
							}						
						]
					},
					options:{
						layout: {
							padding: {
								left: 10,
								right: 10,
								top: 10,
								bottom: 30
							}
						},
						scales: {
					    	 xAxes: [{
					    	     ticks: {
					    	       callback: function(value) {
					    	         if (value.length > 4) {
					    	          	return value.substr(0, 4) + '...'; //차트라벨 4글자 이후에 ... 처리
					    	        	} else {
					    	           	return value
					    	        	}
					    	        },
					    	      }
					    	    }]
						},
					       tooltips: {
					    	    enabled: true,
					    	    mode: 'label',
					    	    callbacks: {
					    	      title: function(tooltipItems, data) {
					    	        var idx = tooltipItems[0].index;
					    	        return data.labels[idx];
					    	      }
					    	    }
					    	  }			
					}
				
				
				});
			}else{// 각 시험 평균 및 표준편차
				title.html("<i class='fa fa-angle-right'></i> 각 시험 평균 및 표준편차");
				var classChart = document.getElementById('bar2').getContext('2d');
				var myNewChart = new Chart(classChart, {
					type: 'bar',
					data: {
						labels: chartLabels,
						datasets: [
							{
								label: "각 시험 표준편차",
								yAxisID: 'std',
								backgroundColor: 'rgb(169, 99, 132)',
								borderColor: 'rgb(169, 99, 132)',
								data: stdDatas,
								fill:false,
								lineTension:0,
								type:'line'
							},		
							{
								label: "각 시험 평균",
								yAxisID: 'avg',
								backgroundColor: 'rgb(255, 99, 132)',
								borderColor: 'rgb(255, 99, 132)',
								data: chartClassDatas								
							}											
						]
					},
					options:{
						layout: {
							padding: {
								left: 10,
								right: 10,
								top: 10,
								bottom: 30
							}
						},
						scales: {
					    	 xAxes: [{
					    	     ticks: {
					    	       callback: function(value) {
					    	         if (value.length > 4) {
					    	          	return value.substr(0, 4) + '...'; //차트라벨 4글자 이후에 ... 처리
					    	        	} else {
					    	           	return value
					    	        	}
					    	        },
					    	      }
					    	    }],
							yAxes: [
								{
									id:'std',
									type:'linear',
									position:'right',
									ticks: {
										max: 30,
										min: 0,
										stepSize: 10
									}
								},
								{
								id:'avg',
								type:'linear',
								position:'left',
								ticks: {
									max: 100,
									min: 0,
									stepSize: 20
								}
							}]
						},
				       tooltips: {
				    	    enabled: true,
				    	    mode: 'label',
				    	    callbacks: {
				    	      title: function(tooltipItems, data) {
				    	        var idx = tooltipItems[0].index;
				    	        return data.labels[idx];
				    	      }
				    	    }
				    	  }			
					}
				});
			}
		});
	});
	
	//양회준 10.29 점수별 학생분포
	var examInfoTitle="${studentChart[0].exam_info_name}";
	$("#searchSpread").change(function() {
		examInfoNum=$("#searchSpread option:selected").val();
		examInfoTitle=$("#searchSpread option:selected").text();
		$("#line2").remove();
		$("#divline2").append('<canvas id="line2" height="300"></canvas>');
		spreadChart(examInfoTitle);
	});
	
	function spreadChart(){
		if(examInfoTitle=="시험 목록"){
			var ctx = document.getElementById('line2').getContext('2d');
			ctx.font="30px Arial";
			ctx.fillText("과목을 선택해주세요.", 10, 75);
		}else{
	//점수별 학생분포
		$.ajax({
			type:"post",
			url:"studentScoreSpread.do",
			data:{
				"exam_info_num":examInfoNum,
				"class_name":className				  
				},
			datatype:"json",
			success:function(data){				
				var ctx = document.getElementById('line2').getContext('2d');
				ctx.canvas.width = $("#divline2").width(); 
			    ctx.canvas.parentNode.style.height = '350px';
				var myBarChart = new Chart(ctx, {
				    type: 'bar',				    
				    data: {
				      labels: ["0~10", "11~20", "21~30", "31~40", "41~50", "51~60", 
				    	  "61~70", "71~80", "81~90", "91~100"],
				      datasets: [
				        {
				          label: examInfoTitle,
				          backgroundColor: '#ffa366',
				          borderColor: '#ffa366',
				          data: data,
				        }
				      ]
				    },
				    options:{
				    maintainAspectRatio:false,
				      layout: {
				          padding: {
				              left: 10,
				              right: 10,
				              top: 10,
				              bottom: 10
				          }
				      },
				    scales:{yAxes: [{ticks: {stepSize: 1 }}]}				       
				    }
				});
			},
			error:function(error){
			}
		});
		}
	}
})
</script>