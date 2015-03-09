package com.edu.test;

import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.edu.test.service.HomeService;

/**
 * Handles requests for the application home page.
 */
@Controller  
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	 HomeService homeService;     
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	
	
	@RequestMapping(value="/selectSports", method = RequestMethod.POST)
	public @ResponseBody List<HashMap<String, Object>> selectSports(HttpServletRequest request, Model model)throws Exception {

		Map<String,String> paramMap = new HashMap<String,String>();

		List<HashMap<String, Object>> retList = homeService.selectSports(paramMap);

		return retList; 

	}
	
	@RequestMapping(value="/insertSports", method = RequestMethod.POST)
	public @ResponseBody Map<String,String> insertSports(HttpServletRequest request, Model model)throws Exception {

		Map<String,String> resultMap = new HashMap<String,String>();
		
		String id = request.getParameter("id") == null ? "" : request.getParameter("id").toString();
		String sports1 = request.getParameter("sports1") == null ? "" : request.getParameter("sports1").toString();
		String sports2 = request.getParameter("sports2") == null ? "" : request.getParameter("sports2").toString();
		String sports3 = request.getParameter("sports3") == null ? "" : request.getParameter("sports3").toString();
		String sports4 = request.getParameter("sports4") == null ? "" : request.getParameter("sports4").toString();

		
		Map<String,String> paramMap = new HashMap<String,String>();
//		paramMap.put("id", request.getParameter("id"));
		paramMap.put("id", id);
		paramMap.put("sports1", sports1);
		paramMap.put("sports2", sports2);
		paramMap.put("sports3", sports3);
		paramMap.put("sports4", sports4);
		
		
		try{
			int resultValue = homeService.insertSports(paramMap);
			if(resultValue == 1){
				resultMap.put("retVal", "1");
				
			}else{
				resultMap.put("retVal", "0");
			}
		
		}catch(Exception e){
			resultMap.put("retVal", "0");
			e.printStackTrace();
		}
			
		return resultMap; 

	}
	
	
	
	
	@RequestMapping(value="/updateSports", method = RequestMethod.POST)
	public @ResponseBody Map<String,String> updateSports(HttpServletRequest request, Model model)throws Exception {

		Map<String,String> resultMap = new HashMap<String,String>();
		
		String id = request.getParameter("id") == null ? "" : request.getParameter("id").toString();
		String sports1 = request.getParameter("sports1") == null ? "" : request.getParameter("sports1").toString();
		String sports2 = request.getParameter("sports2") == null ? "" : request.getParameter("sports2").toString();
		String sports3 = request.getParameter("sports3") == null ? "" : request.getParameter("sports3").toString();
		String sports4 = request.getParameter("sports4") == null ? "" : request.getParameter("sports4").toString();

		
		Map<String,String> paramMap = new HashMap<String,String>();
		paramMap.put("id", id);
		paramMap.put("sports1", sports1);
		paramMap.put("sports2", sports2);
		paramMap.put("sports3", sports3);
		paramMap.put("sports4", sports4);
		
		
		int resultValue = homeService.updateSports(paramMap);
		
		try{
			if(resultValue == 1){
				resultMap.put("retVal", "1");
				
			}else{
				resultMap.put("retVal", "0");
				
			}
			
		}catch(Exception e){
			resultMap.put("retVal", "0");
			
			e.printStackTrace();
		}
			
		return resultMap;

	}
	
	
	
	@RequestMapping(value="/deleteSports", method = RequestMethod.POST)
	public @ResponseBody Map<String,String> deleteSports(HttpServletRequest request, Model model)throws Exception {

		Map<String,String> resultMap = new HashMap<String,String>();

		
		Map<String,String> paramMap = new HashMap<String,String>();
		paramMap.put("id", request.getParameter("id"));

		
		int resultValue = homeService.deleteSports(paramMap);
		
		if(resultValue == 1){
			resultMap.put("retVal", "1");
			
		}else{
			resultMap.put("retVal", "0");
			
		}
			
		return resultMap; 

	}
	
	
	
	
	

	
}
