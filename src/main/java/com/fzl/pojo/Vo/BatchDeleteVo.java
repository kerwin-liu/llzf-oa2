package com.fzl.pojo.Vo;

/**
 * Created by kerwin.liu on 2017/10/25.
 */
public class BatchDeleteVo {
    private Long id;
    private String  name;
    private String  error;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }
}
