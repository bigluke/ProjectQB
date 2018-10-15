package onet.com.common.dao;

import java.sql.SQLException;
import java.util.List;

import onet.com.vo.ExamInfoDto;
import onet.com.vo.Exam_infoDto;
import onet.com.vo.MemberDto;
import onet.com.vo.NoticeDto;

public interface CommonDao {
	/*한결 - 메인페이지 데이터 뿌리기 10.10*/
	public List<NoticeDto> notice(NoticeDto dto);
	public List<Exam_infoDto> exam_info(Exam_infoDto dto);
	/* 끝 */
	/*현이 - examInfoDetail 10.15 시작 */ 
	public ExamInfoDto examScheduleDetail(int exam_info_num);
	/*현이 - examInfoDetail 10.15 끝 */ 

	/*양회준 - 10.15 내 정보 수정 시작*/
	public MemberDto myPageInfo(String member_id);
	public int myPageUpdate(MemberDto memberDto)  throws ClassNotFoundException, SQLException;
	public int myPageDrop(MemberDto memberDto)  throws ClassNotFoundException, SQLException;
	/*양회준 - 10.15 내 정보 수정 끝*/

}
