package com.edu.test.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface HomeService {
	public List<HashMap<String,Object>> selectSports(Map<String,String> paramMap) throws Exception;
	
	public int insertSports(Map<String,String> paramMap) throws Exception;
	
	public int updateSports(Map<String,String> paramMap) throws Exception;
	
	public int deleteSports(Map<String,String> paramMap) throws Exception;
}