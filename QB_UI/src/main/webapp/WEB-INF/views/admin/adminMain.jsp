<%-- 
	@JSP:adminMain.jsp
	@DATE:2018-10-06
	@Author:양회준
	@Desc:클래스 목록 페이지(스토리보드 7 of 41)
 --%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link href="${pageContext.request.contextPath}/css/adminMain.css"
	rel="stylesheet">
<script
	src="${pageContext.request.contextPath}/lib/onet-js/adminMain.js"></script>

<script
	src="${pageContext.request.contextPath}/lib/onet-js/jquery-ui.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<section id="main-content">
	<section class="wrapper site-min-height">
		<div class="row mt">

			<!--  DATE PICKERS -->
			<div class="col-lg-12">
				<div class="row content-panel">
					<div class="panel-heading">
						<header class="panel-heading wht-bg">
							<h4 class="gen-case">
								<i class="fa fa-angle-right"></i>&nbsp;&nbsp;&nbsp;클래스 목록
							</h4>
						</header>

					</div>
					<div class="panel-body">
						<div class="row searchRowDiv">
							<div class="col-lg-4">
								<button class="btn btn-theme" data-toggle="modal"
									data-target="#myModal" id="makeNewClassBtn">새 클래스 개설하기</button>
							</div>
							<div class="col-lg-8 searchRowRightDiv">
								<select class="form-control searchRightBtnDiv" id="searchType"
									name="searchType">
									<option value="all">전체 강의</option>
									<option value="ing">수강중 강의</option>
									<option value="end">지난 강의</option>
								</select> <input type="text" class="form-control searchRightBtnDiv"
									placeholder="검색어를 입력" id="keyword" name="keyword">
								<button type="button" class="btn btn-theme searchRightBtn"
									id="searchBtn">검색</button>
							</div>
						</div>

						<!-- Modal -->
						<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
							aria-labelledby="myModalLabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<form action="classInsert.do" id="insertClassForm"
										class="form-horizontal style-form" method="post">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal"
												aria-hidden="true">&times;</button>
											<h4 class="modal-title" id="myModalLabel">클래스 개설</h4>
										</div>
										<div class="modal-body">
											<div class="form-group">
												<label class="col-sm-2 col-sm-2 control-label">클래스명</label>
												<div class="col-sm-10">
													<input type="text" class="form-control"
														placeholder="클래스 명을 입력해주세요." id="class_name"
														name="class_name" onblur="confirmClass()">
													<div id="classdiv"></div>
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-2 col-sm-2 control-label">수강기간</label>
												<div class="col-md-10">
													<div class="input-group input-large">
														<input type="text"
															class="form-control dpd1 class_start_date"
															name="class_start_date" id="new_class_start_date"
															required readonly /> <span class="input-group-addon">
															에서 </span> <input type="text"
															class="form-control dpd2 class_end_date"
															name="class_end_date" id="new_class_end_date" required
															readonly />

													</div>
													<span class="help-block">기간을 선택하세요.</span>
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-2 col-sm-2 control-label">강사명</label>
												<div class="col-sm-10">
													<input type="text" class="form-control"
														placeholder="강사님 이름을 입력해주세요." id="teacher_name"
														name="teacher_name">
												</div>
											</div>

											<!-- /col-lg-12 -->
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-default"
												data-dismiss="modal">취소</button>
											<button type="button" class="btn btn-theme" id="classSubmitBtn">생성</button>
										</div>
									</form>
								</div>
							</div>
						</div>

						<!-- Class Modify Modal  -->
						<div class="modal fade" id="classupdate" tabindex="-1"
							role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<form class="form-horizontal style-form" method="post"
										id="updateClassForm" action="updateClass.do">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal"
												aria-hidden="true">&times;</button>
											<h4 class="modal-title" id="myModalLabel">클래스 수정</h4>
										</div>
										<div class="modal-body">
											<div class="form-group">
												<input type="hidden" id="class_num_update" name="class_num">
												<label class="col-sm-2 col-sm-2 control-label">클래스명</label>
												<div class="col-sm-10">
													<input type="text" class="form-control"
														id="class_name_update" name="class_name" onblur="confirmClass2()" required>
														<div id="classdiv2"></div>
												</div>
												
											</div>
											<div class="form-group">
												<label class="col-sm-2 col-sm-2 control-label">수강기간</label>
												<div class="col-md-10">
													<div class="input-group input-large">
														<input type="text"
															class="form-control dpd1 class_start_date"
															name="class_start_date" id="" required readonly /> <span
															class="input-group-addon"> 에서 </span> <input type="text"
															class="form-control dpd2 class_end_date"
															name="class_end_date" id="" required readonly />
													</div>
													<span class="help-block">기간을 선택하세요.</span>
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-2 col-sm-2 control-label">강사명</label>
												<div class="col-sm-10">
													<input type="text" class="form-control"
														id="teacher_name_update" name="teacher_name">
												</div>
											</div>

											<!-- /col-lg-12 -->
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-default"
												data-dismiss="modal">취소</button>
											<button type="button" class="btn btn-theme"
												id="updateClassBtn">수정</button>
										</div>
									</form>
								</div>
							</div>
						</div>

						<!-- Class Delete Modal  -->
						<div class="modal fade" id="classDelete" tabindex="-1"
							role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<form class="form-horizontal style-form" method="post"
										id="deleteClassForm" action="deleteClass.do">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal"
												aria-hidden="true">&times;</button>
											<h4 class="modal-title" id="myModalLabel">클래스 삭제</h4>
										</div>
										<div class="modal-body">
											<div class="classDeleteModelBody">
												<input type="hidden" id="class_name_modal" name="class_name"
													value="" /> 선택하신 클래스를 삭제하시겠습니까?
											</div>
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-default"
												data-dismiss="modal">취소</button>
											<button type="button" class="btn btn-theme"
												id="deleteClassBtn">삭제</button>
										</div>
									</form>
								</div>
							</div>
						</div>

						<div class="row mt">
							<div class="col-lg-12">
								<div id="classlistView"></div>
							</div>
						</div>

					</div>
				</div>
	</section>
	<!-- /wrapper-low -->
