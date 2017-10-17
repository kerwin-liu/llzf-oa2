package com.fzl.service.impl;

import com.fzl.service.CustomerService;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by liujingtao on 2017/10/17.
 */
@Service
public class CustomerServiceImpl implements CustomerService {

    @Override
    public ModelAndView customer() {
        return new ModelAndView("Customer-data");
    }
}
