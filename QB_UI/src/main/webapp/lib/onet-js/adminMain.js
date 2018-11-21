$(function() {
	// fancybox
	/*jQuery(".fancybox").fancybox();*/
	
	// 새 클래스 개설 버튼 눌렀을 때 날짜 빈칸으로 
	$('#makeNewClassBtn').click(function(){
		$('#new_class_start_date').val('');
		$('#new_class_end_date').val('');
	});
	
	// deleteClass 모달에 hidden값 넣기 
	$(document).on("click", ".deleteClass", function(){
		var class_name = $(this).parent().children().eq(0).val();
		$('#class_name_modal').val(class_name);
	});
	
	// deleteClass Form 전송 
	$('#deleteClassBtn').click(function(){
		action = "${pageContext.request.contextPath}/deleteClass.do?class_name=" + $('#class_name_modal').val();
		$('#deleteClassForm').submit();
	});
	
	// updateClass 모달에 값 넣기 
	$(document).on("click", ".updateClass", function(){
		var class_num = $(this).parent().children().eq(1).val();
		var class_name = $(this).parent().children().eq(0).val();
		var teacher_name = $(this).parent().children().eq(2).val();
		var class_start_date = $(this).parent().children().eq(3).val();
		var class_end_date = $(this).parent().children().eq(4).val();
		
		$('#class_num_update').val(class_num);
 		$('#class_name_update').val(class_name);
 		$('.class_start_date').val(class_start_date);
 		$('.class_end_date').val(class_end_date);
 		$('#teacher_name_update').val(teacher_name);
	});
	

	
});
