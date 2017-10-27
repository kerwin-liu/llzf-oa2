<%--
  Created by IntelliJ IDEA.
  User: liujingtao
  Date: 2017/10/18
  Time: 21:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html style="width: 100%;height: 100%">
<head>
    <title></title>
    <link rel="stylesheet" type="text/css" href="../../js/jquery-easyui-1.5.1/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="../../js/jquery-easyui-1.5.1/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="../../js/jquery-easyui-1.5.1/demo/demo.css">
    <script type="text/javascript" src="../../js/jquery.js"></script>
    <%--<script type="text/javascript" src="../../js/jquery.easyui.min.js"></script>--%>

    <script type="text/javascript" src="../../js/jquery-easyui-1.5.1/jquery.min.js"></script>
    <script type="text/javascript" src="../../js/jquery-easyui-1.5.1/jquery.easyui.min.js"></script>

</head>
<body>
<style type="text/css">
    .left{
        float: left;
        width: 45%;
        height: 95%;
        border: 0px solid red;
    }
    .center{
        float: left;
        width: 9%;
        height: 50%;
        border: 0px solid red;
        padding-top: 20%;
    }
    .right{
        float: left;
        width: 45%;
        height: 95%;
        border: 0px solid red;
    }

</style>
<div class="left">
    <table id="dg1" style="width: 100%;height: 95%">

    </table>
</div>
<div class="center">
    <center>
        <a id="btns1" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-right'">移交</a>
        <br/>
        <br/>
        <br/>
        <a id="btns2" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a>
    </center>
</div>
<div class="right">
    <div class="datagrid-toolbar" style="height: 27px;width: 100%;border: 0px solid red;">
        员工:<input id="employee3" name="mem" />

    </div>
    <table id="dg2"  style="width: 100%;height: 95%">

    </table>
</div>
<script type="text/javascript">
    $(function(){
        $("#dg1").datagrid({
            data:$("#dg").datagrid("getSelections"),
            singleSelect: false,
            fitColumns: true,
            fit: true,
            rownumbers: true,
            remoteSort: false,
            columns: [[
                {field: 'khId', title: '编号', width: 50, align: 'center',hidden:true},
                {field: 'khmc', title: '姓名', width: 100, align: 'center'},
                {field: 'khlx', title: '客户类型', width: 60, align: 'center',formatter:function(value, row, index){
                    var type="";
                    if(value==1){
                        type="一般客户";
                    }
                    if(value==2){
                        type="潜力客户";
                    }
                    if(value==3){
                        type="意客客户";
                    }
                    if(value==4){
                        type="未有兴趣客户";
                    }
                    return type;
                }},
                {field: 'name', title: '负责人', width: 100, align: 'center'}
            ]],
            onClickCell:function(rowIndex, field, value){
                $("#dg1").datagrid("unselectAll");
            }
        });
        $("#dg2").datagrid({
            singleSelect: false,
            fitColumns: true,
            fit: true,
            rownumbers: true,
            remoteSort: false,
            columns: [[
                {field: 'khId', title: '编号', width: 50, align: 'center',hidden:true},
                {field: 'khmc', title: '姓名', width: 100, align: 'center'},
                {field: 'khlx', title: '客户类型', width: 60, align: 'center',formatter:function(value, row, index){
                    var type="";
                    if(value==1){
                        type="一般客户";
                    }
                    if(value==2){
                        type="潜力客户";
                    }
                    if(value==3){
                        type="意客客户";
                    }
                    if(value==4){
                        type="未有兴趣客户";
                    }
                    return type;
                }},
                {field: 'name', title: '负责人', width: 100, align: 'center'}
            ]]
        });
        var url="/member/getAll";
        $.ajax({
            url:url,
            type:'POST',//OR GET
            dataType:'json',
            success:function(data){
                if(data.code==200){
                    var value = data.date,
                        d=[];
                    for (var i=0;i<value.length;i++){
                        d.push({"id":value[i].memberId,"text":value[i].name});
                    }
                    d[0].selected=true;
                    $("#employee3").combobox({
                        valueField:'id',
                        textField:'text',
                        data:d
                    });
                }else{
                    tip(data.msg);
                }
            }
        });
        $("#btns1").click(function(){
            $("#dg2").datagrid({data:$("#dg1").datagrid("getRows")});
        });
        $("#btns2").click(function(){
            var value=$("#employee3").val();
           var url="";
           var rows=$("#dg2").datagrid("getRows");
            var data=[];
            if(rows.length==0){
                tip("请先移交客户");
                return;
            }
            for (var i=0;i<rows.length;i++){
                var da = {"clientId":rows[i].khId,"memberId":value};
                data.push(da);
            }
            $.ajax({
               url:'/client/batchZy',
               type:'POST',
                contentType: "application/json; charset=utf-8",
               dataType:'json',
               data:JSON.stringify({"list":data}),
               success:function(datas){
                if(data.code==200){
                    tip(data.msg);
                    tbdata(1,30);
                }else{
                    tip(data.msg);
                }
               }
           });
        });

        //$(".datagrid-toolbar").insertBefore(".datagrid-view");
    });

</script>
</body>

</html>
