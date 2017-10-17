package com.fzl.controller;

import com.fzl.service.CustomerService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by liujingtao on 2017/10/17.
 */
@Controller
@RequestMapping("customerController")
public class CustomerController  extends BaseController{
    private static final Logger LOGGER = LoggerFactory.getLogger(CustomerController.class);

    @Autowired
    private CustomerService CustomerService;

    @RequestMapping(value = "customer",method = RequestMethod.GET)
    public String customer(){
        System.err.println("999");
        return "Customer-data";
    }
}
