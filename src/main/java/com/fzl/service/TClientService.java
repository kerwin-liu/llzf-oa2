package com.fzl.service;

import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartFile;

import com.fzl.pojo.TClient;

/**
 * Created by kerwin.liu on 2017/10/14.
 */
public interface TClientService {
    boolean insertTClient(TClient tClient);

    boolean updateTClient(TClient tClient);


    /**
     * 查询客户列表用于导出
     * @return 客户列表信息数据
     * @param  clientId前端必须保持一致
     */
    List<TClient> findObjects(List<Integer> clientId);

    /**
     * 导出客户列表
     * @param clientList
     * @param outputStream
     */
    void exportExcel(List<TClient> clientList,ServletOutputStream outputStream);



    /**
     * 导入客户列表
     * @param importFile  导入客户列表的路径
     * @param name        导入的excel的名字
     */
    void importExcel(MultipartFile importFile, String name);



    /**
     * 展示所有客户
     *
     */
    List<TClient> findObjects();




}
