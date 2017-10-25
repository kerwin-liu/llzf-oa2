package com.fzl.service;

import com.fzl.pojo.ClientLog;

import java.util.List;

/**
 * Created by kerwin.liu on 2017/10/25.
 */
public interface ClientLogService {
    List<ClientLog> getAllById(Long id);
}
