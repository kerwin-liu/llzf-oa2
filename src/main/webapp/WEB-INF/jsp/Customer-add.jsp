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
    <style type="text/css">
        #from {
            margin: 0;
            padding: 10px 30px;
        }

        .ftitle {
            font-size: 14px;
            font-weight: bold;
            color: #666;
            padding: 5px 0;
            margin-bottom: 10px;
            border-bottom: 1px solid #ccc;
        }
        .fitem {
            margin-bottom: 5px;
        }

        .fitem label {
            display: inline-block;
            width: 50px;
        }
        .item-one{
            width: 200px;
        }
        .item-two{
            width: 200px;
        }
        select{
            width: 172px;
        }
    </style>
</head>
<body>
<form id="from" action="/client/save" method="post">
    <div class="ftitle">员工信息</div>
    <div class="fitem">
            <span class="item-one">
                <label>账号:</label>
                <input name="number" class="easyui-validatebox textbox" required="true" size="20">
            </span>
        <span class="item-two">
                <label>组别:</label>
                <select class="easyui-combobox" name="groups" class="easyui-validatebox" size="20">
                    <option value="1" selected>一部</option>
                    <option value="2">二部</option>
                </select>
            </span>
    </div>
    <div class="fitem">
          <span class="item-one">
                 <label>权限:</label>
                <select class="easyui-combobox" name="permissions" class="easyui-validatebox" size="20">
                    <option value="1">管理员</option>
                    <option value="2">部长</option>
                    <option value="3" selected>员工</option>
                </select>
            </span>
        <span class="item-two">
                <label>性别:</label>
                <select class="easyui-combobox" name="sex" class="easyui-validatebox" size="20">
                    <option value="man">男</option>
                    <option value="woman">女</option>
                </select>
           </span>
    </div>
    <div class="fitem">
           <span class="item-one">
                <label>姓名:</label>
                <input name="name" class="easyui-validatebox textbox" required="true">
           </span>
        <span class="item-two">
                 <label>手机:</label>
                <input name="phone"  class="easyui-validatebox textbox" required="true">
            </span>
    </div>
    <div class="fitem">
           <span class="item-one">
                <label>QQ:</label>
                <input name="qq">
           </span>
        <span class="item-two">
                 <label>QQ昵称:</label>
                <input name="qqnc">
            </span>
    </div>
    <div class="fitem">
        <label>身份证:</label>
        <input name="card" size="53"  class="easyui-validatebox textbox" required="true">
    </div>
    <div class="fitem">
        <label>住址:</label>
        <input name="address" size="53">
    </div>
    <div class="fitem">
        <label>备注:</label>
        <input name="remark" size="53">
    </div>
</form>


</body>
</html>
