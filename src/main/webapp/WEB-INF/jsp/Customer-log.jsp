<%--
  Created by IntelliJ IDEA.
  User: liujingtao
  Date: 2017/10/21
  Time: 13:47
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
.table td{
    color: #949494;
    text-align: left;
}
.table tr td:first-child{
    color: #949494;
    font-family: 'Microsoft Yahei', '微软雅黑';
    font-size: 18px;
    text-align: center;
}
</style>

<div style="width: 49%;height: 98%;float: left;border: 0px solid red">
    <div style="width: 60%;height: 10%;border-bottom: 2px solid #949494;margin-left: 15%;line-height: 38px;font-size: 20px;color: #949494;text-align: center;font-family: 'Microsoft Yahei', '微软雅黑';font-weight: 800">
        客户信息
    </div>
    <div style="width: 100%;height: 89%;border: 0px solid red">
        <input id="ids" style="display: none;"/>
        <table class="table" border="0" style="height: 90%">
            <tr style="width: 100%;">
                <td style="width: 27%">业务员:</td>
                <td style="width:25%;" colspan="3">
                    <input id="mem" style="border: 0px; width:230px"></td>
            </tr>
            <tr>
                <td style="width:15%;">客户姓名:</td>
                <td style="width:15%;"> <input style="width: 50px;border: 1px" id="names" type="text"/></td>
                <td style="width:25%;">客户手机:</td>
                <td style="width:25%;"><input style="width: 100px;border: 1px" id="phones" type="text"/></td>
            </tr>
            <tr>
                <td>微信号:</td>
                <td><input style="width: 50px;border: 1px" id="weixins" type="text"/> </td>
                <td>微信名:</td>
                <td><input style="width: 50px;border: 1px" id="qqqncs" type="text"/></td>
            </tr>
            <tr>
                <td>QQ:</td>
                <td> <input style="width: 50px;border: 1px" id="qqs" type="text"/> </td>
                <td>客户类型:</td>
                <td><input style="width: 60px;border: 1px" id="types" type="text"/> </td>
            </tr>

            <tr>
                <td>归档日期:</td>
                <td colspan="3"><input style="width: 146px;border: 1px" id="times" type="text"/> </td>
            </tr>
            <tr>
                <td>备注:</td>
                <td colspan="3"><input style="width: 50px;border: 1px" id="remarks" type="text"/></td>
            </tr>
        </table>

    </div>
</div>
<div style="width: 49%;height: 98%;float: left;border: 0px solid red;margin-left: 10px">
<div style="width: 100%;height: 24%;font-size: 18px">
    服务信息:<textarea id="servermsg" cols="36" style="resize: none" ></textarea>
</div>
    <div style="width: 100%;height: 70%">
       <table id="zztb" style="width: 100%;height: 100%">

       </table>
    </div>
    <div style="width: 90%;height: 6%;">
        <a id="add-bt1" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'">添加信息</a>
        <a id="cancel-bt2" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">删除</a>
        <a id="cancel-bt3" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">一键删除</a>
    </div>
