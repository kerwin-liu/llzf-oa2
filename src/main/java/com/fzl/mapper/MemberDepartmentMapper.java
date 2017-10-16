package com.fzl.mapper;

import com.fzl.pojo.MemberDepartment;

public interface MemberDepartmentMapper {
    int deleteByPrimaryKey(Integer memberId);

    int insert(MemberDepartment record);

    int insertSelective(MemberDepartment record);

    MemberDepartment selectByPrimaryKey(Integer memberId);

    int updateByPrimaryKeySelective(MemberDepartment record);

    int updateByPrimaryKey(MemberDepartment record);
}