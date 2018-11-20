<%-- 
	@JSP:teacherMyExamPaper.jsp
	@DATE:2018-10-10
	@Author:유영준
	@Desc:강사-내 시험지 페이지(스토리보드 23 of 41)
	
	@2018-10-10 현이 : 시험지 생성 탭 추가
	
	@2018-10-11 영준 : 시험지 탭 메뉴 통합
 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="se"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="security"%>
<link
	href="${pageContext.request.contextPath}/css/teacherMyExamPaper.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/css/teacherExamManagement.css"
	rel="stylesheet">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<!-- dateficker -->
<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />


<!--main content start-->

<section id="main-content">
	<section class="wrapper site-min-height">
		<div class="row mt">
			<div class="col-lg-12">
				<div class="row content-panel div_table">
					<div class="panel-heading">

						<ul class="nav nav-tabs nav-justified">
							<li class="active"><a data-toggle="tab" href="#overview">
							<se:authorize access="hasRole('ROLE_TEACHER')">
							내 시험지 
							</se:authorize> 
							<se:authorize access="hasRole('ROLE_ADMIN')">
							시험지 관리
							</se:authorize>
							</a></li>
							<se:authorize access="hasRole('ROLE_TEACHER')">
							<li><a data-toggle="tab" href="#tempExamPaper"
								class="contact-map">임시 저장된 시험지 </a></li>
							</se:authorize>
							<li><a data-toggle="tab" href="#examSchedule"
								class="contact-map" id="examinfotab"> 시험 일정 <se:authorize
										access="hasRole('ROLE_ADMIN')">관리
							</se:authorize>
							</a></li>
						</ul>

					</div>
					<!-- panel-heading -->

					<!-- 시험지 모달 -->
					<div id="exam_preview" class="modal fade">
						<div class="fix">
							<a href="#" class="print" onclick="printpage()"
								title="Print page">Print page</a> <a href="#" class="close"
								title="Close print preview" data-dismiss="modal">Close</a>
						</div>
						<div class="modal-dialog">
							<div class="book"></div>
						</div>
					</div>


					<div class="panel-body">
						<div class="tab-content">
							<!-- 내 시험지 탭 시작 -->
							<div id="overview" class="tab-pane active">
								<div class="row">
									<div id="div_myExam" class="col-md-12">
										<div class="searchtitle">
										<select class="form-control searchRightBtnDiv"
													id="searchType" name="searchType">
													<option value="all">전체</option>
													<se:authorize access="hasRole('ROLE_ADMIN')">
													<option value="n">클래스명</option>
													<option value="p">시험지명</option>
													</se:authorize>
													<se:authorize access="hasRole('ROLE_TEACHER')">
													<option value="n">제목</option>
													<option value="p">설명</option>
													</se:authorize>
												</select> <input type="text" class="form-control searchRightBtnDiv"
													placeholder="검색어를 입력" id="keyword" name="keyword">
												<button type="button" class="btn btn-theme searchRightBtn"
													id="searchBtn">검색</button>
													
										</div>
										<div>
											<a href="examPaperMake.do" class="examPaper-insert"> <img
												src="../img/material-icon.png"> <strong>새 시험지
													만들기</strong></a>
										</div>										
									</div>
									<!-- 내 시험지 div 끝 -->

								</div>
								<!-- /col-md-12 -->
								<div class="row mt">
									<div class="col-lg-12">
										<div id="examlistView"></div>
									</div>
								</div>
							</div>
							<!-- 내 시험지 탭 끝-->

							<!-- 임시 저장된 시험지 tab 시작-->
							<div id="tempExamPaper" class="tab-pane">
								<div class="row">
									<div id="div_tempExam" class="col-md-12">										
										<form action="" method="post" id="pickMyExamPaperForm">
											<div class="col-lg-12">

												<!-- 시험지 하나의 div 시작 -->
												<div id="examTempPaperDiv">
													
												</div>
											</div>
										</form>
									</div>
									<!-- /overview -->
								</div>
							</div>

							<!-- 시험 일정 tab 시작 -->
							<div id="examSchedule" class="tab-pane">
								<div class="row">
									<!-- 시험 일정 DeleteModal 시작-->
									<div class="modal fade" id="scheduleDeleteModal" tabindex="-1"
										role="dialog" aria-labelledby="myModalLabel"
										aria-hidden="true">
										<!-- 시험 일정 DeleteModal 끝 -->
									</div>

									<div id="div_examSchedule" class="col-md-12">
									<div class="searchtitle">							
										<se:authorize access="hasRole('ROLE_TEACHER')">
										<input type="text" name="datefilter" id="fromtodate" class="form-control searchRightBtnDiv" placeholder="날짜 입력"/>
										</se:authorize>
										<se:authorize access="hasRole('ROLE_ADMIN')">
												<select class="form-control searchRightBtnDiv"
													id="searchType2" name="searchType2">
													<option value="all">전체</option>
													<option value="n">클래스명</option>
													<option value="p">시험명</option>
												</select> 
										</se:authorize>
										<input type="text" class="form-control searchRightBtnDiv"
											placeholder="검색어를 입력" id="keyword2" name="keyword2">										
										<button type="button" class="btn btn-theme searchRightBtn"
											id="searchBtn2">검색</button>
									</div>																									
									</div>
								</div>
								<!-- 시험 일정 tab 끝 -->
								<div class="row mt">
									<div class="col-lg-12">
										<div id="examlistView2"></div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</section>
