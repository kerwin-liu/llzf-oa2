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
    <title>修改密码</title>
</head>
<body>
<div style="padding:3px 2px;border-bottom:1px solid #ccc">修改密码</div>
    <form id="ff" action="" method="post">
        <table>
            <tr>
                <td><label>姓名:</label></td>
                <td><input name="userName" class="easyui-validatebox textbox" required="true" size="20">
                </td>
            </tr>
            <tr>
                <td><label>原密码:</label></td>
                <td><input name="oldPassword" type="password" class="easyui-validatebox password" required="true" size="20"></td>
            </tr>
            <tr>
                <td><label>新密码:</label></td>
                <td> <input name="newPassword" type="password" class="easyui-validatebox password" required="true" size="20"></td>
            </tr>
            <tr>
                <td></td>
                <td><input type="button" value="保存" class="btn"/></td>
            </tr>
        </table>
</form>
<script type="text/javascript" src="../../js/jquery.js"></script>
<srript>
    <script type="text/javascript" >
        $(function () {
            $(".btn").click(function () {
                $.ajax({
                    url:'/user/updatePassword',
                    dataType:'json',
                    type:"POST",
                    success:function(data) {
                        alert(JSON.stringify(data));
                    }
                });
            })
        });
    </script>
</srript>
</body>
</html>