</div>
<div id="dd"></div>
<script type="text/javascript">
    var row = $("#dg").datagrid("getSelections");
    var id = row[0].clientId;
    $("#ids").val(row[0].khId);
    $("#names").val(row[0].khmc);
    $("#phones").val(row[0].khsjh);
    $("#weixins").val(row[0].khwx);
    $("#qqs").val(row[0].khqq);
    $("#qqqncs").val(row[0].khqqnc);
    $("#cards").val(row[0].khsfzh);
    $("#remarks").val(row[0].bz);
    var type=row[0].khlx;
    if(type==1){
        $("#types").val("一般客户");

    }
    if(type==2){
        $("#types").val("潜力客户");

    }if(type==3){
        $("#types").val("意向客户");

    }if(type==4){
        $("#types").val("未有兴趣客户");

    }
    var time = new Date(row[0].cjsj);
    $("#times").val(date2str(time,'yyyy-MM-dd hh:mm:ss'));
    if(row[0].khxb==0){
        $("#sexs").val("男");
    }else{
        $("#sexs").val("女");
    }
    var url="/user/get";
    $.ajax({
        url:url,
        type:'GET',//OR GET
        dataType:'json',
        success:function(data){
            $("#mem").val(data.date.name)
        }
    });
    $("#zztb").datagrid({
        singleSelect: false,
        fitColumns: true,
        fit: true,
        remoteSort: false,
        rownumbers: true,
        columns: [[
            {field : 'IDs',title : 'IDs',checkbox : true,width : 8,align : 'center'},
            {field: 'cjsj', title: '时间', width: 50, align: 'center',formatter:function(value, row, index){
                var time = new Date(value);
                return date2str(time,'yyyy-MM-dd hh:mm:ss');
            }},
            {field: 'zznr', title: '追踪信息', width: 100, align: 'center'}
            ]]
    });
   $.ajax({
       url:'/clientLog/getAll/'+$("#ids").val(),
       type:'POST',
       dataType:'json',
       success:function(data){
           $("#zztb").datagrid("loadData",{total:data.date.length,rows:data.date});
       }
    });

    $("#add-bt1").click(function(){
        var value = $("#servermsg").val();
        var khId = $("#ids").val();
        var byzd = row[0].byzd;
        if (value){
            $.ajax({
                url:'/clientLog/save',
                type:'POST',
                dataType:'json',
                data:{"khId":khId,"zznr":value,"byzd":byzd},
                success:function(data){
                    if(data.code==200){
                        $.ajax({
                            url:'/clientLog/getAll/'+$("#ids").val(),
                            type:'POST',
                            dataType:'json',
                            success:function(data){
                                $("#zztb").datagrid("loadData",{total:data.date.length,rows:data.date});
                            }
                        });
                        $("#servermsg").val("");
                    }else{
                        tip(data.msg);
                    }
                }
            })
        }else {
            tip("请在服务信息框中,添加服务信息！！！");
        }
    });
    $("#cancel-bt2").click(function(){
        var rows = $("#zztb").datagrid("getSelections");
        if(rows.length==0){
            tip("请选择至少一条数据进行删除");
        }else {
            var ids=[];
            for (var i=0;i<rows.length;i++){
                ids.push(rows[i].zzId);
            }
            $.messager.confirm('确定', '你确定要删除吗?', function (r) {
                if (r) {
                    $.post('/clientLog/batchDelete/', {"ids": JSON.stringify(ids)}, function (result) {
                        //alert(result);
                        if (result.code == 200) {
                            console.log(result);
                            var str = result.msg + "\r" + "删除失败列表：" + "\r";
                            if (result.date != null && result.date.length > 0) {
                                var json = {};
                                for (var i = 0; i < result.date.length; i++) {
                                    var nameList = json[result.date[i].error];
                                    if (typeof(nameList) == "undefined") {
                                        nameList = [];
                                    }
                                    nameList.push(result.date[i].name);
                                    var s = "原因：" + result.date[i].error + "\r" + "删除失败人员：" + nameList + "\r";
                                    str += s
                                }
                                alert(str);
                            } else {
                                alert(result.msg);
                            }
                            $.ajax({
                                url:'/clientLog/getAll/'+$("#ids").val(),
                                type:'POST',
                                dataType:'json',
                                success:function(data){
                                    $("#zztb").datagrid("loadData",{total:data.date.length,rows:data.date});
                                }
                            });
//                            $('#dg').datagrid('reload');	// reload the user data
                        } else {
                            $.messager.show({	// show error message
                                title: '错误',
                                msg: result.msg
                            });
                        }
                    }, 'json');
                }})
        }
    });
    $("#cancel-bt3").click(function(){
       $.ajax({
           url:'/clientLog/deleteAll/'+$("#ids").val(),
           type:'POST',
           dataType:'json',
           success:function(data){
               tip(data.msg);
               $.ajax({
                   url:'/clientLog/getAll/'+$("#ids").val(),
                   type:'POST',
                   dataType:'json',
                   success:function(data){
                       $("#zztb").datagrid("loadData",{total:data.date.length,rows:data.date});
                   }
               });
           }
       })
    });
</script>
</body>
</html>
