package com.fzl.mapper;

import com.fzl.pojo.Qo.UserUpdateQo;
import com.fzl.pojo.User;

public interface UserMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);

    User selectByUser(User user);

    int selectRole(User sessionUser);

    int updatePassword(UserUpdateQo userUpdateQo);

    Integer selectUserIdbyMemberID(Integer memberId);

    User selectUserbyMemberID(Integer memberId);
}