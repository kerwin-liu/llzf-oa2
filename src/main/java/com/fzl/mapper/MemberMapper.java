package com.fzl.mapper;

import com.fzl.common.Pages;
import com.fzl.pojo.Member;
import com.fzl.pojo.Qo.MemberQo;
import com.fzl.pojo.Vo.MemberVo;

import java.util.List;

public interface MemberMapper {
    int deleteByPrimaryKey(Long memberId);

    int insert(Member record);

    int insertSelective(Member record);

    Member selectByPrimaryKey(Long memberId);

    int updateByPrimaryKeySelective(Member record);

    int updateByPrimaryKey(Member record);

    Member queryMemberByuserid(Long id);

    Member queryMemberByNo(String number);

    List<Member> queryListByCondition(MemberQo memberQo);

    int countClient(Long memberId);

    MemberVo queryMemberVoByuserid(Long id);

    List<MemberVo> queryVoListByCondition(MemberQo memberQo);
}