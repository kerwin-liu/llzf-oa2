package com.fzl.pojo;

import java.util.Date;

public class TAdmin {
    private Integer adminId;

    private String name;

    private String password;

    private Date time;

    private String adminRese2;

    public Integer getAdminId() {
        return adminId;
    }

    public void setAdminId(Integer adminId) {
        this.adminId = adminId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public String getAdminRese2() {
        return adminRese2;
    }

    public void setAdminRese2(String adminRese2) {
        this.adminRese2 = adminRese2 == null ? null : adminRese2.trim();
    }
}