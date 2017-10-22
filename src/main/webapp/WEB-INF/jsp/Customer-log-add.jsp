<%--
  Created by IntelliJ IDEA.
  User: liujingtao
  Date: 2017/10/18
  Time: 20:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html style="height: 100%;width: 100%">
<head>
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="../../js/jquery-easyui-1.5.1/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="../../js/jquery-easyui-1.5.1/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="../../js/jquery-easyui-1.5.1/demo/demo.css">
    <script type="text/javascript" src="../../js/jquery.js"></script>
    <%--<script type="text/javascript" src="../../js/jquery.easyui.min.js"></script>--%>

    <script type="text/javascript" src="../../js/jquery-easyui-1.5.1/jquery.min.js"></script>
    <script type="text/javascript" src="../../js/jquery-easyui-1.5.1/jquery.easyui.min.js"></script>

</head>
<body>
<form id="from" action="/client/save" method="post" target="hidden_frame">
    <div class="ftitle">追踪信息</div>
    <div class="fitem">
            <span class="item-one">
                <label>时间:</label>
                <input type="text" name="historySearchTimes" readonly="readonly" style="width:80px;"/>
            </span>
    </div>
    <div class="fitem">
         <span class="item-one">
                <label>内容:</label>
                <input type="text" style="width:280px;"/>
         </span>
    </div>
</form>
<iframe name='hidden_frame' id="hidden_frame" style='display: none'></iframe>
<script type="text/javascript">
    $("input[name='historySearchTimes']").attr("class","Wdate").attr("style","height:20px;width:140px;").click(function(){WdatePicker({
        dateFmt:'yyyy-MM-dd HH:mm:ss',
    });});
    $('#hidden_frame').load(function(){
        var text=$(this).contents().find("body").text();
        // 根据后台返回值处理结果
        var j=$.parseJSON(text);
        $.messager.alert('提示',j.msg);
        tbdata();
    });

</script>
</body>
</html>
