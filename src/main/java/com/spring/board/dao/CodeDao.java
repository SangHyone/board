package com.spring.board.dao;

import java.util.List;

import com.spring.board.vo.CodeVo;

public interface CodeDao {
	
	public List<CodeVo> selectMenuList() throws Exception; 
	
	public List<CodeVo> selectPhoneList() throws Exception; 
	
}
