package com.fzl.pojo.Qo;

/**
 * Created by kerwin.liu on 2017/10/14.
 */
public class BaseQuery {
    protected Integer pageIndex = 1;
    protected Integer pageSize = 10;

    public Integer getPageIndex() {
        return pageIndex;
    }

    public void setPageIndex(Integer pageIndex) {
        this.pageIndex = pageIndex;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }
}