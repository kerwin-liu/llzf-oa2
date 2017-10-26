<%--
  Created by IntelliJ IDEA.
  User: xixin
  Date: 2017/10/19
  Time: 11:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="../../js/jquery-easyui-1.5.1/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="../../js/jquery-easyui-1.5.1/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="../../js/jquery-easyui-1.5.1/demo/demo.css">
    <script type="text/javascript" src="../../js/tools.js"></script>
    <title>修改密码</title>
    <script type="text/javascript" src="../../js/jquery.js"></script>
    <%--<script type="text/javascript" src="../../js/jquery.easyui.min.js"></script>--%>

    <script type="text/javascript" src="../../js/jquery-easyui-1.5.1/jquery.min.js"></script>
    <script type="text/javascript" src="../../js/jquery-easyui-1.5.1/jquery.easyui.min.js"></script>
</head>
<body>
<form id="from" action="/user/updatePassword" method="post" target="hidden_frame">
    <div class="fitem" style="padding-top: 20px;">
        <label class="item-one">姓名:</label>
        <input name="userName" style="height: 25px;" class="easyui-validatebox textbox" required="true" size="20">
    </div>
    <div class="fitem">
        <label class="item-one">原密码:</label>
        <input name="oldPassword" id="oldPassword" style="height: 25px;" type="password" class="easyui-validatebox" missingMessage="不能为空" validType="number" required="true" size="20">
    </div>
    <div class="fitem">
        <label class="item-one">新密码:</label>
        <input name="newPassword" style="height: 25px;" type="password" class="easyui-validatebox password" required="required" validType="equals['#oldPassword']" size="20">
    </div>

</form>
<iframe name='hidden_frame' id="hidden_frame" style='display: none'></iframe>

<script type="text/javascript" >
    $(function () {
        $('#hidden_frame').load(function () {
//            var data_url='/member/getList?pageIndex=1&pageSize=10';
            var text = $(this).contents().find("body").text();
            // 根据后台返回值处理结果
            try {
                var data = $.parseJSON(text);
                if(data.code==200){
                    alert(data.msg);
                    window.location.href = "/loginOut";//退出session
                }else{
                    $.messager.alert('提示', data.msg);
                }
//                tbdata(data_url);
            } catch (e) {

            }

        });

    });
</script>
</body>
</html>
