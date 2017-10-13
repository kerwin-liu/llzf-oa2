package com.fzl.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fzl.mapper.TMemberMapper;
import com.fzl.pojo.TMember;
import com.fzl.service.TmemberService;


@Service
public class TmemberServiceImpl implements TmemberService {

	@Autowired
	private TMemberMapper memberMapper;
	
	
	
	@Override
	public TMember getTmemberByMemberId(int memberId) {

		return  memberMapper.selectByPrimaryKey(memberId) ;
	}

	
}
