package com.fzl.controller;

import com.fzl.mapper.DepartmentMapper;
import com.fzl.pojo.Department;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * Created by Administrator on 2017/10/17.
 */
@Controller
@RequestMapping("department")
public class DepartmentController extends BaseController{
    @Autowired
    private DepartmentMapper departmentMapper;
    /**
     * 查询所有部门
     * @param request
     * @param response
     */
    @RequestMapping("getAll")
    public void getAll(HttpServletRequest request, HttpServletResponse response){
       List<Department> list=departmentMapper.queryAll();
       writeCommonDataResponse(response,"200","查询成功",list);
    }
}
