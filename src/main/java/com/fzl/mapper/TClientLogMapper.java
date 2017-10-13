package com.fzl.mapper;

import com.fzl.pojo.TClientLog;
import com.fzl.pojo.TClientLogExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface TClientLogMapper {
    int countByExample(TClientLogExample example);

    int deleteByExample(TClientLogExample example);

    int insert(TClientLog record);

    int insertSelective(TClientLog record);

    List<TClientLog> selectByExample(TClientLogExample example);

    int updateByExampleSelective(@Param("record") TClientLog record, @Param("example") TClientLogExample example);

    int updateByExample(@Param("record") TClientLog record, @Param("example") TClientLogExample example);
}