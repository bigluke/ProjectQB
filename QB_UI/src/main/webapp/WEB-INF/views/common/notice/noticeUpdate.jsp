<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="se" uri="http://www.springframework.org/security/tags"%>	
<style>
.img{
	width:100px;
	height:100px;
}
#txtFile1{
	display:inline;
	border: 2px solid #063f54;
	border-radius: 4px;
}
#txtFile2{
	display:inline;
	border: 2px solid #063f54;
	border-radius: 4px;
}
.filename{
	display:inline-block;
	width:300px;
}
.fileDeletebtn{
	height:32px;
}
#notice_name{
	width:100%;
}
.noticeUpdateButton{
	background: #337ab7;
	border-color: #337ab7;
	width:100px;
}

.noticeCancelButton{
	background: #B9062F;
	width:100px;
}
.subject{
	width:100px;
	color:#063f54;
	font-weight: bold;
}
.filediv{
	margin-left: -15px;
}
</style>
<!-- 강사 공지사항 글쓰기 -->
<section id="main-content">
	<section class="wrapper site-min-height">
		<div class="fluid-container">
				<div class="col-lg-12"></div>
				<!-- /col-lg-12 -->
				<div class="col-lg-12 mt">
					<div class="row content-panel div_table">
						<!-- 클래스 공지사항 -->
						<div id="noticeWrite_div" class="col-md-12">
							<form action="noticeRealUpdate.do" method="post" enctype="multipart/form-data" onsubmit="return check();">
								<table class="table">
									<tr>
										<td class="fst_td subject">제목</td>
										<td class="scd_td"><input type="text" id="notice_name" name="notice_name"
											class="notice_input" value="${result[0].notice_name}"/></td>
									</tr>
									<tr>
										<td class="fst_td subject">내용</td>
										<td class="sec_td"><textarea id="notice_content" name="notice_content" class="summernote1 notice_input" 
												rows="20" >${result[0].notice_content}</textarea></td>
									</tr>
									<tr>
										<td class="fst_td subject">파일 첨부</td>
										<td>
											<c:choose>
												<c:when test="${empty result[0].notice_file1 && empty result[0].notice_file2}">
													<span><i class="fa fa-paperclip"></i> 첨부된 파일이 없습니다.</span><br>
												</c:when>
											</c:choose>
											<c:choose>
												<c:when test="${not empty result[0].notice_file1 ||	not empty result[0].notice_file2}">
													<span><i class="fa fa-paperclip"></i> 기존 첨부파일</span><br>
												</c:when>
											</c:choose>
											
											<c:choose>
												<c:when test="${not empty result[0].notice_file1 && empty result[0].notice_file2}">
													<div class="col-sm-6 filediv">
													<span class="span"><strong>${originFileName1}&nbsp;&nbsp;</strong><a class="fileDeletebtn1"><i class="fa fa-trash-o"></i>&nbsp;삭제</a></span>
													</div>
													<div class="col-sm-6 filediv">
													<span class="span"><strong>첨부된 파일이 없습니다</strong></span>
													</div>
													<br>
													<div class="col-sm-6 filediv">
													<input type="file" id="txtFile1" class="file" name="files1" value="result[0].notice_file1"/>
													</div>
													<div class="col-sm-6 filediv">
													<input type="file" id="txtFile2" class="file" name="files2" />
													</div>
												</c:when>
											</c:choose>
											
											
											<c:choose>
												<c:when test="${not empty result[0].notice_file2 && empty result[0].notice_file1}">
													<div class="col-sm-6 filediv">
													<span class="span"><strong>첨부된 파일이 없습니다</strong></span>
													</div>
													<div class="col-sm-6 filediv">
													<span class="span"><strong>${originFileName2}&nbsp;&nbsp;</strong><a class="fileDeletebtn2"><i class="fa fa-trash-o"></i>&nbsp;삭제</a></span>
													</div>
													<div class="col-sm-6 filediv">
													<input type="file" id="txtFile1" class="file" name="files1"/>
													</div>
													<div class="col-sm-6 filediv">
													<input type="file" id="txtFile1" class="file" name="files2" value="result[0].notice_file2"/>
													</div>
												</c:when>
											</c:choose>
											
											
											<input type="hidden" id="class_name" name="class_name" value="${result[0].class_name}">
											<input type="hidden" id="notice_num" name="notice_num" value="${result[0].notice_num}">
											<input type="hidden" name="class_num" value="${class_num}">
											
											<c:choose>
												<c:when test="${empty result[0].notice_file1 && empty result[0].notice_file2}">
												<div class="col-sm-6 filediv">
												<input type="file" id="txtFile1" class="file" name="files1" />
												</div>
												<div class="col-sm-6 filediv">
												<input type="file" id="txtFile2" class="file" name="files2" />
												</div>
												</c:when>
											</c:choose>
											
											
											<c:choose>
												<c:when test="${not empty result[0].notice_file1 && not empty result[0].notice_file2}">
												<div class="col-sm-6 filediv">
													<span class="span filename"><strong>${originFileName1}&nbsp;&nbsp;</strong><a class="fileDeletebtn1"><i class="fa fa-trash-o"></i>&nbsp;삭제</a></span>
													<input type="file" id="txtFile1" class="file" name="files1"/>
												</div>
												<div class="col-sm-6 filediv">	
													<span class="span filename"><strong>${originFileName2}&nbsp;&nbsp;</strong><a class="fileDeletebtn2"><i class="fa fa-trash-o"></i>&nbsp;삭제</a></span>
													<input type="file" id="txtFile2" class="file" name="files2"/>
												</div>
												</c:when>
											</c:choose>
											
										</td>
									</tr>
									<tr>
										<td class="fst_td"></td>
										<td colspan="2">
											<button type="submit" id="btnupdate" class="btn btn-info noticeUpdateButton">수정</button>&nbsp;&nbsp;
											<se:authorize access="hasRole('ROLE_TEACHER')">
											<a href="teacherMain.do"><input type="button" class="btn btn-theme04 noticeCancelButton" value="취소" /></a>
											</se:authorize>
											<se:authorize access="hasRole('ROLE_ADMIN')">
											<a href="adminClassMain.do?class_name=${result[0].class_name}&class_num=${class_num}"><input type="button" class="btn btn-theme04 noticeCancelButton" value="취소" /></a>
											</se:authorize>
											<!-- <button class="btn btn-info">취소</button> -->
										</td>
									</tr>
								</table>
							</form>
						</div>
						<!-- /클래스 공지사항 -->

					</div>
					<!-- /col-lg-12 -->
				</div>
				<!-- /row -->

			<!-- /container -->
		</div>
	</section>
	<!-- /wrapper -->
