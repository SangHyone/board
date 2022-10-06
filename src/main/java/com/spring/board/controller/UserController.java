package com.spring.board.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.board.HomeController;
import com.spring.board.service.codeService;
import com.spring.board.service.userService;
import com.spring.board.vo.CodeVo;
import com.spring.board.vo.UserVo;
import com.spring.common.CommonUtil;

@Controller
public class UserController {
	
	@Autowired
	userService userService;
	
	@Autowired
	codeService codeService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "/user/join.do", method = RequestMethod.GET)
	public String joinPage(Locale locale, Model model) throws Exception {
		List<CodeVo> phoneList = codeService.selectPhoneList();
		
		model.addAttribute("phoneList", phoneList);
		return "/user/join";
	}
	
	@RequestMapping(value = "/user/joinAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String joinAction(Locale locale, UserVo userVo) throws Exception {
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		System.out.println(userVo);
		List<CodeVo> phoneList = codeService.selectPhoneList();
		for(CodeVo vo : phoneList) {
			if(userVo.getUserPhone1().equals(vo.getCodeId())) {
				userVo.setUserPhone1(vo.getCodeName());
			}
		}
		int resultCnt = userService.userInsert(userVo);
		
		result.put("success", (resultCnt > 0) ? "Y" : "N");
		String callbackMsg = commonUtil.getJsonCallBackString(" ", result);

		System.out.println("callbackMsg::" + callbackMsg);

		return callbackMsg;
	}
	
	@RequestMapping(value = "/user/checkId.do", method = RequestMethod.POST)
	@ResponseBody
	public String checkId(Locale locale, String	userId) throws Exception {
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		List<String> list = userService.userList();
		int resultCnt = 0;
		if(userId!="") {
			for(String str : list) {
				if(str.equals(userId)) {
					resultCnt++;
					break;
				}
			}
			result.put("success", (resultCnt == 0) ? "Y" : "N");
		}else {
			result.put("success", "D");
		}
		
		String callbackMsg = commonUtil.getJsonCallBackString(" ", result);
		
		System.out.println("callbackMsg::" + callbackMsg);
		
		return callbackMsg;
	}
	
	@RequestMapping(value = "/user/login.do", method = RequestMethod.GET)
	public String loginpage(Locale locale, Model model) throws Exception {
		
		return "/user/login";
	}
	
	@RequestMapping(value = "/user/loginAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String loginAction(Locale locale, UserVo userVo, Model model , HttpSession session) throws Exception {
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		System.out.println(userVo);
		List<String> list = userService.userList();
		int cnt = 0;
		for(String str : list) {
			if(str.equals(userVo.getUserId())) {
				UserVo dbVo = userService.selectUserById(str);
				if(dbVo.getUserPw().equals(userVo.getUserPw())) {
					session.setAttribute("user", dbVo);
				}else {
					result.put("pwError", "Y");
				}
			}else{
				cnt++;
				
			}
		}
		System.out.println(cnt);
		System.out.println(list.size());
		if(cnt==list.size()) {
			result.put("idError", "Y");
		}
	
		String callbackMsg = commonUtil.getJsonCallBackString(" ", result);

		System.out.println("callbackMsg::" + callbackMsg);

		return callbackMsg;
	}
	
	@RequestMapping(value = "/user/logout.do", method = RequestMethod.GET)
	public String logout(Locale locale, HttpSession session) throws Exception {
		String url = "/board/boardList.do";
		session.invalidate();
		
		return "redirect:" + url;
	}

}
