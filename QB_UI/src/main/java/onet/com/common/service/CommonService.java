package onet.com.common.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import onet.com.common.dao.CommonDao;
import onet.com.teacher.dao.TeacherDao;
import onet.com.vo.CommentDto;

import onet.com.vo.CategoryDto;
import onet.com.vo.ChartCategory;
import onet.com.vo.Class_chartDto;

import onet.com.vo.ExamInfoDto;
import onet.com.vo.ExamPaperDoQuestionDto;
import onet.com.vo.ExamQuestionDto;
import onet.com.vo.Exam_infoDto;
import onet.com.vo.MemberDto;
import onet.com.vo.MessageDto;
import onet.com.vo.NoticeDto;
import onet.com.vo.QuestionDto;
import onet.com.vo.Question_choiceDto;
import onet.com.vo.Score_chartDto;
import onet.com.vo.StudentExamScoreInfo;

@Service
public class CommonService {
	
	@Autowired
	private SqlSession sqlsession;
	
   /*한결 - 10.10 강사 메인페이지 백그라운드 시작*/
	public List<MemberDto> member(String member_id) {
		CommonDao dao = sqlsession.getMapper(CommonDao.class);
		List<MemberDto> result = dao.member(member_id);
		return result;
	}
	public List<NoticeDto> teacher_student_Main(String member_id) {
		CommonDao dao = sqlsession.getMapper(CommonDao.class);
		NoticeDto dto = new NoticeDto();
		List<NoticeDto> result = dao.notice(member_id);
		return result;
	}
   
   public List<Exam_infoDto> exam_info(String member_id) {
      CommonDao dao = sqlsession.getMapper(CommonDao.class);      
      Exam_infoDto dto = new Exam_infoDto();      
      List<Exam_infoDto> result = dao.exam_info(member_id);
      return result;
   }
   /*한결 - 10.10 강사 메인페이지 백그라운드  끝*/
	   
	/*민지 - 10.10 관리자 메인페이지 백그라운드 시작*/
	public List<NoticeDto> admin_Main(String class_name) {
		CommonDao dao = sqlsession.getMapper(CommonDao.class);
		NoticeDto dto = new NoticeDto();
		dto.setClass_name(class_name);
		List<NoticeDto> result = dao.adminnotice(dto);
		return result;
	}
	
	public List<ExamInfoDto> admin_exam_info(String class_name) {
		CommonDao dao = sqlsession.getMapper(CommonDao.class);		
		ExamInfoDto dto = new ExamInfoDto();		
		dto.setClass_name(class_name);
		List<ExamInfoDto> result = dao.adminexam_info(dto);
		return result;
	}
	/*민지 - 10.10 관리자 메인페이지 백그라운드 끝*/
	
	/*현이 - 10.15 examScheduleDetail 시작*/
	public ExamInfoDto examScheduleDetail(int exam_info_num) {
		CommonDao dao = sqlsession.getMapper(CommonDao.class);
		ExamInfoDto result = dao.examScheduleDetail(exam_info_num);
		return result;
	}
	/*현이 - 10.15 examScheduleDetail 끝*/
	
	/*양회준 - 10.15 내정보 시작 */
	//내정보 보기
	public MemberDto myPageInfo(String member_id) {
		CommonDao commonDao = sqlsession.getMapper(CommonDao.class);
		MemberDto memberDto = commonDao.myPageInfo(member_id);
		return memberDto;
	}	
	//내정보 수정
	public String myPageUpdate(MemberDto memberDto)
			throws ClassNotFoundException, SQLException, IOException {
		CommonDao commonDao = sqlsession.getMapper(CommonDao.class);
		commonDao.myPageUpdate(memberDto);
		return "redirect:myPage.do";
	}
	//내정보 탈퇴
	public String myPageDrop(MemberDto memberDto)
			throws ClassNotFoundException, SQLException, IOException {
		CommonDao commonDao = sqlsession.getMapper(CommonDao.class);
		commonDao.myPageDrop(memberDto);
		return "redirect:myPage.do";
	}
	/*양회준 - 10.15 내정보 끝 */

