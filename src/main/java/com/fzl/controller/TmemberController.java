package com.fzl.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fzl.pojo.TMember;
import com.fzl.service.TmemberService;


@Controller
public class TmemberController extends BaseController{

	
	@Autowired
	private TmemberService  memberService;
	
	@RequestMapping("/oa/{memberId}")
	@ResponseBody
	public TMember getMemberBymemberId(@PathVariable Integer memberId){
		
		return memberService.getTmemberByMemberId(memberId);
		
	}
	
	
	@RequestMapping("/oop")
	public String getMemberBymember(){
		
		return "index";
		
	}
	
	@RequestMapping("/login")
	public String login(){
		
		return "index";
		
	}
	@RequestMapping("/home")
	public String home(){

		return "home";

	}
}