</section>

<script>
		
var classParam = {	
		"begin" : 0,
		"searchType" : "all",
		"keyword" : "",
}

$(document).ready(function(){
	
	adminMainClass(classParam);
	var lastScrollTop = 0;
	
	// 무한 스크롤 
	$(window).scroll(function(){	// ① 스크롤 이벤트 최초 발생
		
		var currentScrollTop = $(window).scrollTop();
		if( currentScrollTop - lastScrollTop > 0 ){
	        // 2. 현재 스크롤의 top 좌표가  > (게시글을 불러온 화면 height - 윈도우창의 height) 되는 순간
	         if ($(window).scrollTop() >= ($(document).height() - $(window).height()) ){ //② 현재스크롤의 위치가 화면의 보이는 위치보다 크다면  if( scrollTop + windowHeight + 30 > documentHeight )
				classParam.begin += 8;
				adminMainClass(classParam);
				//console.log("begin : " + classParam.begin +"번부터");
			 }
		  }
	});
	
	
	$('#searchBtn').click(function(){  
		
		classParam.begin = 0; 
		classParam.searchType = $("#searchType").val();
		classParam.keyword = $("#keyword").val();
		$('#classlistView').empty();
		
		adminMainClass(classParam);
		
	});
	
	$('#searchType').change(function() {
		
		$("#keyword").val("");
		$("#keyword").focus();
		classParam.begin = 0;
		classParam.searchType = $("#searchType").val();
		classParam.keyword = "";
		$('#classlistView').empty();
		
		adminMainClass(classParam);
		
	});
}); // document.ready 종료 

	//클래스 목록 가져오는 ajax
	function adminMainClass(classParam){
		$.ajax({
			url : "adminMainView.do",
			type : 'GET',
			dataType : "html",
			data : classParam,
			success : function(data){
				$('#classlistView').append(data);
				$(".classDivOverFlow").each(function(){
					var charVal = $(this).text().trim();
					var code = (charVal.charCodeAt(0)+charVal.charCodeAt(2)+charVal.charCodeAt(4))%12;					
					var img=$(this).prev();
					for(var i=0;i<12;i++){
						switch(code){
							case i: img.attr("src","${pageContext.request.contextPath}/img/classIcon/classicon"+i+".png"); break;
						}
					}
				});
			
			},
			error : function(error) {
			}
		});
	}


	var classcheck = false;	
	
	$('#classSubmitBtn').click(function(){
		if(classcheck == false){
			swal("클래스 명을 확인해주세요");
			$("#class_name").focus();
			return false;
		} else if(classcheck == true){
			swal({
		           title: "클래스를 생성하시겠습니까?",
		           icon: "info",
		           buttons: true,
		           dangerMode: true
		      }).then((willDelete) => { 
		        if (willDelete) {
		            swal({
		                 title: "클래스가 생성되었습니다.",
		                  text: "",
		                  icon:"success"
		               }).then(function() {
		                  $('#insertClassForm').submit();
		            });
		          
		        } else {
		        }
		   });
	}
	});
	
	var classcheck2 = false;	
	$('#updateClassBtn').click(function(){
		if(classcheck2 == false){
			swal("클래스 명을 확인해주세요");
			$("#class_name_update").focus();
			return false;
		} else if(classcheck2 == true){
			swal({
		           title: "클래스를 수정하시겠습니까?",
		           icon: "info",
		           buttons: true,
		           dangerMode: true
		      }).then((willDelete) => { 
		        if (willDelete) {
		            swal({
		                 title: "클래스가 수정되었습니다.",
		                  text: "",
		                  icon:"success"
		               }).then(function() {
		                  $('#updateClassForm').submit();
		            });
		          
		        } else {
		        }
		   });
	}
	});
	

	function confirmClass() {
		
		var val = $("#class_name").val();
		var iddiv = $("#classdiv");
		if (val == "") {
			iddiv.html("클래스를 입력해주세요.");
			$('#classdiv').css("color", "green");
			classcheck = false;

		} else {
			$.ajax({
				url : 'classCheck.do',
				data : {
					'class_name' : val
				},
				dataType : 'json',
				success : function(data) {
					if (data.result == true) {
						iddiv.html("사용가능한 클래스 입니다.");
						$('#classdiv').css("color", "green");
						classcheck = true;
					} else {
						iddiv.html("사용 불가능한 클래스 입니다.");
						$('#classdiv').css("color", "red");
						classcheck = false;
					}
				}
			});
		}
	}
	function confirmClass2() {
		
		var val = $("#class_name_update").val();
		var iddiv = $("#classdiv2");
		if (val == "") {
			iddiv.html("클래스를 입력해주세요.");
			$('#classdiv2').css("color", "green");
			classcheck2 = false;

		} else {
			$.ajax({
				url : 'classCheck.do',
				data : {
					'class_name' : val
				},
				dataType : 'json',
				success : function(data) {
					if (data.result == true) {
						iddiv.html("사용가능한 클래스 입니다.");
						$('#classdiv2').css("color", "green");
						classcheck2 = true;
					} else {
						iddiv.html("사용 불가능한 클래스 입니다.");
						$('#classdiv2').css("color", "red");
						classcheck2 = false;
					}
				}
			});
		}
	}
	
	var dateFormat = "yy-mm-dd",
    from = $( ".class_start_date" )
      .datepicker({
        defaultDate: "+1w",
        changeMonth: true,
        numberOfMonths: 1,
        minDate:0
      })
      .on( "change", function() {
        to.datepicker( "option", "minDate", getDate( this ) );
      }),
    to = $( ".class_end_date" ).datepicker({
      defaultDate: "+1w",
      changeMonth: true,
      numberOfMonths: 1
    })
    .on( "change", function() {
      from.datepicker( "option", "maxDate", getDate( this ) );
    });
	
  function getDate( element ) {
    var date;
    try {
      date = $.datepicker.parseDate( dateFormat, element.value );
    } catch( error ) {
      date = null;
    }

    return date;
  }
  
</script>