	public String memberDrop(String member_id)
			throws ClassNotFoundException, SQLException, IOException {
		CommonDao commonDao = sqlsession.getMapper(CommonDao.class);
		String result = commonDao.memberDrop(member_id);
		
		return result;
	}
	
	
	/*현이 - ExamPaperDo 10.18 시작 */ 
	public List<ExamPaperDoQuestionDto> examPaperDoQuestion(int exam_info_num) throws ClassNotFoundException, SQLException, IOException {
		CommonDao commonDao = sqlsession.getMapper(CommonDao.class);
		List<ExamPaperDoQuestionDto> questionList = commonDao.examPaperDoQuestion(exam_info_num);
		return questionList;
	}
	
	public List<Question_choiceDto> examPaperDoQuestion_choice(int exam_info_num) throws ClassNotFoundException, SQLException, IOException {
		CommonDao commonDao = sqlsession.getMapper(CommonDao.class);
		List<Question_choiceDto> questionChoiceList = commonDao.examPaperDoQuestion_choice(exam_info_num);
		return questionChoiceList;
	}
	
	public int questionCount(int exam_info_num) throws ClassNotFoundException, SQLException, IOException {
		
		CommonDao commonDao = sqlsession.getMapper(CommonDao.class);
		int questionCount = commonDao.questionCount(exam_info_num);
		return questionCount;
	}
	/*현이 - ExamPaperDo 10.18 끝 */ 
	
/*######################      재훈 시작             ######################*/

//문제관리 - 문제삭제 전 삭제가능여부 판단
	public int singleQuestionDelete(int question_num) {
		CommonDao dao = sqlsession.getMapper(CommonDao.class);
		QuestionDto qdto = new QuestionDto();
		Question_choiceDto cdto = new Question_choiceDto();
		int result = 0;
		
		List<ExamQuestionDto> qSearch = dao.singleQuestionDeleteSearch(question_num);
		if(qSearch.isEmpty()) {
			
			cdto.setQuestion_num(question_num);
			qdto.setQuestion_num(question_num);
			dao.singleQuestionChoiceDelete(cdto);
			result = dao.singleQuestionDelete(qdto);
			return result;
		}else {
			return result;
		}
	}

	public int insertBoardList(NoticeDto dto) {
		CommonDao dao = sqlsession.getMapper(CommonDao.class);
		String notice_num = dao.noticeNumFind(dto);
		if(notice_num != null) {
			int notice_number = Integer.parseInt(notice_num);
			dto.setNotice_num(notice_number+1);
			int result = dao.insertBoardList(dto);
			return result;
		}else {
			dto.setNotice_num(1);
			int result = dao.insertBoardList(dto);
			return result;
		}		
	}
	
	public List<NoticeDto> noticeDetail(String class_name, int notice_num){
		CommonDao dao = sqlsession.getMapper(CommonDao.class);
		NoticeDto dto = new NoticeDto();
		dto.setClass_name(class_name);
		dto.setNotice_num(notice_num);
		List<NoticeDto> result = dao.noticeDetail(dto);
		return result;
	}


//문제관리 - 문제 수정 전 수정가능여부 판단
	public int singleUpdateCheck(int question_num) {
		CommonDao dao = sqlsession.getMapper(CommonDao.class);
		int result = 0;
		
		List<ExamQuestionDto> qSearch = dao.singleQuestionDeleteSearch(question_num);
		if(qSearch.isEmpty()) {
			result = 1;
			return result;
		}else {
			return result;
		}
	}
//문제 수정 페이지 - 문제 정보 가져오기
	public List<QuestionDto> questionInfo(int question_num) {
		CommonDao commonDao = sqlsession.getMapper(CommonDao.class);
		QuestionDto qdto = new QuestionDto();
		qdto.setQuestion_num(question_num);
		List<QuestionDto> result = commonDao.questionInfo(qdto);
			
		return result;
	}	
//문제 수정 페이지 - 문제 보기정보 가져오기
	public List<Question_choiceDto> questionChoiceInfo(int question_num) {
		CommonDao commonDao = sqlsession.getMapper(CommonDao.class);
		Question_choiceDto cdto = new Question_choiceDto();
		cdto.setQuestion_num(question_num);
		List<Question_choiceDto> result = commonDao.questionChoiceInfo(cdto);
			
		return result;
	}	
//문제 수정 페이지 - 문제카테고리 가져오기
	public List<CategoryDto> questionCategoryInfo(int question_num) {
		CommonDao commonDao = sqlsession.getMapper(CommonDao.class);
		List<CategoryDto> result = commonDao.questionCategoryInfo(question_num);
			
		return result;
	}

