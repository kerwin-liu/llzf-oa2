package com.fzl.controller;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.ConversionNotSupportedException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.MissingPathVariableException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.NoHandlerFoundException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.validation.Validator;
import java.io.IOException;
import java.net.BindException;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by kerwin.liu on 2017/10/14.
 */
@Controller
public class BaseController {
    private String codeKey="code";
    private String msgKey="msg";
    private String dateKey="date";
    private static final Logger LOGGER = LoggerFactory.getLogger(BaseController.class);

    @ExceptionHandler
    public void standardMvcExceptionHandler(HttpServletRequest request, HttpServletResponse response, Exception ex) {
        if (ex instanceof BindException) {
            // 处理BindException 400
            handleBindException(request, response, (BindException)ex);
        } else if (ex instanceof ConversionNotSupportedException) {
            // 转换异常通常发生在MessageConvert中 500
            handlerConversionException(request, response, (ConversionNotSupportedException)ex);
        } else if (ex instanceof HttpRequestMethodNotSupportedException) {
            // 请求Method不支持 405
            handlerMethodNotSupportException(request, response, (HttpRequestMethodNotSupportedException) ex);
        } else if (ex instanceof NoHandlerFoundException) {
            // 找不到对应的Handler 404
            handlerHandlerNotFoundException(request, response, (NoHandlerFoundException) ex);
        } else if (ex instanceof MissingPathVariableException) {
            // 路径参数找不到异常 500
            handlerPathVariableException(request, response, (MissingPathVariableException) ex);
        } else {
            handlerUnkownException(request, response, ex);
        }
    }

    private void handlerUnkownException(HttpServletRequest request, HttpServletResponse response, Exception ex) {
        LOGGER.error("SpringMVC请求抛出未知异常，请求路径为:{},异常信息为：{}",request.getRequestURL() ,ex);
        Map<String, Object> data = new HashMap<>(); data.put("code", HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        data.put("msg", "系统未知异常，请联系运维");
        writeCommonResponse(response, data);
    }


    private void handlerPathVariableException(HttpServletRequest request, HttpServletResponse response, MissingPathVariableException ex) {
        LOGGER.error("SpringMVC请求找不到对应的路径参数，请求路径为:{},异常信息为：{}",request.getRequestURL() ,ex);
        Map<String, Object> data = new HashMap<>(); data.put("code", HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        data.put("msg", "请求数据不合法");
        writeCommonResponse(response, data);
    }

    private void handlerHandlerNotFoundException(HttpServletRequest request, HttpServletResponse response,
                                                 NoHandlerFoundException ex) {
        LOGGER.error("SpringMVC请求找不到对应的Controller，请求路径为:{},异常信息为：{}",request.getRequestURL() ,ex);
        Map<String, Object> data = new HashMap<>(); data.put("code", HttpServletResponse.SC_NOT_FOUND);
        data.put("msg", "请求路径不合法");
        writeCommonResponse(response, data);
    }

    private void handlerMethodNotSupportException(HttpServletRequest request, HttpServletResponse response,
                                                  HttpRequestMethodNotSupportedException ex) {
        LOGGER.error("SpringMVC请求方式不正确，请求路径为:{},异常信息为：{}",request.getRequestURL() ,ex);
        Map<String, Object> data = new HashMap<>(); data.put("code", HttpServletResponse.SC_METHOD_NOT_ALLOWED);
        data.put("msg", "请求方式不合法");
        writeCommonResponse(response, data);
    }

    private void handlerConversionException(HttpServletRequest request, HttpServletResponse response, ConversionNotSupportedException ex) {
        LOGGER.error("SpringMVC参数转换异常，请求路径为:{},异常信息为：{}",request.getRequestURL() ,ex);
        Map<String, Object> data = new HashMap<>(); data.put("code", HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        data.put("msg", "请求数据不合法");
        writeCommonResponse(response, data);
    }

    private void handleBindException(HttpServletRequest request, HttpServletResponse response, BindException ex) {
        Map<String, Object> data = new HashMap<>();
        LOGGER.error("SpringMVC参数bind异常，请求路径为:{},异常信息为：{}",request.getRequestURL() ,ex);
        data.put("code", HttpServletResponse.SC_BAD_REQUEST);
        data.put("msg", "请求数据不合法");
        writeCommonResponse(response, data);
    }

    protected void writeCommonResponse(HttpServletResponse response, final Map<String, Object> data) {
        response.setContentType("application/json;charset=UTF-8");
        ObjectMapper mapper = new ObjectMapper();
        try {
            mapper.writeValue(response.getWriter(), data);
        }
        catch (JsonGenerationException | JsonMappingException e) {
            writeCommonFailureResponse(response);
            e.printStackTrace();
        }
        catch (IOException e) {
            writeFatalFailureResponse(response);
            e.printStackTrace();
        }
    }
    protected void writeCommonFailureResponse(HttpServletResponse response) {
        writeResponse(response, "500", "响应失败");
    }
    protected void writeFatalFailureResponse(HttpServletResponse response) {
        writeResponse(response, "500", "响应失败");
    }
    @SuppressWarnings("serial")
    protected void writeResponse(HttpServletResponse response, String code, String msg) {
        response.setContentType("application/json;charset=UTF-8");
        ObjectMapper mapper = new ObjectMapper();
        final String resultcode=code;
        final String resultMsg = msg;
        try {
            mapper.writeValue(response.getWriter(), new HashMap<String, String>() {
                {
                    put(codeKey, resultcode);
                    put(msgKey, resultMsg);
                }
            });
        }
        catch (JsonGenerationException | JsonMappingException e) {
            writeCommonFailureResponse(response);
            e.printStackTrace();
        }
        catch (IOException e) {
            writeFatalFailureResponse(response);
            e.printStackTrace();
        }
    }
    protected void writeCommonDataResponse(HttpServletResponse response,  String code,  String msg,  Object object) {
        response.setContentType("application/json;charset=UTF-8");
        ObjectMapper mapper = new ObjectMapper();
        final String resultCode=code;
        final String resultMsg =msg;
        final Object resultObject=object;
        try {
            mapper.setSerializationInclusion(JsonInclude.Include.NON_NULL);
            mapper.writeValue(response.getWriter(), new HashMap<String, Object>() {
                {
                    put(codeKey, resultCode);
                    put(msgKey, resultMsg);
                    put(dateKey, resultObject);
                }
            });
        } catch (JsonGenerationException | JsonMappingException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
