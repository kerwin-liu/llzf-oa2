package com.fzl.service;

import com.fzl.common.Pages;
import com.fzl.pojo.Member;
import com.fzl.pojo.Qo.MemberQo;

/**
 * Created by Administrator on 2017/10/16.
 */
public interface MemberService {
    boolean saveMember(Member member,Long userId);

    Member queryMemberByNo(String number);

    boolean update(Member member);

    boolean deleteByid(Long memberId);

    Pages<Member> queryMemberByDepartment(MemberQo memberQo, Long id);

    Pages<Member> queryMemberByDepartment(MemberQo memberQo);
}
