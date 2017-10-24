package com.fzl.service;

import com.fzl.pojo.Client;

import java.util.List;

/**
 * Created by kerwin.liu on 2017/10/24.
 */
public interface ClientService {
    List<Client> saveExcel(List<Client> list);
}
