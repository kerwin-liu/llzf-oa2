package com.fzl.controller;

import com.fzl.pojo.User;
import com.fzl.service.UserService;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
public class LoginController extends BaseController {
    private static final Logger LOGGER = LoggerFactory.getLogger(LoginController.class);
    @Autowired
    private UserService userService;

    @RequestMapping("index")
    public String index(HttpServletRequest request, HttpServletResponse response) {
        return "index";
    }

    @RequestMapping("login")
    public String login(HttpServletRequest request, User user) {
        HttpSession session = request.getSession();
        if (StringUtils.isNotEmpty(user.getUserName()) && StringUtils.isNotEmpty(user.getPassword())) {
            User resultUser = userService.selectUser(user);
            if (resultUser != null) {
                session.setAttribute("user", resultUser);
                return "index";
            }
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
        User admin = new User();
        admin.setUserName("asds");
        admin.setPassword("123");
        List<User> list = new ArrayList<>();
        User admin1 = new User();
        admin1.setUserName("ddddd");
        admin1.setPassword("3456");
        list.add(admin);
        list.add(admin1);
        writeCommonDataResponse(response, "200", "成功", list);
    }


}
