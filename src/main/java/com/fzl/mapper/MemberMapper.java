package com.fzl.mapper;

import com.fzl.pojo.Member;

public interface MemberMapper {
    int deleteByPrimaryKey(Long memberId);

    int insert(Member record);

    int insertSelective(Member record);

    Member selectByPrimaryKey(Long memberId);

    int updateByPrimaryKeySelective(Member record);

    int updateByPrimaryKey(Member record);

    Member queryMemberByuserid(Long id);

    Member queryMemberByNo(String name);
}