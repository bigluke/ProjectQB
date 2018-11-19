package onet.com.teacher.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.ResponseBody;

import onet.com.sms.Coolsms;
import onet.com.teacher.dao.TeacherDao;
import onet.com.vo.ClassDto;
import onet.com.vo.Class_chartDto;
import onet.com.vo.ExamInfoDto;
import onet.com.vo.ExamMemberDto;
import onet.com.vo.ExamPaperDto;
import onet.com.vo.ExamQuestionDto;
import onet.com.vo.ExamQuestionListDto;
import onet.com.vo.MemberDto;
import onet.com.vo.QuestionDto;
import onet.com.vo.Question_choiceDto;
import onet.com.vo.Question_levelDto;
import onet.com.vo.Score_chartDto;
import onet.com.vo.Student_answerDto;

@Service
public class TeacherService {

	@Autowired
	private SqlSession sqlsession;

	/* 한결 - 10.17 새 시험지 만들기 문제 뿌리기 각 문제,문제보기,문제 난이도 시작 */
	public List<QuestionDto> question() {
		TeacherDao dao = sqlsession.getMapper(TeacherDao.class);
		List<QuestionDto> result = dao.question();
		return result;
	}

	public List<Question_choiceDto> question_choice() {
		TeacherDao dao = sqlsession.getMapper(TeacherDao.class);
		List<Question_choiceDto> result = dao.question_choice();
		return result;
	}

	public List<Question_levelDto> question_level() {
		TeacherDao dao = sqlsession.getMapper(TeacherDao.class);
		List<Question_levelDto> result = dao.question_level();
		return result;
	}
	/* 한결 - 10.17 새 시험지 만들기 문제 뿌리기 각 문제,문제보기,문제 난이도 끝 */

	/* 재훈 - 10.19 강사 문제관리 - 내가 만든 문제 시작 */
	public List<QuestionDto> teacherMyQuestion(String member_id) {
		TeacherDao dao = sqlsession.getMapper(TeacherDao.class);
		List<QuestionDto> result = dao.teacherMyQuestion(member_id);
		return result;
	}

	public List<QuestionDto> teacherMyQuestionSearch(String lgsearchtype, String mdsearchtype, String smsearchtype,
			String leveltype, String questiontype, String keyword, String member_id) {
		TeacherDao dao = sqlsession.getMapper(TeacherDao.class);
		List<QuestionDto> result = dao.teacherMyQuestionSearch(lgsearchtype, mdsearchtype, smsearchtype, leveltype,
				questiontype, keyword, member_id);
		return result;
	}

	/* 재훈 - 10.19 강사 문제관리 - 내가 만든 문제 끝 */

	/* 영준 - 10.16 선생님 시험관리 페이지 시작 */
	public List<ExamPaperDto> examPaperList(int class_num) {
		TeacherDao dao = sqlsession.getMapper(TeacherDao.class);
		List<ExamPaperDto> result = dao.examPaperList(class_num);
		return result;
	}
	/* 영준 - 10.16 강사 시험관리 페이지 끝 */

	/* 한결 - 10.17 시험지 체크 및 insert 시작 */
	public int examPaperInsert(ExamPaperDto dto) {
		TeacherDao dao = sqlsession.getMapper(TeacherDao.class);
		int result = dao.examPaperInsert(dto);
		return result;
	}

	public int examPaperUpdate(int exam_paper_num, String exam_paper_name, String member_id, String exam_paper_desc,
			String exam_paper_status) {
		TeacherDao dao = sqlsession.getMapper(TeacherDao.class);
		int result = dao.examPaperUpdate(exam_paper_num, exam_paper_name, member_id, exam_paper_desc,
				exam_paper_status);
		return result;
	}

	public int examQuestionInsert(int exam_paper_num, String question_num, String exam_question_seq,
			String exam_question_score) {
		TeacherDao dao = sqlsession.getMapper(TeacherDao.class);
		int result = dao.examQuestionInsert(exam_paper_num, question_num, exam_question_seq, exam_question_score);
		return result;
	}

