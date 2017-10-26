package com.fzl.pojo.Qo;

import java.util.Date;

public class ClientQo extends BaseQuery {

    private Long memberId;

    private String khmc;

    private String khlx;

    private String khcjlx;

    private String khsjh;

    private String khqq;

    private String khwx;

    private Date cjsjQ;

    private Date cjsjZ;

    private String byzd;

    private Long departmentId;

    public Long getMemberId() {
        return memberId;
    }

    public void setMemberId(Long memberId) {
        this.memberId = memberId;
    }

    public String getKhmc() {
        return khmc;
    }

    public void setKhmc(String khmc) {
        this.khmc = khmc;
    }

    public String getKhlx() {
        return khlx;
    }

    public void setKhlx(String khlx) {
        this.khlx = khlx;
    }

    public String getKhcjlx() {
        return khcjlx;
    }

    public void setKhcjlx(String khcjlx) {
        this.khcjlx = khcjlx;
    }

    public String getKhsjh() {
        return khsjh;
    }

    public void setKhsjh(String khsjh) {
        this.khsjh = khsjh;
    }

    public String getKhqq() {
        return khqq;
    }

    public void setKhqq(String khqq) {
        this.khqq = khqq;
    }

    public String getKhwx() {
        return khwx;
    }

    public void setKhwx(String khwx) {
        this.khwx = khwx;
    }

    public Date getCjsjQ() {
        return cjsjQ;
    }

    public void setCjsjQ(Date cjsjQ) {
        this.cjsjQ = cjsjQ;
    }

    public Date getCjsjZ() {
        return cjsjZ;
    }

    public void setCjsjZ(Date cjsjZ) {
        this.cjsjZ = cjsjZ;
    }

    public String getByzd() {
        return byzd;
    }

    public void setByzd(String byzd) {
        this.byzd = byzd;
    }

    public Long getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(Long departmentId) {
        this.departmentId = departmentId;
    }
}