package com.fzl.service;

import com.fzl.pojo.Member;
import com.fzl.pojo.Qo.UserUpdateQo;
import com.fzl.pojo.User;

/**
 * Created by Administrator on 2017/10/16.
 */
public interface UserService {
    User selectUser(User user);

    Integer selectRole(User sessionUser);

    boolean saveUser(Integer memberId,Integer creatId);

    boolean selectUserIdbyMemberID(Integer memberId);

    boolean updatePassword(UserUpdateQo userUpdateQo);

    boolean passwordReset(Integer memberId);

    User selectUserbyMemberID(Integer memberId);

    boolean deleteUser(Integer memberId);

    Member queryMember(Integer id);
}
