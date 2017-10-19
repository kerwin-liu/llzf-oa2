package com.fzl.controller;

import com.fzl.pojo.Member;
import com.fzl.pojo.Qo.MemberQo;
import com.fzl.pojo.Qo.UserUpdateQo;
import com.fzl.pojo.User;
import com.fzl.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by Administrator on 2017/10/16.
 */
@Controller
@RequestMapping("user")
public class UserController extends BaseController {
    private static final Logger LOGGER = LoggerFactory.getLogger(UserController.class);
    @Autowired
    private UserService userService;

    @RequestMapping(value = "changePsd", method = RequestMethod.GET)
    public String index(HttpServletRequest request, HttpServletResponse response, MemberQo memberQo) {
        return "changePsd";
    }

    /**
     * 创建用户
     * @param request
     * @param response
     * @param memberId
     */
    @RequestMapping(value = "creat/{memberId}", method = RequestMethod.POST)
    public void save(HttpServletRequest request, HttpServletResponse response, @PathVariable Long memberId ) {
        //user数据校验 查看这个员工是不是已经开通用户
        boolean isHave= userService.selectUserIdbyMemberID(memberId);
        if(isHave){
            writeResponse(response, "400", "该员工已经有账户");
            return;
        }
        //权限判断 1获取user 通过id查询权限
        User sessionUser = (User) request.getSession().getAttribute("user");
        Long role= userService.selectRole(sessionUser);
        //管理员和主管可以增加员工 员工级别的不能添加员工
        if(role.compareTo(3L)==0){
            writeResponse(response, "400", "该用户无创建权限");
            return;
        }
        boolean save= userService.saveUser(memberId,sessionUser.getId());
        if(save){
            writeResponse(response, "200", "用户创建成功");
            return;
        }
        writeResponse(response, "400", "用户创建失败");
    }

    /**
     * 更新密码
     * @param request
     * @param response
     * @param userUpdateQo
     */
    @RequestMapping(value = "updatePassword",method = RequestMethod.POST)
    public void update(HttpServletRequest request,HttpServletResponse response, UserUpdateQo userUpdateQo){
        //比较数据的合法性
        User sessionUser = (User) request.getSession().getAttribute("user");
        if(sessionUser.getId().compareTo(userUpdateQo.getId())!=0||
                !sessionUser.getUserName().equals(userUpdateQo.getUserName())||
                !sessionUser.getPassword().equals(userUpdateQo.getOldPassword())){
            writeResponse(response, "400", "原密码和账号不匹配");
            return;
        }
        if(userUpdateQo.getOldPassword().equals(userUpdateQo.getNewPassword())){
            writeResponse(response, "400", "原密码和新密码相同");
            return;
        }
        boolean upadte= userService.updatePassword(userUpdateQo);
        if(upadte){
            writeResponse(response, "200", "密码更新成功");
            return;
        }
        writeResponse(response, "400", "密码更新失败");
    }

    /**
     * 重置密码
     * @param request
     * @param response
     * @param memberId
     */
    @RequestMapping(value = "passwordReset/{memberId}",method = RequestMethod.POST)
    public void passwordReset(HttpServletRequest request, HttpServletResponse response, @PathVariable Long memberId){
        User sessionUser = (User) request.getSession().getAttribute("user");
        Long role= userService.selectRole(sessionUser);
        //管理员和主管可以增加员工 员工级别的不能添加员工
        if(role.compareTo(3L)==0){
            writeResponse(response, "400", "该用户无重置密码权限");
            return;
        }
        boolean reset= userService.passwordReset(memberId);
        if(reset){
            writeResponse(response, "200", "密码重置成功");
            return;
        }
        writeResponse(response, "400", "密码重置失败");
    }

    @RequestMapping("getOne/{memberId}")
    public void getOne(HttpServletRequest request, HttpServletResponse response, @PathVariable Long memberId){
        User sessionUser = (User) request.getSession().getAttribute("user");
        Long role= userService.selectRole(sessionUser);
        //管理员和主管可以增加员工 员工级别的不能添加员工
        if(role.compareTo(3L)==0){
            writeResponse(response, "400", "该用户无查看密码权限");
            return;
        }
        User user= userService.selectUserbyMemberID(memberId);
        if(user==null){
            writeResponse(response, "400", "密码查看失败");
        }
        writeCommonDataResponse(response, "200", "密码查看成功",user);
    }

    /**
     * 用户停用
     * @param request
     * @param response
     * @param memberId
     */
    @RequestMapping("delete/{memberId}")
    public void delete(HttpServletRequest request, HttpServletResponse response, @PathVariable Long memberId){
        User sessionUser = (User) request.getSession().getAttribute("user");
        Long role= userService.selectRole(sessionUser);
        //管理员和主管可以增加员工 员工级别的不能添加员工
        if(role.compareTo(3L)==0){
            writeResponse(response, "400", "该用户无停用用户权限");
            return;
        }
        boolean delete= userService.deleteUser(memberId);
        if(delete){
            writeResponse(response, "200", "用户停用成功");
            return;
        }
        writeResponse(response, "400", "用户停用失败");
    }

    /**
     * 查询自己的信息通过user查member信息
     * @param request
     * @param response
     */
    @RequestMapping(value = "get",method = RequestMethod.GET)
    public void delete(HttpServletRequest request, HttpServletResponse response){
        User sessionUser = (User) request.getSession().getAttribute("user");

        Member member = userService.queryMember(sessionUser.getId());
        if(member==null){
            writeResponse(response, "400", "查询失败");
            return;
        }
        writeCommonDataResponse(response, "200", "查询成功",member);
    }
}
