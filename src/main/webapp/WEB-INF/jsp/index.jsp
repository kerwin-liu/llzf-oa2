<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html style="width: 100%;height: 100%" >
<head>
<meta charset="utf-8">

    <link rel="stylesheet" type="text/css" href="../../js/jquery-easyui-1.5.1/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="../../js/jquery-easyui-1.5.1/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="../../js/jquery-easyui-1.5.1/demo/demo.css">
    <link rel="stylesheet" href="../../css/base.css" />
    <link rel="stylesheet" type="text/css" href="../css/jquery.dialog.css" />
    <link rel="stylesheet" href="../../css/index.css" />

<style type="text/css">
    .fitem {
        margin-bottom: 5px;
    }

    .fitem label {
        display: inline-block;
        width: 70px;
    }
    .item-one {
        width: 300px;
        padding-left: 10px;
    }
</style>
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
                <div class="welcome ue-clear" ><span >欢迎您,</span><a href="#" style="color: white" id="userName"></a></div>

            </div>
            <div class="toolbar ue-clear">
                <a class="changePsd" style="padding-right: 10px;font-size: 15px;cursor: pointer;color: white;">修改密码</a>
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
                <iframe  href="#" name="iframe" id="iframe" width="100%" height="100%" frameborder="0"></iframe>
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
            <em>V2.0&nbsp;2017</em>
        </div>
    </div>
</div>
<div class="exitDialogs">
	<div class="dialog-contents">
    	<div class="ui-dialog-icons"></div>
        <div class="ui-dialog-texts">
        	<p class="dialog-contents">你确定要退出系统？</p>
            <p class="tips">如果是请点击“确定”，否则点“取消”</p>
            
            <div class="buttons">
                <div style="margin-bottom: 5px;margin-top: -15px;margin-right:10px;margin-left:-10px;float: left">


                <%--<form action="/loginOut" method="get">

                </form>--%>
                    <input type="button"  class="button long2 ok" value="确定" />
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
<%--<script type="text/javascript" src="../../js/jquery-easyui-1.5.1/jquery.min.js"></script>--%>
<script type="text/javascript" src="../../js/jquery-easyui-1.5.1/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../../js/jquery.dialogs.js"></script>
<script type="text/javascript" src="../../js/index.js"></script>
<script type="text/javascript" src="../../js/tools.js"></script>
<script type="text/javascript" >
    var b=false;
    window.onload=function () {
        var type1 = "<li class=\"office current\"><div class=\"nav-header\"><a id=\"index\" href=\"#\" target=\"iframe\"  class=\"ue-clear\"><span>首页</span></a> </div> </li>",
            type2 = "<li class=\"gongwen\"><div class=\"nav-header\"><a id=\"index1\" href=\"/member/index\" target=\"iframe\" class=\"ue-clear\"><span>员工管理</span></a></div></li>",
            type3 = "<li class=\"nav-info\"><div class=\"nav-header\"><a id=\"index3\"  href=\"/customerController/customer\" target=\"iframe\" class=\"ue-clear\"><span>客户管理</span></a></div></li>",
            type4 = "<li style='display: none;' class=\"konwledge\"><div class=\"nav-header\"><a href=\"/user/changePsd\" target=\"iframe\" class=\"ue-clear\"><span>密码修改</span></a></div></li>",
           // type5 = "<li class=\"agency\"><div class=\"nav-header\"><a href=\"/pages/Customer-allot\" target=\"iframe\" class=\"ue-clear\"><span>移交客户</span></a></div></li>",
            type6 = "<li class=\"konwledge\"><div class=\"nav-header\"><a href=\"/pages/Customer-knockdown\" target=\"iframe\" class=\"ue-clear\"><span>成交客户</span></a></div></li>",
            type7 = "<li class=\"email\"><div class=\"nav-header\"><a href=\"/pages/department\" target=\"iframe\" class=\"ue-clear\"><span>部门管理</span></a></div></li>";

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
                 // classes.append(type5);
                  classes.append(type6);
                  classes.append(type7);
                    var a = document.getElementById("index");
                    a.href="/pages/main";
                    a.click("return false");
                    $("#index").href="#";
                }
                //主管
                if(data.date.id==2){
                    classes.append(type1);
                    classes.append(type2);
                    classes.append(type3);
                   // classes.append(type5);
                    classes.append(type6);
                    var a = document.getElementById("index");
                    a.href="/pages/main";
                    a.click("return false");
                    $("#index1").href="#";
                }
                //业务员
                if(data.date.id==3){
                    classes.append(type1);
                    classes.append(type3);
                    classes.append(type6);
                    var a = document.getElementById("index");
                    a.href="/pages/main";
                    a.click("return false");
                    $("#index3").href="#";
                }
        }
        });
        $.ajax({
            url:'/user/get',
            dataType:'json',
            success:function (data) {
                $("#userName").html(data.date.name)
            }
        });
        //密码修改
        $(".changePsd").click(function () {
            createwindow("密码修改", "/user/changePsd",300,200);
        });
    }
</script>
</html>
