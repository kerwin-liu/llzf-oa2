package com.fzl.mapper;

import com.fzl.pojo.Department;

public interface DepartmentMapper {
    int insert(Department record);

    int insertSelective(Department record);
}