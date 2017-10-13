package com.fzl.controller;

import com.fzl.mapper.TAdminMapper;
import com.fzl.pojo.TAdmin;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Created by kerwin.liu on 2017/10/13.
 */
@Controller
@RequestMapping("user")
public class TAdminController {
    @Autowired
    private TAdminMapper tAdminMapper;

    @RequestMapping(value = "login", method = RequestMethod.POST)
    public String login(HttpServletRequest request, HttpServletResponse response, TAdmin tAdmin) {
        HttpSession session = request.getSession();
        TAdmin admin = tAdminMapper.selectByTAdmin(tAdmin);
        if (admin != null) {
            session.setAttribute("user", admin);
            return "index";
        }
        return "login";
    }

    @RequestMapping(value = "home", method = RequestMethod.POST)
    public String home(HttpServletRequest request, HttpServletResponse response, TAdmin tAdmin) {
        return "home";
    }
}
