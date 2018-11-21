<%-- 
	@JSP:noticeWrite.jsp
	@DATE:2018-10-10
	@Author:우한결
	@Desc:강사 공지사항 글쓰기 페이지(스토리보드 18 of 41)
 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="se" uri="http://www.springframework.org/security/tags" %>	
<style>
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
#notice_title{
	width:100%;
	border-radius: 5px;
}
.noticebutton{
	background:#063f54;
	width:100px;
}
.noticeCancelbutton{
	background:#B9062F;
	width:100px;
}
.subject{
	color:#063f54;
	font-weight: bold;
	width:100px;
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
							<form action="noticeView.do" method="post" enctype="multipart/form-data" onsubmit="return check();">
								<table class="table">
									<tr>
										<td class="fst_td subject">제목</td>
										<td class="scd_td"><input type="text" id="notice_title" name="notice_name"
											class="notice_input" placeholder="제목을 입력해주세요" required /></td>
									</tr>
									<tr>
										<td class="fst_td subject">내용</td>
										<td class="sec_td"><textarea id="notice_content" name="notice_content" class="summernote1 notice_input" 
												rows="20" placeholder="내용을 입력해주세요"></textarea></td>
									</tr>
									<tr>
										<td class="fst_td subject">파일 첨부</td>
										<td class="scd_td">
											<div class="col-sm-6 filediv">
											<input type="file" id="txtFile1" name="files1" />
											</div>
											<div class="col-sm-6 filediv">
											<input type="file" id="txtFile2" name="files2" />
											</div>
											<input type="hidden" id="class_name" name="class_name" value="${class_name}">
											<input type="hidden" name="class_num" value="${class_num}">
										</td>
									</tr>
									<tr>
										<td class="fst_td"></td>
										<td colspan="2">
											<button type="submit" id="notice_submit" class="btn btn-theme noticebutton">글 등록</button>
											<se:authorize access="hasRole('ROLE_TEACHER')">
												<a href="teacherMain.do" class="btn btn-theme04 noticeCancelbutton">취소</a>
											</se:authorize>
											<se:authorize access="hasRole('ROLE_ADMIN')">
												<a href="adminClassMain.do?class_num=${class_num}&class_name=${class_name}" class="btn btn-info noticeCancelbutton">취소</a>
											</se:authorize>
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
		if($('#notice_content').val() == "" || $('#notice_content').val() == null){
			swal("글 내용을 반드시 입력해주세요", "글내용을 입력하지 않으면 등록할 수 없습니다", "error");
		return false;
		}else{
		return true;	
	}
	}

</script>
