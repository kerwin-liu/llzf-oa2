package com.fzl.common;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class Pages<T> implements Serializable {
    private static final long serialVersionUID = 1L;
    private static final int DEFAULT_PAGE_SIZE = 20;
    private int pageSize;
    private int start;
    private List<T> data;
    private long totalCount;

    public Pages() {
        this(0, 0L, 20, new ArrayList());
    }

    public Pages(int start, long totalSize, int pageSize, List<T> data) {
        if(pageSize > 0 && start >= 0 && totalSize >= 0L) {
            this.pageSize = pageSize;
            this.start = start;
            this.totalCount = totalSize;
            this.data = data;
        } else {
            throw new IllegalArgumentException("Illegal Arguments to Initiate Page Object");
        }
    }

    public long getTotalCount() {
        return this.totalCount;
    }

    public long getTotalPageCount() {
        return getTotalPageCount(this.totalCount, this.pageSize);
    }

    public static long getTotalPageCount(long totalCount, int pageSize) {
        return totalCount % (long)pageSize != 0L?totalCount / (long)pageSize + 1L:totalCount / (long)pageSize;
    }

    public int getPageSize() {
        return this.pageSize;
    }

    public void setResult(List<T> data) {
        this.data = data;
    }

    public List<T> getResult() {
        return this.data;
    }

    public int getCurrentPageNo() {
        return this.start / this.pageSize + 1;
    }

    public boolean hasNextPage() {
        return (long)this.getCurrentPageNo() < this.getTotalPageCount();
    }

    public boolean hasPreviousPage() {
        return this.getCurrentPageNo() > 1;
    }

    public boolean isEmpty() {
        return this.data == null || this.data.isEmpty();
    }

    public int getStartIndex() {
        return (this.getCurrentPageNo() - 1) * this.pageSize;
    }

    public int getEndIndex() {
        int endIndex = this.getCurrentPageNo() * this.pageSize - 1;
        return (long)endIndex < this.totalCount?endIndex:(int)this.totalCount - 1;
    }

    protected static int getStartOfPage(int pageNo) {
        return getStartOfPage(pageNo, 20);
    }

    public static int getStartOfPage(int pageNo, int pageSize) {
        return (pageNo - 1) * pageSize;
    }

    public String toString() {
        return "PageInfo{totalCount: " + this.getTotalCount() + "; pageNo: " + this.getCurrentPageNo() + "; pageSize: " + this.getPageSize() + "; pageCount: " + this.getTotalPageCount() + "; data: " + (this.data == null?0:this.data.size()) + "; round: " + this.getStartIndex() + "-" + this.getEndIndex() + "}";
    }
}
