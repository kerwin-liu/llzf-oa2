<%--
  Created by IntelliJ IDEA.
  User: liujingtao
  Date: 2017/10/17
  Time: 14:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html style="height: 100%">
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
<div class="datagrid-toolbar" style="height: 60px;width: 100%;border: 0px solid red;float: left;">

        <div style="width: 14%;height: 25px;float: left;margin-left: 2%;border: 0px solid red;margin-top: 0.3%">
            <a id="btn1" href="ss" class="easyui-linkbutton" data-options="iconCls:'icon-add'">添加客户</a>
        </div>
        <div style="width: 14%;height: 25px;float: left;margin-left: 2%;border: 0px solid red;margin-top: 0.3%">
            <a id="btn2" href="ss" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">修改资料</a>
        </div>
        <div style="width: 14%;height: 25px;float: left;margin-left: 2%;border: 0px solid red;margin-top: 0.3%">
            <a id="btn3" href="ss" class="easyui-linkbutton" data-options="iconCls:'icon-clear'">拉黑</a>
        </div>
        <div style="width: 14%;height: 25px;float: left;margin-left: 2%;border: 0px solid red;margin-top: 0.3%">
            <a id="btn4" href="ss" class="easyui-linkbutton" data-options="iconCls:'icon-large-shapes'">客户经理</a>
        </div>
        <div style="width: 14%;height: 25px;float: left;margin-left: 2%;border: 0px solid red;margin-top: 0.3%">
            <a id="btn5" href="ss" class="easyui-linkbutton" data-options="iconCls:'icon-add'">删除客户</a>
        </div>
        <div style="width: 14%;height: 25px;float: left;margin-left: 2%;border: 0px solid red;margin-top: 0.3%">
            <a id="btn6" href="ss" class="easyui-linkbutton" data-options="iconCls:'icon-add'">数据导出</a>
        </div>

        <div style="width: 97%;height: 25px;float: left;margin-left: 2%;margin-top: 0.3%;border: 0px solid red">
类型:<input type="text"/>
        </div>


</div>
<div id="dg" style="height: 99%;width: 99%;border: 1px solid red;float: left;margin-left: 0.3%"></div>
</body>
<script type="text/javascript">
    $(function(){
        $("#dg").datagrid({
            title:'本地客户',
            singleSelect: false,
            fitColumns: true,
            fit: true,
            rownumbers: true,
            remoteSort: false,

            columns: [[
                {field: 'IDs', title: 'IDs', checkbox: true, width: 8, align: 'center'},
                {field: 'ID', title: '编号', width: 100, align: 'center', hidden: 'true'},
                {field: 'BOOKNAME', title: '姓名', width: 100, align: 'center'},
                {field: 'AUTHER', title: '性别', width: 100, align: 'center'},
                {field: 'PRESS', title: '手机号', width: 100, align: 'center'},
                {field: 'PRICE', title: '微信号', width: 100, align: 'center'},
                {field: 'TIME', title: '微信名', width: 100, align: 'center'},
                {field: 'TIME', title: 'QQ号', width: 100, align: 'center'},
                {field: 'TIME', title: '客户类型', width: 100, align: 'center'},
                {field: 'TIME', title: '负责人', width: 100, align: 'center'},
                {field: 'TIME', title: '备注', width: 100, align: 'center'},
                {field: 'BOOKNUM', title: '归档日期', width: 100, align: 'center'},
                {
                    field: 'obj', title: '操作', align: 'center', width: 28, formatter: function (value, row, index) {
                    return "<a id='de' onclick=deletes('" + row.ID + "')>删除</a>";
                }
                }
            ]]
        });
        $(".datagrid-toolbar").insertBefore(".datagrid-view");

        })

</script>
</html>
