package com.spring.board.dao.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.board.dao.UserDao;
import com.spring.board.vo.UserVo;

@Repository
public class UserDaoImpl implements UserDao{

	@Autowired
	SqlSession sqlSession;
	
	@Override
	public int userInsert(UserVo userVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert("user.userInsert",userVo);
	}

	@Override
	public List<String> userList() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("user.userList");
	}

	@Override
	public UserVo userLogin(UserVo userVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("user.userLogin", userVo);
	}

	@Override
	public UserVo selectUserById(String	userId) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("user.selectUserById", userId);
	}

}
