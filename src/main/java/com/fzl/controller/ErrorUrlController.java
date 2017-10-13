package com.fzl.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by kerwin.liu on 2017/10/13.
 */
@Controller
public class ErrorUrlController {
    @RequestMapping("*")
    @ResponseBody
    public String errorUrl(HttpServletRequest request) {
        String servletPath = request.getServletPath();
        System.out.println("servletPath"+servletPath);
        return "{\"msg\":\"not find\"}";
    }
}
