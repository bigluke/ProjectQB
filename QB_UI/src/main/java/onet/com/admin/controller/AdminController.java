package onet.com.admin.controller;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.security.Principal;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.encoding.PasswordEncoder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import onet.com.admin.service.AdminService;
import onet.com.common.service.CommonService;
import onet.com.student.service.StudentService;
import onet.com.teacher.service.TeacherService;
import onet.com.vo.CategoryDto;
import onet.com.vo.ClassDto;
import onet.com.vo.Class_chartDto;
import onet.com.vo.CommentDto;
import onet.com.vo.ExamInfoDto;
import onet.com.vo.ExamMemberDto;
import onet.com.vo.ExamPaperDoQuestionDto;
import onet.com.vo.ExamPaperDto;
import onet.com.vo.MemberDto;
import onet.com.vo.MessageDto;
import onet.com.vo.NoticeDto;
import onet.com.vo.QuestionDto;
import onet.com.vo.Question_choiceDto;
import onet.com.vo.RoleDto;
import onet.com.vo.Score_chartDto;
import onet.com.vo.StudentExamScoreInfo;
import onet.com.vo.Student_answerQuesDto;

@Controller
@RequestMapping(value="/admin/")
public class AdminController {
	
	@Autowired
	private AdminService adminService;

	@Autowired
	private CommonService commonService;
	
	@Autowired
	private TeacherService teacherService;
	
	@Autowired
	private StudentService studentService;
	
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	/*양회준 10.14 관리자 메인 시작*/
	@RequestMapping("adminMain.do")
	public String adminMain(Model model) {
		
		return "admin.adminMain";
	}
	/*양회준 10.14 관리자 메인 끝*/
	
	/*정원 - 문제분류페이지 관련 시작 */
	@RequestMapping("questionCategory.do")
	public String questionCategory(Model model) throws Exception {
		
		List<CategoryDto> list1;
		list1=adminService.lgProblemCategoryList();
		model.addAttribute("list1",list1);
		
		List<CategoryDto> list2;
		list2=adminService.mdProblemCategoryList();
		model.addAttribute("list2",list2);
		
		List<CategoryDto> list3;
		list3=adminService.smProblemCategoryList();
		model.addAttribute("list3",list3);
		
		return "admin.questionCategory";
	}
	/*정원 - 문제분류페이지 관련 끝*/
	
	/* 영준 10.08 회원관리관련 시작 */
	@RequestMapping("adminMember.do")
	public String adminMember(Model model) throws Exception {
		List<ClassDto> classList;
		classList=adminService.classList();
		model.addAttribute("classList", classList);
		
		List<MemberDto> memberList;
		memberList=adminService.memberList();
		model.addAttribute("memberDto", memberList);

		List<RoleDto> roleList;
		roleList = adminService.roleList();
		model.addAttribute("roleList", roleList);
				
		return "admin.adminMember";
		
	}
	//양회준 10.30 데이터테이블Ajax
	@RequestMapping("adminMemberAjax.do")
	public @ResponseBody List<MemberDto> adminMemberAjax(String exam_info_name) throws Exception {		
		List<MemberDto> list=adminService.memberList();				
		return list;		
	}
	
	@RequestMapping(value="adminMemberView.do")
	public @ResponseBody ModelAndView adminMemberView() {
		List<MemberDto> memberList = adminService.adminMemberView();
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("admin.adminMember");
		mv.addObject("memberList", memberList);
		
		return mv;
	}
	
	
	@RequestMapping(value="adminMemberUpdate.do", method = RequestMethod.POST)
	public @ResponseBody String adminMemberUpdate(@RequestBody MemberDto dto) //@RequestBody (비동기: 객체 형태로 받아요) 
	{	
		int result = adminService.updateMember(dto);
		String result2 = String.valueOf(result);
		return result2;
		
	}
	
	/* 영준 - 10.22 회원관리 회원 삭제 시작 */
	@RequestMapping(value="adminMemberDelete.do", method = RequestMethod.POST)
	public @ResponseBody int adminMemberDelete(@RequestParam String member_id)
	{	
		int result = adminService.deleteMember(member_id);
		return result;
	}
	/* 영준 - 10.22 회원관리 회원 삭제 끝 */

	//양회준 10-22 admin 회원관리 비동기 검색
		@RequestMapping(value="memberSearchAjax.do", method=RequestMethod.POST)
		public @ResponseBody List<MemberDto> memberSearchAjax(@RequestParam("searchRole") String searchRole, 
				@RequestParam("searchClassName") String searchClassName, @RequestParam("searchMemberInfo") String searchMemberInfo,
				@RequestParam("searchBox") String searchBox) throws IOException, ClassNotFoundException, SQLException {
					
			List<MemberDto> memberDto = adminService.memberSearchAjax(searchRole, searchClassName, searchMemberInfo, searchBox);
			
			return memberDto;
		}
		
		//양회준 10-23 admin 회원관리 비동기 일괄등록
		@RequestMapping(value="updateStudentsAjax.do", method=RequestMethod.POST)
		public @ResponseBody String updateStudentsAjax(@RequestParam("updateStudentArr") ArrayList<String> updateStudentArr) 
				throws IOException, ClassNotFoundException, SQLException {
			
			int result = adminService.updateStudentsAjax(updateStudentArr);
			
			return ""+result;
		}
		//양회준 10-23 admin 회원관리 비동기 일괄삭제
		@RequestMapping(value="deleteStudentsAjax.do", method=RequestMethod.POST)
		public @ResponseBody String deleteStudentsAjax(@RequestParam("deleteStudentArr") ArrayList<String> deleteStudentArr) 
				throws IOException, ClassNotFoundException, SQLException {
			
			int result = adminService.deleteStudentsAjax(deleteStudentArr);
			
			return ""+result;
		}
	
	/* 영준 10.23 회원관리관련 끝 */
	
	/*민지 10.12 클래스멤버리스트 , 클래스 리스트 관련 */
/*	@RequestMapping("adminClassInfo.do")
	public String adminClassInfo(Model model, int class_num) throws Exception{
		
		
//전체 클래스 데이터
		List<ClassDto> classList;
		classList=adminService.classList();
		model.addAttribute("classList", classList);
// 해당 클래스 데이터
		List<ClassDto> classlist;
		classlist=adminService.classlist(class_num);
		model.addAttribute("classlist", classlist);
		
		List<MemberDto> classMemberList;
		classMemberList= teacherService.classMemberList(class_num);
		model.addAttribute("classMemberList", classMemberList);
		return "admin.adminClassInfo";
	}*/

	
	@RequestMapping(value = "adminClassMemberUpdate.do", method = RequestMethod.POST)
	public @ResponseBody String adminClassMemberUpdate(@RequestBody MemberDto dto) //@RequestBody (비동기: 객체 형태로 받아요) 
	{	
		
		/*deptService.insertDept(dto);
		return dto.toString();*/
		int result = adminService.classMemberUpdate(dto);
		String result2 = String.valueOf(result);
		return result2;
		
	}
	/*민지 10.12 클래스멤버리스트 관련 끝*/

	
	
