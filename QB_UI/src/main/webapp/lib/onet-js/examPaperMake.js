/**
 * 18.10.10 현이 teacherMyExamPaper.js 파일 추가
 * 18.10.16 한결 선택문제 출제 및 삭제 
 */

jQuery(document).ready(function() {


   TaskList.initTaskWidget();
   
   /*선택문제 출제 + 문제 수 +카운트*/
   $('#pickQuestionBtn').click(function(){
      
      var sortable_li_num = $('#qnum').text();
     
      var selected = new Array();
      
      
	  var chkArray = [];
	  var alQuestionName = "";
	  $('#sortable input[name="checkbox[]"]').each(function(){
		 chkArray.push($(this).val()); 
	  });
	  for(i=0;i<chkArray.length;i++){
		  $('.questions input[name="checkbox[]"]:checked').each(function() {
			 if(chkArray[i] == $(this).val()){
				 alQuestionName = alQuestionName +$(this).parents('.qnumdiv').siblings('#questiontitle').find('b').text() + "\n";
			 }
		  });
	  }
	  
	  $('.questions input[name="checkbox[]"]:checked').each(function() {
		 if(alQuestionName !=""){
			  swal("같은 문제가 이미 출제되었습니다.\n"+"문제 제목  : \n"+alQuestionName);			  
		  }		  
	         selected.push("<li class='liright'><div class='questionDivRight'>" 
	               + $(this).parents().parents().html()
	               + "</div><div class='qscore'>배점:&nbsp; <input type='number' " +
	                     "class='form-control questionScoreInputTag' id='insertedQScore' name='quantity' val='1' min='1' max='20'  " +
	                     "onchange='plusqcore()' /></div></li>");	         
	         sortable_li_num++;
		  
	   });
	  //input클릭 줄복 방지
	  $("input").click(function () {
		  event.stopPropagation();
	  });

      $('#sortable').append(selected);
      $('input[name="checkbox[]"]:checked').prop('checked',false);
      $(".questionDiv").removeClass('active');
      $(".check-img").removeClass('active');
      $(".check-img").attr('src',"");
      
      $('#qnum').text(sortable_li_num);
   });
   
   /*미리보기*/
   $('#miriBtn').click(function(){
	   var mirilength = Math.round($('#sortable>li').length);
	   var pageCount = 0;
	   $('.book').children().remove();
	   $("#sortable>li").each(function(index){
		   if(index == 0 || index%6 == 0){
			   
			   
			   if(index != 0){
				   pageCount++;
			   }
			   $(".book").append("<div class='page' id='page"+pageCount+"'>");
			   
		   }
		   $('#page'+pageCount).append("<span>"+(index+1)+" . </span>"+$(this).find("#questiontitle").html() + "<br><br>");
		   if(index%6 == 5){
			   $(".book").append("</div>");
			   
		   }
		   
	   });
	   
   })
   
   /*선택문제 삭제 + 문제 수 -카운트 / 점수 -카운트*/
   $('#pickQuestionDeleteBtn').click(function(){
      
      var sortable_li_num = $('#qnum').text();
      var qc = Number($('#qcore').text());
      
      
      $('#sortable input[name="checkbox[]"]:checked').each(function() {
         
         $(this).closest("li").remove();
         sortable_li_num--;
         
         
         qc = qc - Number($(this).closest('li').find('#insertedQScore').val());
      });
      $('#qnum').text(sortable_li_num);
      $('#qcore').text(qc);
   });

   /*임시저장 버튼 눌렀을 떄*/
   $('#pickQuestionTempSaveModalBtn').click(function(){
	   
	   var questionNum = "";
	   var questionScore = "";
	   var questionIndex = "";
	   $('.selectedBox').find('input[name="checkbox[]"]').each(function(index){
		   if($(this).closest('li').find('#insertedQScore').val()==""){
			   $(this).closest('li').find('#insertedQScore').val("0");
		   }
		   questionNum += $(this).val() + ", ";
		   questionScore += $(this).closest('li').find('#insertedQScore').val() + ", ";
		   questionIndex += (index+1) + ", ";
	   });
	   
	   $('#saveQNum').val(questionNum);
	   $('#saveEQSeq').val(questionIndex);
	   $('#saveEQScore').val(questionScore);

	   $('#pickQuestionTempSaveModal').modal(); 
	   
	 //boot모달 포커스	   
		$('#pickQuestionTempSaveModal').on('shown.bs.modal', function () {
		    $('#tempexamname').focus();
		})
   });
   
   /*점수가 100점일때 그리고 배점에 빈칸이 없을 떄 시험지생성 활성화*/
   $('#makeExamSubmitModalBtn').click(function(){
	   var count = [];
	   var score = [];
	   
	   $('.selectedBox').find('input[name="checkbox[]"]').each(function(index){
		   var eachScore = $(this).closest('li').find('#insertedQScore').val();
		   count.push(index);
		   if(eachScore!=""){
			   score.push(eachScore);
		   }
	   });
	   if(count.length == score.length && $('#qcore').text()==100){
		   $('#makeExamSubmitModal').modal();
	   }else{
		   swal("각 문제의 배점 및 총 배점을 확인해주세요.\n총 배점이 100점일때만 시험지를 생성할 수 있습니다.\n");
	   }
	 //boot모달 포커스
	   $('#makeExamSubmitModal').on('shown.bs.modal', function () {
		    $('#exam_name').focus();
		})
   });
   
   
});