	/*######################      재훈 끝             ######################*/
	
	public List<MemberDto> boardNull(String member_id){
		CommonDao commonDao = sqlsession.getMapper(CommonDao.class);
		List<MemberDto> boardNull = commonDao.noticeNullCheck(member_id);
		return boardNull;
	}
	
	public List<CommentDto> comment(String class_name, int notice_num){
		CommonDao commonDao = sqlsession.getMapper(CommonDao.class);
		CommentDto dto = new CommentDto();
		dto.setClass_name(class_name);
		dto.setNotice_num(notice_num);
		List<CommentDto> comment = commonDao.comment(dto);
		return comment;
	}
	
	public List<CommentDto> commentGroup(String class_name, int notice_num){
		CommonDao commonDao = sqlsession.getMapper(CommonDao.class);
		CommentDto dto = new CommentDto();
		dto.setClass_name(class_name);
		dto.setNotice_num(notice_num);
		List<CommentDto> commentGroup = commonDao.commentGroup(dto);
		return commentGroup;
	}
		
	public int commentReply(CommentDto dto){
		CommonDao commonDao = sqlsession.getMapper(CommonDao.class);
		int result = commonDao.commentReply(dto);
		return result;
	}


	public int commentInsert(CommentDto dto){
		CommonDao commonDao = sqlsession.getMapper(CommonDao.class);
		int result = commonDao.commentInsert(dto);
		return result;
	}
	
	public int commentUpdate(CommentDto dto) {
		CommonDao commonDao = sqlsession.getMapper(CommonDao.class);
		int result = commonDao.commentUpdate(dto);
		return result;
	}
	
	public int commentReplyDelete(CommentDto dto) {
		CommonDao commonDao = sqlsession.getMapper(CommonDao.class);
		int result = commonDao.commentReplyDelete(dto);
		return result;
	}

	//양회준 10-24 관리자, 강사-학생&성적관리 페이지
	public List<MemberDto> studentInfo(String member_id, String class_num){
		List<MemberDto> studentList = null;
		CommonDao dao = sqlsession.getMapper(CommonDao.class);
		if(member_id.equals("admin")) {
			studentList = dao.adminStudentInfo(class_num);
		}else {	
			studentList = dao.studentInfo(member_id);
		}		
		return studentList;
	}
	//양회준 10-24 관리자, 강사-학생&성적관리 페이지-학생정보 chart
	public Map<String, Object> studentChartInfo(String member_id, String class_name){
		CommonDao dao = sqlsession.getMapper(CommonDao.class);
		List<Score_chartDto> studentChart = dao.studentChartInfo(member_id);
		
		List<Class_chartDto> classChart = dao.classChartInfo(class_name);
		Map<String, Object> chart = new HashMap<String, Object>();
		chart.put("studentName", studentChart);
		chart.put("className", classChart);
		return chart;
	}
	//양회준 10-25 학생&성적관리 학생개인 성적확인
	public List<StudentExamScoreInfo> studentExamScoreInfo(String member_id, String class_name){
		CommonDao dao = sqlsession.getMapper(CommonDao.class);		
		List<StudentExamScoreInfo> list = dao.studentExamScoreInfo(member_id, class_name);//시험 정보
		List<StudentExamScoreInfo> ctgrlist = dao.studentExamScoreInfoCtgr(member_id, class_name);//시험 당 소분류
		
		for(StudentExamScoreInfo data : list) {
			ArrayList<String> ctgr = new ArrayList<String>();
			for(StudentExamScoreInfo data2 : ctgrlist) {
				if(data.getExam_info_num()==data2.getExam_info_num()) {
					ctgr.add(data2.getSm_category_name());//시험당 관련 소분류명을 Arraylist에 담음					
				}
			}
			data.setSmCtgrName(ctgr);//소분류 ArrayList를 DTO에 담음
		}
		
		return list;
	}
	//양회준 10-29 학생&성적관리 클래스 통계 표
	public List<Score_chartDto> studentExamScoreList(String class_name){
		CommonDao commonDao = sqlsession.getMapper(CommonDao.class);	
		
		List<Score_chartDto> scorelist= commonDao.studentExamScoreList(class_name);//과목별 점수
		List<Score_chartDto> avglist= commonDao.studentExamScoreAvg(class_name);//평균점수
		for(Score_chartDto data : avglist) {
			HashMap<String, Integer> score = new HashMap<String, Integer>();
			//score.clear();
			for(Score_chartDto data2 : scorelist) {				
				if(data.getMember_id().equals(data2.getMember_id())) {//아이디가 같을 경우 점수를 map 대입
					score.put(data2.getExam_info_name(), data2.getScore_chart_score());								
				}
			}
			data.setScore_list(score);;//점수리스트를 평균리스트에 대입			
		}
		return avglist;
	}
	
