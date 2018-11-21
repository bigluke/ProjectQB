<%-- 
	@JSP:examScheduleUpdate.jsp
	@DATE:2018-10-14
	@Author:양회준
	@Desc:강사-시험 일정 등록/수정(스토리보드 28 of 41)
 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="se" uri="http://www.springframework.org/security/tags"%>
<link
	href="${pageContext.request.contextPath}/css/examScheduleRegist.css"
	rel="stylesheet">
 <script
	src="${pageContext.request.contextPath}/lib/onet-js/examScheduleRegist.js"></script> 
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>


<section id="main-content">
  <section class="wrapper-low site-min-height">
 
    <div class="row mt">
      <div class="col-lg-12 mt">
        <div class="row content-panel">
       			 <div class="panel-heading">
						<header class="panel-heading wht-bg">
							<h4 class="gen-case">
								<i class="fa fa-angle-right"></i>&nbsp;&nbsp;&nbsp;시험 일정 등록
							</h4>
						</header>
				</div>
        
          <div class="panel-body">
              <div id="updateExam" class="tab-pane">
                <div class="row">
                 <div class="col-md-12">
                 <form action="examInfoInsert.do" id="examScheduleRegistForm" class="form-horizontal style-form" method="post" >   
                    <div class="col-md-3" id="examScheduleUpdateMember">
	                    <div class="invite-row">
	                      <h4 class="pull-left">응시대상자</h4>
	                    </div>
                  	<div class="checkName">
						<div class="form-panel">
	                      <label>
	                        <input type="checkbox"  id="checkall">전체선택
	                      </label>
	                      	<c:forEach items="${classMemberList}" var="classMemberList">
	                        <ul class="chat-available-user" id ="checkboxNameUl">
	                          <div class="checkbox" id="checkboxName">
	                            <label>
	                            	<input type="checkbox"  name="chk" id="chk" value="${classMemberList.member_id}">${classMemberList.member_name}<br>(${classMemberList.member_id })
	                            </label>
	                          </div>
	                        </ul>
	                        </c:forEach>
	                      </div>
                     </div>
                  </div>
                  <div class="col-md-1">
                  </div>
                  <div class="col-md-8">
                    <%-- 폼 양식 시작 --%>        
                     
                         <input type="hidden" id="exam_paper_name" name="exam_info_name" value="${param.exam_paper_name}"/>                         
                         <input type="hidden" id="exam_paper_num" name="exam_paper_num" value="${param.exam_paper_num}"/> 
                         <input type="hidden" id="class_num" name="class_num" value="${class_num}"/>
                         <input type="hidden" id="class_name" name="class_name" value="${class_name}"/> 
						 <input type="hidden" id="memberarray2" name="memberarray2" />
						 
						 <div class="form-group">
                          <label class="control-label col-md-2">시험명</label>
                            <div class="col-lg-8"><p id="examName">${param.exam_paper_name}</p></div>
                        </div>
                        <div class="form-group">
                          <label class="control-label col-md-2">날짜</label>
                            <div class="col-lg-8">
                            <p><input type="text" class="form-control form-control-inline" name="exam_info_date"
                             id="exam_info_date"  size="16" readonly required placeholder="이곳을 클릭한 후 캘린더에서 날짜를 선택해주세요."></p>
                            </div>

                        </div>
                        <div class="form-group">
                          <label class="control-label col-lg-2">시간</label>
                            <div class="col-lg-4">
                              <div class="input-group bootstrap-timepicker">
                                <input style="z-index:0;" type="text" autocomplete="off" class="form-control timepicker-default" id="exam_info_start"
                                 name="exam_info_start" onchange="checktime()" required placeholder="시험 시작 시간 선택    >>">
                                 <span class="input-group-btn">
                                   <button class="btn btn-theme04" type="button" style="z-index:0;"><i class="fa fa-clock-o" style="z-index:0;"></i></button>
                                </span>
                              </div>
                              <label class="control-label pull-right">시작</label>
                            </div>
                            <div class="col-lg-4">
                              <div class="input-group bootstrap-timepicker">
                                <input style="z-index:0;" type="text" autocomplete="off" class="form-control timepicker-default" id="exam_info_end"
                                 name="exam_info_end" onchange="checktime()" required required placeholder="시험 종료 시간 선택    >>">
                                  <span class="input-group-btn">
                                    <button class="btn btn-theme04" type="button" style="z-index:0;"><i class="fa fa-clock-o"></i></button>
                                  </span>
                              </div>
                              <label class="control-label pull-right">종료</label>
                            </div>
                            <div id="timeinfo"></div>
                          </div>
                        <!--timepicker group end-->
                          <div class="form-group">
                          	<div class="col-lg-2">
                            <label class="control-label"  style="margin-right:15px;" id="examtimelabel">시험시간</label>
                            </div>
                            <div class="col-lg-8">
                            <input  id="exam_info_time" class="form-control"  type="text" name="exam_info_time"  readonly
                            placeholder="시작, 종료 시간 입력시에 시험 시간이 계산됩니다." >
                            </div>
                          </div>
                          <div class="form-group">
                            <label class="control-label col-lg-2">종료알림</label>
                              <label class="control-label col-lg-8">시험 종료 5분 전에 시스템에서 응시자 전원에게 알림을 보냅니다.</label>
                          </div>
                          <div class="form-group">
                            <label class="control-label col-lg-2">응시대상</label>
                              <div class="col-lg-8 examInfoTextBox">
                                <input type="text" autocomplete="off" class="form-control" placeholder="이곳에 입력된 응시 대상자는 학생들의 시험 일정에 표시됩니다." id="exam_info_member" name="exam_info_member" required>
                              </div>
                          </div>
                          <div class="form-group">
                            <label class="control-label col-lg-2">설명</label>
                              <div class="col-lg-8 examInfoTextBox">
                                <textarea rows="3" class="form-control" placeholder="이 시험에 대한 설명을 입력해주세요." id="exam_info_desc" name="exam_info_desc" required></textarea>
                              </div>
                          </div>
                          <br>
                          <br>
                          <br>
                     </div>
	                     <div class="col-md-12 examScheduleBtnDiv">
	                      <button class="btn btn-theme pull-right" id="examManagementBtn" type="button" onclick="check()">시험 일정 등록</button>
	                       <se:authorize access="hasRole('ROLE_TEACHER')">
	                        <button type="button" class="btn btn-second pull-right" onclick="location.href='${pageContext.request.contextPath}/teacher/examManagement.do'">취소</button>
	                        </se:authorize>
	                          <se:authorize access="hasRole('ROLE_ADMIN')">
	                        <button type="button" class="btn btn-second pull-right" onclick="location.href='${pageContext.request.contextPath}/admin/examManagement.do'">취소</button>
	                        </se:authorize>
	                      <input type="hidden" id="memberlistbox" name="memberlistbox"/>
	                       
	                    </div>
                        </form>
                        <%-- 폼 양식 끝 --%>

                      </div>
                    </div>

                  </div>
                </div>
              </div>
              <!-- /tab-pane -->
                <!-- /row -->
              </div>
              <!-- /tab-pane -->
            </div>
            <!-- /tab-content -->
          </div>
          <!-- /panel-body -->

 
      <!-- /row -->

    <!-- /container -->
  </section>
  <!-- /wrapper -->