	public int examQuestionDelete(String exam_paper_num) {
		TeacherDao dao = sqlsession.getMapper(TeacherDao.class);
		int result = dao.examQuestionDelete(exam_paper_num);
		return result;
	}

	/* 한결 - 10.17 시험지 체크 및 insert 끝 */

	/* 영준 - 10.16 선생님 시험관리 페이지 끝 */

	/* 민지 - 10.18 시험등록 */
	public int examInfoInsert(ExamInfoDto dto) {

		TeacherDao dao = sqlsession.getMapper(TeacherDao.class);
		int result = dao.examInfoInsert(dto);
		return result;
	}

	public int examMemberInsert(ExamMemberDto dto) {
		TeacherDao dao = sqlsession.getMapper(TeacherDao.class);

		int result = dao.examMemberInsert(dto);
		return result;

	}
	/* 민지- 10.18 시험등록 끝 */

	/*--성태용 시작--*/

	// 문제 검색
	public List<QuestionDto> questionSearch(String lgsearchtype, String mdsearchtype, String smsearchtype,
			String leveltype, String questiontype, String keyword) {
		TeacherDao dao = sqlsession.getMapper(TeacherDao.class);
		List<QuestionDto> result = dao.questionSearch(lgsearchtype, mdsearchtype, smsearchtype, leveltype, questiontype,
				keyword);
		return result;
	}

	// 내시험지 리스트
	public List<ExamPaperDto> myExamPaperList(String member_id) {
		TeacherDao dao = sqlsession.getMapper(TeacherDao.class);
		List<ExamPaperDto> result = dao.myExamPaperList(member_id);
		return result;
	}

	// 내임시시험지 리스트
	public List<ExamPaperDto> myTempExamList(String member_id, int begin) {
		TeacherDao dao = sqlsession.getMapper(TeacherDao.class);
		List<ExamPaperDto> result = dao.myTempExamList(member_id, begin);
		return result;
	}

	// 시험등록 일정리스트
	public List<ExamInfoDto> examScheduleList(String member_id) {
		TeacherDao dao = sqlsession.getMapper(TeacherDao.class);
		List<ExamInfoDto> result = dao.examScheduleList(member_id);
		return result;
	}

	public List<ExamInfoDto> examScheduleList2(int exam_paper_num) {
		TeacherDao dao = sqlsession.getMapper(TeacherDao.class);
		List<ExamInfoDto> result = dao.examScheduleList2(exam_paper_num);
		return result;
	}

	public int deleteExam(int exam_paper_num) {
		TeacherDao dao = sqlsession.getMapper(TeacherDao.class);

		int result = 0;
		int checkdate = dao.checkDate(exam_paper_num); // 0이 아닐경우 현재 날짜보다 높다
		int checkinfo = dao.checkExamInfo(exam_paper_num); // 0이면 등록된 일정이 없다

		if (checkinfo == 0 && checkdate == 0) {
			dao.deleteExam(exam_paper_num);
			result = 1; // delete
		} else if (checkinfo != 0 && checkdate == 0) {
			dao.updateExam(exam_paper_num);
			result = 2; // update
		} else if (checkinfo != 0 && checkdate != 0) {
			result = 3; // 삭제불가
		}
		return result;
	}

	public int updateExamCheck(int exam_paper_num) {
		TeacherDao dao = sqlsession.getMapper(TeacherDao.class);

		int result = 0;
		int checkdate = dao.checkDate(exam_paper_num); // 0이 아닐경우 현재 날짜보다 높다
		int checkinfo = dao.checkExamInfo(exam_paper_num); // 0이면 등록된 일정이 없다

		if (checkinfo == 0 && checkdate == 0) {
			result = 1;
		} else if (checkinfo != 0 && checkdate == 0) {
			result = 2;
		} else if (checkinfo != 0 && checkdate != 0) {
			result = 3; // 수정불가
		}
		return result;
	}

