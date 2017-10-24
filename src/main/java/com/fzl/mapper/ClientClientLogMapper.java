package com.fzl.mapper;

import com.fzl.pojo.ClientClientLog;

public interface ClientClientLogMapper {
    int deleteByPrimaryKey(Long zzId);

    int insert(ClientClientLog record);

    int insertSelective(ClientClientLog record);

    ClientClientLog selectByPrimaryKey(Long zzId);

    int updateByPrimaryKeySelective(ClientClientLog record);

    int updateByPrimaryKey(ClientClientLog record);
}