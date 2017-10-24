package com.fzl.service.impl;

import com.fzl.mapper.ClientMapper;
import com.fzl.pojo.Client;
import com.fzl.service.ClientService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by kerwin.liu on 2017/10/24.
 */
@Service
public class ClientServiceImpl implements ClientService{
    @Autowired
    private ClientMapper clientMapper;
    @Override
    public List<Client> saveExcel(List<Client> list) {
        List<Client> listFalse = new ArrayList<>();
        for (Client client : list) {
            try {
                int i = clientMapper.insertSelective(client);
            }catch (Exception e){
                listFalse.add(client);
            }
        }
        return listFalse;
    }
}
