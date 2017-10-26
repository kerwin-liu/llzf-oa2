package com.fzl.controller;

import com.alibaba.fastjson.JSON;
import com.fzl.common.ExcelUtils;
import com.fzl.common.Pages;
import com.fzl.mapper.MemberMapper;
import com.fzl.pojo.Client;
import com.fzl.pojo.Member;
import com.fzl.pojo.Qo.ClientZyQo;
import com.fzl.pojo.Qo.ClientQo;
import com.fzl.pojo.Vo.ClientVo;
import com.fzl.pojo.User;
import com.fzl.service.ClientService;
import com.fzl.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2017/10/24.
 */
@Controller
@RequestMapping("client")
public class ClientController extends BaseController {
    private final String FILEPATH = "D://导入客户模板.xls";
    //private final String UPLOADFILEPATH = "/home/llzf/";
    private final String UPLOADFILEPATH = "D://";
    @Autowired
    private UserService userService;
    @Autowired
    private ClientService clientService;
    @Autowired
    private MemberMapper memberMapper;

    /**
     * 下载模板
     */
    @RequestMapping(value = "download", method = RequestMethod.GET)
    public void download(HttpServletRequest request, HttpServletResponse response) {
        User sessionUser = (User) request.getSession().getAttribute("user");
        Long role = userService.selectRole(sessionUser);
        if (role.compareTo(1L) != 0) {
            writeResponse(response, "400", "该用户无下载模板权限");
            return;
        }
        try {
            ExcelUtils.exportExcel(response, FILEPATH);
        } catch (Exception e) {
            writeResponse(response, "400", "下载失败请重试");
        }
    }

    /**
     * 上传excel文件，并入库
     */
    @RequestMapping(value = "upload", method = RequestMethod.POST)
    public void upload(HttpServletRequest request, HttpServletResponse response, @RequestParam("file") MultipartFile file) {
        User sessionUser = (User) request.getSession().getAttribute("user");
        Long role = userService.selectRole(sessionUser);
        if (role.compareTo(1L) != 0) {
            writeResponse(response, "400", "该用户无上传权限");
            return;
        }
        String filePath = null;
        if (!file.isEmpty()) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd/");
            String datePath = sdf.format(new Date());
            String filename = file.getOriginalFilename();
            filePath = UPLOADFILEPATH + datePath + new Date().getTime() + filename;
            File tempFile = new File(filePath);
            if (!tempFile.exists()) {
                tempFile.mkdirs();
                List<Client> list = new ArrayList<>();
                try {
                    file.transferTo(new File(filePath));
                    list = ExcelUtils.getBatchInvoiceDtoList(filePath, sessionUser.getId());
                } catch (IOException e) {
                    writeResponse(response, "400", "保存失败，请重新上传");
                    return;
                }
                List<Client> listFalse = clientService.saveExcel(list);
                writeCommonDataResponse(response, "200", "保存【" + list.size() + "】条数据，失败【" + listFalse.size() + "】条", listFalse);
            }
        }
    }

    /**
     * 查询客户列表
     */
    @RequestMapping(value = "getList", method = RequestMethod.POST)
    public void getList(HttpServletRequest request, HttpServletResponse response, ClientQo clientQo) {
        User sessionUser = (User) request.getSession().getAttribute("user");
        Long role = userService.selectRole(sessionUser);
        //权限：员工只能查看自己的，主管只能查看本部门的，管理员查看全部的
        if (role.compareTo(3L) == 0) {
            Pages<ClientVo> pages = clientService.selectPagesByMemberId(clientQo, sessionUser.getId());
            writeCommonDataResponse(response, "200", "查询成功", pages);
            return;
        }
        if (role.compareTo(2L) == 0) {
            Pages<ClientVo> pages = clientService.selectPagesByClientVo(clientQo, sessionUser.getId());
            writeCommonDataResponse(response, "200", "查询成功", pages);
            return;
        }
        if (role.compareTo(1L) == 0) {
            Pages<ClientVo> pages = clientService.selectPagesByClientVo(clientQo);
            writeCommonDataResponse(response, "200", "查询成功", pages);
            return;
        }
    }

    /**
     * 保存客户
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    public void save(HttpServletRequest request, HttpServletResponse response, Client client) {
        User sessionUser = (User) request.getSession().getAttribute("user");
        client.setCjrId(sessionUser.getId());
        Member member = memberMapper.queryMemberByuserid(sessionUser.getId());
        client.setMemberId(member.getMemberId());
        boolean save = clientService.saveClient(client);
        if (save) {
            writeResponse(response, "200", "客户添加成功");
            return;
        }
        writeResponse(response, "400", "客户添加失败");
    }

    /**
     * 修改客户
     */
    @RequestMapping(value = "update", method = RequestMethod.POST)
    public void update(HttpServletRequest request, HttpServletResponse response, Client client) {
        boolean update = clientService.updateClient(client);
        if (update) {
            writeResponse(response, "200", "客户修改成功");
            return;
        }
        writeResponse(response, "400", "客户修改失败");
    }

    /**
     * 批量删除客户
     */
    @RequestMapping(value = "batchDelete", method = RequestMethod.POST)
    public void update(HttpServletRequest request, HttpServletResponse response, @RequestParam(value = "ids") String json) {
        User sessionUser = (User) request.getSession().getAttribute("user");
        Long role = userService.selectRole(sessionUser);
        //管理员和主管可以删除客户
        if (role.compareTo(3L) == 0) {
            writeResponse(response, "400", "该用户无删除客户权限");
            return;
        }
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
            clientService.deleteClient(id);
        }
        writeResponse(response, "200", "删除成功");
    }
    /**
     * 批量客户转移
     */
    @RequestMapping(value = "batchZy",method = RequestMethod.POST)
    public void batchZy(HttpServletRequest request, HttpServletResponse response, List<ClientZyQo> qoList) {
        for (ClientZyQo clientCJLXQo : qoList) {
            clientService.batchZy(clientCJLXQo);
        }
        writeResponse(response, "200", "转移成功");
    }
}
