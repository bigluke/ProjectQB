

function updateExamBtn(num){
	
	var exam_paper_num = num;
	var exam_name = $("#exam_name").val();
	var exam_desc = $("#exam_desc").val();
	
	var lastcheck = confirm("수정을 완료하시겠습니까?");
	
	if(lastcheck == true){
		$.ajax({
			url : "examquestionsdelete.do",
			type : "get",
			data : {
				"exam_paper_num" : exam_paper_num,
				"exam_name" : exam_name,
				"exam_desc" : exam_desc
			},
			success:function(data){
				
				$('.selectedBox').find('input[name="checkbox[]"]').each(function(index){
					var question_num = $(this).val();   //문제 번호
					var exam_question_seq = Number(index+1) //문제 배치 번호
					var exam_question_score = $(this).parents('.qnumdiv').siblings('.qscore').find('#insertedQScore').val() //문제 배점
					
					$.ajax({
						url : "examquestionsinsert.do",
						type : "get",
						dataType : "json",
						data : {
							"exam_paper_num" : exam_paper_num,
							"question_num" : question_num,
							"exam_question_seq" : exam_question_seq,
							"exam_question_score" : exam_question_score,
						},
						success:function(data){
							location.href="examManagement.do";
						}
					})
				});
			}
		});
	}else{
		
	}
}