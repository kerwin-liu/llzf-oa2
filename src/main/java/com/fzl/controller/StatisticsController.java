package com.fzl.controller;

import com.fzl.common.DateUtils;
import com.fzl.pojo.Statistics;
import com.fzl.pojo.User;
import com.fzl.service.ClientService;
import com.fzl.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import sun.org.mozilla.javascript.internal.ast.NewExpression;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2017/10/26.
 */
@Controller
@RequestMapping("statistics")
public class StatisticsController extends BaseController {
    private final SimpleDateFormat FORMAT = new SimpleDateFormat("yyyy-MM-dd");
    @Autowired
    private UserService userService;
    @Autowired
    private ClientService clientService;

    /**
     * 当天新增客户 和新增追踪信息条数
     */
    @RequestMapping("today")
    public void today(HttpServletRequest request, HttpServletResponse response) {
        User sessionUser = (User) request.getSession().getAttribute("user");
        Long role = userService.selectRole(sessionUser);
        //权限：员工只能查看自己的，主管只能查看本部门的，管理员查看全部的
        Statistics statistics = new Statistics();
        if (role.compareTo(3L) == 0) {
            statistics = clientService.countTodayByUserId(sessionUser.getId());
            statistics.setTjrq(FORMAT.format(new Date()));
            writeCommonDataResponse(response, "200", "查询成功", statistics);
            return;
        }
        if (role.compareTo(2L) == 0) {
            statistics = clientService.countTodayByDepartmentId(sessionUser.getId());
            statistics.setTjrq(FORMAT.format(new Date()));
            writeCommonDataResponse(response, "200", "查询成功", statistics);
            return;
        }
        if (role.compareTo(1L) == 0) {
            statistics = clientService.countToday();
            statistics.setTjrq(FORMAT.format(new Date()));
            writeCommonDataResponse(response, "200", "查询成功", statistics);
            return;
        }
    }

    /**
     * 查询一个星期的新增总数
     */
    @RequestMapping("week")
    public void week(HttpServletRequest request, HttpServletResponse response) {
        User sessionUser = (User) request.getSession().getAttribute("user");
        Long role = userService.selectRole(sessionUser);
        //权限：员工只能查看自己的，主管只能查看本部门的，管理员查看全部的
        Statistics statistics = new Statistics();
        if (role.compareTo(3L) == 0) {
            statistics = clientService.countWeekByUserId(sessionUser.getId());
            statistics.setTjrq(FORMAT.format(new Date()));
            writeCommonDataResponse(response, "200", "查询成功", statistics);
            return;
        }
        if (role.compareTo(2L) == 0) {
            statistics = clientService.countWeekByDepartmentId(sessionUser.getId());
            statistics.setTjrq(FORMAT.format(new Date()));
            writeCommonDataResponse(response, "200", "查询成功", statistics);
            return;
        }
        if (role.compareTo(1L) == 0) {
            statistics = clientService.countWeek();
            statistics.setTjrq(FORMAT.format(new Date()));
            writeCommonDataResponse(response, "200", "查询成功", statistics);
            return;
        }
    }
    /**
     * 查询一个星期内每天的数据
     */
    @RequestMapping("todayList")
    public void todayList(HttpServletRequest request, HttpServletResponse response) {
        User sessionUser = (User) request.getSession().getAttribute("user");
        Long role = userService.selectRole(sessionUser);
        //权限：员工只能查看自己的，主管只能查看本部门的，管理员查看全部的
        List<Statistics> list= new ArrayList<>();
        if (role.compareTo(3L) == 0) {
            list = clientService.counttodayListByUserId(sessionUser.getId());
            writeCommonDataResponse(response, "200", "查询成功", list);
            return;
        }
        if (role.compareTo(2L) == 0) {
            list = clientService.counttodayListByDepartmentId(sessionUser.getId());
            writeCommonDataResponse(response, "200", "查询成功", list);
            return;
        }
        if (role.compareTo(1L) == 0) {
            list = clientService.counttodayList();
            writeCommonDataResponse(response, "200", "查询成功", list);
            return;
        }
    }
}
