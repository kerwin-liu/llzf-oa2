package com.fzl.pojo;

import java.util.Date;

public class TClientLog {
    private Integer clientId;

    private String clientLog;

    private Date time;

    public Integer getClientId() {
        return clientId;
    }

    public void setClientId(Integer clientId) {
        this.clientId = clientId;
    }

    public String getClientLog() {
        return clientLog;
    }

    public void setClientLog(String clientLog) {
        this.clientLog = clientLog == null ? null : clientLog.trim();
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }
}