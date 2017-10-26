package com.fzl.service.impl;

import com.fzl.common.Pages;
import com.fzl.mapper.*;
import com.fzl.pojo.Client;
import com.fzl.pojo.Department;
import com.fzl.pojo.Member;
import com.fzl.pojo.Qo.ClientZyQo;
import com.fzl.pojo.Qo.ClientQo;
import com.fzl.pojo.Vo.ClientVo;
import com.fzl.service.ClientService;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by kerwin.liu on 2017/10/24.
 */
@Service
public class ClientServiceImpl implements ClientService {
    @Autowired
    private ClientMapper clientMapper;
    @Autowired
    private MemberMapper memberMapper;
    @Autowired
    private DepartmentMapper departmentMapper;
    @Autowired
    private ClientLogMapper clientLogMapper;
    @Autowired
    private ClientMemberMapper clientMemberMapper;

    @Override
    public List<Client> saveExcel(List<Client> list) {
        List<Client> listFalse = new ArrayList<>();
        for (Client client : list) {
            try {
                int i = clientMapper.insertSelective(client);
            } catch (Exception e) {
                listFalse.add(client);
            }
        }
        return listFalse;
    }

    @Override
    public Pages<ClientVo> selectPagesByClientVo(ClientQo clientQo) {
        //管理员权限，查询所有
        PageHelper.startPage(clientQo.getPageIndex(), clientQo.getPageSize());
        List<ClientVo> list = clientMapper.selectClientVosByclientVo(clientQo);
        Page<ClientVo> page = (Page<ClientVo>) list;
        return new Pages<>(page.getStartRow(), page.getTotal(), page.getPageSize(), list);
    }

    @Override
    public Pages<ClientVo> selectPagesByMemberId(ClientQo clientQo, Long userId) {
        //仅仅查询自己名下的客户
        PageHelper.startPage(clientQo.getPageIndex(), clientQo.getPageSize());
        //查询用户的员工号
        Member member = memberMapper.queryMemberByuserid(userId);
        clientQo.setMemberId(member.getMemberId());
        List<ClientVo> list = clientMapper.selectClientVosByclientVo(clientQo);
        Page<ClientVo> page = (Page<ClientVo>) list;
        return new Pages<>(page.getStartRow(), page.getTotal(), page.getPageSize(), list);
    }

    @Override
    public Pages<ClientVo> selectPagesByClientVo(ClientQo clientQo, Long userId) {
        //仅仅查询自己部门的客户
        PageHelper.startPage(clientQo.getPageIndex(), clientQo.getPageSize());
        //查询主管的部门号
        Department department = departmentMapper.queryDepartmentByUserId(userId);
        clientQo.setDepartmentId(department.getId());
        List<ClientVo> list = clientMapper.selectClientVosByclientVo(clientQo);
        Page<ClientVo> page = (Page<ClientVo>) list;
        return new Pages<>(page.getStartRow(), page.getTotal(), page.getPageSize(), list);
    }

    @Override
    public boolean saveClient(Client client) {
        return clientMapper.insertSelective(client) > 0;
    }

    @Override
    public boolean updateClient(Client client) {
        return clientMapper.updateByPrimaryKeySelective(client) > 0;
    }

    @Override
    public boolean deleteClient(Long id) {
        //删除该客户所有的追踪数据
        int deleteLog = clientLogMapper.deleteByClientId(id);
        //删除客户员工关联表
        int i = clientMemberMapper.deleteByPrimaryKey(id);
        //删除客户表
        int i1 = clientMapper.deleteByPrimaryKey(id);
        if (i > 0 && i1 > 0) {
            return true;
        } else {
            return false;
        }
    }

    @Override
    public void batchZy(ClientZyQo clientCJLXQo) {
        Client client = new Client();
        client.setMemberId(clientCJLXQo.getMemberId());
        client.setKhId(clientCJLXQo.getClientId());
        client.setByzd("1");
        clientMapper.updateByPrimaryKeySelective(client);
    }
}
