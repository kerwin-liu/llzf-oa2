package com.fzl.pojo;

import java.util.Date;

public class ClientMember {
    private Long khId;

    private Long memberId;

    private Date xgsj;

    public Long getKhId() {
        return khId;
    }

    public void setKhId(Long khId) {
        this.khId = khId;
    }

    public Long getMemberId() {
        return memberId;
    }

    public void setMemberId(Long memberId) {
        this.memberId = memberId;
    }

    public Date getXgsj() {
        return xgsj;
    }

    public void setXgsj(Date xgsj) {
        this.xgsj = xgsj;
    }
}