package com.edu.test.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.edu.test.dao.HomeDao;

@Service
public class HomeServiceImpl implements HomeService {

	@Autowired
	HomeDao homeDao;

	public List<HashMap<String, Object>> selectSports(Map<String, String> paramMap) throws Exception {
		return homeDao.selectSports(paramMap);
	}

	@Override
	public int insertSports(Map<String, String> paramMap) throws Exception {
		
		return homeDao.insertSports(paramMap);
	}

	@Override
	public int updateSports(Map<String, String> paramMap) throws Exception {
		return homeDao.updateSports(paramMap);
	}

	@Override
	public int deleteSports(Map<String, String> paramMap) throws Exception {
		return homeDao.deleteSports(paramMap);
	}

}
