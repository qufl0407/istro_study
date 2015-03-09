package com.edu.test.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class HomeDao {

   @Autowired
    private SqlSession sqlSession;

    public List<HashMap<String,Object>> selectSports(Map<String,String> paramMap) throws Exception{
    	return sqlSession.selectList("home.selectSports", paramMap);
    }
    
    public int insertSports(Map<String,String> paramMap) throws Exception{
    	return sqlSession.insert("home.insertSports", paramMap);
    }
    
    public int updateSports(Map<String,String> paramMap) throws Exception{
    	return sqlSession.update("home.updateSports", paramMap);
    }
    
    public int deleteSports(Map<String,String> paramMap) throws Exception{
    	return sqlSession.delete("home.deleteSports", paramMap);
    }
    
} 

