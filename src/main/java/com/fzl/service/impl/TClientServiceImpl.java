package com.fzl.service.impl;

import com.fzl.mapper.TClientMapper;
import com.fzl.pojo.TClient;
import com.fzl.service.TClientService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by kerwin.liu on 2017/10/14.
 */
@Service
public class TClientServiceImpl implements TClientService{
    @Autowired
    private TClientMapper tClientLogMapper;
    @Override
    public boolean insertTClient(TClient tClient) {
        return tClientLogMapper.insert(tClient)>0;
    }

    @Override
    public boolean updateTClient(TClient tClient) {
        return tClientLogMapper.updateByPrimaryKey(tClient)>0;
    }
}