	/*민지 10.13 클래스 멤버 삭제 관련*/
		@RequestMapping(value = "adminClassMemberDelete.do", method = RequestMethod.POST)
		public @ResponseBody String adminClassMemberDelete(@RequestBody MemberDto dto) //@RequestBody (비동기: 객체 형태로 받아요) 
		{	
			/*deptService.insertDept(dto);
			return dto.toString();*/
			int result = adminService.classMemberDelete(dto);
			String result2 = String.valueOf(result);
			return result2;
			
		}
	/*민지 10.13 클래스 멤버 삭제 관련 끝*/


	/*현이 18.10.09 관리자 마이페이지 시작*/
		
	@RequestMapping("myPage.do")
	public String mypage() {

		return "common.admin.common.myPage";
	}
	
	/*현이 18.10.09 관리자 마이페이지 끝*/

	
	/*민지 18.10.10 메시지 페이지 시작*/
	@RequestMapping("myMessage.do")
	   public String myMessage(Model model, Principal principal) {
	       String member_id = principal.getName();
	       MessageDto dto = new MessageDto();
	          List<MemberDto> classMemberList = commonService.classMemeberList(member_id);
	          //받은쪽지함이 null일때 처리
	          int receiveMessageCheck = commonService.receiveMessageCheck(member_id);
	          if(receiveMessageCheck > 0) {
	          List<MessageDto> receiveMessage = commonService.receiveMessage(member_id);
	          for(int i=0; i<receiveMessage.size(); i++) {
	        	  String date = receiveMessage.get(i).getMessage_date().substring(0, receiveMessage.get(i).getMessage_date().length()-5);
	        	  receiveMessage.get(i).setMessage_date(date);
	        	  String sendManId = receiveMessage.get(i).getSend_member_id();
	        	  String sendManName = commonService.nameSearch(sendManId);
	        	  receiveMessage.get(i).setMember_name(sendManName);
	          }
	          model.addAttribute("receiveMessage", receiveMessage);
	          }
	          //보낸쪽지함이 null일때 처리
	          int sendMessageCheck = commonService.sendMessageCheck(member_id);
	          if(sendMessageCheck > 0) {
	        	   List<MessageDto> sendMessage = commonService.sendMessage(member_id);
	 	          for(int i=0; i<sendMessage.size(); i++) {
	 	        	  String date = sendMessage.get(i).getMessage_date().substring(0, sendMessage.get(i).getMessage_date().length()-5);
	 	        	  sendMessage.get(i).setMessage_date(date);
	 	        	  String receiveManId = sendMessage.get(i).getReceive_member_id();
	 	        	  String receiveManName = commonService.nameSearch2(receiveManId);
	 	        	  sendMessage.get(i).setMember_name(receiveManName);
	 	          }
	          model.addAttribute("sendMessage", sendMessage);
	          }
	          
	          
	          List<MemberDto> classTeacherList=commonService.classTeacherList(member_id);
	          List<MemberDto> teacherList = adminService.teacherList();
	          
	          model.addAttribute("teacherList", teacherList);
	          model.addAttribute("classMemberList", classMemberList);
	          model.addAttribute("classTeacherList",classTeacherList);
	          
	          model.addAttribute("member_id", member_id);
		
	          
		return "common.admin.common.myMessage";
	}
	/*민지 18.10.10 메시지 페이지 끝*/
	@RequestMapping("headerMessage.do")
	public @ResponseBody ModelAndView  headerMessage(Model model, Principal principal) throws ParseException {
			
		 ModelAndView mv = new ModelAndView();
		 String member_id = principal.getName();
		 mv.setViewName("ajax.common.receiveMessage_ajax");
		 /*int receiveMessageHeader = commonService.receiveMessageHeader(member_id);*/
		 int receiveMessageCheck = commonService.receiveMessageCheck(member_id);
		 if(receiveMessageCheck > 0) {
		 List<MessageDto> receiveMessage = commonService.receiveMessage(member_id);
		 
		 for(int i=0; i<receiveMessage.size(); i++) {
			 if(receiveMessage.get(i).getMessage_content().length()>12) {
				 String receiveSize = receiveMessage.get(i).getMessage_content().substring(0, 11);
				 String receiveSize2 = receiveSize + "...";
				 receiveMessage.get(i).setMessage_content(receiveSize2);
			 }
		 }
		 Date today = new Date();
		 SimpleDateFormat day = new SimpleDateFormat("yyyy-MM-dd");
		 SimpleDateFormat time = new SimpleDateFormat("HH:mm:ss", Locale.KOREA);
	       for(int i=0; i<receiveMessage.size(); i++) {
	        	  String sendManId = receiveMessage.get(i).getSend_member_id();
	        	  String sendManName = commonService.nameSearch(sendManId);
	        	  receiveMessage.get(i).setMember_name(sendManName);
	        	  String sendDate = receiveMessage.get(i).getMessage_date().substring(0, receiveMessage.get(i).getMessage_date().length()-3);
	        	  //보낸 날짜,시간
				String sendday = receiveMessage.get(i).getMessage_date().substring(0, 10);
				String sendtime = receiveMessage.get(i).getMessage_date().substring(11,receiveMessage.get(i).getMessage_date().length()-3);
	      
				//현재 날짜, 시간
	        	  String currentday = day.format(today);
	        	  String currenttime = time.format(today);
	        	  
	        	  
	        	  Date begindate =day.parse(sendday);
				  Date enddate = day.parse(currentday);
				
				  long diff = enddate.getTime()-begindate.getTime();
				  long diffDays = diff/(24*60*60*1000);
				String diffdays = String.valueOf(diffDays);
				
				Date begintime = time.parse(sendtime);
				Date endtime = time.parse(currenttime);
					
				long diffs = endtime.getTime() - begintime.getTime();
				long diffmin = diffs / (1000*60);
	        	if(sendday.equals(currentday)) {
	        		if(diffmin==0) {
	        			receiveMessage.get(i).setMessage_date("방금 도착");
	        		}else {
	        			receiveMessage.get(i).setMessage_date(diffmin+"분 전 도착");
	        		}
	        		
	        		
	        	}else {
	        		receiveMessage.get(i).setMessage_date(diffdays+"일 전 도착");
	        	}
	        	   
	          }
	       
	    	   mv.addObject("receiveMessage", receiveMessage); 
		 }
		return mv;
		
	}

	
	
	// 관리자 클래스 상세보기  - 공지사항
	//10.15민지
	@RequestMapping("adminClassMain.do")
	public String adminClassMain(Model model, String class_name, String class_num, Principal principal) { 
		List<NoticeDto> notice;
		String date="";
		notice=commonService.admin_Main(class_name);
		for(int i=0; i<notice.size(); i++) {
	    	  date = notice.get(i).getNotice_date().substring(0, notice.get(i).getNotice_date().length()-5);
	    	 notice.get(i).setNotice_date(date);
	      }
		if(notice.isEmpty()) {
		}else {
			model.addAttribute("notice", notice);
		}
		model.addAttribute("class_name", class_name);
		model.addAttribute("class_num", class_num);
		List<ExamInfoDto> exam_info = commonService.admin_exam_info(class_name);
		model.addAttribute("exam_info", exam_info);
		return "common.adminClass.admin.notice.notice";
	}
	