</section>

<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>

	function check(){
		var a = $('#notice_content').val();
				if(a == "" || a == null){
			swal("글 내용을 반드시 입력해주세요", "글내용을 입력하지 않으면 등록할 수 없습니다", "error");
		return false;
		}else{
		return true;	
	}
	}

	
		
	$(document).ready(function(){
		var class_name = $('#class_name').val();
		var notice_num = $('#notice_num').val();
			
	$('.fileDeletebtn1').click(function(){
		$.ajax({
			  type : "post",
			  url : "fileDeletebtn1.do",
			  data:{class_name:$('#class_name').val(), notice_num:$('#notice_num').val()},
			  success : function(data){
				  swal({
				       title: "파일이 삭제되었습니다",
					   text: "파일을 다시 추가하려면 파일을 업로드해주세요",
					   icon:"info"
					}).then(function() {
					    window.location = "noticeUpdate.do?notice_num="+notice_num+"&class_name="+class_name;
					});
			  },
			  error: function(error){
				  alert("에러야!");
			 }
		});
	});
	
	$('.fileDeletebtn2').click(function(){
		$.ajax({
			  type : "post",
			  url : "fileDeletebtn2.do",
			  data:{class_name:$('#class_name').val(), notice_num:$('#notice_num').val()},
			  success : function(data){
				  swal({
				       title: "파일이 삭제되었습니다",
					   text: "파일을 다시 추가하려면 파일을 업로드해주세요",
					   icon:"info"
					}).then(function() {
					    window.location = "noticeUpdate.do?notice_num="+notice_num+"&class_name="+class_name;
					});
			  },
			  error: function(error){
				  alert("에러야!");
			 }
		});
	});
	
	});
	
	
	

</script>
