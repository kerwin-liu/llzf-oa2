package com.fzl.controller;

import com.alibaba.fastjson.JSON;
import com.fzl.common.IDUtils;
import com.fzl.mapper.ClientLogMapper;
import com.fzl.mapper.ClientMapper;
import com.fzl.pojo.Client;
import com.fzl.pojo.ClientLog;
import com.fzl.pojo.ClientMember;
import com.fzl.pojo.Qo.ClientLogQo;
import com.fzl.service.ClientLogService;
import org.apache.poi.ss.formula.functions.Now;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.List;

/**
 * Created by kerwin.liu on 2017/10/25.
 */
@Controller
@RequestMapping("clientLog")
public class ClientLogController extends BaseController {
    @Autowired
    private ClientLogService clientLogService;
    @Autowired
    private ClientLogMapper clientLogMapper;
    @Autowired
    private ClientMapper clientMapper;
    /**
     * 查询追踪信息
     */
    @RequestMapping(value = "getAll/{id}", method = RequestMethod.POST)
    public void getAll(HttpServletResponse response, @PathVariable Long id) {
        List<ClientLog> list = clientLogService.getAllById(id);
        writeCommonDataResponse(response, "200", "查询成功", list);
    }

    /**
     * 批量删除
     */
    @RequestMapping(value = "batchDelete", method = RequestMethod.POST)
    public void batchDelete(HttpServletResponse response, @RequestParam(value = "ids") String json) {
        List<Long> ids = null;
        try {
            ids = (List<Long>) JSON.parse(json);
        } catch (Exception e) {
            writeResponse(response, "400", "json格式不合法");
            return;
        }
        if (ids == null) {
            writeResponse(response, "400", "删除内容为空");
            return;
        }
        for (Long id : ids) {
            clientLogService.deleteClientLog(id);
        }
        writeResponse(response, "200", "删除成功");
    }

    /**
     * 全部删除
     */
    @RequestMapping(value = "deleteAll/{clientId}", method = RequestMethod.POST)
    public void deleteAll(HttpServletResponse response, @PathVariable Long clientId) {
        clientLogService.deleteAllClientLog(clientId);
        writeResponse(response, "200", "删除成功");
    }

    /**
     * 增加追踪日志
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    public void save(HttpServletResponse response, ClientLogQo clientLogQo) {
        ClientLog clientLog = new ClientLog();
        clientLog.setZzId(IDUtils.getId());
        clientLog.setKhId(clientLogQo.getKhId());
        clientLog.setZznr(clientLogQo.getZznr());
        clientLogMapper.insertSelective(clientLog);
        //khcjlx 客户成交类型是1 保存的同时修改客户成交类型 byzd 1是新转移的客户 修改转移类型
        if ("1".equals(clientLogQo.getKhcjlx())||"1".equals(clientLogQo.getByzd())) {
            Client client = new Client();
            client.setKhId(clientLogQo.getKhId());
            client.setKhcjlx(clientLogQo.getKhcjlx());
            if("1".equals(clientLogQo.getKhcjlx())){
                client.setCjsj(new Date());
            }
            client.setByzd(clientLogQo.getByzd());
            clientMapper.updateByPrimaryKeySelective(client);
        }
        writeResponse(response, "200", "新增追踪信息成功");
    }
}
