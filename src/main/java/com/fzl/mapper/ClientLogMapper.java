package com.fzl.mapper;

import com.fzl.pojo.ClientLog;

import java.util.List;

public interface ClientLogMapper {
    int deleteByPrimaryKey(Long zzId);

    int insert(ClientLog record);

    int insertSelective(ClientLog record);

    ClientLog selectByPrimaryKey(Long zzId);

    int updateByPrimaryKeySelective(ClientLog record);

    int updateByPrimaryKey(ClientLog record);

    int deleteByClientId(Long id);

    List<ClientLog> selectByClientId(Long id);
}