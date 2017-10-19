<%--
  Created by IntelliJ IDEA.
  User: liujingtao
  Date: 2017/10/17
  Time: 14:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
    <script type="text/javascript" src="../../js/tools.js"></script>
    <script type="text/javascript" src="../../js/My97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript" src="../../js/dataformat.js"></script>
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
<div class="datagrid-toolbar" style="height: 80px;width: 100%;border: 0px solid red;">

        <div style="width: 14%;height: 25px;float: left;margin-left: 2%;border: 0px solid red;margin-top: 0.3%">
            <a id="btn1" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'">添加客户</a>
        </div>
        <div style="width: 14%;height: 25px;float: left;margin-left: 2%;border: 0px solid red;margin-top: 0.3%">
            <a id="btn2" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">修改资料</a>
        </div>
       <%--
            <div style="width: 14%;height: 25px;float: left;margin-left: 2%;border: 0px solid red;margin-top: 0.3%">
            <a id="btn3" href="ss" class="easyui-linkbutton" data-options="iconCls:'icon-clear'">拉黑</a>
            </div>
        --%>
        <div style="width: 14%;height: 25px;float: left;margin-left: 2%;border: 0px solid red;margin-top: 0.3%">
            <a id="btn4" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-large-shapes'">客户追踪</a>
        </div>
        <div style="width: 14%;height: 25px;float: left;margin-left: 2%;border: 0px solid red;margin-top: 0.3%">
            <a id="btn5" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'">删除客户</a>
        </div>
        <div style="width: 14%;height: 25px;float: left;margin-left: 2%;border: 0px solid red;margin-top: 0.3%">
            <a id="btn6" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'">数据导出</a>
        </div>
    <div style="width: 14%;height: 25px;float: left;margin-left: 2%;border: 0px solid red;margin-top: 0.3%">
        <a id="btn9" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'">数据导入</a>
    </div>

        <div style="width: 97%;height: 25px;float: left;margin-left: 2%;margin-top: 0.3%;border: 0px solid red">
            类型:<select id="type" style="width:80px;"></select>
            产品:<select id="c" style="width:80px;"></select>
            姓名：<input id="name" type="text" style="width:80px;"/>
            手机:<input type="text" style="width:80px;"/>
            QQ:<input type="text" style="width:80px;"/>
            日期:<input type="text" name="historySearchTime" readonly="readonly" style="width:80px;"/>
            至 <input type="text" name="nowSearchTime" style="width:80px;"/>
            负责人： <select id="" style="width:80px;"></select>
            <a id="btn8" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
        </div>


</div>
<div  style="height: 105%;width: 100%;border: 0px solid red;float: left;margin-left: -18px;margin-top: -18px">
    <table id="dg" style="height: 99%;width: 99%;"></table>
</div>
</body>
<script type="text/javascript">
    $(function(){
        var myDate = new Date();
        var historyTimeString= date2str(getBeforeTimeByMinute(myDate,-60),'yyyy-MM-dd hh:mm:ss'),
            nowTimeString= date2str(myDate,'yyyy-MM-dd hh:mm:ss');
       // $("input[name='historySearchTime']").val(historyTimeString);
        $("input[name='historySearchTime']").attr("class","Wdate").attr("style","height:20px;width:140px;").click(function(){WdatePicker({
            dateFmt:'yyyy-MM-dd HH:mm:ss',
        });});
       //$("input[name='nowSearchTime']").val(nowTimeString);
        $("input[name='nowSearchTime']").attr("class","Wdate").attr("style","height:20px;width:140px;").click(function(){WdatePicker({
            dateFmt:'yyyy-MM-dd HH:mm:ss',
        });});


        $("#dg").datagrid({
            title:'本地客户',
            singleSelect: false,
            fitColumns: true,
            fit: true,
            rownumbers: true,
            remoteSort: false,
            columns: [[
                {field: 'memberId', title: '编号', width: 100, align: 'center'},
                {field: 'name', title: '姓名', width: 100, align: 'center'},
                {field: 'sex', title: '性别', width: 100, align: 'center'},
                {field: 'phone', title: '手机号', width: 100, align: 'center'},
                {field: 'weixin', title: '微信号', width: 100, align: 'center'},
                {field: 'qqqnc', title: '微信名', width: 100, align: 'center'},
                {field: 'qq', title: 'QQ号', width: 100, align: 'center'},
                {field: 'type', title: '客户类型', width: 60, align: 'center'},
                {field: 'funds', title: '负责人', width: 100, align: 'center'},
                {field: 'remark', title: '备注', width: 100, align: 'center'},
                {field: 'time', title: '归档日期', width: 100, align: 'center'},
                {
                    field: 'obj', title: '操作', align: 'center', width: 28, formatter: function (value, row, index) {
                    return "<a id='de' onclick=deletes('" + row.ID + "')>删除</a>";
                }
                }
            ]]
        });
        $(".datagrid-toolbar").insertBefore(".datagrid-view");
        $("#btn1").click(function(){
            createwindow("添加客户", "/pages/Customer-add",600,320);
        });

        $("#btn2").click(function(){
            updata();
        });
        $("#btn4").click(function(){
            trace();
        });
        $("#btn5").click(function(){
            deletes();
        });
        $("#btn6").click(function(){
            exports();
        });
        $("#btn9").click(function(){
            imports();
        });
        tbdata();
        });
function tbdata(){
    $.ajax({
        url:'/client/getList',
        dataType:'json',
        success:function(data){
            console.log(data);
            $("#dg").datagrid("loadData",{total:data.date.totalCount,rows:data.date.result});
        }
    });
}
function updata(){
    var rows= $("#dg").datagrid("getSelections");
    if(rows.length>1||rows.length==0){
        tip("请选择一条数据进行修改");
    }else{
        createwindow("修改客户", "/pages/Customer-add",600,320);
    }
}

function trace(){
    var rows= $("#dg").datagrid("getSelections");
    if(rows.length>1||rows.length==0){
        tip("请选择一条数据进行修改");
    }else{
        createwindow("修改客户", "/pages/Customer-add",600,320);
    }
}

function deletes(){
    var rows= $("#dg").datagrid("getSelections");
    if(rows.length==0){
        tip("请至少选择一条数据进行修改");
    }else{
        var id="";
        for (var i=0;i<rows.length;i++){
            id +=rows[i].CLIENTID+",";
        }
        id = id.substring(0,id.length-1);
        var url="";
        $.ajax({
            url:url,
            dataType:'json',
            success:function(data){
                if(data.code==200){

                }else{
                    tip(data.msg);
                }
            }
        })
    }
}

function imports(){

}

function exports(){

}



</script>
</html>
