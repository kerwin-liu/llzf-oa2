package com.fzl.pojo.Qo;

import java.util.Date;

public class ClientLogQo {
    private Long khId;

    private String zznr;

    private String khcjlx;

    private String  byzd;

    private Date cjsj;

    private Date xgsj;

    public Long getKhId() {
        return khId;
    }

    public void setKhId(Long khId) {
        this.khId = khId;
    }

    public String getZznr() {
        return zznr;
    }

    public void setZznr(String zznr) {
        this.zznr = zznr == null ? null : zznr.trim();
    }

    public Date getCjsj() {
        return cjsj;
    }

    public void setCjsj(Date cjsj) {
        this.cjsj = cjsj;
    }

    public Date getXgsj() {
        return xgsj;
    }

    public void setXgsj(Date xgsj) {
        this.xgsj = xgsj;
    }

    public String getKhcjlx() {
        return khcjlx;
    }

    public void setKhcjlx(String khcjlx) {
        this.khcjlx = khcjlx;
    }

    public String getByzd() {
        return byzd;
    }

    public void setByzd(String byzd) {
        this.byzd = byzd;
    }
}