	//양회준 10.29 학생&성적관리.클래스통계.점수별분포
	public int[] studentScoreSpread(int exam_info_num, String class_name){
		CommonDao dao = sqlsession.getMapper(CommonDao.class);
		int spreadCount = 0;
		int[] spreadList = new int[10];
		int start = 0;
		int end = 10;
		for(int i=0;i<10;i++) {
			if(i==0) {
				spreadCount = dao.studentScoreSpread(exam_info_num, class_name, start, end);
			}else {
				start = (i*10)+1;
				end = (i*10)+10;
				spreadCount = dao.studentScoreSpread(exam_info_num, class_name, start, end);
			}
			spreadList[i]=spreadCount;
		}
		return spreadList;
	}
	//양회준 11.8 학생&성적관리.클래스통계.표준편차
	public List<Double> classExamSTD(String class_name){
		CommonDao dao = sqlsession.getMapper(CommonDao.class);
		List<Double> std = dao.classExamSTD(class_name);
		return std;
	}
	//양회준 11.9 학생.성적관리.도넛차트
	public List<ChartCategory> studentExamScRatio(String member_id, String class_name){
		CommonDao dao = sqlsession.getMapper(CommonDao.class);
		List<ChartCategory> answer = dao.studentExamScRatio(member_id, class_name);
		return answer;
	}
	public List<ChartCategory> studentExamMdRatio(String member_id, String class_name){
		CommonDao dao = sqlsession.getMapper(CommonDao.class);
		List<ChartCategory> answer = dao.studentExamMdRatio(member_id, class_name);
		return answer;
	}

	public List<NoticeDto> noticeUpdateList(NoticeDto dto) {
		CommonDao commonDao = sqlsession.getMapper(CommonDao.class);
		List<NoticeDto>result = commonDao.noticeUpdateList(dto);
		return result;
	}
	
	public int updateBoardList(NoticeDto dto) {
		CommonDao dao = sqlsession.getMapper(CommonDao.class);
		int result = dao.updateBoardList(dto);
		return result;
	}
	
	@Transactional
	public int noticeDelete(NoticeDto dto) {
		CommonDao dao = sqlsession.getMapper(CommonDao.class);
		int result = 0;
		try {
			dao.noticeFromCommentDelete(dto);
			result = dao.noticeDelete(dto);
		}catch(Exception e) {
			throw e;
		}
		return result;
	}	

	// 영준 10.25 관리자, 강사 - 학생&성적관리 페이지 - 반 등수
	public List<Score_chartDto> classRank(int exam_info_num){
		CommonDao dao = sqlsession.getMapper(CommonDao.class);
		List<Score_chartDto> classRank = dao.classRank(exam_info_num);
		return classRank;
	}


	
	//민지 10.26 강사-쪽지 페이지 해당클래스학생 리스트 
	   public List<MemberDto> classMemeberList(String member_id) {
	      CommonDao dao = sqlsession.getMapper(CommonDao.class);
	      
	      List<MemberDto> result = dao.classMemeberList(member_id);
	      
	      return result;
	   }

	   public List<MessageDto> receiveMessage(String member_id){
		   CommonDao dao = sqlsession.getMapper(CommonDao.class);
		   List<MessageDto> result = dao.receiveMessage(member_id);
		   String sendManId = result.get(0).getSend_member_id();
		   for(int i=0; i<result.size(); i++) {
			   result.get(i).setMember_name(dao.nameSearch(sendManId));
		   }
		   return result;
	   }

	   public List<MessageDto> sendMessage(String member_id){
		   CommonDao dao = sqlsession.getMapper(CommonDao.class);
		   List<MessageDto> result = dao.sendMessage(member_id);
		   return result;
	   }
	   
