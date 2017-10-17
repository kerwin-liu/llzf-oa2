package com.fzl.service.impl;

import com.fzl.common.IDUtils;
import com.fzl.mapper.MemberMapper;
import com.fzl.mapper.UserMapper;
import com.fzl.mapper.UserMemberMapper;
import com.fzl.pojo.Member;
import com.fzl.pojo.Qo.UserUpdateQo;
import com.fzl.pojo.User;
import com.fzl.pojo.UserMember;
import com.fzl.service.UserService;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by Administrator on 2017/10/16.
 */
@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private UserMemberMapper userMemberMapper;
    @Autowired
    private MemberMapper memberMapper;

    @Override
    public User selectUser(User user) {
        User resultUser = userMapper.selectByUser(user);
        return resultUser;
    }

    @Override
    public Long selectRole(User sessionUser) {
        return userMapper.selectRole(sessionUser);
    }

    @Override
    public boolean saveUser(Long memberId, Long creatId) {
        //用户信息入库
        User user = new User();
        user.setId(IDUtils.getId());
        user.setUserName(RandomStringUtils.randomAlphabetic(6) + RandomStringUtils.randomNumeric(2));
        user.setPassword(RandomStringUtils.randomAlphanumeric(8));
        user.setCreatUserId(creatId);
        int insert1 = userMapper.insertSelective(user);
        //用户和员工关联表入库
        UserMember userMember = new UserMember();
        userMember.setUserId(user.getId());
        userMember.setMemberId(memberId);
        int insert = userMemberMapper.insert(userMember);
        //员工信息更改是否开通账号为已开通1
        Member member = new Member();
        member.setOpen("1");
        memberMapper.updateByPrimaryKeySelective(member);
        if (insert1 == 1 && insert == 1) {
            return true;
        }
        return false;
    }

    @Override
    public boolean selectUserIdbyMemberID(Long memberId) {
        Long userId = userMapper.selectUserIdbyMemberID(memberId);
        return (userId == null ? false : true);
    }

    @Override
    public boolean updatePassword(UserUpdateQo userUpdateQo) {
        return userMapper.updatePassword(userUpdateQo) > 0;
    }

    @Override
    public boolean passwordReset(Long memberId) {
        UserUpdateQo userUpdateQo = new UserUpdateQo();
        userUpdateQo.setNewPassword(RandomStringUtils.randomAlphanumeric(8));
        return userMapper.updatePassword(userUpdateQo) > 0;
    }

    @Override
    public User selectUserbyMemberID(Long memberId) {
        return userMapper.selectUserbyMemberID(memberId);
    }

    @Override
    public boolean deleteUser(Long memberId) {
        //user 状态
        User user = new User();
        user.setStatus(0);
        int i1 = userMapper.updateByPrimaryKeySelective(user);
        //member 状态
        Member member = new Member();
        member.setOpen("0");
        member.setMemberId(memberId);
        int i = memberMapper.updateByPrimaryKeySelective(member);
        if (i > 0 && i1 > 0) {
            return true;
        }
        return false;
    }

    @Override
    public Member queryMember(Long id) {
        return memberMapper.queryMemberByuserid(id);
    }
}
