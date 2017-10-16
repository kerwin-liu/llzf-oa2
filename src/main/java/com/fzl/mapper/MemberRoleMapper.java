package com.fzl.mapper;

import com.fzl.pojo.MemberRole;

public interface MemberRoleMapper {
    int deleteByPrimaryKey(Integer memberId);

    int insert(MemberRole record);

    int insertSelective(MemberRole record);

    MemberRole selectByPrimaryKey(Integer memberId);

    int updateByPrimaryKeySelective(MemberRole record);

    int updateByPrimaryKey(MemberRole record);
}