	public int deleteTempExam(int exam_paper_num) {
		TeacherDao dao = sqlsession.getMapper(TeacherDao.class);
		int result = dao.deleteExam(exam_paper_num);
		return result;
	}

	public List<QuestionDto> updateExamView(int exam_paper_num) {
		TeacherDao dao = sqlsession.getMapper(TeacherDao.class);
		List<QuestionDto> result = dao.updateExamView(exam_paper_num);
		return result;
	}

	public int examquestionsdelete(int exam_paper_num, String exam_name, String exam_desc) {
		TeacherDao dao = sqlsession.getMapper(TeacherDao.class);
		int result = dao.examquestionsdelete(exam_paper_num);
		int result2 = dao.examNameUpdate(exam_paper_num, exam_name, exam_desc);

		return result;
	}

	public int examquestionsinsert(int exam_paper_num, int question_num, int exam_question_seq,
			int exam_question_score) {
		TeacherDao dao = sqlsession.getMapper(TeacherDao.class);
		int result = dao.examquestionsinsert(exam_paper_num, question_num, exam_question_seq, exam_question_score);
		return result;
	}

	public ExamPaperDto examNameDesc(int exam_paper_num) {
		TeacherDao dao = sqlsession.getMapper(TeacherDao.class);
		ExamPaperDto result = dao.examNameDesc(exam_paper_num);
		return result;
	}

	public int examEnableUpdate(int exam_paper_num) {
		TeacherDao dao = sqlsession.getMapper(TeacherDao.class);
		int result = dao.updateExam(exam_paper_num);
		return result;
	}

	public int newExaminsert(ExamPaperDto dto) {
		TeacherDao dao = sqlsession.getMapper(TeacherDao.class);
		int result = dao.newExaminsert(dto);

		int exampapernum = dto.getExam_paper_num();

		return exampapernum;
	}

	public List<ExamQuestionListDto> examQuestionList(int exam_paper_num) {
		TeacherDao dao = sqlsession.getMapper(TeacherDao.class);
		List<ExamQuestionListDto> result = dao.examQuestionList(exam_paper_num);

		return result;
	}

	public List<ExamInfoDto> examinfoSearch(String searchType2, String keyword, int begin, String member_id,
			String date_from, String date_to) {
		TeacherDao dao = sqlsession.getMapper(TeacherDao.class);
		List<ExamInfoDto> result = dao.examinfoSearch(searchType2, keyword, begin, member_id, date_from, date_to);
		return result;
	}

	/*--성태용 끝--*/
	/* 민지 10.12 클래스멤버 리스트, 클래스 리스트 관리 */
	public List<MemberDto> classMemberList(int exam_paper_num, String member_id) {
		TeacherDao dao = sqlsession.getMapper(TeacherDao.class);

		List<MemberDto> result = dao.classMemberList(exam_paper_num, member_id);
		return result;
	}

	public List<MemberDto> classMemberListUpdate(int exam_info_num) {
		TeacherDao dao = sqlsession.getMapper(TeacherDao.class);

		List<MemberDto> result = dao.classMemberListUpdate(exam_info_num);

		return result;
	}

	public ClassDto classInfo(int exam_paper_num) {
		TeacherDao dao = sqlsession.getMapper(TeacherDao.class);
		ClassDto result = dao.classInfo(exam_paper_num);
		return result;

	}

	/* 영준 - 10.18 선생님 시험일정 삭제 시작 */
	public int teacherExamSchedultDelete(int exam_info_num) {
		ExamInfoDto dto = new ExamInfoDto();
		dto.setExam_info_num(exam_info_num);
		TeacherDao dao = sqlsession.getMapper(TeacherDao.class);
		int result = dao.teacherExamSchedultDelete(dto);
		return result;
	}
	/* 영준 - 10.18 선생님 시험일정 삭제 끝 */

