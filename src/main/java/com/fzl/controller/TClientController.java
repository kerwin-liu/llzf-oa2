package com.fzl.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fzl.common.Pages;
import com.fzl.pojo.TClient;
import com.fzl.pojo.User;
import com.fzl.pojo.Qo.TClientQo;
import com.fzl.service.TClientService;
import com.fzl.service.UserService;

/**
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
	 * 分页查询
	 *
	 * @param request
	 * @param response
	 * @param tClientQo
	 */
	@RequestMapping(value = "getAll", method = RequestMethod.GET)
	public void getAll(HttpServletRequest request,
			HttpServletResponse response, TClientQo tClientQo) {

		System.out.println("getAll====");
		// 判断查询条件合法性
		// 分页查询数据
		// 返回json
	}




	/**
	 * 导出 Excel
	 * <p>
	 * 逻辑：1 查找用户列表 2 导出
	 *
	 * @throws IOException
	 */

	@RequestMapping(value = "exportExcel")
	public void exportExcel(@RequestParam(name = "id") List<Integer> clientId,
			HttpServletResponse response) {
		try {
			// 注意提醒前段页面必须判断clientId.size是否为0
			// 查找用户列表（多选、单选、全选）
			List<TClient> listTClient = tClientService.findObjects(clientId);
			// 导出
			response.setContentType("application/x-execl");
			response.setHeader("Content-Disposition", "attachment;filename="
					+ new String("客户列表.xls".getBytes(), "ISO-8859-1"));
			ServletOutputStream outputStream = response.getOutputStream();
			tClientService.exportExcel(listTClient, outputStream);
			if (outputStream != null) {
				outputStream.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 导入Excel
	 *
	 * @param importFile
	 *            导入的Excel文件路径
	 * @return null ====这里有可能换为列表页面“list”
	 */
	@RequestMapping("impExcel")
	@ResponseBody
	public String importFile(MultipartFile importFile) {
		// 获取excel文件 importFile
		if (importFile != null) {
			// 是否为excel文件
			if (importFile.getName().matches("^.+\\.(?i)((xls)|(xlsx))$")) {
				// 2导入
				tClientService.importExcel(importFile, importFile.getName());
			}
		}
		return null;
	}

	@RequestMapping(value = "getList", method = RequestMethod.GET)
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
     * @param client
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    public void save(HttpServletRequest request, HttpServletResponse response, TClient client) {
//******  补上：按照权限 来判断是否操作的本部门或者本员工之下的客户、否则不能增加
//      //权限判断 1获取user 通过id查询权限
//      User sessionUser = (User) request.getSession().getAttribute("user");
//      Long role = userService.selectRole(sessionUser);
//      if (role.compareTo(3L) == 0) {
//          writeResponse(response, "400", "该用户无增加权限");
//          return;
//      }

    	User sessionUser = (User) request.getSession().getAttribute("user");

        List<TClient> list = tClientService.queryTClientByClientCard(client.getCard());


        if(list != null){
        	writeResponse(response, "400", "此客户账号已使用");
          return;
        }


        boolean save = tClientService.saveTClient(client,sessionUser.getId());

        if(save){
          writeResponse(response, "200", "客户添加成功");
          return;
        }
        writeResponse(response, "400", "客户添加失败");
    }





    /**
     * 修改员工信息
     *
     * @param request
     * @param response
     * @param
     */
    @RequestMapping(value = "update", method = RequestMethod.POST)
    public void update(HttpServletRequest request, HttpServletResponse response, TClient client) {

//******  补上：按照权限 来判断是否操作的本部门或者本员工之下的客户、否则不能编辑
//        //权限判断 1获取user 通过id查询权限
//        User sessionUser = (User) request.getSession().getAttribute("user");
//        Long role = userService.selectRole(sessionUser);
//        if (role.compareTo(3L) == 0) {
//            writeResponse(response, "400", "该用户无修改权限");
//            return;
//        }



    	  boolean update = tClientService.update(client);
        if (update) {
        writeResponse(response, "200", "客户修改成功");
        return;
    }

        writeResponse(response, "400", "客户修改失败");
    }
}
