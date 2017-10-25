package com.fzl.service.impl;

import com.fzl.common.IDUtils;
import com.fzl.common.Pages;
import com.fzl.mapper.*;
import com.fzl.pojo.*;
import com.fzl.pojo.Qo.MemberQo;
import com.fzl.pojo.Vo.MemberVo;
import com.fzl.service.MemberService;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by Administrator on 2017/10/16.
 */
@Service
public class MemberServiceImpl implements MemberService {
    @Autowired
    private MemberMapper memberMapper;
    @Autowired
    private MemberRoleMapper memberRoleMapper;
    @Autowired
    private MemberDepartmentMapper memberDepartmentMapper;
    @Autowired
    private DepartmentMapper departmentMapper;
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private UserMemberMapper userMemberMapper;

    @Override
    public boolean saveMember(Member member, Long UserId) {
        //保存员工表
        member.setMemberId(IDUtils.getId());
        member.setCreatUserId(UserId);
        int i = memberMapper.insertSelective(member);
        //保存部门表
        MemberDepartment memberDepartment = new MemberDepartment();
        memberDepartment.setMemberId(member.getMemberId());
        memberDepartment.setDepartmentId(member.getGroups());
        int i2 = memberDepartmentMapper.insertSelective(memberDepartment);
        //保存权限表
        MemberRole memberRole = new MemberRole();
        memberRole.setMemberId(member.getMemberId());
        memberRole.setRoleId(member.getPermissions());
        int i1 = memberRoleMapper.insertSelective(memberRole);
        if (i > 0 && i2 > 0 && i1 > 0) {
            return true;
        }
        return false;
    }

    @Override
    public Member queryMemberByNo(String number) {
        return memberMapper.queryMemberByNo(number);
    }

    @Override
    public boolean update(Member member) {
        //更新员工信息
        int i = memberMapper.updateByPrimaryKeySelective(member);
        //更新员工权限信息
        MemberDepartment memberDepartment = new MemberDepartment();
        memberDepartment.setMemberId(member.getMemberId());
        memberDepartment.setDepartmentId(member.getGroups());
        int i2 = memberDepartmentMapper.updateByPrimaryKeySelective(memberDepartment);
        //保存权限表
        MemberRole memberRole = new MemberRole();
        memberRole.setMemberId(member.getMemberId());
        memberRole.setRoleId(member.getPermissions());
        int i1 = memberRoleMapper.updateByPrimaryKeySelective(memberRole);
        if (i > 0 && i2 > 0 && i1 > 0) {
            return true;
        }
        return false;
    }

    @Override
    public boolean deleteByid(Long memberId) {
        memberMapper.deleteByPrimaryKey(memberId);
        memberDepartmentMapper.deleteByPrimaryKey(memberId);
        memberRoleMapper.deleteByPrimaryKey(memberId);
        //删除对应用户
        User user = userMapper.selectUserbyMemberID(memberId);
        if(user!=null){
            userMemberMapper.deleteByPrimaryKey(user.getId());
            userMapper.deleteByPrimaryKey(user.getId());
        }
        return true;
    }

    @Override
    public Pages<Member> queryMemberByDepartment(MemberQo memberQo, Long id) {
        PageHelper.startPage(memberQo.getPageIndex(), memberQo.getPageSize());
        //通过userid查部门
       Department department= departmentMapper.queryDepartmentByUserId(id);
        memberQo.setDepartmentId(department.getId());
        List<Member> list = memberMapper.queryListByCondition(memberQo);
        Page<Member> page = (Page<Member>) list;
        return new Pages<>(page.getStartRow(), page.getTotal(), page.getPageSize(), list);
    }

    @Override
    public List<Member> queryMemberByDepartmentALl(MemberQo memberQo, Long id) {
        Department department= departmentMapper.queryDepartmentByUserId(id);
        memberQo.setDepartmentId(department.getId());
        return memberMapper.queryListByCondition(memberQo);
    }

    @Override
    public List<Member> queryMemberByDepartmentAll(MemberQo memberQo) {
        memberQo.setDepartmentId(null);
        return memberMapper.queryListByCondition(memberQo);
    }

    @Override
    public Pages<Member> queryMemberByDepartment(MemberQo memberQo) {
        PageHelper.startPage(memberQo.getPageIndex(), memberQo.getPageSize());
        memberQo.setDepartmentId(null);
        List<Member> list = memberMapper.queryListByCondition(memberQo);
        Page<Member> page = (Page<Member>) list;
        return new Pages<>(page.getStartRow(), page.getTotal(), page.getPageSize(), list);
    }

    @Override
    public int countClient(Long memberId) {
        return memberMapper.countClient(memberId);
    }

    @Override
    public Pages<MemberVo> queryMemberVoByDepartment(MemberQo memberQo, Long id) {
        PageHelper.startPage(memberQo.getPageIndex(), memberQo.getPageSize());
        //通过userid查部门
        Department department= departmentMapper.queryDepartmentByUserId(id);
        memberQo.setDepartmentId(department.getId());
        List<MemberVo> list = memberMapper.queryVoListByCondition(memberQo);
        Page<MemberVo> page = (Page<MemberVo>) list;
        return new Pages<>(page.getStartRow(), page.getTotal(), page.getPageSize(), list);
    }
    public Pages<MemberVo> queryMemberVoByDepartment(MemberQo memberQo) {
        PageHelper.startPage(memberQo.getPageIndex(), memberQo.getPageSize());
        memberQo.setDepartmentId(null);
        List<MemberVo> list = memberMapper.queryVoListByCondition(memberQo);
        Page<MemberVo> page = (Page<MemberVo>) list;
        return new Pages<>(page.getStartRow(), page.getTotal(), page.getPageSize(), list);
    }

    @Override
    public Member queryMemberByMemberId(Long memberId) {
        return memberMapper.selectByPrimaryKey(memberId);
    }
}