	/* 민지 - 10.22 시험일정 수정 */

	public List<ExamInfoDto> classExamList(int exam_info_num) {
		TeacherDao dao = sqlsession.getMapper(TeacherDao.class);
		ExamInfoDto dto = new ExamInfoDto();
		dto.setExam_info_num(exam_info_num);
		List<ExamInfoDto> result = dao.classExamList(dto);
		return result;
	}

	public int examInfoIUpdate(ExamInfoDto dto) {
		TeacherDao dao = sqlsession.getMapper(TeacherDao.class);

		int result = dao.examInfoIUpdate(dto);

		return result;
	}

	public List<ExamMemberDto> classExamMemberList(int exam_info_num) {
		TeacherDao dao = sqlsession.getMapper(TeacherDao.class);
		ExamMemberDto dto = new ExamMemberDto();
		dto.setExam_info_num(exam_info_num);
		List<ExamMemberDto> result = dao.classExamMemberList(dto);
		return result;
	}

	public int teacherExamMemberDelete(int exam_info_num) {
		TeacherDao dao = sqlsession.getMapper(TeacherDao.class);
		int result = dao.teacherExamMemberDelete(exam_info_num);
		return result;
	}

	public List<MemberDto> examNotcheckMemberList(int exam_info_num) {
		TeacherDao dao = sqlsession.getMapper(TeacherDao.class);

		List<MemberDto> result = dao.examNotcheckMemberList(exam_info_num);
		return result;
	}
	/* 민지 - 10.22 시험일정 수정 끝 */

	// 양회준 11.5 코멘트 추가
	public @ResponseBody int studentInfoCommentUpdate(String member_id, int exam_info_num, String score_chart_comment) {
		TeacherDao dao = sqlsession.getMapper(TeacherDao.class);
		int result = dao.studentInfoCommentUpdate(member_id, exam_info_num, score_chart_comment);
		return result;
	}

	// 양회준 11.5 코멘트 취소
	public @ResponseBody String studentInfoCommentCancel(String member_id, int exam_info_num) {
		TeacherDao dao = sqlsession.getMapper(TeacherDao.class);
		String comment = dao.studentInfoCommentCancel(member_id, exam_info_num);
		return comment;
	}

	public List<ExamPaperDto> exampaperSearch(String searchType, String keyword, int begin, String member_id) {
		TeacherDao dao = sqlsession.getMapper(TeacherDao.class);
		List<ExamPaperDto> result = dao.exampaperSearch(searchType, keyword, begin, member_id);
		return result;
	}

	// 시험 등록시 테이블 초기화
	public int initializeStudentAnswer(String[] memberchecklist, int infonum2, int exam_paper_num, String class_name) {

		TeacherDao dao = sqlsession.getMapper(TeacherDao.class);

		// student_answer 학생 답안지 초기화
		List<ExamQuestionDto> examQuestionList = dao.selectExamQuestion(exam_paper_num);
		int initializeResult = 0;
		for (String member_id : memberchecklist) {
			Student_answerDto answerDto = new Student_answerDto();
			answerDto.setMember_id(member_id);
			for (ExamQuestionDto questionDto : examQuestionList) {
				answerDto.setExam_info_num(infonum2);
				answerDto.setQuestion_num(questionDto.getQuestion_num());
				answerDto.setExam_question_seq(questionDto.getExam_question_seq());
				answerDto.setStudent_answer_choice(null);
				answerDto.setStudent_answer_status(0);
				initializeResult += dao.initializeStudentAnswer(answerDto);
			}
		}

		// scoreChart 초기화
		int initializeResult2 = 0;
		for (String member_id : memberchecklist) {
			Score_chartDto scoreDto = new Score_chartDto();
			scoreDto.setMember_id(member_id);
			scoreDto.setExam_info_num(infonum2);
			scoreDto.setScore_chart_score(0);
			scoreDto.setScore_chart_rank(0);
			scoreDto.setClass_name(class_name);
			initializeResult2 += dao.initializeScoreChart(scoreDto);
		}

		// classChart 초기화
		int initializeResult3 = 0;
		Class_chartDto classScoreDto = new Class_chartDto();
		classScoreDto.setClass_name(class_name);
		classScoreDto.setExam_info_num(infonum2);
		classScoreDto.setClass_chart_avg(0);
		initializeResult3 = dao.initializeClassChart(classScoreDto);

		return 0;
	}