function makeExamSubmitBtn(num){
	var examPNum = $('#insertEPNum').val();
	var examName = "";
	
	var examDesc = "";
	var examPStatus = num;
	/*유효성검사*/
	if(num==0 && examPNum == ""){
		if($('.exam-paper-name').val()==""){
			swal("시험지 이름을 작성해주세요"); return false;
		}else if($('.exam-paper-desc').val()==""){
			swal("시험지 설명을 작성해주세요\n(ex.총 10문제)"); return false;
		}
		examName=$('.exam-paper-name').val().trim();
		examDesc=$('.exam-paper-desc').val().trim();
		$('.createEPaper').val(examName);
		$('.createEPDesc').val(examDesc);
		
		insertEP(examName, examDesc, examPStatus);
	}else if(num==1 && examPNum == ""){
		if($('.createEPaper').val()==""){
			swal("시험지 이름을 작성해주세요"); return false;
		}else if($('.createEPDesc').val()==""){
			swal("시험지 설명을 작성해주세요\n(ex.총 10문제)"); return false;
		}
		examName=$('.createEPaper').val().trim();
		examDesc=$('.createEPDesc').val().trim();
		
		insertEP(examName, examDesc, examPStatus);
	}else if(num==0 && examPNum != ""){
		if($('.exam-paper-name').val()==""){
			swal("시험지 이름을 작성해주세요");
		}else if($('.exam-paper-desc').val()==""){
			swal("시험지 설명을 작성해주세요\n(ex.총 10문제)");
		}
		examName=$('.exam-paper-name').val().trim();
		examDesc=$('.exam-paper-desc').val().trim();
		$('.createEPaper').val(examName);
		$('.createEPDesc').val(examDesc);
		
		updateEP(examPNum, examName, examDesc, examPStatus);
	}else if(num==1 && examPNum != ""){
		if($('.createEPaper').val()==""){
			swal("시험지 이름을 작성해주세요");
		}else if($('.createEPDesc').val()==""){
			swal("시험지 설명을 작성해주세요\n(ex.총 10문제)");
		}
		examName=$('.createEPaper').val().trim();
		examDesc=$('.createEPDesc').val().trim();
		
		updateEP(examPNum, examName, examDesc, examPStatus);
	}

}

function insertEP(examName, examDesc, examPStatus){
  var promise = $.ajax({
  url:"../teacher/examPaperInsert.do",
  type:"get",
  dataType:"json",
  data:{
     "exam_paper_name":examName, 
     "exam_paper_desc":examDesc,
     "exam_paper_status":examPStatus
     },
     global:false,
   success:function(epnum){
	   $('.selectedBox').find('input[name="checkbox[]"]').each(function(index){
	         var questionNum = $(this).val();
	         var EQSeq=(Number(index) + 1);	     
	         $.ajax({
	            url:"../teacher/examQuestionInsert.do",
	            type:"get",
	            dataType:"json",
	            data:{
	               "exam_paper_num":epnum,
	               "question_num":$(this).val(),
	               "exam_question_seq":EQSeq,
	               "exam_question_score":$(this).closest('li').find('#insertedQScore').val()
	            },
	            global:false,
	            success:function(data){

	            }
	         });
	      });         
	         
	         if(examPStatus==1){
	        	 swal({
				       title: "시험지가 생성되었습니다.",
					   text: "",
					   icon:"success"
					}).then(function() {
					    window.location = "examManagement.do";
					});
	         }else{
	        	 $('#insertEPNum').val(epnum);
	        	 $('#pickQuestionTempSaveModal').modal('hide'); 
				 swal("임시 저장되었습니다.");
	         }
   }
});
}
function updateEP(examPNum, examName, examDesc, examPStatus){
	 $.ajax({
       url:"../teacher/examPaperUpdate.do",
       type:"get",
       dataType:"json",
       data:{
    	  "exam_paper_num":examPNum,
          "exam_paper_name":examName, 
          
          "exam_paper_desc":examDesc,
          "exam_paper_status":examPStatus
       },
       global:false,
       success:function(data){
    	   $.ajax({
             url:"../teacher/examQuestionDelete.do",
             type:"get",
             dataType:"json",
             data:{
                "exam_paper_num":examPNum
                },
             success:function(Qnum){
            	 $('.selectedBox').find('input[name="checkbox[]"]').each(function(index){
                   var questionNum = $(this).val();
                   var EQSeq=(Number(index) + 1);
                   var Score = $(this).closest('li').find('#insertedQScore').val();
                      
                      $.ajax({
                         url:"../teacher/examQuestionInsert.do",
                         type:"get",
                         dataType:"json",
                         data:{
                            "exam_paper_num":examPNum,
                            "question_num":$(this).val(),
                            "exam_question_seq":EQSeq,
                            "exam_question_score":Score
                         },
                         global:false,
                         success:function(data){
                            
                            
                         }
                      });
                   });
             }
          });
    	   if(examPStatus==1){
  	         	location.href="examManagement.do";
  	       }else{
  	        	$('#pickQuestionTempSaveModal').modal('hide'); 
  				swal("임시 저장되었습니다.");
  	       }
       },
       error:function(xml){
          swal("업데이트 에러입니다.");
       }
    });
}

function plusqcore(){
	var qc = Number($('#qcore').val());
	$('.questionScoreInputTag').each(function(){
		if($(this).val()>100){
			swal("한 문제당 최대 배점은 20점까지 인정됩니다.");
			$(this).val(20);
			qc += Number(20);
		} else {
			qc += Number($(this).val());
		}
	});
		if(qc > 100){
			swal("총 점수가 100점이 넘을 수 없습니다.");
			$('#qcore').text(qc);
		}
		$('#qcore').text(qc);
};


$(function() {
	$("#sortable").sortable();
	$("#sortable").disableSelection();
});