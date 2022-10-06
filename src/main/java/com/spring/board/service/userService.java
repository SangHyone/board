package com.spring.board.service;

import java.util.List;

import com.spring.board.vo.UserVo;

public interface userService {
	
	public int userInsert(UserVo userVo) throws Exception;
	
	public List<String> userList() throws Exception;
	
	public UserVo userLogin(UserVo userVo) throws Exception;
	
	public UserVo selectUserById(String	userId) throws Exception;
}