	public String examManagementRoleCheck(String member_id) {
		TeacherDao dao = sqlsession.getMapper(TeacherDao.class);
		String result = dao.examManagementRoleCheck(member_id);
		return result;
	}

	// 시험 등록되면 학생에게 메시지 전송
	public void sendExamInfoMesssage(String[] memberchecklist, int exam_info_num) {

		TeacherDao dao = sqlsession.getMapper(TeacherDao.class);
		
		// 시험 번호로 시험 정보들 끌고옴 
		ExamInfoDto examInfoDto = dao.selectExamInfo(exam_info_num);
		String message = "[시험 일정 안내]\n시험명  : " + examInfoDto.getExam_info_name() + "\n일정 : " + examInfoDto.getExam_info_date() + " " 
							+ examInfoDto.getExam_info_start() + " ~ " + examInfoDto.getExam_info_end()
							+ "\n\n 화이팅입니다!";	//	문자 메시지 내용 
		//System.out.println("메시지 최종본  : \n" + message);
		
		// 시험에 등록된 학생들의 번호 끌고옴
		/*String phoneNumberAll = "";
		for(String member_id : memberchecklist) {
			MemberDto memberDto = dao.selectMember(member_id);
			phoneNumberAll += memberDto.getMember_phone() + ", ";
		}
		String phoneNumber = phoneNumberAll.substring(0, phoneNumberAll.length()-2);*/
		//System.out.println("phoneNumber 최종본 : \n" + phoneNumber);
		
		/*
		 * 서버에서 받은 API_KEY, API_SECRET를 입력해주세요.
		 */
		
		// 하단의 주석 풀고 문자 테스트 해주세요. 
		String api_key = "NCSWVEGBC6I60DAJ";
		String api_secret = "5VAQOBUGYAHWXEHJDODJNYWKZ0KDCVGY";
		Coolsms coolsms = new Coolsms(api_key, api_secret);
		 
		HashMap<String, String> set = new HashMap<String, String>();
		set.put("to", "01033814205");  // 수신번호 set.put("to", "010000000000");   받는사람 번호 여러개 입력시 set.put("to", "01000000000, 01000000001"); 

		// 10월 16일 이후로 발신번호 사전등록제로 인해 등록된 발신번호로만 문자를 보내실 수 있습니다.
		set.put("from", "01075319022"); // 발신번호
		set.put("text", message); // 문자내용 set.put("text", "Test Message"); 
		set.put("type", "lms"); // 문자 타입  단문은 sms, 장문은 lms

		JSONObject result = coolsms.send(set); // 보내기&전송결과받기
		if ((Boolean) result.get("status") == true) {
			// 메시지 보내기 성공 및 전송결과 출력
			System.out.println("문자 전송 성공");
			//System.out.println(result.get("group_id")); // 그룹아이디
			//System.out.println(result.get("result_code")); // 결과코드
			//System.out.println(result.get("result_message")); // 결과메시지
			//System.out.println(result.get("success_count")); // 성공갯수
			//System.out.println(result.get("error_count")); // 발송실패 메시지 수
		} else {
			// 메시지 보내기 실패
			System.out.println("실패");
			System.out.println(result.get("code")); // REST API 에러코드
			System.out.println(result.get("message")); // 에러메시지
		}

	}

}