	@RequestMapping("noticeDetail.do")
	public String noticeDetail(Model model, String class_name, int notice_num, Principal principal) {
		List<NoticeDto> result = commonService.noticeDetail(class_name, notice_num);
		 for(int i=0; i<result.size(); i++) {
	    	 String date = result.get(i).getNotice_date().substring(0, result.get(i).getNotice_date().length()-5);
	    	 result.get(i).setNotice_date(date);
	      }
		List<CommentDto> comment = commonService.comment(class_name, notice_num);
		List<CommentDto> commentGroup = commonService.commentGroup(class_name, notice_num);
		if(result.get(0).getNotice_file1() != null && result.get(0).getNotice_file2() != null) {
			String file1 = result.get(0).getNotice_file1();
			int index1 = file1.indexOf("_");
			String originFileName1 = file1.substring(index1+1);
			String file2 = result.get(0).getNotice_file2();
			int index2 = file2.indexOf("_");
			String originFileName2 = file2.substring(index2+1);
			model.addAttribute("originFileName1",originFileName1);
			model.addAttribute("originFileName2",originFileName2);
		}else if(result.get(0).getNotice_file1() != null && result.get(0).getNotice_file2() == null) {
			String file1 = result.get(0).getNotice_file1();
			int index1 = file1.indexOf("_");
			String originFileName1 = file1.substring(index1+1);
			model.addAttribute("originFileName1",originFileName1);
		}else if(result.get(0).getNotice_file1() == null && result.get(0).getNotice_file2() != null) {
			String file2 = result.get(0).getNotice_file2();
			int index2 = file2.indexOf("_");
			String originFileName2 = file2.substring(index2+1);
			model.addAttribute("originFileName2",originFileName2);
		}
		String name = principal.getName();
		model.addAttribute("result", result);
		model.addAttribute("comment", comment);
		model.addAttribute("commentGroup", commentGroup);
		model.addAttribute("name", name);		
		
		return "common.adminClass.admin.notice.noticeDetail";
	}
	
	@RequestMapping("noticeWrite.do")
	public String noticeWrite(String class_name, String class_num, Model model) {
		
		model.addAttribute("class_num", class_num);
		model.addAttribute("class_name",class_name);
		return "common.adminClass.admin.notice.noticeWrite";
	}

	@RequestMapping("noticeUpdate.do")
	public String noticeUpdate(Model model,int notice_num, String class_name) {
		NoticeDto dto = new NoticeDto();
		dto.setNotice_num(notice_num);
		dto.setClass_name(class_name);
		List<NoticeDto> result = commonService.noticeUpdateList(dto);
		if(result.get(0).getNotice_file1() != null && result.get(0).getNotice_file2() != null) {
			String file1 = result.get(0).getNotice_file1();
			int index1 = file1.indexOf("_");
			String originFileName1 = file1.substring(index1+1);
			String file2 = result.get(0).getNotice_file2();
			int index2 = file2.indexOf("_");
			String originFileName2 = file2.substring(index2+1);
			model.addAttribute("originFileName1",originFileName1);
			model.addAttribute("originFileName2",originFileName2);
		}else if(result.get(0).getNotice_file1() != null && result.get(0).getNotice_file2() == null) {
			String file1 = result.get(0).getNotice_file1();
			int index1 = file1.indexOf("_");
			String originFileName1 = file1.substring(index1+1);
			model.addAttribute("originFileName1",originFileName1);
		}else if(result.get(0).getNotice_file1() == null && result.get(0).getNotice_file2() != null) {
			String file2 = result.get(0).getNotice_file2();
			int index2 = file2.indexOf("_");
			String originFileName2 = file2.substring(index2+1);
			model.addAttribute("originFileName2",originFileName2);
		}
		
		model.addAttribute("result",result);
		return "common.adminClass.admin.notice.noticeUpdate";
	}
	
	
	// 관리자 클래스 상세보기 - 시험 관리 
	@RequestMapping("examScheduleDetail.do")
	public String examScheduleDetail(Model model, int exam_info_num) {
		
		// 10.23 현이 추가 (TeacherController에서 가져옴) 
		ExamInfoDto dto = commonService.examScheduleDetail(exam_info_num);  
		model.addAttribute("dto", dto);
		
		return "common.adminClass.admin.exam.examScheduleDetail";
	}  
	
	@RequestMapping("examPaperUpdate.do")
	public String examPaperUpdate() {

		return "common.adminClass.admin.exam.examPaperUpdate";
	}
	
	
	
	// 관리자 클래스 상세보기 - 시험지 관련 
	@RequestMapping("examPaperMake.do")
	public String examPaperMake(Model model){
		/* 문제 카테고리 */
		List<CategoryDto> list1;
		list1 = adminService.lgCategoryList();
		model.addAttribute("list1", list1);

		List<CategoryDto> list2;
		list2 = adminService.mdCategoryList();
		model.addAttribute("list2", list2);

		List<CategoryDto> list3;
		list3=adminService.smCategoryList();
		model.addAttribute("list3",list3);
		
		List<CategoryDto> levellist;
		levellist = adminService.questionLevelList();
		model.addAttribute("levellist",levellist);
		
		return "common.admin.exampaper.examPaperMake";
	}
	
	@RequestMapping("examPaperModify.do")
	public String examPaperModify(){
		
		return "common.adminClass.admin.exampaper.examPaperModify";
	}
	
	
	
