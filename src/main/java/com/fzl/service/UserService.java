package com.fzl.service;

import com.fzl.pojo.Member;
import com.fzl.pojo.Qo.UserUpdateQo;
import com.fzl.pojo.User;

/**
 * Created by Administrator on 2017/10/16.
 */
public interface UserService {
    User selectUser(User user);

    Long selectRole(User sessionUser);

    boolean saveUser(Long memberId,Long creatId);

    boolean selectUserIdbyMemberID(Long memberId);

    boolean updatePassword(UserUpdateQo userUpdateQo);

    boolean passwordReset(Long memberId);

    User selectUserbyMemberID(Long memberId);

    boolean deleteUser(Long memberId);

    Member queryMember(Long id);
}
