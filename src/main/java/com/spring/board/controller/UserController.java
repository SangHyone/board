package com.spring.board.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;

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
		
		for(String str : list) {
			if(str.equals(userId)) {
				resultCnt++;
				break;
			}
		}
		
		result.put("success", (resultCnt == 0) ? "Y" : "N");
		String callbackMsg = commonUtil.getJsonCallBackString(" ", result);
		
		System.out.println("callbackMsg::" + callbackMsg);
		
		return callbackMsg;
	}
	
	@RequestMapping(value = "/user/login.do", method = RequestMethod.GET)
	public String loginpage(Locale locale, Model model) throws Exception {
		
		return "/user/login";
	}
	
}
