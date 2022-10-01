package com.spring.board.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.board.dao.CodeDao;
import com.spring.board.service.codeService;
import com.spring.board.vo.CodeVo;

@Service
public class codeServiceImpl implements codeService{
	
	@Autowired
	private CodeDao codeDao;

	@Override
	public List<CodeVo> selectMenuList() throws Exception {
		// TODO Auto-generated method stub
		return codeDao.selectMenuList();
	}

	@Override
	public List<CodeVo> selectPhoneList() throws Exception {
		// TODO Auto-generated method stub
		return codeDao.selectPhoneList();
	}
	
	
}