<!-- main-content -->


<script
	src="${pageContext.request.contextPath}/lib/onet-js/examScheduleUpdate.js"></script>
<script src="${pageContext.request.contextPath}/lib/common-scripts.js"></script>
<script src="${pageContext.request.contextPath}/lib/tasks.js"
	type="text/javascript"></script>
<script
	src="${pageContext.request.contextPath}/lib/onet-js/examManagement.js"
	type="text/javascript"></script>

<script>
var classcheck = true;	//	왜 false?
var classParam = {
		"begin" : 0,
		"searchType" : "all",
		"keyword" : "",
}
var tempExam = {
		"begin" : 0,
		"searchType" : "all",
		"keyword" : "",
}

var classParam2 = {
		"begin" : 0,
		"searchType2" : "all",
		"keyword" : "",
		"date_from" : "",
		"date_to" : ""
}
var role = "${role}";

$(document).ready(function(){	
	$('#keyword').focus();
	
	$('input[name="datefilter"]').daterangepicker({
	      autoUpdateInput: false,
	      locale: {
	          cancelLabel: 'Clear'
	      }
	  });

	  $('input[name="datefilter"]').on('apply.daterangepicker', function(ev, picker) {
	      $(this).val(picker.startDate.format('YYYY-MM-DD') + ' ~ ' + picker.endDate.format('YYYY-MM-DD'));
	      
	      
	  });

	  $('input[name="datefilter"]').on('cancel.daterangepicker', function(ev, picker) {
	      $(this).val('');
	  });
	
	//무한 스크롤
	
	if(role == 'ROLE_TEACHER'){
	imsiSaveExam(tempExam);
	}
	examinfolistClass(classParam2);
	examlistClass(classParam);	
	
	
	var lastScrollTop = 0;
	
	
	$(window).scroll(function(){
		var currentScrollTop = $(window).scrollTop();
		if( currentScrollTop - lastScrollTop > 0 ){
	            // 2. 현재 스크롤의 top 좌표가  > (게시글을 불러온 화면 height - 윈도우창의 height) 되는 순간
	         if ($(window).scrollTop() >= ($(document).height() - $(window).height()) -10 ){ //② 현재스크롤의 위치가 화면의 보이는 위치보다 크다면
	        	 
	        	 //scrollTop + windowHeight + 30 > documentHeight
	        	
	        	 
				classParam.begin += 5;
	        	examlistClass(classParam);
	        	
	        	classParam2.begin += 5;
				examinfolistClass(classParam2);
				
				if(role == 'ROLE_TEACHER'){
					tempExam.begin += 5;
					imsiSaveExam(tempExam);
				}
				
			 }
		  }
	});
	
	
	$('.miri').click(function(){
		var exam_paper_num = $(this).attr('id');
		
			 $.ajax({
				  url : "examMiri.do",
				  type:'GET',
				  data : {
					  'exam_paper_num' : exam_paper_num
				  },
				  dataType:"html",
				  success:function(data){
					  $('.book').html(data);
				  }
			   });
	   });
	
	$('#searchBtn').click(function(){  // search 버튼을 눌렀을 때는 json 데이터의 내용을 변경시켜서 파라미터로 보내기 
		
		classParam.begin = 0; 
		classParam.searchType = $("#searchType").val();
		classParam.keyword = $("#keyword").val();
		$('#examlistView').empty();
		examlistClass(classParam);
		
	});
	
	$('#searchBtn2').click(function(){  // search 버튼을 눌렀을 때는 json 데이터의 내용을 변경시켜서 파라미터로 보내기 
		if($('#fromtodate').val()){
			var fromtodate = $("#fromtodate").val();
			var strArray = fromtodate.split('~');
			var date_from = strArray[0].trim();
			var date_to = strArray[1].trim();	
			
			classParam2.date_from = date_from;
			classParam2.date_to = date_to;
		}else{
			classParam2.date_from = "";
			classParam2.date_to = "";
		}
 		if($("#searchType2").val()){
 			classParam2.searchType2= $("#searchType2").val();
 		}
 		
 		classParam2.begin = 0;
		classParam2.keyword = $("#keyword2").val();
		
		$('#examlistView2').empty();
		examinfolistClass(classParam2); 
		
	});
});

