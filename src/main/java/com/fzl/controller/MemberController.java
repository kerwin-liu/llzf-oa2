package com.fzl.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.fzl.common.Pages;
import com.fzl.pojo.Member;
import com.fzl.pojo.Qo.MemberQo;
import com.fzl.pojo.User;
import com.fzl.pojo.Vo.BatchDeleteVo;
import com.fzl.pojo.Vo.MemberVo;
import com.fzl.service.MemberService;
import com.fzl.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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
            MemberVo memberVo = userService.queryMemberVo(sessionUser.getId());
            writeCommonDataResponse(response, "200", "查询成功", memberVo);
            return;
        }
        if (role.compareTo(2L) == 0) {
            Pages<MemberVo> pages = memberService.queryMemberVoByDepartment(memberQo, sessionUser.getId());
            writeCommonDataResponse(response, "200", "查询成功", pages);
            return;
        }
        if (role.compareTo(1L) == 0) {
            Pages<MemberVo> pages = memberService.queryMemberVoByDepartment(memberQo);
            writeCommonDataResponse(response, "200", "查询成功", pages);
            return;
        }
    }

    @RequestMapping(value = "getAll", method = RequestMethod.POST)
    public void getAll(HttpServletRequest request, HttpServletResponse response, MemberQo memberQo) {
        //权限：员工只能查看自己的，主管只能查看本部门的，管理员查看全部的
        User sessionUser = (User) request.getSession().getAttribute("user");
        Long role = userService.selectRole(sessionUser);
        //管理员和主管可以增加员工 员工级别的不能添加员工
        if (role.compareTo(3L) == 0) {
            Member member = userService.queryMember(sessionUser.getId());
            writeCommonDataResponse(response, "200", "查询成功", member);
            return;
        }
        if (role.compareTo(2L) == 0) {
            List<Member> members = memberService.queryMemberByDepartmentALl(memberQo, sessionUser.getId());
            writeCommonDataResponse(response, "200", "查询成功", members);
            return;
        }
        if (role.compareTo(1L) == 0) {
            List<Member> members = memberService.queryMemberByDepartmentAll(memberQo);
            writeCommonDataResponse(response, "200", "查询成功", members);
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
        Member memberByNo = memberService.queryMemberByNo(member.getNumber());
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
    public void update(HttpServletRequest request, HttpServletResponse response, Member member, Long id) {
        //权限判断 1获取user 通过id查询权限
        User sessionUser = (User) request.getSession().getAttribute("user");
        Long role = userService.selectRole(sessionUser);
        //管理员和主管可以增加员工 员工级别的不能添加员工
        member.setMemberId(id);
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
     * 删除员工
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
        //查询员工下边是不是有客户
        int a = memberService.countClient(memberId);
        if (a > 0) {
            writeResponse(response, "400", "该员工下还有" + a + "个客户");
            return;
        }
        boolean delete = memberService.deleteByid(memberId);
        writeResponse(response, "200", "删除成功");
    }

    @RequestMapping(value = "batchDelete", method = RequestMethod.POST)
    public void batchDelete(HttpServletRequest request, HttpServletResponse response, @RequestBody String json) {
        User sessionUser = (User) request.getSession().getAttribute("user");
        Long role = userService.selectRole(sessionUser);
        //管理员和主管可以增加员工 员工级别的不能添加员工
        if (role.compareTo(3L) == 0) {
            writeResponse(response, "400", "该用户无删除员工权限");
            return;
        }

        Map<String, Object> map = null;
        try {
            map = (Map<String, Object>) JSON.parse(json);
        } catch (Exception e) {
            writeResponse(response, "400", "json格式不合法");
            return;
        }
        List<String> ids = (List<String>) map.get("ids");
        if (ids == null) {
            writeResponse(response, "400", "删除内容为空");
            return;
        }
        List<BatchDeleteVo> listfalse = new ArrayList<>();
        BatchDeleteVo batchDeleteVo = null;
        for (String id : ids) {
            Long memberId = Long.valueOf(id);
            //查询员工下边是不是有客户
            int a = memberService.countClient(memberId);
            if (a > 0) {
                batchDeleteVo = new BatchDeleteVo();
                Member member = memberService.queryMemberByMemberId(memberId);
                batchDeleteVo.setId(id);
                batchDeleteVo.setName(member.getName());
                batchDeleteVo.setError("该员工名下还存在客户，请确认");
                listfalse.add(batchDeleteVo);
            } else {
                boolean delete = memberService.deleteByid(memberId);
                if (!delete) {
                    batchDeleteVo = new BatchDeleteVo();
                    Member member = memberService.queryMemberByMemberId(memberId);
                    batchDeleteVo.setId(id);
                    batchDeleteVo.setName(member.getName());
                    batchDeleteVo.setError("该员工删除失败，原因未知");
                    listfalse.add(batchDeleteVo);
                }
            }

        }
        writeCommonDataResponse(response,"200","删除【"+ids.size()+"】名员工，失败【"+listfalse.size()+"】名",listfalse);
    }
}
