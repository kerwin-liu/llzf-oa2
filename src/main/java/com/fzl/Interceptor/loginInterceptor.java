package com.fzl.Interceptor;

import com.fzl.pojo.TAdmin;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by kerwin.liu on 2017/10/13.
 */
public class loginInterceptor extends HandlerInterceptorAdapter {
    public loginInterceptor() {
        super();
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        request.setCharacterEncoding("UTF-8");
        String url = request.getServletPath();
        System.out.println(" URL："+url);
        if(url.endsWith(".css")||url.endsWith(".js")||url.endsWith(".png")){
            //判断是否已经登录
            TAdmin loginUser = (TAdmin)request.getSession().getAttribute("user");
            if(loginUser == null){
                //未登录状态
                response.sendRedirect("user/login");
                return false;
            }
        }
        return true;
//        return super.preHandle(request, response, handler);
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        super.postHandle(request, response, handler, modelAndView);
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        super.afterCompletion(request, response, handler, ex);
    }

    @Override
    public void afterConcurrentHandlingStarted(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        super.afterConcurrentHandlingStarted(request, response, handler);
    }
}
