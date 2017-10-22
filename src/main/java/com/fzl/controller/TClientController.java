package com.fzl.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fzl.common.Pages;
import com.fzl.pojo.TClient;
import com.fzl.pojo.TClientLog;
import com.fzl.pojo.User;
import com.fzl.pojo.Qo.TClientQo;
import com.fzl.service.TClientService;
import com.fzl.service.UserService;

/**
 * /customerController/ss
 *  Created by kerwin.liu on 2017/10/14.
 */
@Controller
@RequestMapping("client")
public class TClientController extends BaseController {
	private static final Logger LOGGER = LoggerFactory
			.getLogger(TClientController.class);
	@Autowired
	private TClientService tClientService;

	@Autowired
	private UserService userService;





	/**
	 * 导出 Excel
	 * <p>
	 * 逻辑：1 查找用户列表 2 导出
	 * 
	 * @throws IOException
	 */

	@RequestMapping(value = "exportExcel")
	public void exportExcel(HttpServletRequest request,
			HttpServletResponse response) {
   try {
		System.out.println("====exportExcel");
		User sessionUser = (User) request.getSession().getAttribute("user");
		Long role = userService.selectRole(sessionUser);
		Long id = sessionUser.getId();
		
		// 判断是否为员工
				if (role.compareTo(3L) == 0) {
					
					
					// 查找用户列表（多选、单选、全选）
					List<TClient> listTClient = tClientService.findClientListByMemberId(id);
					// 导出
					response.setContentType("application/x-execl");
					response.setHeader("Content-Disposition", "attachment;filename="
							+ new String("客户列表.xls".getBytes(), "ISO-8859-1"));
					ServletOutputStream outputStream = response.getOutputStream();
//					response.getOutputStream()
					tClientService.exportExcel(listTClient, outputStream);
					if (outputStream != null) {
						outputStream.close();
					}
					
					 return ;
				}

				// 判断是否为主管

				if (role.compareTo(2L) == 0) {
					
					// 查找用户列表（多选、单选、全选）
					List<TClient> listTClient = tClientService.findClientListByDepartmentId(id);
					// 导出
					response.setContentType("application/x-execl");
					response.setHeader("Content-Disposition", "attachment;filename="
							+ new String("客户列表.xls".getBytes(), "ISO-8859-1"));
					ServletOutputStream outputStream = response.getOutputStream();
					tClientService.exportExcel(listTClient, outputStream);
					if (outputStream != null) {
						outputStream.close();
					}
					
					 return ;

				}
		        //判断是否为管理员
				if (role.compareTo(1L) == 0) {

					
					// 查找用户列表（多选、单选、全选）
					List<TClient> listTClient = tClientService.findClientListAll();
					// 导出
					response.setContentType("application/x-execl");
					response.setHeader("Content-Disposition", "attachment;filename="
							+ new String("客户列表.xls".getBytes(), "ISO-8859-1"));
					ServletOutputStream outputStream = response.getOutputStream();
					tClientService.exportExcel(listTClient, outputStream);
					if (outputStream != null) {
						outputStream.close();
					}
					
					 return ;

				}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 导入Excel
	 *
	 *            导入的Excel文件路径
	 * @return null ====这里有可能换为列表页面“list”
	 */
	@RequestMapping(value = "importExcel" , method = RequestMethod.POST)
	public void importFile(HttpServletRequest request,HttpServletResponse response,MultipartFile path) {
		
		MultipartFile importFile  =  path; 
		
		System.out.println("importExcel====1002"+path.toString());
		System.out.println("importExcel====10022"+path.getOriginalFilename());
	
		System.out.println("importFile===="+importFile);
		
		User sessionUser = (User) request.getSession().getAttribute("user");
		Long role = userService.selectRole(sessionUser);
		Long id = sessionUser.getId();
	
		// 获取excel文件 importFile
		if (importFile != null) {
			System.out.println("importExcel====1003"+importFile.getOriginalFilename());
			System.out.println("importExcel====100332"+path.getName().matches("^.+\\.(?i)((xls)|(xlsx))$"));
			System.out.println("importExcel====10066"+importFile.getName().matches("^.+\\.(?i)((xls)|(xlsx))$"));
			// 是否为excel文件  -- 前台以判断
//			if (importFile.getOriginalFilename().matches("^.+\\.(?i)((xls)|(xlsx))$")) {
				// 2导入
				System.out.println("10033");
				tClientService.importExcel(importFile, importFile.getName(),role,id);
//			}   
				 writeResponse(response, "200", "0");
		}
		 writeResponse(response, "400", "导入失败");
	}

	@RequestMapping(value = "getList", method = RequestMethod.POST)
	public void getClientList(HttpServletRequest request,
			HttpServletResponse response, TClientQo tClientQo) {

		User sessionUser = (User) request.getSession().getAttribute("user");
		Long role = userService.selectRole(sessionUser);
		

		System.out.println("1001====");

		// 判断是否为员工
		if (role.compareTo(3L) == 0) {

			Pages<TClient> pages = tClientService.queryTClientByMemberId(
					tClientQo, sessionUser.getId());

			writeCommonDataResponse(response, "200", "查询成功", pages);

			 return ;
		}

		// 判断是否为主管

		if (role.compareTo(2L) == 0) {

			Pages<TClient> pages = tClientService.queryTClientByDepartment(
					tClientQo, sessionUser.getId());

			writeCommonDataResponse(response, "200", "查询成功", pages);

			 return ;

		}
        //判断是否为管理员
		if (role.compareTo(1L) == 0) {

			Pages<TClient> pages = tClientService
					.queryTClientByAdmin(tClientQo);

			writeCommonDataResponse(response, "200", "查询成功", pages);

			 return;

		}

	}
	
	
	
	
	
	/**
     * 保存员工数据
     *
     * @param request
     * @param response

     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    public String  save(HttpServletRequest request, HttpServletResponse response, TClient client) {
    	User sessionUser = (User) request.getSession().getAttribute("user");
        
    	System.out.println("===1001===save==="+client.toString());
    	System.out.println("sessionUser.getId()"+sessionUser.getId());
        
        boolean save = tClientService.saveTClient(client,sessionUser.getId());
        
        if(save){
//          writeResponse(response, "200", "客户添加成功");
        	System.out.println("跳转开始------");
//        	return "redirect:/customerController/customer";
          return "index";
        }
        else{
        writeResponse(response, "400", "客户添加失败");
    
        }
        return "index";
    }

	
	
	
	
    /**
     * 修改员工信息
     *
     * @param request
     * @param response
     */
    @RequestMapping(value = "update", method = RequestMethod.POST)
    public void update(HttpServletRequest request, HttpServletResponse response, TClient client) {
    	
    	
    	System.out.println("修改ing====");
    	System.out.println("update====="+client.toString());
    	System.out.println("update==id==="+client.getClientId());
    	
    	
        boolean update = tClientService.updateTClient(client);
        if (update) {
        writeResponse(response, "200", "客户修改成功");
        return;
    }
    	
        writeResponse(response, "400", "客户修改失败");
    }

    
    
    
    
     private  List<Long> getSubClinentIdMethod(String info){
		
		
		List<String> adList = Arrays.asList(info.split(","));
		
		List<Long>  clientIdList = new ArrayList<>();
 		
		for(String  str  : adList ){
			clientIdList.add(Long.valueOf(str));
		}
		return clientIdList;
	}
    
	
    /**
     * 删除客户
     *
     * @param request
     * @param response
     * @param clientId
     */
    @RequestMapping(value = "delete/{clientId}", method = RequestMethod.GET)
  
    public void delete(HttpServletRequest request, HttpServletResponse response, @PathVariable String clientId) {

    	
    	System.out.println("clientds=="+clientId);
    	
    	
    	if(!clientId.contains(",")){
    		
    		boolean delete = tClientService.deleteByid(Long.valueOf(clientId));
    	
    		if(delete){
    			writeResponse(response, "200", "删除成功"); 
    		}
    		else{
    			writeResponse(response, "400", "删除失败"); 
    		}
    		
    	}
    	
    	else{
    		
    		System.out.println("进入else");
    		
    		List<Long> clientIdList = getSubClinentIdMethod(clientId);
    		
    		boolean delete = tClientService.deleteByids(clientIdList);
    		
    		if(delete){
    			writeResponse(response, "200", "删除成功"); 
    		}
    		else{
    			writeResponse(response, "400", "删除失败"); 
    		}
    		
    	}
    
    }
	

    
    /**
     * 客戶追蹤信息
     * @param request
     * @param response
     * @param clientId
     */
    @RequestMapping("getLog/{clientId}")
    public void getClientLog(HttpServletRequest request, HttpServletResponse response, @PathVariable Long clientId) {
    	
    	
    	 List<TClientLog> list = tClientService.selectClientInfoByClientId(clientId);
    	
    		writeCommonDataResponse(response, "200", "成功", list);
    	
    }

    
    @RequestMapping("saveLog")
    public void saveClientLog(HttpServletRequest request, HttpServletResponse response,TClientLog tLog){

    	System.err.println(tLog.getClientId());
    	boolean flag = tClientService.saveClientLog(tLog);
    	
    	if(flag){
    		
			writeResponse(response, "200", "添加成功"); 
		}
		else{
			writeResponse(response, "400", "添加失败"); 
		}
    	
    }
    





    @RequestMapping("turnClient/{message}")
	public void  turnClientInfo(HttpServletRequest request, HttpServletResponse response,@PathVariable String message){


    if(!message.contains(",")){

		 boolean  flag = tClientService.updatByClientId(Long.valueOf(message));

		 if(flag){
			 writeResponse(response, "200", "修改成功");
		 }else{
			 writeResponse(response, "400", "修改失败");
		 }


	}
	else{


    	List<Long> list = getSubClinentIdMethod(message);

    	boolean flag =  tClientService.updatByClientIds(list);

		if(flag){
			writeResponse(response, "200", "修改成功");
		}else{
			writeResponse(response, "400", "修改失败");
		}
	}


	}



	@RequestMapping("queryAllIpAs2")
	public void  getClientByIp(HttpServletRequest request, HttpServletResponse response){


			List<TClient> list = tClientService.queryByIp();

		writeCommonDataResponse(response, "200", "查询成功", list);


		}
}
