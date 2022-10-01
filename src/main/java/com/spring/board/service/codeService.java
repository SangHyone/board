package com.spring.board.service;

import java.util.List;

import com.spring.board.vo.CodeVo;

public interface codeService {
	
	public List<CodeVo> selectMenuList() throws Exception;

	public List<CodeVo> selectPhoneList() throws Exception;
}
