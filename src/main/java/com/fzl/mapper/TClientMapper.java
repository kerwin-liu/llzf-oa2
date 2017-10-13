package com.fzl.mapper;

import com.fzl.pojo.TClient;
import com.fzl.pojo.TClientExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface TClientMapper {
    int countByExample(TClientExample example);

    int deleteByExample(TClientExample example);

    int deleteByPrimaryKey(Integer clientId);

    int insert(TClient record);

    int insertSelective(TClient record);

    List<TClient> selectByExample(TClientExample example);

    TClient selectByPrimaryKey(Integer clientId);

    int updateByExampleSelective(@Param("record") TClient record, @Param("example") TClientExample example);

    int updateByExample(@Param("record") TClient record, @Param("example") TClientExample example);

    int updateByPrimaryKeySelective(TClient record);

    int updateByPrimaryKey(TClient record);
}