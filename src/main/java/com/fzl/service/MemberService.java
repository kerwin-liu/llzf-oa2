package com.fzl.service;

import com.fzl.pojo.Member;

/**
 * Created by Administrator on 2017/10/16.
 */
public interface MemberService {
    boolean saveMember(Member member,Integer userId);

    Member queryMemberByNo(String name);

    boolean update(Member member);

    boolean deleteByid(Integer memberId);
}
