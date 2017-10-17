package com.fzl.controller;

import com.fzl.common.Pages;
import com.fzl.pojo.Member;
import com.fzl.pojo.Qo.MemberQo;
import com.fzl.pojo.User;
import com.fzl.service.MemberService;
import com.fzl.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by Administrator on 2017/10/16.
 */
@Controller
@RequestMapping("member")
public class MemberController extends BaseController {
    private static final Logger LOGGER = LoggerFactory.getLogger(MemberController.class);
    @Autowired
    private MemberService memberService;
    @Autowired
    private UserService userService;

    @RequestMapping(value = "index", method = RequestMethod.GET)
    public String index(HttpServletRequest request, HttpServletResponse response, MemberQo memberQo) {
        return "employee-data";
    }
    @RequestMapping(value = "getList", method = RequestMethod.POST)
    public void getList(HttpServletRequest request, HttpServletResponse response, MemberQo memberQo) {
        //权限：员工只能查看自己的，主管只能查看本部门的，管理员查看全部的
        User sessionUser = (User) request.getSession().getAttribute("user");
        Long role = userService.selectRole(sessionUser);
        //管理员和主管可以增加员工 员工级别的不能添加员工
        if (role.compareTo(3L) == 0) {
            Member member = userService.queryMember(sessionUser.getId());
            writeCommonDataResponse(response, "200", "查询成功",member);
            return;
        }
        if(role.compareTo(2L) == 0){
            Pages<Member> pages  = memberService.queryMemberByDepartment(memberQo,sessionUser.getId());
            writeCommonDataResponse(response, "200", "查询成功",pages);
            return;
        }
        if(role.compareTo(1L) == 0){
            Pages<Member> pages  = memberService.queryMemberByDepartment(memberQo);
            writeCommonDataResponse(response, "200", "查询成功",pages);
            return;
        }
    }

    /**
     * 保存员工数据
     *
     * @param request
     * @param response
     * @param member
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    public void save(HttpServletRequest request, HttpServletResponse response, Member member) {
        //校验数据合法性
        //权限判断 1获取user 通过id查询权限
        User sessionUser = (User) request.getSession().getAttribute("user");
        Long role = userService.selectRole(sessionUser);
        //管理员和主管可以增加员工 员工级别的不能添加员工
        if (role.compareTo(3L) == 0) {
            writeResponse(response, "400", "该用户无创建权限");
            return;
        }
        //查询此工号是不是已存在
        Member memberByNo = memberService.queryMemberByNo(member.getName());
        if (memberByNo != null) {
            writeResponse(response, "400", "此工号已使用");
            return;
        }
        boolean save = memberService.saveMember(member, sessionUser.getId());
        if (save) {
            writeResponse(response, "200", "员工添加成功");
            return;
        }
        writeResponse(response, "400", "员工添加失败");
    }

    /**
     * 修改员工信息
     *
     * @param request
     * @param response
     * @param member
     */
    @RequestMapping(value = "update", method = RequestMethod.POST)
    public void update(HttpServletRequest request, HttpServletResponse response, Member member) {
        //权限判断 1获取user 通过id查询权限
        User sessionUser = (User) request.getSession().getAttribute("user");
        Long role = userService.selectRole(sessionUser);
        //管理员和主管可以增加员工 员工级别的不能添加员工
        if (role.compareTo(3L) == 0) {
            writeResponse(response, "400", "该用户无修改权限");
            return;
        }
        boolean update = memberService.update(member);
        if (update) {
            writeResponse(response, "200", "员工修改成功");
            return;
        }
        writeResponse(response, "400", "员工修改失败");
    }

    /**
     * 删除用户
     *
     * @param request
     * @param response
     * @param memberId
     */
    @RequestMapping(value = "delete/{memberId}", method = RequestMethod.POST)
    public void delete(HttpServletRequest request, HttpServletResponse response, @PathVariable Long memberId) {
        User sessionUser = (User) request.getSession().getAttribute("user");
        Long role = userService.selectRole(sessionUser);
        //管理员和主管可以增加员工 员工级别的不能添加员工
        if (role.compareTo(3L) == 0) {
            writeResponse(response, "400", "该用户无删除员工权限");
            return;
        }
        boolean delete = memberService.deleteByid(memberId);
    }
}