	// 관리자 클래스 상세보기 - 학생 & 성적관리 
	@RequestMapping("studentInfo.do")
	public String studentInfo(Model model, Principal principal, HttpServletRequest request){
		String member_id = principal.getName();
		String class_num=request.getParameter("class_num");	
		String student_id;
		String class_name;		
		List<MemberDto> studentList = commonService.studentInfo(member_id, class_num);
        try {
        	student_id = studentList.get(0).getMember_id();
            class_name = studentList.get(0).getClass_name();
        }catch(Exception e) {
        	student_id="데이터가 없습니다.";
            class_name="데이터가 없습니다.";
        }
        
		//클래스 번호로 차트 가져오기
		Map<String, Object> chart = commonService.studentChartInfo(student_id, class_name);
		List<Score_chartDto> studentChart = (List<Score_chartDto>) chart.get("studentName");
		List<Class_chartDto> classChart = (List<Class_chartDto>) chart.get("className");
		model.addAttribute("studentList",studentList);
		model.addAttribute("classChart",classChart);
		model.addAttribute("studentChart",studentChart);
		
		//학생 개인 성적확인
		List<StudentExamScoreInfo> studentExamScoreInfo = commonService.studentExamScoreInfo(student_id, class_name);
		model.addAttribute("studentExamScoreInfo",studentExamScoreInfo);
		//학생 전체 성적확인
		List<Score_chartDto> studentExamScoreList = commonService.studentExamScoreList(class_name);
		model.addAttribute("studentExamScoreList",studentExamScoreList);
		//표준편차
		List<Double> std = new ArrayList<Double>();
		std = commonService.classExamSTD(class_name);
		model.addAttribute("std",std);
		
		return "common.adminClass.admin.grade.studentInfo";
	}
	// 관리자 클래스 상세보기 - 학생 & 성적관리 - 개별차트부르기
	@RequestMapping(value="studentChartInfo.do", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> studentChartInfo(@RequestParam("member_id") String member_id,
			@RequestParam("class_name") String class_name){
		//양회준 10-24
		Map<String, Object> chart = commonService.studentChartInfo(member_id, class_name);
		List<Class_chartDto> studentChart = (List<Class_chartDto>) chart.get("className");

		return chart;
	}
	//양회준 10-26 학생&성적관리 학생개인 성적확인
	@RequestMapping(value="studentExamScoreInfo.do", method=RequestMethod.POST)
	public @ResponseBody List<StudentExamScoreInfo> studentExamScoreInfo(@RequestParam("member_id") String member_id,
			@RequestParam("class_name") String class_name){
		//양회준 10-24
		List<StudentExamScoreInfo> result = commonService.studentExamScoreInfo(member_id, class_name);
		return result;
	}
	

	/*###################     재훈 시작         ####################*/
	
	//관리자 - 문제관리 페이지 문제분류 셀렉트박스 데이터값 출력
	@RequestMapping("questionManagement.do")
	public String questionManagement(Model model, Principal principal) throws Exception {
		
		List<CategoryDto> lgCatList;
		lgCatList=adminService.lgCategoryList();
		model.addAttribute("lgCatList",lgCatList);
		
		List<CategoryDto> mdCatList;
		mdCatList=adminService.mdCategoryList();
		model.addAttribute("mdCatList",mdCatList);
		
		List<CategoryDto> smCatList;
		smCatList=adminService.smCategoryList();
		model.addAttribute("smCatList",smCatList);
		
		List<CategoryDto> quesLevelList;
		quesLevelList=adminService.questionLevelList();
		model.addAttribute("quesLevelList",quesLevelList);
		
		String member_id = principal.getName();
		MemberDto memberDto = commonService.myPageInfo(member_id);
		model.addAttribute("memberDto", memberDto);

		return "common.admin.question.questionManagement";
	}
	//관리자 - 문제 관리 페이지 문제 출력 
	@RequestMapping(value="myQuestionView.do")
	public @ResponseBody ModelAndView classListView(Model model) {
		List<QuestionDto> question = adminService.question();
		model.addAttribute("question", question);
		List<Question_choiceDto> question_choice = adminService.question_choice();
		model.addAttribute("question_choice", question_choice);
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("ajax.common.questionManagement_ajax");
		mv.addObject("question", question);
		mv.addObject("question_choice",question_choice);
		
		return mv;
	}
	//관리자 - 문제관리 페이지 분류별/키워드별 검색 기능
	@RequestMapping(value="myQuestionSearch.do")
	public @ResponseBody ModelAndView myQuestionSearch(@RequestParam("lgsearchtype") String lgsearchtype, 
	         @RequestParam("mdsearchtype") String mdsearchtype, @RequestParam("smsearchtype") String smsearchtype,
	         @RequestParam("leveltype") String leveltype, @RequestParam("questiontype") String questiontype,
	         @RequestParam("keyword") String keyword) {
		
		List<QuestionDto> question = adminService.questionSearch(lgsearchtype,mdsearchtype,smsearchtype,leveltype,questiontype,keyword);
		List<Question_choiceDto> question_choice = adminService.question_choice();
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("ajax.common.questionManagement_ajax");
		mv.addObject("question", question);
		mv.addObject("question_choice",question_choice);
		
		return mv;
	}

	//관리자 - 문제관리 페이지 새 문제 만들기 기능
		@RequestMapping(value="insertQuestion.do", method=RequestMethod.POST)
		public String insertQuestion(QuestionDto dto2, Question_choiceDto dto, HttpServletRequest request) 
				throws IOException, ClassNotFoundException, SQLException {
			if (dto2.getQuestion_type().equals("객관식")) {
				adminService.insertQuestion(dto2, request);
				adminService.insertQuestionChoice(dto2, dto, request);
			} else {
				adminService.insertQuestion(dto2, request);
			}
			return "redirect:questionManagement.do";
		}
	//관리자 - 문제관리 페이지 문제삭제 전 삭제가능여부 판단
	@RequestMapping("singleQuestionDelete.do")
	public @ResponseBody Map<String,Object> singleQuestionDelete(int question_num){
		
		Map<String,Object> map = new HashMap <String,Object>();
		int result = commonService.singleQuestionDelete(question_num);
		
		if(result == 0) {
			map.put("result", "삭제불가");
		}else {
			map.put("result", "삭제가능");
		}
		return map;
	}
	//관리자 - 문제관리 페이지 문제수정 전 수정가능여부 판단
	@RequestMapping("singleUpdateCheck.do")
	public @ResponseBody Map<String,Object> singleUpdateCheck(int question_num){
		
		Map<String,Object> map = new HashMap <String,Object>();
		int result = commonService.singleUpdateCheck(question_num);
		
		if(result == 0) {
			map.put("result", "삭제불가");
		}else {
			map.put("result", "삭제가능");
		}
		return map;
	}
	//관리자 - 문제수정 페이지 이동시 관련 데이터 출력
	@RequestMapping("questionUpdate.do")
	public String questionUpdate(Model model, int question_num) {
		
		List<QuestionDto> qdto;
		qdto=commonService.questionInfo(question_num);
		model.addAttribute("qdto",qdto);
		
		List<Question_choiceDto> cdto;
		cdto=commonService.questionChoiceInfo(question_num);
		model.addAttribute("cdto",cdto);
		
		List<CategoryDto> qcat;
		qcat=commonService.questionCategoryInfo(question_num);
		model.addAttribute("qcat",qcat);
		
		List<CategoryDto> lgCatList;
		lgCatList=adminService.lgCategoryList();
		model.addAttribute("lgCatList",lgCatList);
		
		List<CategoryDto> mdCatList;
		mdCatList=adminService.mdCategoryList();
		model.addAttribute("mdCatList",mdCatList);
		
		List<CategoryDto> smCatList;
		smCatList=adminService.smCategoryList();
		model.addAttribute("smCatList",smCatList);
		
		List<CategoryDto> quesLevelList;
		quesLevelList=adminService.questionLevelList();
		model.addAttribute("quesLevelList",quesLevelList);
		
		return "common.admin.question.questionUpdate";
	}	
	
	/*###################     재훈 끝         ####################*/
	
	/*현이 18.10.09 관리자 마이페이지 시작*/
	/*양회준 10.15 내 정보 수정 시작*/
	@RequestMapping(value = "myPage.do", method = RequestMethod.GET)
	public String myPageInfo(Model model, Principal principal) throws ClassNotFoundException, SQLException {
		String member_id = principal.getName();
		MemberDto memberDto = commonService.myPageInfo(member_id);
		model.addAttribute("memberDto", memberDto);
		return "common.admin.common.myPage";
	}
	/*양회준 10.15 내 정보 수정 끝*/
	/*현이 18.10.09 관리자 마이페이지 끝*/
	
	@RequestMapping(value = "myPage.do", method = RequestMethod.POST)
	public String myPageUpdate(MemberDto memberDto) throws IOException, ClassNotFoundException, SQLException {
		String url = "redirect:myPage.do";
		memberDto.setMember_pwd(this.bCryptPasswordEncoder.encode(memberDto.getMember_pwd()));
		try {
			url = commonService.myPageUpdate(memberDto);
		} catch (Exception e) {
		}
		// 예외 발생에 상관없이 목록페이지 요청 처리
		return url;
	}
	
	/* 양회준 10.15 내정보 탈퇴 시작*/
	@RequestMapping("myPageDrop.do")
	public String myPageDrop(MemberDto memberDto)
			throws IOException, ClassNotFoundException, SQLException {
			memberDto.setMember_enable("0");
			commonService.myPageDrop(memberDto);
		
		// 예외 발생에 상관없이 목록페이지 요청 처리
		return "redirect:/login.jsp";
	}
	/* 양회준 10.15 내정보 탈퇴 끝*/	
	
	/* 양회준 10.16 내정보 비밀번호 확인 시작*/
	@RequestMapping(value="memberDrop.do", method=RequestMethod.POST)
	public @ResponseBody int memberDrop(@RequestParam("member_id") String member_id, 
			@RequestParam("member_pwd") String member_pwd) throws IOException, ClassNotFoundException, SQLException { 
		int result;
		String pwd = commonService.memberDrop(member_id);		
		 if(bCryptPasswordEncoder.matches(member_pwd, pwd)){
			 result = 1; //비빌번호 일치
		 }else {
			 result = 0; //비밀번호 불일치
		 }
		
		return result;
	}
	/* 양회준 10.16 내정보 비밀번호 확인 끝*/

	// 정원 - 문제분류관리 - insert
	@RequestMapping("lgCatAdd.do")
	public @ResponseBody Map<String, Object> lgCatAdd(String lgCatAdd) {
		Map<String, Object> map = new HashMap<String, Object>();
		if(lgCatAdd.trim()=="") {
			map.put("result", "null");
			return map;
		}else {
		String result = adminService.lgCatAdd(lgCatAdd);
		map.put("result", result);
		return map;
	}
	}	
	@RequestMapping("mdCatAdd.do")
	public @ResponseBody Map<String, Object> mdCatAdd(String selectLgCat, String mdCatAdd) {
		Map<String, Object> map = new HashMap<String, Object>();
		if(selectLgCat.trim()=="") {
			map.put("result", "null");
			return map;
		}else if(mdCatAdd.trim()=="") {
			map.put("result", "textNull");
			return map;
		}else {
		String result = adminService.mdCatAdd(selectLgCat, mdCatAdd);
		map.put("result", result);
		return map;
	}
	}
	@RequestMapping("smCatAdd.do")
	public @ResponseBody Map<String, Object> smCatAdd(String selectMdCat, String smCatAdd) {
		Map<String, Object> map = new HashMap<String, Object>();
		if(selectMdCat.trim()=="") {
			map.put("result", "null");
			return map;
		}else if(smCatAdd.trim()=="") {
			map.put("result", "textNull");
			return map;
		}else {
		String result = adminService.smCatAdd(selectMdCat, smCatAdd);
		map.put("result", result);
		return map;
	}
	}	
	// 정원 - 문제분류관리 insert 끝
	
	// 정원 - 문제분류관리 update 시작
	@RequestMapping("lgUpdate.do")
	public @ResponseBody Map<String, Object> lgUpdate(String lgCatCode, String lgCatName, String lgBeforeName) {
		Map<String, Object> map = new HashMap<String, Object>();
		CategoryDto dto = new CategoryDto();
		String check = adminService.lgCatIdCheck(lgCatName);
		if((lgCatName.equals(lgBeforeName)) || check == null) {
			dto.setLg_category_code(lgCatCode);
			dto.setLg_category_name(lgCatName);
			adminService.lgUpdate(dto);
			map.put("result", "null");
			return map;
		}else{
			map.put("result","Notnull");
			return map;
		}
		
	}	
		@RequestMapping("mdUpdate.do")
		public @ResponseBody Map<String, Object> mdUpdate(String mdCatCode, String mdCatName, String lgSelectCode, String mdBeforeName) {
			Map<String, Object> map = new HashMap<String, Object>();
			CategoryDto dto = new CategoryDto();
			String check = adminService.mdCatIdCheck(mdCatName);
			if((mdCatName.equals(mdBeforeName)) || check == null) {
				dto.setLg_category_code(lgSelectCode);
				dto.setMd_category_code(mdCatCode);
				dto.setMd_category_name(mdCatName);
				adminService.mdUpdate(dto);
				map.put("result", "null");
				return map;
			}else {
				map.put("result","Notnull");
				return map;
			}
		}
		
		@RequestMapping("smUpdate.do")
		public @ResponseBody Map<String, Object> smUpdate(String smCatCode, String smCatName, String mdSelectCode, String smBeforeName) {
			Map<String, Object> map = new HashMap<String, Object>();
			CategoryDto dto = new CategoryDto();
			String check = adminService.smCatIdCheck(smCatName);
			if((smCatName.equals(smBeforeName)) || check == null) {
				dto.setMd_category_code(mdSelectCode);
				dto.setSm_category_code(smCatCode);
				dto.setSm_category_name(smCatName);
				adminService.smUpdate(dto);
				map.put("result", "null");
				return map;
			}else {
				map.put("result","Notnull");
				return map;
			}
		}
	// 정원 - 문제분류관리 update 끝

	
	
	//10.17민지- 클래스수정 중복체크
	@RequestMapping(value="classNameCheck.do", method=RequestMethod.GET)
	public @ResponseBody Map<String, Object> idCheck(@RequestParam("class_name") String class_name) {
		String memberid = adminService.classCheck(class_name);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", memberid == null);
		map.get("result");
		return map;
	}
	
	// 정원 -문제분류 delete 시작
	@RequestMapping("lgDelete.do")
	public @ResponseBody Map<String, Object> lgDelete(String lgDeleteCode) {
		Map<String, Object> map = new HashMap<String, Object>();
		int result = adminService.lgDelete(lgDeleteCode);
		if(result == 0) {
			map.put("result", "삭제불가");
		}else {
			map.put("result", "삭제가능");
		}	
			return map;
	} 
	
	@RequestMapping("mdDelete.do")
	public @ResponseBody Map<String, Object> mdDelete(String mdDeleteCode) {
		Map<String, Object> map = new HashMap<String, Object>();
		int result = adminService.mdDelete(mdDeleteCode);
		if(result == 0) {
			map.put("result", "삭제불가");
		}else {
			map.put("result", "삭제가능");
		}
			return map;
	}
	
	@RequestMapping("smDelete.do")
	public @ResponseBody Map<String, Object> smDelete(String smDeleteCode) {
		Map<String, Object> map = new HashMap<String, Object>();
			int result = adminService.smDelete(smDeleteCode);
			if(result == 0) {
				map.put("result", "삭제불가");
			}else {
				map.put("result", "삭제가능");
			}
			return map;
	}
	
	
	@RequestMapping("selectLgList.do")
	public ModelAndView selectLgList(String lgCode) {
		List<CategoryDto> list1 = null;
		if(lgCode.trim().equals("전체조회")) {
			list1 = adminService.selectTotalLgList();
		}else {
			list1 = adminService.selectLgList(lgCode);
		}
		ModelAndView mv = new ModelAndView();
		mv.setViewName("ajax.admin.questionCategory_ajax");
		mv.addObject("list1", list1);
		return mv;
	}


	@RequestMapping("selectMdList.do")
	public ModelAndView selectMgList(String lgCode) {
		List<CategoryDto> list2 = null;
		if(lgCode.trim().equals("전체조회")) {
			list2 = adminService.selectTotalMdList();	
		}else {
			list2 = adminService.selectMdList(lgCode);
		}
		ModelAndView mv = new ModelAndView();
		mv.setViewName("ajax.admin.questionCategory_ajax2");
		mv.addObject("list2", list2);
		return mv;
	}
	
	@RequestMapping("selectSmList.do")
	public ModelAndView selectSmList(String lgCode) {
		List<CategoryDto> list3 = null;
		if(lgCode.trim().equals("전체조회")) {
			list3 = adminService.selectTotalSmList();	
		}else {
			list3 = adminService.selectSmList(lgCode);
		}
		ModelAndView mv = new ModelAndView();
		mv.setViewName("ajax.admin.questionCategory_ajax3");
		mv.addObject("list3", list3);
		return mv;
	}
	
	@RequestMapping("selectMdRealList.do")
	public ModelAndView selectMdRealList(String mdCode) {
		List<CategoryDto> list2 = adminService.selectMdRealList(mdCode);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("ajax.admin.questionCategory_ajax2");
		mv.addObject("list2", list2);
		return mv;
	}
	
	@RequestMapping("selectSmRealList.do")
	public ModelAndView selectSmRealList(String mdCode) {
		List<CategoryDto> list3 = adminService.selectSmRealList(mdCode);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("ajax.admin.questionCategory_ajax3");
		mv.addObject("list3", list3);
		return mv;
	}
	
	@RequestMapping("selectSmRealList2.do")
	public ModelAndView selectSmRealList2(String smCode) {
		List<CategoryDto> list3 = adminService.selectSmRealList2(smCode);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("ajax.admin.questionCategory_ajax3");
		mv.addObject("list3", list3);
		return mv;
	}

	/*민지:10.18 시험등록  끝*/
	
	@RequestMapping(value="noticeView.do", method=RequestMethod.POST)
	public String noticeWrite(NoticeDto dto, Principal principal,MultipartHttpServletRequest request, RedirectAttributes red) throws Exception {
		String member_id = principal.getName();
		dto.setMember_id(member_id);
		long time = System.currentTimeMillis(); 
		SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		String str = dayTime.format(new Date(time));
		dto.setNotice_date(str);
		
		MultipartFile file1 = request.getFile("files1");
		MultipartFile file2 = request.getFile("files2");
		String originFileName1 = file1.getOriginalFilename();
		String originFileName2 = file2.getOriginalFilename();
		long fileSize1 = file1.getSize();
		long fileSize2 = file2.getSize();
		String path =  request.getServletContext().getRealPath("/upload/notice/");
		
		UUID uuid = UUID.randomUUID();
		String savaFile1 = uuid.toString()+"_" + originFileName1;
		String saveFile2 = uuid.toString()+"_" + originFileName2;
		
		String safeFile1 = path + savaFile1;
		String safeFile2 = path + saveFile2;
		if(fileSize1 > 0 && fileSize2 > 0) {
			file1.transferTo(new File(safeFile1));
			file2.transferTo(new File(safeFile2));
			dto.setNotice_file1(savaFile1);
			dto.setNotice_file2(saveFile2);
		}else if(fileSize1 > 0 && fileSize2 == 0){
			file1.transferTo(new File(safeFile1));
			dto.setNotice_file1(savaFile1);
		}else if(fileSize2 > 0 && fileSize1 == 0) {
			file2.transferTo(new File(safeFile2));
			dto.setNotice_file2(saveFile2);
		}
		int result = commonService.insertBoardList(dto);
		String class_name = dto.getClass_name();
		/*int class_num = adminService.checkClassNum(class_name);
		red.addAttribute("class_num", class_num);*/
		red.addAttribute("class_name", class_name);
		return "redirect:adminClassMain.do";
	}
	
	@RequestMapping(value="noticeRealUpdate.do", method=RequestMethod.POST)
	public String noticeRealUpdate(NoticeDto dto, Principal principal,MultipartHttpServletRequest request, RedirectAttributes red) throws Exception {
		String member_id = principal.getName();
		dto.setMember_id(member_id);
		long time = System.currentTimeMillis(); 
		SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		String str = dayTime.format(new Date(time));
		dto.setNotice_date(str);
		int notice_num = dto.getNotice_num();
		String class_name = dto.getClass_name();
		MultipartFile file1 = request.getFile("files1");
		MultipartFile file2 = request.getFile("files2");
		String originFileName1 = file1.getOriginalFilename();
		String originFileName2 = file2.getOriginalFilename();
		long fileSize1 = file1.getSize();
		long fileSize2 = file2.getSize();
		String path =  request.getServletContext().getRealPath("/upload/notice/");
		
		UUID uuid = UUID.randomUUID();
		String savaFile1 = uuid.toString()+"_" + originFileName1;
		String saveFile2 = uuid.toString()+"_" + originFileName2;
		
		String safeFile1 = path + savaFile1;
		String safeFile2 = path + saveFile2;
		
		
		
		if(fileSize1 > 0 && fileSize2 > 0) {
			file1.transferTo(new File(safeFile1));
			file2.transferTo(new File(safeFile2));
			dto.setNotice_file1(savaFile1);
			dto.setNotice_file2(saveFile2);
			commonService.updateBoardList(dto);
		}else if(fileSize1 > 0 && fileSize2 == 0){
			file1.transferTo(new File(safeFile1));
			dto.setNotice_file1(savaFile1);
			commonService.updateBoardListFile1(dto);
		}else if(fileSize2 > 0 && fileSize1 == 0) {
			file2.transferTo(new File(safeFile2));
			dto.setNotice_file2(saveFile2);
			commonService.updateBoardListFile2(dto);
		}else {
			commonService.updateNoBoardList(dto);
		}
		red.addAttribute("class_name", class_name);
		red.addAttribute("notice_num", notice_num);
		return "redirect:noticeDetail.do";
	}
	
	@RequestMapping("noticeDelete.do")
	public String noticeDelete(Model model,int notice_num, String class_name, RedirectAttributes red) {
		NoticeDto dto = new NoticeDto();
		dto.setNotice_num(notice_num);
		dto.setClass_name(class_name);
		int result = commonService.noticeDelete(dto);
		red.addAttribute("class_name", class_name);
		return "redirect:adminClassMain.do";
	}
	
	@RequestMapping("commentReply.do")
	public @ResponseBody int commentReply(int notice_num, String class_name, int comment_num, String replyInput, Principal principal){
		String member_id = principal.getName();
		CommentDto dto = new CommentDto();
		dto.setClass_name(class_name);
		dto.setNotice_num(notice_num);
		dto.setComment_num(comment_num);
		dto.setMember_id(member_id);
		dto.setComment_content(replyInput);
		int result = commonService.commentReply(dto);
		return result;
		
	}
	
	@RequestMapping("commentInsert.do")
	public @ResponseBody int commentInsert(Model model, String class_name, int notice_num, String textarea, Principal principal) {
		String name = principal.getName();
		CommentDto dto = new CommentDto();
		dto.setMember_id(name);
		dto.setClass_name(class_name);
		dto.setNotice_num(notice_num);
		dto.setComment_content(textarea);
		int result = commonService.commentInsert(dto);
		return 0;
	}
	
	@RequestMapping("noticeDetailAjax.do")
	public ModelAndView noticeDetailAjax(Model model, String class_name, int notice_num, Principal principal) {
		List<NoticeDto> result = commonService.noticeDetail(class_name, notice_num);
		List<CommentDto> comment = commonService.comment(class_name, notice_num);
		List<CommentDto> commentGroup = commonService.commentGroup(class_name, notice_num);
		String name = principal.getName();
		ModelAndView mv = new ModelAndView();
		mv.setViewName("ajax.teacher.noticeDetail_ajax1");
		mv.addObject("result", result);
		mv.addObject("comment", comment);
		mv.addObject("commentGroup", commentGroup);
		mv.addObject("name", name);
		return mv;
	}
	
	@RequestMapping("noticeReplyUpdate.do")
	public @ResponseBody int noticeReplyUpdate(Model model, int comment_num, String comment_content) {
		CommentDto dto = new CommentDto();
		dto.setComment_num(comment_num);
		dto.setComment_content(comment_content);
		int result = commonService.commentUpdate(dto);
		return 0;
	}
	
	@RequestMapping("commentReplyDelete.do")
	public @ResponseBody int commentReplyDelete(Model model,int comment_num) {
		CommentDto dto = new CommentDto();
		dto.setComment_num(comment_num);
		int result = commonService.commentReplyDelete(dto);
		return 0;
	}
	
	@RequestMapping("fileDeletebtn1.do")
	public @ResponseBody int fileDeletebtn1(Model model,int notice_num, String class_name) {
		NoticeDto dto = new NoticeDto();
		dto.setNotice_num(notice_num);
		dto.setClass_name(class_name);
		int result = commonService.fileDeletebtn1(dto);
		return result;
	}
	
	@RequestMapping("fileDeletebtn2.do")
	public @ResponseBody int fileDeletebtn2(Model model,int notice_num, String class_name) {
		NoticeDto dto = new NoticeDto();
		dto.setNotice_num(notice_num);
		dto.setClass_name(class_name);
		int result = commonService.fileDeletebtn2(dto);
		return result;
	}
	

	 @RequestMapping("message_check.do")
	    public @ResponseBody int message_check(@RequestParam("message_check")int message_check,@RequestParam("message_num")int message_num) {
	        MessageDto dto = new MessageDto();
	        int result = commonService.message_check(message_check, message_num);
	        return result;
	 }
	/* 영준 10.25 반 등수 시작 */
	@RequestMapping(value="classRank.do", method=RequestMethod.POST)
	public @ResponseBody List<Score_chartDto> classRank(@RequestParam("exam_info_num") int exam_info_num) {
		List<Score_chartDto> classRank = commonService.classRank(exam_info_num);
		return classRank;
	}
	//양회준 10.29 학생&성적관리.클래스통계.점수별분포
	@RequestMapping(value="studentScoreSpread.do", method=RequestMethod.POST)
	public @ResponseBody int[] studentScoreSpread(@RequestParam("exam_info_num") int exam_info_num, 
			@RequestParam("class_name") String class_name) {
		int[] spreadList = commonService.studentScoreSpread(exam_info_num, class_name);
		return spreadList;
	}


	
	 @RequestMapping("sendMessageDelete.do")
		public @ResponseBody int sendMessageDelete(String sendDeleteHidden) {
			int result = 0;
			String[] sendDeleteHiddenArray=sendDeleteHidden.split(",");
			for(int i = 0; i < sendDeleteHiddenArray.length;i++) {
				result = commonService.sendMessageDelete(sendDeleteHiddenArray[i]);
			}
			return result;
		}
	 
	 @RequestMapping("receiveMessageDelete.do")
		public @ResponseBody int receiveMessageDelete(String receiveDeleteHidden) {
			int result = 0;
			String[] receiveDeleteHiddenArray=receiveDeleteHidden.split(",");
			for(int i = 0; i < receiveDeleteHiddenArray.length;i++) {				
				result = commonService.receiveMessageDelete(receiveDeleteHiddenArray[i]);
			}
			return result;
		}
	 
	// 10.24 현이 ajax로 시험지의 문제들 불러오기 - 양회준 11.2 추가수정
	   @RequestMapping("pastExamPaperView.do")
	   public @ResponseBody ModelAndView pastExamPaperView(int exam_info_num, 
			   @RequestParam("student_answer_status") String student_answer_status, 
			   @RequestParam("question_answerSheet") String question_answerSheet, 
	         int begin, int rowPerPage, @RequestParam("member_id") String member_id ) 
	        		 throws ClassNotFoundException, SQLException, IOException {
	      	      
	      ModelAndView mav = new ModelAndView();
	      
	      List<ExamPaperDoQuestionDto> questionList = null;
	      List<Question_choiceDto> questionChoiceList = null;
	      
	      int begin2 = begin - 1;
	      
	      if(question_answerSheet.equals("question")) {      //   문제 리턴(페이징 처리 필요) 
	         
	         mav.setViewName("ajax.student.pastExamPaper_ajax");
	         if(student_answer_status.equals("all")) {
	            questionList = studentService.examPaperDoQuestion(exam_info_num, begin2, rowPerPage);   
	            questionChoiceList = studentService.examPaperDoQuestion_choice(exam_info_num);
	         } else if (student_answer_status.equals("wrong")){
	            questionList = studentService.examPaperDoWrongQuestion(member_id, exam_info_num, begin2, rowPerPage);
	            questionChoiceList = studentService.examPaperDoWrongQuestion_choice(exam_info_num);
	         }
	         
	      } else if (question_answerSheet.equals("answerSheet")) {   //   답안지 리턴(페이징 필요 없음, 전체 보여주기) 
	         
	         mav.setViewName("ajax.student.pastExamPaperAnswer_ajax");
	         if(student_answer_status.equals("all")) {
	            questionList = studentService.examPaperDoQuestion(exam_info_num, 0, 0);   //   begin, rowPerPage0 추가했음
	            questionChoiceList = studentService.examPaperDoQuestion_choice(exam_info_num);
	         } else if (student_answer_status.equals("wrong")){
	            questionList = studentService.examPaperDoWrongQuestion(member_id, exam_info_num, 0, 0);
	            questionChoiceList = studentService.examPaperDoWrongQuestion_choice(exam_info_num);
	         }
	         
	      }
	            
	      mav.addObject("questionList", questionList);
	      mav.addObject("questionChoiceList", questionChoiceList);
	            
	      return mav;
	   }
	   
	   // 10.24 현이 ajax로 학생 답안지 리스트 가져오기 - 양회준 11.2 추가수정
		@RequestMapping("searchStudentAnswer.do")
		public @ResponseBody List<Student_answerQuesDto> selectStudentAnswer(@RequestParam("member_id") String member_id,
				@RequestParam("exam_info_num") int exam_info_num, @RequestParam("student_answer_status") String student_answer_status){
			
			List<Student_answerQuesDto> studentAnswerList = studentService.selectStudentAnswer(member_id, exam_info_num, student_answer_status);
			return studentAnswerList;
		}
		
		// 10.24 현이 지난 시험지 보기 - 양회준 11.2 추가수정
		@RequestMapping("pastExamPaper.do")
		public String pastExamPaper(Model model, int exam_info_num, String member_id) throws ClassNotFoundException, SQLException, IOException {
			ExamInfoDto exam_info = commonService.examScheduleDetail(exam_info_num);
			model.addAttribute("exam_info", exam_info);
			
			int questionCount = commonService.questionCount(exam_info_num);
			int wrongQuestionCount = studentService.wrongQuestionCount(member_id, exam_info_num);
			model.addAttribute("questionCount", questionCount);
			model.addAttribute("wrongQuestionCount", wrongQuestionCount);
					
			return "exam.student.pastExamPaper";
		}
		
		//11.05민지 시험일정 수정
		@RequestMapping("examInfoIUpdate.do")
		public String examInfoIUpdate(ExamInfoDto dto,String memberarray2, int exam_info_num) {

			String [] memberchecklist= memberarray2.split(",");
			
			int result = teacherService.examInfoIUpdate(dto);
			
			if(result > 0) {
				int result2 = teacherService.teacherExamMemberDelete(exam_info_num);
				if(result2>0) {
					String memberid="";
					int result3;
					for(int i = 0; i<=memberchecklist.length-1;i++) {
						
						 memberid = memberchecklist[i];
						ExamMemberDto exammemberdto = new ExamMemberDto();
						List<ExamInfoDto> list= teacherService.classExamList(exam_info_num);
						int papernum= list.get(0).getExam_paper_num();
						List<ExamInfoDto> examinfolist = teacherService.examScheduleList2(papernum);
						int infonum = examinfolist.size()-1;
						int infonum2 = examinfolist.get(infonum).getExam_info_num();
			
						exammemberdto.setExam_info_num(infonum2);
						exammemberdto.setMember_id(memberid);
						result3=teacherService.examMemberInsert(exammemberdto);
						
					
					}
					
				}
				
			}
			
			return "redirect:examManagement.do";
		}
		/*11.05 민지 시험일정 삭제 관리자에서*/
		/* 민지 - 18.10.23 시험 일정 삭제 시작 */
		@RequestMapping(value = "teacherExamSchedultDelete.do", method = RequestMethod.POST)
		public @ResponseBody String teacherExamSchedultDelete(@RequestParam("exam_info_num") int exam_info_num, @RequestParam("currentDate") int currentDate, @RequestParam("removeData") int removeData) //@RequestBody (비동기: 객체 형태로 받아요) 
		{	
			
			/*deptService.insertDept(dto);
			return dto.toString();*/
			String result2="";
			if(currentDate>removeData) {
				result2="n";
			}else {
				int result = teacherService.teacherExamSchedultDelete(exam_info_num);
				result2 = String.valueOf(result);
				
			}
			return result2;
			
		}
		/* 민지 - 18.10.23 시험 일정 삭제 끝 */
		
		/*민지 11.05 시험지 무한스크롤*/
		// ajax로 클래스 목록 가져오기  
		//@RequestMapping(value="adminMainView.do")
/*		public @ResponseBody List<ExamPaperDto> exampaperlistClass(int begin) {
			
			System.out.println("begin : " + begin);
			List<ExamPaperDto> classList = adminService.exampaperlistClass(begin);
			
			ModelAndView mv = new ModelAndView();
			mv.addObject("classList", classList);
		
			return classList;
		}*/
		
		// ajax로 검색한 클래스 목록 가져오기 
		@RequestMapping(value="exampaperlistClass.do")
		public @ResponseBody ModelAndView exampaperSearch(@RequestParam("searchType") String searchType, @RequestParam("keyword") String keyword,
				@RequestParam("begin") int begin){
			
			List<ExamPaperDto> classList = null;
			
			classList = adminService.exampaperSearch(searchType, keyword, begin);
			
			ModelAndView mv = new ModelAndView();
			mv.setViewName("ajax.admin.examManagement_admin_ajax");
			mv.addObject("classList", classList);
			mv.addObject("begin",begin);
		
			return mv;
		}
		//시험등록
		
		//11.05 민지 시험일정탭 무한스크롤

	@RequestMapping(value="examinfolistClass.do")
		public @ResponseBody ModelAndView examinfolistClass(@RequestParam("searchType2") String searchType2, @RequestParam("keyword") String keyword,
				@RequestParam("begin") int begin){
			
			List<ExamInfoDto> classList = null;

			classList = adminService.examinfoSearch(searchType2, keyword, begin);
			
			ModelAndView mv = new ModelAndView();
			mv.setViewName("ajax.admin.examManagement_admin_ajax_exam_info");
			mv.addObject("classList", classList);
			mv.addObject("begin",begin);
		
			return mv;
		}

	//11.08 about us 페이지
		@RequestMapping("aboutUs.do")
		public String aboutUs(Model model) {
			
			return "common.admin.common.aboutUs";
		}

	//양회준 11.5 코멘트 추가
	@RequestMapping("studentInfoCommentUpdate.do")
	public @ResponseBody int studentInfoCommentUpdate(@RequestParam("member_id") String member_id,
			@RequestParam("exam_info_num") int exam_info_num,@RequestParam("score_chart_comment") String score_chart_comment) {
		int result = teacherService.studentInfoCommentUpdate(member_id, exam_info_num, score_chart_comment);
		return result;
	}
	
	@RequestMapping("apiInfo.do")
	public String apiInfo(Principal principal, Model model) {
		
		return "common.admin.common.apiInfo";
	}
	@RequestMapping("apiInfomation.do")
	public String apiInfomation(Principal principal, Model model, String class_name, String class_num ) {
		model.addAttribute("class_name", class_name);
		model.addAttribute("class_num", class_num);
		return "common.adminClass.admin.common.apiInfo";
	}
	
}