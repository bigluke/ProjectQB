package onet.com.index.controller;


import java.security.Principal;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import onet.com.index.service.IndexService;
import onet.com.vo.ClassDto;
import onet.com.vo.MemberDto;

@Controller
@RequestMapping("/index/")
public class IndexController {

	@Autowired
	private IndexService indexService;
	
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	

	
	
	@RequestMapping("memberjoin.do")
	public String memberjoin(Model model) {
		List<ClassDto> classList;
		classList = indexService.classList();
		model.addAttribute("classList", classList);
		return "home.memberJoin";
	}

	@RequestMapping("idSearch.do")
	public String idSearch() {

		return "home.findId";
	}
	
	@RequestMapping(value="idSearch.do",method=RequestMethod.POST)
	public String idSearch(MemberDto dto, Model model) {
		String result = indexService.idSearch(dto);

		if(result != null) {
			model.addAttribute("result", result);
		}else {
			result = "false";
			model.addAttribute("result", result);
		}
		return "home.findId";
	}
	
	
	@RequestMapping(value="pwdSearch.do")
	public String pwdSearch() {

		return "home.findPw";
	}
	
	@RequestMapping(value="pwdSearch.do", method=RequestMethod.POST)
	public String pwdSearch(MemberDto dto, Model model) {
		String mailto = dto.getMember_email();
		String member_id = dto.getMember_id();
		String pwd = indexService.sendMail(mailto,"findPw", member_id);
		dto.setMember_pwd(this.bCryptPasswordEncoder.encode(pwd));
		dto.setMember_id(member_id);
		int re = indexService.pwdSearch(dto);
		String result = "";
		if(re > 0) {
			result = "true";
			model.addAttribute("result", result);
		}else {
			result = "false";
			model.addAttribute("result", result);
		}
		return "home.findPw";
	}

	@RequestMapping("noAuth.do")
	public String join(){
		return "home.noAuth";
		
	}

	@RequestMapping(value="insertmember.do", method=RequestMethod.POST)
	public String  memberInsert(MemberDto dto) throws ClassNotFoundException, SQLException {
		
		int result = 0;
		String viewpage="";
		
		dto.setMember_pwd(this.bCryptPasswordEncoder.encode(dto.getMember_pwd()));
		result = indexService.insertMember(dto);
		
		
		
		if(result > 0) {
			viewpage = "redirect:/login.jsp";
		}else {
			 viewpage = "memberjoin.do";
		}
		return viewpage;
	}
	
	@RequestMapping(value="joinCheckId.do", method=RequestMethod.GET)
	public @ResponseBody Map<String, Object> idCheck(@RequestParam("member_id") String member_id) {
		String memberid = indexService.joinCheckId(member_id);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", memberid == null);
		map.get("result");
		return map;
	}
	
	@RequestMapping(value = "mail.do",  method = RequestMethod.POST)
	public @ResponseBody String mail(String mailto,String command , String member_id) {
		String randomNum = indexService.sendMail(mailto, command, member_id);// 회원가입 메일발송
		return randomNum;
	}

	@RequestMapping("login.do")
	public String login() {
		return "redirect:/login.jsp";
	}

	
}
