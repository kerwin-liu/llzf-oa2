package com.fzl.pojo;

import java.util.Date;

public class ClientLog {
    private Long zzId;

    private Long khId;

    private String zznr;

    private Date cjsj;

    private Date xgsj;

    public Long getZzId() {
        return zzId;
    }

    public void setZzId(Long zzId) {
        this.zzId = zzId;
    }

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
}