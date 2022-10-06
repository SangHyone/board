package com.spring.board.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.board.dao.UserDao;
import com.spring.board.service.userService;
import com.spring.board.vo.UserVo;
@Service
public class userServiceImpl implements userService{
	
	@Autowired
	UserDao userDao;

	@Override
	public int userInsert(UserVo userVo) throws Exception {
		// TODO Auto-generated method stub
		return userDao.userInsert(userVo);
	}

	@Override
	public List<String> userList() throws Exception {
		// TODO Auto-generated method stub
		return userDao.userList();
	}

	@Override
	public UserVo userLogin(UserVo userVo) throws Exception {
		// TODO Auto-generated method stub
		return userDao.userLogin(userVo);
	}

	@Override
	public UserVo selectUserById(String	userId) throws Exception {
		// TODO Auto-generated method stub
		return userDao.selectUserById(userId);
	}
	
	
}
