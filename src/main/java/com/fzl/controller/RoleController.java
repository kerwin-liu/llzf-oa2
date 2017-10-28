package com.fzl.controller;

import com.fzl.mapper.RoleMapper;
import com.fzl.pojo.Role;
import com.fzl.pojo.User;
import com.fzl.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2017/10/17.
 */
@Controller
@RequestMapping("role")
public class RoleController extends BaseController {
    @Autowired
    private RoleMapper roleMapper;
    @Autowired
    private UserService userService;

    /**
     * 查询所有角色权限
     *
     * @param request
     * @param response
     */
    @RequestMapping("getAll")
    public void getAll(HttpServletRequest request, HttpServletResponse response) {
        List<Role> list = roleMapper.queryAll();
        User sessionUser = (User) request.getSession().getAttribute("user");
        Long role = userService.selectRole(sessionUser);
        List<Role> list1 = new ArrayList<>();
        if (role.compareTo(3L) == 0) {
            for (Role role1 : list) {
                if (role1.getId().compareTo(3L) == 0) {
                    list1.add(role1);
                }
            }
        }else if(role.compareTo(2L) == 0){
            for (Role role1 : list) {
                if (role1.getId().compareTo(1L) != 0) {
                    list1.add(role1);
                }
            }
        }else {
            list1=list;
        }
        writeCommonDataResponse(response, "200", "查询成功", list1);
    }
}