</section>
<!-- /MAIN CONTENT -->
<!--main content end-->

<script>





	

function check(){
	
	/*체크박스 값 설정*/

	var memberarray = new Array();
	$("input:checkbox[name=chk]:checked").each(function(){
		memberarray.push($(this).val());
	});
    
    document.getElementById("memberarray2").setAttribute('value',memberarray);
    
	/*체크박스 값 설정 끝*/
	
	var timeinfodiv = document.getElementById("timeinfo");
	
	var datecheck = false;
	var start = $('#exam_info_start').val();
	var end = $('#exam_info_end').val();
	
	var start_hour = start.substring(0,2);
	var end_hour=end.substring(0,2);
	
	var start_m=start.substring(3);
	var end_m = end.substring(3);
	
	console.log("date값>>>"+$('#exam_info_date').val()+"<<");
	
	var examDate = $('#exam_info_date').val();
	var date = new Date(); 
	var year = date.getFullYear(); 
	var month = new String(date.getMonth()+1); 
	var day = new String(date.getDate()); 

	// 한자리수일 경우 0을 채워준다. 
	if(month.length == 1){ 
	  month = "0" + month; 
	} 
	if(day.length == 1){ 
	  day = "0" + day; 
	} 

	var todaydate = year + "-" + month + "-" + day;
	console.log("date.getHours()>>" +date.getHours());
	console.log("start_hour>>" +start_hour);
	if(start_hour >= end_hour){
		timeinfodiv.innerHTML = "시간설정을 다시 해주세요.";
		timeinfodiv.style.color = 'red';
		return false;
		}
	else if((todaydate==examDate)&& (Number(date.getHours()) > Number(start_hour))){
			timeinfodiv.innerHTML = "시간설정을 다시 해주세요.";
			timeinfodiv.style.color = 'red';
			return false;
	}else if(start_hour == end_hour){
		if(start_m > end_m){
			timeinfodiv.innerHTML = "시간설정을 다시 해주세요.";
			timeinfodiv.style.color = 'red';
			return false;
		}else if(start_m== end_m){
			timeinfodiv.innerHTML = "시간설정을 다시 해주세요.";
			timeinfodiv.style.color = 'red';
			return false;
		}
	}else if(start=="" && end==""){
		timeinfodiv.innerHTML = "시간설정을 해주세요.";
		timeinfodiv.style.color = 'bule';
		return false;
		
	}else if($('#exam_info_date').val()==""){
		  swal("날짜를 입력하세요", {
		      icon: "info"
		    });
		return false;
	}else if(memberarray==""){
		 swal("학생을 선택하세요.", {
		      icon: "info"
		    });
		return false;
	}else if($('#exam_info_member').val()==""){
		swal("응시대상을 입력하세요.", {
		      icon: "info"
		    });
		return false;
	}else if($('#exam_info_desc').val()==""){
		swal("설명 입력하세요.", {
		      icon: "info"
		    });
		return false;
	}
	else {
		swal({
			  title: "시험 일정 등록하시겠습니까?",
			  icon: "info",
			  buttons: true,
			  dangerMode: true
			}).then((willDelete) => {
			  if (willDelete) {
				  swal({
				       title: "등록이 완료되었습니다.",
					   text: "",
					   icon:"success"
					}).then(function() {
						 document.getElementById("examScheduleRegistForm").submit();
				});
			  } else {
			  }
		});
	}
	
	
	

}
</script>