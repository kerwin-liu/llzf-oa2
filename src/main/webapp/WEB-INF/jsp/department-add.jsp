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
<form id="from" action="/department/save" method="post" target="hidden_frame">
    <div class="ftitle">部门信息</div>
    <input id="id" type="text" style="display: none;"/>
    <div class="fitem">
            <span class="item-one">
                <label>部门:</label>
                <input name="name" class="easyui-validatebox textbox" missingMessage="不能为空" validType="CHS" required="true" size="20">
            </span>

    </div>

</form>
<iframe name='hidden_frame' id="hidden_frame" style='display: none'></iframe>
<script type="text/javascript">
    $.extend($.fn.validatebox.defaults.rules, {
        //验证汉字
        CHS: {
            validator: function (value) {
                return /^[\u0391-\uFFE5]+$/.test(value);
            },
            message: '只能输入汉字'
        }
    })
    $('#hidden_frame').load(function(){
        var text=$(this).contents().find("body").text();
        // 根据后台返回值处理结果
        try {
            var j=$.parseJSON(text);
            $.messager.alert('提示',j.msg);
            loadtable();
        }catch (e){

        }

    });

</script>
</body>
</html>
