package com.fzl.controller;

import com.fzl.mapper.RoleMapper;
import com.fzl.pojo.Role;
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
@RequestMapping("role")
public class RoleController extends BaseController {
    @Autowired
    private RoleMapper roleMapper;

    /**
     * 查询所有角色权限
     *
     * @param request
     * @param response
     */
    @RequestMapping("getAll")
    public void getAll(HttpServletRequest request, HttpServletResponse response) {
        List<Role> list = roleMapper.queryAll();
        writeCommonDataResponse(response, "200", "查询成功", list);
    }
}
