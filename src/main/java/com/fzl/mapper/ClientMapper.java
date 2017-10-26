package com.fzl.mapper;

import com.fzl.pojo.Client;
import com.fzl.pojo.Qo.ClientQo;
import com.fzl.pojo.Qo.CountQo;
import com.fzl.pojo.Statistics;
import com.fzl.pojo.Vo.ClientVo;

import java.util.List;

public interface ClientMapper {
    int deleteByPrimaryKey(Long khId);

    int insert(Client record);

    int insertSelective(Client record);

    Client selectByPrimaryKey(Long khId);

    int updateByPrimaryKeySelective(Client record);

    int updateByPrimaryKey(Client record);

    List<ClientVo> selectClientVosByclientQo(ClientQo clientQo);

    Statistics countTodayByUserId(CountQo countQo);

    Statistics countTodayByDepartmentId(CountQo countQo);

    Statistics countToday(CountQo countQo);

    List<Statistics> counttodayListByUserIdKh(CountQo countQo);

    List<Statistics> counttodayListByUserIdZh(CountQo countQo);
}