package com.fzl.mapper;

import com.fzl.pojo.MemberRole;

public interface MemberRoleMapper {
    int deleteByPrimaryKey(Long memberId);

    int insert(MemberRole record);

    int insertSelective(MemberRole record);

    MemberRole selectByPrimaryKey(Long memberId);

    int updateByPrimaryKeySelective(MemberRole record);

    int updateByPrimaryKey(MemberRole record);
}