	   //민지 쪽지 1029
	   public List<MemberDto> classTeacherList(String member_id) {
		      CommonDao dao = sqlsession.getMapper(CommonDao.class);
		      
		      List<MemberDto> result = dao.classTeacherList(member_id);
		      
		      return result;
		   }
	   
	   public int updateBoardListFile1(NoticeDto dto) {
			CommonDao commonDao = sqlsession.getMapper(CommonDao.class);
			int result = commonDao.updateBoardListFile1(dto);
			return result;
		}
	   
	   public int updateBoardListFile2(NoticeDto dto) {
			CommonDao commonDao = sqlsession.getMapper(CommonDao.class);
			int result = commonDao.updateBoardListFile2(dto);
			return result;
		}

	   public int updateNoBoardList(NoticeDto dto) {
			CommonDao commonDao = sqlsession.getMapper(CommonDao.class);
			int result = commonDao.updateNoBoardList(dto);
			return result;
		}
	   
	   public int fileDeletebtn1(NoticeDto dto) {
			CommonDao commonDao = sqlsession.getMapper(CommonDao.class);
			int result = commonDao.fileDeletebtn1(dto);
			return result;
		}
	   
	   public int fileDeletebtn2(NoticeDto dto) {
			CommonDao commonDao = sqlsession.getMapper(CommonDao.class);
			int result = commonDao.fileDeletebtn2(dto);
			return result;
		}
	   
	   @Transactional
	   public int sendMessageDelete(String sendDeleteHiddenArray) {
			CommonDao dao = sqlsession.getMapper(CommonDao.class);
			int sendDeleteHiddenArrayInt = Integer.parseInt(sendDeleteHiddenArray);
			int result = 0;
			try {
				result = dao.sendMessageDelete(sendDeleteHiddenArrayInt);
				if(result > 0) {
					 MessageDto dto = dao.MessageDeleteCheck(sendDeleteHiddenArrayInt);
					 int rCheck = dto.getReceive_check();
					 int sCheck = dto.getSend_check();
					 if(rCheck > 0 && sCheck > 0) {
						dao.messageRealDelete(sendDeleteHiddenArrayInt);
					 }
				}
			}catch(Exception e) {
				throw e;
			}
			return result;
		}
	   
	   public int receiveMessageDelete(String receiveDeleteHiddenArray) {
			CommonDao dao = sqlsession.getMapper(CommonDao.class);
			int receiveDeleteHiddenArrayInt = Integer.parseInt(receiveDeleteHiddenArray);
			int result = 0;
			try {
				result = dao.receiveMessageDelete(receiveDeleteHiddenArrayInt);
				if(result > 0) {
					 MessageDto dto = dao.MessageDeleteCheck(receiveDeleteHiddenArrayInt);
					 int rCheck = dto.getReceive_check();
					 int sCheck = dto.getSend_check();
					 if(rCheck > 0 && sCheck > 0) {
						dao.messageRealDelete(receiveDeleteHiddenArrayInt);
					 }
				}
			}catch(Exception e) {
				throw e;
			}
			return result;
		}
	   
	
	    
	//민지10.31메시지 체크
	public int message_check(int message_check, int message_num) {
		CommonDao dao = sqlsession.getMapper(CommonDao.class);
		MessageDto dto = new MessageDto();
		dto.setMessage_check(message_check);
		dto.setMessage_num(message_num);
		int result = dao.message_check(dto);
		      
		return result;
	}
	

	public String nameSearch(String sendManId) {
		CommonDao dao = sqlsession.getMapper(CommonDao.class);
		String result = dao.nameSearch(sendManId);
		      
		return result;
	}
	
	public String nameSearch2(String receiveManId) {
		CommonDao dao = sqlsession.getMapper(CommonDao.class);
		String result = dao.nameSearch2(receiveManId);
		      
		return result;
	}

	public String classNum(String member_id) {
		CommonDao dao = sqlsession.getMapper(CommonDao.class);
		String result = dao.classNum(member_id);
		return result;
	}
	
	public int receiveMessageCheck(String member_id) {
		CommonDao dao = sqlsession.getMapper(CommonDao.class);
		int result = dao.receiveMessageCheck(member_id);
		return result;
	}
	public int sendMessageCheck(String member_id) {
		CommonDao dao = sqlsession.getMapper(CommonDao.class);
		int result = dao.sendMessageCheck(member_id);
		return result;
	}
	
	
	
	
}