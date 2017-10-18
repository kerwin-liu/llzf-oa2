package com.fzl.controller;

import com.fzl.pojo.Qo.TClientQo;
import com.fzl.pojo.TClient;
import com.fzl.service.TClientService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Created by kerwin.liu on 2017/10/14.
 */
@Controller
@RequestMapping("client")
public class TClientController extends BaseController {
    private static final Logger LOGGER = LoggerFactory.getLogger(TClientController.class);
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
    public void getAll(HttpServletRequest request,HttpServletResponse response, TClientQo tClientQo) {
        System.out.println("getAll====");
        // 判断查询条件合法性
        // 分页查询数据
        // 返回json
    }
    /**
     * 保存客户信息
     *
     * @param response
     * @param tClient
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    public void save(HttpServletRequest request, HttpServletResponse response, TClient tClient) {
        // 校验数据格式正确性
        // 通过session获取user信息

        // 如果没有权限增加客户信息则返回
        // 数据入库
        System.err.println(tClient.getName());
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
    public void update(HttpServletRequest request,
                       HttpServletResponse response, TClient tClient) {
        // 校验数据格式正确性
        // 通过session获取user信息
        // 如果没有权限更改客户信息则返回（客户必须在员工名下，主管则是在同一部门下多表联查）
        // 数据入库
        boolean update = tClientService.updateTClient(tClient);
        if (update) {
            writeResponse(response, "200", "数据更新成功");
        } else {
            writeResponse(response, "200", "数据更新失败");
        }
    }
    /**
     * 导出 Excel
     * <p>
     * 逻辑：1 查找用户列表 2 导出
     *
     * @throws IOException
     */

    @RequestMapping(value = "exportExcel")
    public void exportExcel(@RequestParam(name = "id") List<Integer> clientId, HttpServletResponse response) {
        try {
//			注意提醒前段页面必须判断clientId.size是否为0
            // 查找用户列表（多选、单选、全选）
            List<TClient> listTClient = tClientService.findObjects(clientId);
            // 导出
            response.setContentType("application/x-execl");
            response.setHeader("Content-Disposition", "attachment;filename="
                    + new String("客户列表.xls".getBytes(), "ISO-8859-1"));
            ServletOutputStream outputStream = response.getOutputStream();
            tClientService.exportExcel(listTClient, outputStream);
            if (outputStream != null) {
                outputStream.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    /**
     * 导入Excel
     *
     * @param importFile 导入的Excel文件路径
     * @return null ====这里有可能换为列表页面“list”
     */
    @RequestMapping("impExcel")
    @ResponseBody
    public String importFile(MultipartFile importFile) {
        // 获取excel文件 importFile
        if (importFile != null) {
            // 是否为excel文件
            if (importFile.getName().matches("^.+\\.(?i)((xls)|(xlsx))$")) {
                // 2导入
                tClientService.importExcel(importFile, importFile.getName());
            }
        }
        return null;
    }

}