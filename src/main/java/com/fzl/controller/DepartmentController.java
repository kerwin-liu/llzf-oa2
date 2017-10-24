package com.fzl.controller;

import com.fzl.common.IDUtils;
import com.fzl.mapper.DepartmentMapper;
import com.fzl.pojo.Department;
import com.fzl.pojo.User;
import com.fzl.service.DepartmentService;
import com.fzl.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * Created by Administrator on 2017/10/17.
 */
@Controller
@RequestMapping("department")
public class DepartmentController extends BaseController {
    @Autowired
    private DepartmentMapper departmentMapper;
    @Autowired
    private UserService userService;

    @Autowired
    private DepartmentService departmentService;

    /**
     * 查询所有部门
     *
     * @param request
     * @param response
     */
    @RequestMapping("getAll")
    public void getAll(HttpServletRequest request, HttpServletResponse response) {
        List<Department> list = departmentMapper.queryAll();
        writeCommonDataResponse(response, "200", "查询成功", list);
    }

    @RequestMapping(value = "save", method = RequestMethod.POST)
    public void save(HttpServletRequest request, HttpServletResponse response, Department department) {
        User sessionUser = (User) request.getSession().getAttribute("user");
        Long role = userService.selectRole(sessionUser);
        //管理员能添加部门
        if (role.compareTo(1L) != 0) {
            writeResponse(response, "400", "该用户无增加部门权限");
            return;
        }
        department.setId(IDUtils.getId());
        boolean save = departmentService.save(department);
        if (save) {
            writeResponse(response, "200", "部门添加成功");
            return;
        }
        writeResponse(response, "400", "部门添加失败");
    }

    @RequestMapping(value = "update", method = RequestMethod.POST)
    public void update(HttpServletRequest request, HttpServletResponse response, Department department) {
        User sessionUser = (User) request.getSession().getAttribute("user");
        Long role = userService.selectRole(sessionUser);
        //管理员可以删除部门
        if (role.compareTo(1L) != 0) {
            writeResponse(response, "400", "该用户无修改部门权限");
            return;
        }
        int i = departmentMapper.updateByPrimaryKeySelective(department);
        if (i > 0) {
            writeResponse(response, "200", "部门修改成功");
            return;
        }
        writeResponse(response, "400", "部门修改失败或部门名称未更改");
    }
    @RequestMapping(value = "delete/{id}", method = RequestMethod.POST)
    public void delete(HttpServletRequest request, HttpServletResponse response, @PathVariable Long id) {
        User sessionUser = (User) request.getSession().getAttribute("user");
        Long role = userService.selectRole(sessionUser);
        //管理员可以删除部门
        if (role.compareTo(1L) != 0) {
            writeResponse(response, "400", "该用户无删除部门权限");
            return;
        }
        int i = departmentMapper.deleteByPrimaryKey(id);
        if (i > 0) {
            writeResponse(response, "200", "部门删除成功");
            return;
        }
        writeResponse(response, "400", "部门删除失败或部门名称未更改");
    }
}
