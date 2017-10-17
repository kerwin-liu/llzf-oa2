<%--
  Created by IntelliJ IDEA.
  User: liujingtao
  Date: 2017/10/17
  Time: 14:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html style="height: 100%">
<head>
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="http://www.w3cschool.cc/try/jeasyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="http://www.w3cschool.cc/try/jeasyui/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="http://www.w3cschool.cc/try/jeasyui/demo/demo.css">
    <script type="text/javascript" src="../../js/jquery.js"></script>
    <%--<script type="text/javascript" src="../../js/jquery.easyui.min.js"></script>--%>
    <script type="text/javascript" src="http://www.w3cschool.cc/try/jeasyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="http://www.w3cschool.cc/try/jeasyui/jquery.edatagrid.js"></script>
</head>
<body>
<div style="height: 10%;width: 99%;border: 1px solid red;float: left;margin-left: 0.3%">
    <a id="btn" href="ss" class="easyui-linkbutton" data-options="iconCls:'icon-add'">添加</a>
</div>
<div id="dg" style="height: 99%;width: 99%;border: 1px solid red;float: left;margin-left: 0.3%"></div>
</body>
<script type="text/javascript">
    $(function(){
        $("#dg").datagrid({
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
        })

</script>
</html>
