package com.fzl.service.impl;

import com.fzl.mapper.DepartmentMapper;
import com.fzl.pojo.Department;
import com.fzl.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by kerwin.liu on 2017/10/24.
 */
@Service
public class DepartmentServiceImpl implements DepartmentService {
    @Autowired
    private DepartmentMapper departmentMapper;

    @Override
    public boolean save(Department department) {
        return departmentMapper.insertSelective(department) > 0;
    }
}
