package com.fzl.mapper;

import com.fzl.pojo.UserMember;

public interface UserMemberMapper {
    int deleteByPrimaryKey(Long userId);

    int insert(UserMember record);

    int insertSelective(UserMember record);

    UserMember selectByPrimaryKey(Long userId);

    int updateByPrimaryKeySelective(UserMember record);

    int updateByPrimaryKey(UserMember record);
}