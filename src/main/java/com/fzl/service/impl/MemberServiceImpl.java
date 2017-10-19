package com.fzl.service.impl;

import com.fzl.common.IDUtils;
import com.fzl.common.Pages;
import com.fzl.mapper.DepartmentMapper;
import com.fzl.mapper.MemberDepartmentMapper;
import com.fzl.mapper.MemberMapper;
import com.fzl.mapper.MemberRoleMapper;
import com.fzl.pojo.Department;
import com.fzl.pojo.Member;
import com.fzl.pojo.MemberDepartment;
import com.fzl.pojo.MemberRole;
import com.fzl.pojo.Qo.MemberQo;
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
    public Pages<Member> queryMemberByDepartment(MemberQo memberQo) {
        PageHelper.startPage(memberQo.getPageIndex(), memberQo.getPageSize());
        memberQo.setDepartmentId(null);
        List<Member> list = memberMapper.queryListByCondition(memberQo);
        Page<Member> page = (Page<Member>) list;
        return new Pages<>(page.getStartRow(), page.getTotal(), page.getPageSize(), list);
    }
}
