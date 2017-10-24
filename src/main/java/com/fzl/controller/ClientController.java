package com.fzl.controller;

import com.fzl.common.ExcelUtils;
import com.fzl.common.IDUtils;
import com.fzl.pojo.Client;
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
    private final String FILEPATH = "/home/llzf/.xlsx";
    private final String UPLOADFILEPATH = "/home/llzf/";
    @Autowired
    private UserService userService;
    @Autowired
    private ClientService clientService;

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

                writeCommonDataResponse(response, "200", "保存【"+list.size()+"】条数据，失败【"+listFalse.size()+"】条",listFalse);
            }
        }
    }
}
