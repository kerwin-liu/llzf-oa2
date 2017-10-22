package com.fzl.pojo;

import java.util.Date;

public class Member {
    private Long memberId;

    private String number;

    private String name;

    private String sex;

    private String phone;

    private String card;

    private String qq;

    private String wexin;

    private Long groups;

    private Long permissions;

    private String qqnc;

    private String address;

    private String remark;

    private Date time;

    private String open;

    private Long creatUserId;

    private String wPhone;

    private String jjlxr;

    private String jjlxrsj;

    private String sugx;

    public Long getMemberId() {
        return memberId;
    }

    public void setMemberId(Long memberId) {
        this.memberId = memberId;
    }

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number == null ? null : number.trim();
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex == null ? null : sex.trim();
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone == null ? null : phone.trim();
    }

    public String getCard() {
        return card;
    }

    public void setCard(String card) {
        this.card = card == null ? null : card.trim();
    }

    public String getQq() {
        return qq;
    }

    public void setQq(String qq) {
        this.qq = qq == null ? null : qq.trim();
    }

    public String getWexin() {
        return wexin;
    }

    public void setWexin(String wexin) {
        this.wexin = wexin == null ? null : wexin.trim();
    }

    public Long getGroups() {
        return groups;
    }

    public void setGroups(Long groups) {
        this.groups = groups;
    }

    public Long getPermissions() {
        return permissions;
    }

    public void setPermissions(Long permissions) {
        this.permissions = permissions;
    }

    public String getQqnc() {
        return qqnc;
    }

    public void setQqnc(String qqnc) {
        this.qqnc = qqnc == null ? null : qqnc.trim();
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address == null ? null : address.trim();
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public String getOpen() {
        return open;
    }

    public void setOpen(String open) {
        this.open = open == null ? null : open.trim();
    }

    public Long getCreatUserId() {
        return creatUserId;
    }

    public void setCreatUserId(Long creatUserId) {
        this.creatUserId = creatUserId;
    }

    public String getwPhone() {
        return wPhone;
    }

    public void setwPhone(String wPhone) {
        this.wPhone = wPhone == null ? null : wPhone.trim();
    }

    public String getJjlxr() {
        return jjlxr;
    }

    public void setJjlxr(String jjlxr) {
        this.jjlxr = jjlxr == null ? null : jjlxr.trim();
    }

    public String getJjlxrsj() {
        return jjlxrsj;
    }

    public void setJjlxrsj(String jjlxrsj) {
        this.jjlxrsj = jjlxrsj == null ? null : jjlxrsj.trim();
    }

    public String getSugx() {
        return sugx;
    }

    public void setSugx(String sugx) {
        this.sugx = sugx;
    }
}