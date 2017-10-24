<%--
  Created by IntelliJ IDEA.
  User: liujingtao
  Date: 2017-10-24
  Time: 21:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html style="height: 100%;width: 100%">
<head>
    <title>部门管理</title>
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
    <style type="text/css">
        .table{
            width: 100%;
            height: 95%;
            float: left;
        }
    </style>
</head>
<body>
<div class="datagrid-toolbar" style="height: 27px;float: left;width: 100%">
    <a id="btn1" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'">添加</a>
    <a id="btn2" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">修改客户</a>

</div>
<div class="table">
    <table id="dg"></table>
</div>
</body>
<script type="text/javascript">
$(function(){
    $("#dg").datagrid({
        singleSelect: false,
        fitColumns: false,
        fit: true,
        remoteSort: false,
        columns: [[
            {field : 'IDs',title : 'IDs',checkbox : true,width : 8,align : 'center'},
            {field: 'id', title: '编号', width: 50, align: 'center',hidden:true},
            {field: 'name', title: '部门名称', width: 100, align: 'center'}
            ]]
    });
    $(".datagrid-toolbar").insertBefore(".datagrid-view");
});

function loadtable(){
$.ajax({
    url:'',
    dataType:'json',
    success:function(data){

    }
})
}
</script>
</html>
