package com.fzl.controller;

import com.fzl.pojo.Qo.TClientQo;
import com.fzl.pojo.TAdmin;
import com.fzl.pojo.TClient;
import com.fzl.service.TClientService;
import org.apache.http.HttpRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by kerwin.liu on 2017/10/14.
 */
@Controller
@RequestMapping("client")
public class TClientController extends BaseController {
    private static final Logger LOGGER = LoggerFactory.getLogger(TAdminController.class);
    @Autowired
    private TClientService tClientService;

    /**
     * 分页查询
     *
     * @param request
     * @param response
     * @param tClientQo
     */
    @RequestMapping(value = "getAll", method = RequestMethod.GET)
    public void getAll(HttpServletRequest request, HttpServletResponse response, TClientQo tClientQo) {
//判断查询条件合法性
        //分页查询数据
        //返回json
    }

    /**
     * 保存客户信息
     *
     * @param response
     * @param tClient
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    public void save(HttpServletRequest request, HttpServletResponse response, TClient tClient) {
        //校验数据格式正确性
        //通过session获取user信息
        TAdmin user = (TAdmin) request.getSession().getAttribute("user");
        //如果没有权限增加客户信息则返回
        //数据入库
        boolean insert = tClientService.insertTClient(tClient);
        if (insert) {
            writeResponse(response, "200", "数据保存成功");
        } else {
            writeResponse(response, "200", "数据保存失败");
        }
    }

    /**
     * 修改客户信息
     *
     * @param response
     * @param tClient
     */
    @RequestMapping(value = "update", method = RequestMethod.POST)
    public void update(HttpServletRequest request, HttpServletResponse response, TClient tClient) {
        //校验数据格式正确性
        //通过session获取user信息
        TAdmin user = (TAdmin) request.getSession().getAttribute("user");
        //如果没有权限更改客户信息则返回（客户必须在员工名下，主管则是在同一部门下多表联查）
        //数据入库
        boolean update = tClientService.updateTClient(tClient);
        if (update) {
            writeResponse(response, "200", "数据更新成功");
        } else {
            writeResponse(response, "200", "数据更新失败");
        }
    }
}
