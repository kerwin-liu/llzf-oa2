package com.fzl.controller;

import com.fzl.pojo.ClientLog;
import com.fzl.service.ClientLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * Created by kerwin.liu on 2017/10/25.
 */
@RequestMapping("clientLog")
public class ClientLogController extends BaseController{
    @Autowired
    private ClientLogService clientLogService;

    /**
     * 查询追踪信息
     */
    @RequestMapping(value = "getAll/{id}", method = RequestMethod.POST)
    public void getAll( HttpServletResponse response, @PathVariable Long id) {
        List<ClientLog> list = clientLogService.getAllById(id);
        writeCommonDataResponse(response,"200","查询成功",list);
    }
    /**
     * 批量删除
     */
}
