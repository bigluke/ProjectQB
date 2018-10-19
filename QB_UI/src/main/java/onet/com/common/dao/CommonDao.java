package onet.com.common.dao;

import java.sql.SQLException;
import java.util.List;

import onet.com.vo.ExamInfoDto;
import onet.com.vo.ExamPaperDoQuestionDto;
import onet.com.vo.Exam_infoDto;
import onet.com.vo.MemberDto;
import onet.com.vo.NoticeDto;
import onet.com.vo.Question_choiceDto;

public interface CommonDao {
	/*한결 - 메인페이지 데이터 뿌리기 10.10*/
	public List<NoticeDto> notice(String member_id);
	public List<Exam_infoDto> exam_info(String member_id);
	/* 끝 */
	/*현이 - examInfoDetail 10.15 시작 */ 
	public ExamInfoDto examScheduleDetail(int exam_info_num);
	/*현이 - examInfoDetail 10.15 끝 */ 

	/*양회준 - 10.15 내 정보 수정 시작*/
	public MemberDto myPageInfo(String member_id);
	public int myPageUpdate(MemberDto memberDto)  throws ClassNotFoundException, SQLException;
	public int myPageDrop(MemberDto memberDto)  throws ClassNotFoundException, SQLException;
	
	public int memberDrop(String member_id, String member_pwd) throws ClassNotFoundException, SQLException;
	
	/*양회준 - 10.15 내 정보 수정 끝*/

	
	/*현이 - ExamPaperDo 10.18 시작 */ 
	public List<ExamPaperDoQuestionDto> examPaperDoQuestion(int exam_info_num) throws ClassNotFoundException, SQLException;
	public List<Question_choiceDto> examPaperDoQuestion_choice(int exam_info_num) throws ClassNotFoundException, SQLException;
	public int questionCount(int exam_info_num) throws ClassNotFoundException, SQLException;
	/*현이 - ExamPaperDo 10.18 끝 */
	

}
