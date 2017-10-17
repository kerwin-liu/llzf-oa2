package com.fzl.mapper;

import com.fzl.pojo.MemberDepartment;

public interface MemberDepartmentMapper {
    int deleteByPrimaryKey(Long memberId);

    int insert(MemberDepartment record);

    int insertSelective(MemberDepartment record);

    MemberDepartment selectByPrimaryKey(Long memberId);

    int updateByPrimaryKeySelective(MemberDepartment record);

    int updateByPrimaryKey(MemberDepartment record);
}