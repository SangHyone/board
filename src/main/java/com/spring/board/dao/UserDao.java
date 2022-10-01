package com.spring.board.dao;

import java.util.List;

import com.spring.board.vo.UserVo;

public interface UserDao {
	
	public int userInsert(UserVo userVo) throws Exception;
	
	public List<String> userList() throws Exception;
}
