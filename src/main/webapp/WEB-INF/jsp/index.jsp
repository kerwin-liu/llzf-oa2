<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="../../css/base.css" />
<link rel="stylesheet" type="text/css" href="../css/jquery.dialog.css" />
<link rel="stylesheet" href="../../css/index.css" />

<title>客户管理系统</title>
    <script type="text/javascript">
        function fn_loginOut() {
            document.forms[0].submit();
        }
    </script>
</head>

<body>
<div id="container">

	<div id="hd">
    	<div class="hd-wrap ue-clear">
        	<div class="top-light"></div>
            <h1 class="logo"></h1>
            <div class="login-info ue-clear">
                <div class="welcome ue-clear"><span>欢迎您,</span><a href="javascript:;" class="user-name">${user.userName} ${user.userName}</a></div>

            </div>
            <div class="toolbar ue-clear">
                <a href="/index" class="home-btn">首页</a>
                 <a class="quit-btn exit"></a>
            </div>
        </div>
    </div>
    <div id="bd">
    	<div class="wrap ue-clear">
        	<div class="sidebar">
            	<h2 class="sidebar-header"><p>菜单栏</p></h2>
                <ul class="nav">
                  <%--  <li class="konwledge"><div class="nav-header"><a href="../javascript:;" class="ue-clear"><span>客户管理</span><i class="icon"></i></a></div></li>--%>
                </ul>
            </div>
            <div class="content">
                <iframe  href="/customerController/customer" name="iframe" id="iframe" width="100%" height="100%" frameborder="0"></iframe>
               <%-- <div class="login-info ue-clear">
                    <div class="welcome ue-clear"style="color: black">
                        <span>${user.userName}</span>
                    </div>
                </div>--%>
            </div>
        </div>
    </div>

    <div id="ft" class="ue-clear">
    	<div class="ft-left">
            <span>某某公司</span>
            <em>Office&nbsp;System</em>
        </div>
        <div class="ft-right">
            <span>Automation</span>
            <em>V2.0&nbsp;2014</em>
        </div>
    </div>
</div>
<div class="exitDialog">
	<div class="dialog-content">
    	<div class="ui-dialog-icon"></div>
        <div class="ui-dialog-text">
        	<p class="dialog-content">你确定要退出系统？</p>
            <p class="tips">如果是请点击“确定”，否则点“取消”</p>
            
            <div class="buttons">
                <div style="margin-bottom: 5px;margin-top: -15px;margin-right:10px;margin-left:-10px;float: left">


                <form action="/user/layout" method="get">
                    <input type="button"  class="button long2 ok" value="确定" />
                </form>
                </div>
                <div style="margin-bottom: 5px;margin-top: -15px;float: left">


                <input type="button" class="button long2 normal" value="取消" />
                </div>
            </div>
        </div>
        
    </div>
</div>
</body>
<script type="text/javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/common.js"></script>
<script type="text/javascript" src="../../js/core.js"></script>
<script type="text/javascript" src="../../js/jquery.dialog.js"></script>
<script type="text/javascript" src="../../js/index.js"></script>
<script type="text/javascript" >
    var b=false;
    window.onload=function () {
        var type1 = "<li class=\"office current\"><div class=\"nav-header\"><a id=\"index\" href=\"#\" target=\"iframe\"  class=\"ue-clear\"><span>首页</span></a> </div> </li>",
            type2 = "<li class=\"gongwen\"><div class=\"nav-header\"><a id=\"index1\" href=\"/member/index\" target=\"iframe\" class=\"ue-clear\"><span>员工管理</span></a></div></li>",
            type3 = "<li class=\"nav-info\"><div class=\"nav-header\"><a id=\"index3\"  href=\"/customerController/customer\" target=\"iframe\" class=\"ue-clear\"><span>客户管理</span></a></div></li>",
            type4 = "<li class=\"konwledge\"><div class=\"nav-header\"><a href=\"/user/changePsd\" target=\"iframe\" class=\"ue-clear\"><span>密码修改</span></a></div></li>",
            type5 = "<li class=\"agency\"><div class=\"nav-header\"><a href=\"/pages/Customer-allot\" target=\"iframe\" class=\"ue-clear\"><span>移交客户</span></a></div></li>",
            type6 = "<li class=\"email\"><div class=\"nav-header\"><a href=\"/pages/Customer-knockdown\" target=\"iframe\" class=\"ue-clear\"><span>成交客户</span></a></div></li>",
            type7 = "";

        var classes=$(".nav");
        $.ajax({
            url:'/user/getRole',
            type:'POST',
            dataType:'json',
            success:function(data) {
                //管理员
                if(data.date.id==1){
                  classes.append(type1);
                  classes.append(type2);
                  classes.append(type3);
                  classes.append(type4);
                  classes.append(type5);
                  classes.append(type6);
                    var a = document.getElementById("index");
                    a.href="/customerController/customer";
                    a.click("return false");
                    $("#index").href="#";
                }
                //主管
                if(data.date.id==2){
                    classes.append(type2);
                    classes.append(type3);
                    classes.append(type5);
                    classes.append(type6);
                    var a = document.getElementById("index1");
                    a.href="/member/index";
                    a.click("return false");
                    $("#index1").href="#";
                }
                //业务员
                if(data.date.id==3){
                    classes.append(type3);
                    var a = document.getElementById("index3");
                    a.href="/customerController/customer";
                    a.click("return false");
                    $("#index3").href="#";
                }
                //
                if(data.date.id==4){

                }

        }
        });
    }
</script>
</html>