/* $('#examinfotab').click(function(){
	var lastScrollTop = 0;
	examinfolistClass(classParam2);
	$(window).scroll(function(){
		var currentScrollTop = $(window).scrollTop();
		if( currentScrollTop - lastScrollTop > 0 ){
	            // 2. 현재 스크롤의 top 좌표가  > (게시글을 불러온 화면 height - 윈도우창의 height) 되는 순간
	         if ($(window).scrollTop() >= ($(document).height() - $(window).height()) -10 ){ //② 현재스크롤의 위치가 화면의 보이는 위치보다 크다면
	        	 
	        	 //scrollTop + windowHeight + 30 > documentHeight
	        	 
					classParam2.begin += 5;
					examinfolistClass(classParam2);
			 }
		  }
	});	
}); */

	//클래스 목록 가져오는 ajax
	function examlistClass(classParam){
	if(role == 'ROLE_TEACHER'){
		$.ajax({
			url : "exampaperlistClass.do",
			type : 'GET',
			dataType : "html",
			data : classParam,
			success : function(data){	
				$('#examlistView').append(data);
			},
			error : function(error) {
				console.log("===========실패");
			}
		});
	}else{
		$.ajax({
			url : "exampaperlistClass.do",
			type : 'GET',
			dataType : "html",
			data : classParam,
			success : function(data){	
				$('#examlistView').append(data);
			},
			error : function(error) {
				console.log("===========실패");
			}
		});
	}
	
	}
	function imsiSaveExam(tempExam){
		$.ajax({
			url : "myTempExamList.do",
			type : 'GET',
			dataType : "html",
			data : tempExam,
			success : function(data){	
				$('#examTempPaperDiv').append(data);
				}
		});
	}
				
	function examinfolistClass(classParam2){		
		$.ajax({
			url : "examinfolistClass.do",
			type : 'GET',
			dataType : "html",
			data : classParam2,
			success : function(data){	
				$('#examlistView2').append(data);

			},
			error : function(error) {
				console.log("===========실패");
			}
		});
	}

	function printpage(){
		
		var divContents = $('.book').html();
		var printWindow = window.open('','','height=800, width=1500');
        printWindow.document.write(divContents);
        printWindow.document.close();
        printWindow.print();
	}
	function updateExamCheck() {
		/* event.stopPropagation(); *///중복클릭 방지 코드
		var exam_paper_num = window.event.target.id;

		$.ajax({
			url : "updateExamCheck.do",
			type : "get",
			dataType : "json",
			data : {
				'exam_paper_num' : exam_paper_num
			},
			global:false,
			success : function(data){
				if(data == 1){
					location.href = "updateExamView.do?exam_paper_num=" + exam_paper_num;		
				}else if(data == 2){
					location.href = "updateExamView.do?exam_paper_num=" + exam_paper_num;
				}else{
					swal({
						title : "수정불가",
						text : "등록된 시험일정이 있습니다. 시험일정을 확인하고 수정해주세요.",
						icon : "warning",
					});
				}
			}
		});
	}
	function deleteExamCheck() {
		var exam_paper_num = window.event.target.id;
		swal({
			  title: "시험지를 삭제 하시겠습니까?",
			  icon: "warning",
			  buttons: true,
			  dangerMode: true
			}).then((willDelete) => {
			  if (willDelete) {
				  $.ajax({
						url : "deleteExam.do",
						type : 'GET',
						dataType : "json",
						data : {
							'exam_paper_num' : exam_paper_num
						},
						global:false,
						success : function(data) {
							if (data == 1) {
								swal({
									title : "삭제완료",
									icon : "success",
								});							
								$('#' + exam_paper_num).closest('.deleteline').remove();
								
							} else if (data == 2) {
								swal({
									title : "삭제완료",
									text : "삭제가 완료외었습니다.학생-(지난시험보기에는 남아있음)",
									icon : "success",
								});
								$('#' + exam_paper_num).closest('.deleteline').remove();
							} else {
								swal({
									title : "삭제불가",
									text : "등록된 시험일정이 있습니다.",
									icon : "warning",
									dangerMode: true
								});
							}
						},
						error : function(error) {
							console.log("===========실패");
						}
					});
			    swal("Poof! Your imaginary file has been deleted!", {
			      icon: "success",
			    });
			  } else {}
			});
	}
	function deleteTempExamCheck() {
		var exam_paper_num = window.event.target.id;
		swal({
			  title: "시험지를 삭제 하시겠습니까?",
			  icon: "warning",
			  buttons: true,
			  dangerMode: true
			}).then((willDelete) => {
			  if (willDelete) {
				  $.ajax({
						url : "deleteTempExam.do",
						type : 'GET',
						dataType : "json",
						data : {
							'exam_paper_num' : exam_paper_num
						},
						global:false,
						success : function(data) {
							swal({
								title : "삭제완료",
								icon : "success",
							});
							$('#' + exam_paper_num).closest('.deleteline').remove();			
						},
						error : function(error) {
							console.log("===========실패");
						}
					});
				  
			    swal("Poof! Your imaginary file has been deleted!", {
			      icon: "success",
			    });
			  } else {
			  }
		});
	}
</script>