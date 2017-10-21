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
</head>
<body>
<div class="left">
    <div class="datagrid-toolbar" style="height: 27px;width: 100%;border: 0px solid red;">
        员工:<select id="employee1" onselect="select1()"></select>
        客户类型:<select id="type" >
                    <option value="1">一般管户</option>
                    <option value="2">潜力客户</option>
                    <option value="3">意客客户</option>
                    <option value="4">未有兴趣客户</option>
                </select>
        <a id="btn5" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'">保存</a>
    </div>
    <table id="dg1" style="width: 100%;height: 95%">

    </table>
</div>
<div class="center">
    <center>


    <a id="btn1" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-right'">添加</a>
        <br/>
        <br/>
        <br/>

    <a id="btn2" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-left'">移除</a>
    </center>
</div>
<div class="right">
    <div class="datagrid-toolbar" style="height: 27px;width: 100%;border: 0px solid red;">
        员工:<select id="employee2" onselect="loadEmployee2()"></select>
        客户类型:<select id="type2" >
        <option value="1">一般管户</option>
        <option value="2">潜力客户</option>
        <option value="3">意客客户</option>
        <option value="4">未有兴趣客户</option>
    </select>
        <a id="btn6" href="ss" class="easyui-linkbutton" data-options="iconCls:'icon-add'">保存</a>
    </div>
    <table id="dg2"  style="width: 100%;height: 95%">

    </table>
</div>
</body>
<script type="text/javascript">
    $(function(){
        $("#dg1").datagrid({
            singleSelect: false,
            fitColumns: true,
            fit: true,
            rownumbers: true,
            remoteSort: false,

            columns: [[
                {field : 'IDs',title : 'IDs',checkbox : true,width : 8,align : 'center'},
                {field: 'CLIENTID', title: '编号', width: 100, align: 'center'},
                {field: 'NAME', title: '姓名', width: 100, align: 'center'},
                {field: 'TYPR', title: '客户类型', width: 60, align: 'center'},
                {field: 'funds', title: '负责人', width: 100, align: 'center'},
                {field: 'remark', title: '备注', width: 100, align: 'center'},
                {field: 'time', title: '归档日期', width: 100, align: 'center'}
            ]]
        });
        $("#dg2").datagrid({
            singleSelect: false,
            fitColumns: true,
            fit: true,
            rownumbers: true,
            remoteSort: false,

            columns: [[
                {field : 'IDs',title : 'IDs',checkbox : true,width : 8,align : 'center'},
                {field: 'CLIENTID', title: '编号', width: 100, align: 'center'},
                {field: 'NAME', title: '姓名', width: 100, align: 'center'},
                {field: 'TYPR', title: '客户类型', width: 60, align: 'center'},
                {field: 'funds', title: '负责人', width: 100, align: 'center'},
                {field: 'remark', title: '备注', width: 100, align: 'center'},
                {field: 'time', title: '归档日期', width: 100, align: 'center'}
            ]]
        });

    })

    //左侧员工下拉框
    function select1(){
        var value_1 = $("#employee2").val();
        //需要进行判断 当value_1是NULL的时候 加载全部 还需要根据当前登录用户的信息进行筛选他所属的 客户
        var url=""+value_1;
        $.ajax({
            url:'',
            type:'POST',//OR GET
            dataType:'json',
            success:function(data){
                if(data.code==200){
                    var value = data.date.result;
                    $("#employee1").children().remove();
                    for (var i = 0 ; i < value.length ; i++){
                        $("#employee1").append("<option value='"+value[i].id+"'>"+value[i].name+"</option>");
                    }
                }else{
                    tip(data.msg);
                }


            }
        })
    }
    
    //联动右侧员工
    function loadEmployee2(){
        var value_1 = $("#employee1").val();
        var url=""+value_1;
        $.ajax({
            url:url,
            type:'POST',//OR GET
            dataType:'json',
            success:function (data) {
                if(data.code==200){
                    var value = data.date.result;
                    $("#employee2").children().remove();
                    for (var i = 0 ; i < value.length ; i++){
                        $("#employee2").append("<option value='"+value[i].id+"'>"+value[i].name+"</option>");
                    }
                }else{
                    tip(data.msg);
                }
            }
        })
    }

</script>
</html>
