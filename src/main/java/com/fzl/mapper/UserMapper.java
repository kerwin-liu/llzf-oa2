package com.fzl.mapper;

import com.fzl.pojo.Qo.UserUpdateQo;
import com.fzl.pojo.User;

public interface UserMapper {
    int deleteByPrimaryKey(Long id);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);

    User selectByUser(User user);

    Long selectRole(User sessionUser);

    int updatePassword(UserUpdateQo userUpdateQo);

    Long selectUserIdbyMemberID(Long memberId);

    User selectUserbyMemberID(Long memberId);
}