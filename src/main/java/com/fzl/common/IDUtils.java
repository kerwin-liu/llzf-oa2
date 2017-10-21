package com.fzl.common;

import org.apache.tools.ant.taskdefs.Sleep;

import java.util.Random;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * 各种id生成策略
 * <p>Title: IDUtils</p>
 * <p>Description: </p>
 * <p>Company: www.itcast.com</p>
 *
 * @version 1.0
 * @author 入云龙
 * @date 2015年7月22日下午2:32:10
 */
public class IDUtils {

    /**
     * 图片名生成
     */
    public static String genImageName() {
        //取当前时间的长整形值包含毫秒
        long millis = System.currentTimeMillis();
        //long millis = System.nanoTime();
        //加上三位随机数
        Random random = new Random();
        int end3 = random.nextInt(999);
        //如果不足三位前面补0
        String str = millis + String.format("%03d", end3);

        return str;
    }

    /**
     * 商品id生成
     */
    public static int genItemId() {
        //取当前时间的长整形值包含毫秒
        long millis = System.currentTimeMillis();
        //long millis = System.nanoTime();
        //加上两位随机数
        Random random = new Random();
        int end2 = random.nextInt(99);
        //如果不足两位前面补0
        String str = millis + String.format("%02d", end2);
        int id = new Integer(str);
        return id;
    }
    public static long genItemId(String s) {
        //取当前时间的长整形值包含毫秒
        long millis = System.currentTimeMillis();
        //long millis = System.nanoTime();
        //加上两位随机数
        Random random = new Random();
        int end2 = random.nextInt(99);
        //如果不足两位前面补0
        String str = millis + String.format("%02d", end2);
        long id = new Long(str);
        return id;
    }
    private static final AtomicInteger integer = new AtomicInteger(0);

    public static long getId() {
        long time = System.currentTimeMillis();
        StringBuilder str = new StringBuilder(20);
        str.append(time);
        int intValue = integer.getAndIncrement();
        if (integer.get() >= 10000) {
            integer.set(0);
        }
        if (intValue < 10) {
            str.append("000");
        } else if (intValue < 100) {
            str.append("00");
        } else if (intValue < 1000) {
            str.append("0");
        }
        str.append(intValue);
        return Long.parseLong(str.toString().substring(1,str.toString().length()));
    }

    public static void main(String[] args) throws InterruptedException {
        Long time=0L;
        for (int i = 0; i < 200000; i++){
            Thread.sleep(time);
            System.out.println(getId());
//            System.out.println(genItemId());
//            System.out.println(genItemId("s"));

        }
    }
}
