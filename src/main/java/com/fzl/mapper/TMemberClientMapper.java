package com.fzl.mapper;

import com.fzl.pojo.TMemberClient;
import com.fzl.pojo.TMemberClientExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface TMemberClientMapper {
    int countByExample(TMemberClientExample example);

    int deleteByExample(TMemberClientExample example);

    int insert(TMemberClient record);

    int insertSelective(TMemberClient record);

    List<TMemberClient> selectByExample(TMemberClientExample example);

    int updateByExampleSelective(@Param("record") TMemberClient record, @Param("example") TMemberClientExample example);

    int updateByExample(@Param("record") TMemberClient record, @Param("example") TMemberClientExample example);
}