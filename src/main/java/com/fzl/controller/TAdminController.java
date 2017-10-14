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
import java.util.ArrayList;
import java.util.List;

/**
 * Created by kerwin.liu on 2017/10/13.
 */
@Controller
@RequestMapping("user")
public class TAdminController extends BaseController{
    @Autowired
    private TAdminMapper tAdminMapper;

    @RequestMapping("/")
    public String login1() {
        return "login";
    }
    @RequestMapping("index")
    public String index(HttpServletRequest request, HttpServletResponse response, TAdmin tAdmin) {
        return "index";
    }
    @RequestMapping("login")
    public String login(HttpServletRequest request, HttpServletResponse response, TAdmin tAdmin) {
        HttpSession session = request.getSession();
        TAdmin admin = tAdminMapper.selectByTAdmin(tAdmin);
        if (admin != null) {
            session.setAttribute("user", admin);
            return "index";
        }
        return "login";
    }

    @RequestMapping(value = "home", method = RequestMethod.GET)
    public String home(HttpServletRequest request, HttpServletResponse response) {
        return "home";
    }

    @RequestMapping(value = "loginOut", method = RequestMethod.GET)
    public String loginOut(HttpServletRequest request) {
        HttpSession session = request.getSession();
        session.setAttribute("user", null);
        return "login";
    }

    @RequestMapping(value = "test", method = RequestMethod.GET)
    public void test(HttpServletRequest request, HttpServletResponse response) {

        TAdmin admin = new TAdmin();
        admin.setName("asds");
        admin.setPassword("123");
        List<TAdmin> list=new ArrayList<>();
        TAdmin admin1 = new TAdmin();
        admin1.setName("ddddd");
        admin1.setPassword("3456");
        list.add(admin);
        list.add(admin1);
        writeCommonDataResponse(response, "200", "成功", list);
    }


}
