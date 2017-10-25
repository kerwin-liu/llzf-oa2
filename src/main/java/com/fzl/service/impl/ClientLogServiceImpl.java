package com.fzl.service.impl;

import com.fzl.mapper.ClientLogMapper;
import com.fzl.pojo.ClientLog;
import com.fzl.service.ClientLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by kerwin.liu on 2017/10/25.
 */
@Service
public class ClientLogServiceImpl implements ClientLogService {
    @Autowired
    private ClientLogMapper clientLogMapper;
    @Override
    public List<ClientLog> getAllById(Long id) {
        return clientLogMapper.selectByClientId(id);
    }
}
