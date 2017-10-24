<%--
  Created by IntelliJ IDEA.
  User: liujingtao
  Date: 2017-10-24
  Time: 20:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html style="width: 100%;height: 100%">
<head>
    <title>首页</title>
    <link rel="stylesheet" type="text/css" href="../../js/jquery-easyui-1.5.1/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="../../js/jquery-easyui-1.5.1/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="../../js/jquery-easyui-1.5.1/demo/demo.css">
    <script type="text/javascript" src="../../js/jquery.js"></script>
    <%--<script type="text/javascript" src="../../js/jquery.easyui.min.js"></script>--%>

    <script type="text/javascript" src="../../js/jquery-easyui-1.5.1/jquery.min.js"></script>
    <script type="text/javascript" src="../../js/jquery-easyui-1.5.1/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../../js/tools.js"></script>
    <script type="text/javascript" src="../../js/My97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript" src="../../js/dataformat.js"></script>
    <script type="text/javascript" src="../../js/echarts.js"></script>
    <style type="text/css">
        .content{
            width: 100%;
            height: 99%;
            border: 1px solid red;
        }
        .left{
            width: 39.5%;
            height: 100%;
            float: left;
            border: 1px solid red;
        }
        .right-top{
            width: 60%;
            height: 49.7%;
            float: left;
            border: 1px solid red;
        }
        .right-bottom{
            width: 60%;
            height: 49.7%;
            float: left;
            border: 1px solid red;
        }
        .right-top-top{
            width: 49.7%;
            height: 100%;
            float: left;
            border: 1px solid red;
        }
        .right-top-bottom{
            width: 49.7%;
            height: 100%;
            float: left;
            border: 1px solid red;
        }
    </style>
</head>
<body>
<div class="content">
    <div class="left">

    </div>
    <div class="right-top">
        <div class="right-top-top" id="day-bar"></div>
        <div class="right-top-bottom" id="month-bar"></div>
    </div>
    <div class="right-bottom" >
        <div id="month-line" style="width: 100%;height: 100%"></div>
    </div>
</div>
</body>
<script type="text/javascript">
var myCharts01 = echarts.init(document.getElementById("day-bar")),
    myCharts02 = echarts.init(document.getElementById("month-bar")),
    myCharts03 = echarts.init(document.getElementById("month-line"));

</script>
</html>
