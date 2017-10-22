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

</head>
<body>

<div style="width: 49%;height: 98%;float: left;border: 0px solid red">
    <div style="width: 60%;height: 10%;border: 0px solid red;margin-left: 15%;line-height: 38px;font-size: 18px;color: red;text-align: center;font-family: 'Adobe 仿宋 Std R';font-weight: 800">
        客户信息
    </div>
    <div style="width: 100%;height: 89%;border: 0px solid red">
        <table border="0" style="height: 80%">
            <tr style="width: 100%">
                <td style="width: 27%">业务员:</td>
                <td style="width:25%;" colspan="3"><input id="mem" style="border: 0px; width:230px"></td>

            </tr>
            <tr>
                <td style="width:15%;">客户姓名:</td>
                <td style="width:15%;"> <input style="width: 50px;border: 0px" id="names" type="text"/></td>
                <td style="width:25%;">客户手机:</td>
                <td style="width:25%;"><input style="width: 100px;border: 0px" id="phone" type="text"/></td>
            </tr>
            <tr>
                <td>微信号:</td>
                <td><input style="width: 50px;border: 0px" id="weixin" type="text"/> </td>
                <td>微信名:</td>
                <td><input style="width: 50px;border: 0px" id="qqqnc" type="text"/></td>
            </tr>
            <tr>
                <td>QQ:</td>
                <td> <input style="width: 50px;border: 0px" id="qq" type="text"/> </td>
                <td>客户类型:</td>
                <td><input style="width: 50px;border: 0px" id="type" type="text"/> </td>
            </tr>

            <tr>
                <td>归档日期:</td>
                <td colspan="3"><input style="width: 146px;border: 0px" id="time" type="text"/> </td>
            </tr>
            <tr>
                <td>备注:</td>
                <td colspan="3"><input style="width: 50px;border: 0px" id="remark" type="text"/> </td>

            </tr>
        </table>

    </div>
</div>
<div style="width: 49%;height: 98%;float: left;border: 0px solid red;margin-left: 10px">
<div style="width: 100%;height: 24%;font-size: 18px">
    服务信息:<textarea cols="36" style="resize: none"  readonly="readonly"></textarea>
</div>
    <div style="width: 100%;height: 70%">
        <textarea cols="36" rows="13"  style="resize: none" readonly="readonly"></textarea>
    </div>
    <div style="width: 30%;height: 6%;margin-left: 40%">
        <a id="add-bt1" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'">添加信息</a>
    </div>
</div>
<div id="dd"></div>
<script type="text/javascript">
    var row = $("#dg").datagrid("getSelections");
    var id = row[0].clientId;
    console.log(row);
    $("#names").val(row[0].name);
    $("#phone").val(row[0].phone);
    $("#weixin").val(row[0].weixin);
    $("#qq").val(row[0].qq);
    $("#qqqnc").val(row[0].qqqnc);
    $("#card").val(row[0].card);
    $("#remark").val(row[0].remark);
    $("#type").val(row[0].type);
    var time = new Date(row[0].time);
    $("#time").val(date2str(time,'yyyy-MM-dd hh:mm:ss'));
    if(row[0].sex==0){
        $("#sex").val("男");
    }else{
        $("#sex").val("女");
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
    $("#add-bt1").click(function(){
        createwindow2("添加客户", "/pages/Customer-log-add",400,220);
    });

    function createwindow2(title, addurl,width,height) {
        width = width?width:700;
        height = height?height:400;
        if(width=="100%" || height=="100%"){
            width = window.top.document.body.offsetWidth;
            height =window.top.document.body.offsetHeight-100;
        }
        var dd = $("#dds");
        if(dd.length==0){
            $("body").append("<div id='dds'></div>");
            dd = $("#dds");
        }

        dd.dialog({
            title: title,
            width: width,
            height: height,
            zIndex:500,
            closed: false,
            cache: false,
            href: addurl,
            modal: true,
            buttons:[{
                text:'提交',
                iconCls:'icon-ok',
                handler:function(){

                    saveObj1($(this));

                }
            },{
                text:'关闭',
                iconCls:'icon-cancel',
                handler:function(){
                    closeObj1($(this));
                }
            }]

        });


    }
    /**
     * 执行保存
     *
     */
    function saveObj1(obj) {
        var from = obj;
        console.log(from);
        for(var i=0;i<from.length;i++){
            var c = $(from[i]).children("#dds");
            if(c.length==0){
                saveObj1($(from[i].parentNode));
            }else{
                if(sub(c.children("#from"))){
                    c.children("#from").submit();
                    c.dialog('close');
                }
                return;
            }
        }
    }

    /**
     * 执行关闭
     */
    function closeObj1(obj) {
        var from = obj;
        for(var i=0;i<from.length;i++){
            var c = $(from[i]).children("#dds");
            if(c.length==0){
                closeObj1($(from[i].parentNode));
            }else{
                c.dialog('close');
                return;
            }
        }
    }

</script>
</body>
</html>
