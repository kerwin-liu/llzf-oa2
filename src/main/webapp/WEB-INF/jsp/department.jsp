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

        .item-one  label {
            display: inline-block;
            width: 70px;
            font-size: 16px;
        }
        .item-one  input {
            height:27px;
            font-size: 16px;
        }
        .item-one {
            width: 300px;
            padding-left: 10px;
        }

    </style>
</head>
<body>
<div class="datagrid-toolbar" style="height: 27px;float: left;width: 100%">
    <a id="btn1" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'">添加部门</a>
    <a id="btn2" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">修改部门</a>
    <a id="btn3" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">删除</a>
</div>
<div class="table">
    <table id="dg"></table>
</div>
</body>
<script type="text/javascript">
$(function(){
    $("#dg").datagrid({
        singleSelect: true,
        fitColumns: false,
        fit: true,
        remoteSort: false,
        rownumbers: true,
        columns: [[
            /*{field : 'IDs',title : 'IDs',checkbox : true,width : 8,align : 'center'},*/
            {field: 'id', title: '编号', width: 50, align: 'center',hidden:true},
            {field: 'name', title: '部门名称', width: 100, align: 'center'}
            ]]
    });
    $(".datagrid-toolbar").insertBefore(".datagrid-view");
    loadtable();
    $("#btn1").click(function(){
        createwindow("添加部门", "/pages/department-add",400,220);
    });

    $("#btn2").click(function(){
        updata();
    });
    $("#btn3").click(function(){
        deletes();
    });
});

function updata(){
    var rows= $("#dg").datagrid("getSelections");
    if(rows.length>1||rows.length==0){
        tip("请选择一条数据进行修改");
    }else{

        createwindow("修改部门", "/pages/department-update",400,220);
    }
}
function deletes() {
    var rows= $("#dg").datagrid("getSelections");
    if(rows.length>1||rows.length==0){
        tip("请选择一条数据进行删除");
    }else{
        var url="/department/delete/"+rows[0].id;
        $.ajax({
            url:url,
            type:'POST',
            dataType:'json',
            success:function(data){
                tip(data.msg);
                loadtable();
            }
        });
    }
}

function loadtable(){
$.ajax({
    url:'/department/getAll',
    dataType:'json',
    success:function(data){
        if(data.code==200){
            $("#dg").datagrid("loadData",{total:data.date.length,rows:data.date});
        }else{
            tip(data.msg);
        }
    }
});
}
</script>
</html>
