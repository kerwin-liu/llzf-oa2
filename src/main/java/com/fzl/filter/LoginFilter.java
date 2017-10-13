package com.fzl.filter;

import com.fzl.pojo.TAdmin;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Created by kerwin.liu on 2017/10/13.
 */
public class LoginFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        // 获得在下面代码中要用的request,response,session对象
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        HttpSession session = request.getSession();

        // 获得用户请求的URI
        String url = request.getRequestURI();
        System.out.println("url" + url);
        TAdmin tAdmin = (TAdmin) session.getAttribute("user");
        if (url.endsWith(".css") || url.endsWith(".js") || url.endsWith(".png")||url.equals("/")||url.equals("/user/login")) {
            filterChain.doFilter(request, response);
        } else if (tAdmin == null) {
            response.sendRedirect("/");
        } else {
            filterChain.doFilter(request, response);
        }
    }

    @Override
    public void destroy() {

    }
}
