package com.fzl.service;

import com.fzl.common.Pages;
import com.fzl.pojo.Member;
import com.fzl.pojo.Qo.MemberQo;
import com.fzl.pojo.Vo.MemberVo;

import java.util.List;

/**
 * Created by Administrator on 2017/10/16.
 */
public interface MemberService {
    boolean saveMember(Member member,Long userId);

    Member queryMemberByNo(String number);

    boolean update(Member member);

    boolean deleteByid(Long memberId);

    Pages<Member> queryMemberByDepartment(MemberQo memberQo, Long id);
    List<Member> queryMemberByDepartmentALl(MemberQo memberQo, Long id);
    Pages<Member> queryMemberByDepartment(MemberQo memberQo);
    List<Member> queryMemberByDepartmentAll(MemberQo memberQo);

    int countClient(Long memberId);

    Pages<MemberVo> queryMemberVoByDepartment(MemberQo memberQo, Long id);
    Pages<MemberVo> queryMemberVoByDepartment(MemberQo memberQo);

    Member queryMemberByMemberId(Long memberId);
}
