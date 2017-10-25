package com.fzl.mapper;

import com.fzl.pojo.Client;

public interface ClientMapper {
    int deleteByPrimaryKey(Long khId);

    int insert(Client record);

    int insertSelective(Client record);

    Client selectByPrimaryKey(Long khId);

    int updateByPrimaryKeySelective(Client record);

    int updateByPrimaryKey(Client record);
}