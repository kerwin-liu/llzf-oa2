package com.fzl.service;

import com.fzl.common.Pages;
import com.fzl.pojo.Client;
import com.fzl.pojo.Qo.ClientZyQo;
import com.fzl.pojo.Qo.ClientQo;
import com.fzl.pojo.Vo.ClientVo;

import java.util.List;

/**
 * Created by kerwin.liu on 2017/10/24.
 */
public interface ClientService {
    List<Client> saveExcel(List<Client> list);

    Pages<ClientVo> selectPagesByClientVo(ClientQo clientQo);

    Pages<ClientVo> selectPagesByMemberId(ClientQo clientQo,Long userId);

    Pages<ClientVo> selectPagesByClientVo(ClientQo clientQo, Long userId);

    boolean saveClient(Client client);

    boolean updateClient(Client client);

    boolean deleteClient(Long id);

    void batchZy(ClientZyQo clientCJLXQo);
}
