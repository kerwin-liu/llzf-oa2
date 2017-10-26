package com.fzl.service.impl;

import com.fzl.common.DateUtils;
import com.fzl.common.ExcelUtils;
import com.fzl.common.Pages;
import com.fzl.mapper.*;
import com.fzl.pojo.Client;
import com.fzl.pojo.Department;
import com.fzl.pojo.Member;
import com.fzl.pojo.Qo.ClientZyQo;
import com.fzl.pojo.Qo.ClientQo;
import com.fzl.pojo.Qo.CountQo;
import com.fzl.pojo.Statistics;
import com.fzl.pojo.Vo.ClientVo;
import com.fzl.service.ClientService;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

/**
 * Created by kerwin.liu on 2017/10/24.
 */
@Service
public class ClientServiceImpl implements ClientService {
    private final SimpleDateFormat FORMAT = new SimpleDateFormat("yyyy-MM-dd");

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
        List<ClientVo> list = clientMapper.selectClientVosByclientQo(clientQo);
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
        List<ClientVo> list = clientMapper.selectClientVosByclientQo(clientQo);
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
        List<ClientVo> list = clientMapper.selectClientVosByclientQo(clientQo);
        Page<ClientVo> page = (Page<ClientVo>) list;
        return new Pages<>(page.getStartRow(), page.getTotal(), page.getPageSize(), list);
    }

    @Override
    public boolean saveClient(Client client) throws Exception {
        return clientMapper.insertSelective(client) > 0;
    }

    @Override
    public boolean updateClient(Client client) throws Exception{
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

    @Override
    public Statistics countTodayByUserId(Long userId) {
        //根据userid查询员工id
        CountQo countQo = new CountQo();
        Member member = memberMapper.queryMemberByuserid(userId);
        countQo.setStart(DateUtils.getDayBegin());
        countQo.setEnd(DateUtils.getDayEnd());
        countQo.setMemberId(member.getMemberId());
        return clientMapper.countTodayByUserId(countQo);
    }

    @Override
    public Statistics countTodayByDepartmentId(Long userId) {
        //根据userid查询部门
        CountQo countQo = new CountQo();
        Department department = departmentMapper.queryDepartmentByUserId(userId);
        countQo.setStart(DateUtils.getDayBegin());
        countQo.setEnd(DateUtils.getDayEnd());
        countQo.setDepartmentId(department.getId());
        return clientMapper.countTodayByDepartmentId(countQo);
    }

    @Override
    public Statistics countToday() {
        CountQo countQo = new CountQo();
        countQo.setStart(DateUtils.getDayBegin());
        countQo.setEnd(DateUtils.getDayEnd());
        return clientMapper.countToday(countQo);
    }

    @Override
    public Statistics countWeekByUserId(Long id) {
        //根据userid查询员工id
        Member member = memberMapper.queryMemberByuserid(id);
        CountQo countQo = new CountQo();
        countQo.setStart(DateUtils.getBeginDayOfWeek());
        countQo.setEnd(DateUtils.getEndDayOfWeek());
        countQo.setMemberId(member.getMemberId());
        return clientMapper.countTodayByUserId(countQo);
    }

    @Override
    public Statistics countWeekByDepartmentId(Long id) {
        //根据userid查询部门
        Department department = departmentMapper.queryDepartmentByUserId(id);
        CountQo countQo = new CountQo();
        countQo.setStart(DateUtils.getBeginDayOfWeek());
        countQo.setEnd(DateUtils.getEndDayOfWeek());
        countQo.setDepartmentId(department.getId());
        return clientMapper.countTodayByDepartmentId(countQo);
    }

    @Override
    public Statistics countWeek() {
        CountQo countQo = new CountQo();
        countQo.setStart(DateUtils.getBeginDayOfWeek());
        countQo.setEnd(DateUtils.getEndDayOfWeek());
        return clientMapper.countToday(countQo);
    }

    @Override
    public List<Statistics> counttodayListByUserId(Long id) {
        CountQo countQo = new CountQo();
        Member member = memberMapper.queryMemberByuserid(id);
        countQo.setStart(DateUtils.getBeginDayOfWeek());
        countQo.setEnd(DateUtils.getEndDayOfWeek());
        countQo.setMemberId(member.getMemberId());
        List<Statistics> khlist = clientMapper.counttodayListByUserIdKh(countQo);
        List<Statistics> zzlist = clientMapper.counttodayListByUserIdZh(countQo);
        return convert(khlist,zzlist);
    }

    @Override
    public List<Statistics> counttodayListByDepartmentId(Long id) {
        CountQo countQo = new CountQo();
        Department department = departmentMapper.queryDepartmentByUserId(id);
        countQo.setStart(DateUtils.getBeginDayOfWeek());
        countQo.setEnd(DateUtils.getEndDayOfWeek());
        countQo.setDepartmentId(department.getId());
        List<Statistics> khlist = clientMapper.counttodayListByUserIdKh(countQo);
        List<Statistics> zzlist = clientMapper.counttodayListByUserIdZh(countQo);
        return convert(khlist,zzlist);
    }

    @Override
    public List<Statistics> counttodayList() {
        CountQo countQo = new CountQo();
        countQo.setStart(DateUtils.getBeginDayOfWeek());
        countQo.setEnd(DateUtils.getEndDayOfWeek());
        List<Statistics> khlist = clientMapper.counttodayListByUserIdKh(countQo);
        List<Statistics> zzlist = clientMapper.counttodayListByUserIdZh(countQo);
        return convert(khlist,zzlist);
    }

    private List<Statistics> convert(List<Statistics> khlist, List<Statistics> zzlist) {
        List<Statistics> list = new ArrayList<>();
        Calendar cal = Calendar.getInstance();
        cal.setTime(DateUtils.getBeginDayOfWeek());
        for (int i = 0; i < 7; i++) {
            cal.add(Calendar.DATE, 1);
            Statistics statistics = new Statistics();
            statistics.setTjrq(FORMAT.format(cal.getTime()));
            statistics.setKhCount(0);
            statistics.setZzCount(0);
            for (Statistics statistics1 : khlist) {
                if (statistics.getTjrq().equals(statistics1.getTjrq())) {
                    statistics.setKhCount(statistics1.getKhCount());
                    break;
                }
            }
            for (Statistics statistics1 : zzlist) {
                if (statistics.getTjrq().equals(statistics1.getTjrq())) {
                    statistics.setZzCount(statistics1.getZzCount());
                    break;
                }
            }

        }
        return list;
    }

}
