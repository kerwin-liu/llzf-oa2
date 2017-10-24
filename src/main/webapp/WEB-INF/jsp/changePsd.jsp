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
    <script type="text/javascript" src="../../js/tools.js"></script>
    <title>修改密码</title>
</head>
<body>
<div style="padding:3px 2px;border-bottom:1px solid #ccc">修改密码</div>
    <form id="ff" action="" method="post" target="hidden_frame">
        <table>
            <tr>
                <td><label>姓名:</label></td>
                <td><input name="userName" class="easyui-validatebox textbox userName" required="true" size="20">
                </td>
            </tr>
            <tr>
                <td><label>原密码:</label></td>
                <td><input name="oldPassword" type="password" class="easyui-validatebox password oldPassword" required="true" size="20"></td>
            </tr>
            <tr>
                <td><label>新密码:</label></td>
                <td> <input name="newPassword" type="password" class="easyui-validatebox password newPassword" required="true" size="20"></td>
            </tr>
            <tr>
                <td></td>
                <td><input type="button" value="保存" class="btn"/></td>
            </tr>
        </table>
</form>
<iframe name='hidden_frame' id="hidden_frame" style='display: none'></iframe>
<script type="text/javascript" src="../../js/jquery.js"></script>

<srript>
    <script type="text/javascript" >
        $(function () {
            $('#hidden_frame').load(function () {
                var text = $(this).contents().find("body").text();
                $(".btn").click(function () {
                    var data={};
                    data['userName']=$(".userName").val();
                    data['oldPassword']=$(".oldPassword").val();
                    data['newPassword']=$(".newPassword").val();
                    $.ajax({
                        url:'/user/updatePassword',
                        dataType:'json',
                        data:data,
                        type:"POST",
                        success:function(data) {
                            if(data.code==200){
                                alert(data.msg);
                                window.location.href = "/loginOut";//退出session
                            }
                        }
                    });
                })

            });


        });
    </script>
</srript>
</body>
</html>
