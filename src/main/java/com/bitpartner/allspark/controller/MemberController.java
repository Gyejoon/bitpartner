package com.bitpartner.allspark.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bitpartner.allspark.service.MemberService;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value = "/ico/allspark/recom")
public class MemberController {
	
	/**
	 * eventPage 접속 Url
	 * @return
	 */
	@RequestMapping(value = "/event", method = RequestMethod.GET)
	public String eventPage() {
		return "event";
	}
	
	
}
