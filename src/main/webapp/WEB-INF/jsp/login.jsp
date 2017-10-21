<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="en">
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="../../css/base.css" />
	<link rel="stylesheet" href="../../css/login.css" />
	<title>客户管理系统</title>
    <script type="text/javascript">
        function fn_login(){
            document.forms[0].submit();
        }
    </script>
</head>
<body>
<form action="/login" method="post">
    <div id="container">
        <div id="bd">
            <div class="login">
                <div class="login-top"><h1 class="logo"></h1></div>
                <div class="login-input">
                    <p class="user ue-clear">
                        <label>用户名</label>
                        <input type="text" id="userName" name="userName"/>
                    </p>
                    <p class="password ue-clear">
                        <label>密&nbsp;&nbsp;&nbsp;码</label>
                        <input type="password" id="password" name="password"/>
                    </p>
                </div>
                <div class="login-btn ue-clear">
                    <div class="btn" onclick="fn_login()">登录</div>
                    <div class="remember ue-clear">
                        <input type="checkbox" id="remember" />
                        <em></em>
                        <label for="remember">记住密码</label>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form>
  <%--  <div id="ft">CopyRight&nbsp;2014&nbsp;&nbsp;版权所有&nbsp;&nbsp;samxinnet.com专注于ui设计&nbsp;&nbsp;皖ICP备09001111号</div>--%>
</body>
<script type="text/javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/common.js"></script>
<script type="text/javascript">
var height = $(window).height();
$("#container").height(height);
$("#bd").css("padding-top",height/2 - $("#bd").height()/2);

$(window).resize(function(){
	var height = $(window).height();
	$("#bd").css("padding-top",$(window).height()/2 - $("#bd").height()/2);
	$("#container").height(height);
	
});

$('#remember').focus(function(){
   $(this).blur();
});

$('#remember').click(function(e) {
	checkRemember($(this));
});

function checkRemember($this){
	if(!-[1,]){
		 if($this.prop("checked")){
			$this.parent().addClass('checked');
		}else{
			$this.parent().removeClass('checked');
		}
	}
}
</script>
</html>