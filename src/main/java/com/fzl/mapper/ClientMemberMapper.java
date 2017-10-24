package com.fzl.mapper;

import com.fzl.pojo.ClientMember;

public interface ClientMemberMapper {
    int deleteByPrimaryKey(Long khId);

    int insert(ClientMember record);

    int insertSelective(ClientMember record);

    ClientMember selectByPrimaryKey(Long khId);

    int updateByPrimaryKeySelective(ClientMember record);

    int updateByPrimaryKey(ClientMember record);
}