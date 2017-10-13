package com.fzl.mapper;

import com.fzl.pojo.TAdminMember;
import com.fzl.pojo.TAdminMemberExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface TAdminMemberMapper {
    int countByExample(TAdminMemberExample example);

    int deleteByExample(TAdminMemberExample example);

    int insert(TAdminMember record);

    int insertSelective(TAdminMember record);

    List<TAdminMember> selectByExample(TAdminMemberExample example);

    int updateByExampleSelective(@Param("record") TAdminMember record, @Param("example") TAdminMemberExample example);

    int updateByExample(@Param("record") TAdminMember record, @Param("example") TAdminMemberExample example);
}