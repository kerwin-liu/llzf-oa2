package com.fzl.service;

import java.io.File;
import java.util.List;

import javax.servlet.ServletOutputStream;

import org.springframework.web.multipart.MultipartFile;

import com.fzl.common.Pages;
import com.fzl.pojo.TClient;
import com.fzl.pojo.TClientLog;
import com.fzl.pojo.Qo.TClientQo;

/**
 * Created by kerwin.liu on 2017/10/14.
 */
public interface TClientService {
	boolean insertTClient(TClient tClient);

	boolean updateTClient(TClient tClient);

	/**
	 * 查询客户列表用于导出
	 * 
	 * @return 客户列表信息数据
	 * @param clientId前端必须保持一致
	 */
	List<TClient> findObjects(List<Integer> clientId);

	/**
	 * 导出客户列表
	 * 
	 * @param clientList
	 * @param outputStream
	 */
	void exportExcel(List<TClient> clientList, ServletOutputStream outputStream);

	/**
	 * 导入客户列表
	 * 
	 * @param importFile
	 *            导入客户列表的路径
	 * @param name
	 *            导入的excel的名字
	 */
	void importExcel(MultipartFile file, String name, Long role, Long id);

	/**
	 * Test==展示所有客户
	 * 
	 */
	List<TClient> findObjects();

	/**
	 * 分页展示客户
	 * 
	 * @param tClientQo
	 *            响应前端对象数据封装
	 * @param id
	 *            根据员工id查询
	 * @return
	 */
	Pages<TClient> queryTClientByMemberId(TClientQo tClientQo, long id);

	/**
	 * 分页展示客户
	 * 
	 * @param tClientQo
	 *            响应前端对象数据封装
	 * @param id
	 *            根据部门id查询
	 * @return
	 */
	Pages<TClient> queryTClientByDepartment(TClientQo tClientQo, Long id);

	/**
	 * 分页展示客户
	 * 
	 * @param tClientQo
	 *            响应前端对象数据封装
	 * @return 管理员查询
	 */
	Pages<TClient> queryTClientByAdmin(TClientQo tClientQo);

	/**
	 * 判断客户的唯一性
	 * 
	 * @param card
	 *            利用身份证检测是否唯一
	 */
	List<TClient> queryTClientByClientCard(String card);

	/**
	 * 保存客户
	 * 
	 * @param client
	 * @param id
	 * @return
	 */
	boolean saveTClient(TClient client, Long id);

	/**
	 * 编辑员工
	 * 
	 * @param client
	 * @return
	 */
	boolean update(TClient client);

	/**
	 * 导出excel专用：根据员工id导出员工下的所有客户
	 * 
	 * @param id
	 * @return
	 */
	List<TClient> findClientListByMemberId(Long id);

	/**
	 * 导出excel专用：根据部门id导出此部门下的所有客户
	 * 
	 * @param id
	 * @return
	 */
	List<TClient> findClientListByDepartmentId(Long id);

	/**
	 * 导出excel专用，管理员导出所有的客户
	 * 
	 * @return
	 */
	List<TClient> findClientListAll();

	
	/**
	 * 删除客户
	 * @param clientId
	 * @return
	 */
	boolean deleteByid(Long clientId);

	
	
	/**
	 * 批量删除客户
	 * @param clientIdList
	 * @return
	 */
	
	boolean deleteByids(List<Long> clientIdList);

	
	

	/**
	 * 根据客戶id查询客户日志
	 * @return 該客戶對應的所有的日誌
	 */
	List<TClientLog> selectClientInfoByClientId(Long id);

	/**
	 * 添加日誌
	 * @param tLog
	 */
	boolean saveClientLog(TClientLog tLog);


	/**
	 * 成交客户-单选
	 * @param id
	 * @return
	 */
	boolean  updatByClientId(Long id);



	/**
	 * 成交客户-多选
	 * @param ids
	 * @return
	 */
	boolean  updatByClientIds(List<Long> ids);


	/**
	 * 展示所有成交客户
	 * @return
	 */
	List<TClient>  queryByIp();


    List<TClient> getSqlMohu(TClientQo tClientQo);
}
