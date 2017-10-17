package com.fzl.service.impl;

import com.fzl.common.IDUtils;
import com.fzl.mapper.MemberDepartmentMapper;
import com.fzl.mapper.MemberMapper;
import com.fzl.mapper.MemberRoleMapper;
import com.fzl.pojo.Member;
import com.fzl.pojo.MemberDepartment;
import com.fzl.pojo.MemberRole;
import com.fzl.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
    public Member queryMemberByNo(String name) {
        return memberMapper.queryMemberByNo(name);
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
}
