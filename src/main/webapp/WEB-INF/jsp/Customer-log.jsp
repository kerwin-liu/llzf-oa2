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
    <div style="width: 60%;height: 10%;border: 0px solid red;margin-left: 15%;line-height: 38px;font-size: 20px;color: #949494;text-align: center;font-family: 'Microsoft Yahei', '微软雅黑';font-weight: 800">
        客户信息
    </div>
    <div style="width: 100%;height: 89%;border: 0px solid red">
        <input id="ids" style="display: none;"/>
        <table class="table" border="0" style="height: 80%">
            <tr style="width: 100%">
                <td style="width: 27%">业务员:</td>
                <td style="width:25%;" colspan="3">
                    <input id="mem" style="border: 0px; width:230px"></td>
            </tr>
            <tr>
                <td style="width:15%;">客户姓名:</td>
                <td style="width:15%;"> <input style="width: 50px;border: 0px" id="names" type="text"/></td>
                <td style="width:25%;">客户手机:</td>
                <td style="width:25%;"><input style="width: 100px;border: 0px" id="phones" type="text"/></td>
            </tr>
            <tr>
                <td>微信号:</td>
                <td><input style="width: 50px;border: 0px" id="weixins" type="text"/> </td>
                <td>微信名:</td>
                <td><input style="width: 50px;border: 0px" id="qqqncs" type="text"/></td>
            </tr>
            <tr>
                <td>QQ:</td>
                <td> <input style="width: 50px;border: 0px" id="qqs" type="text"/> </td>
                <td>客户类型:</td>
                <td><input style="width: 50px;border: 0px" id="types" type="text"/> </td>
            </tr>

            <tr>
                <td>归档日期:</td>
                <td colspan="3"><input style="width: 146px;border: 0px" id="times" type="text"/> </td>
            </tr>
            <tr>
                <td>备注:</td>
                <td colspan="3"><input style="width: 50px;border: 0px" id="remarks" type="text"/></td>
            </tr>
        </table>

    </div>
</div>
<div style="width: 49%;height: 98%;float: left;border: 0px solid red;margin-left: 10px">
<div style="width: 100%;height: 24%;font-size: 18px">
    服务信息:<textarea cols="36" style="resize: none"  readonly="readonly"></textarea>
</div>
    <div style="width: 100%;height: 70%">
        <textarea id="logs" cols="36" rows="13"  style="resize: none" readonly="readonly"></textarea>
    </div>
    <div style="width: 30%;height: 6%;margin-left: 40%">
        <a id="add-bt1" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'">添加信息</a>
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
    $.ajax({
        url:'/client/getLog/'+id,
        dataType:'json',
        success:function(data){
            if(data.code==200){
                var list = data.date;
                var value = "";
                $("#logs").text("");
                for(var i=0;i<list.length;i++) {
                    var time = new Date(list[i].time);
                   value+=date2str(time,'yyyy-MM-dd hh:mm:ss')+"   "+list[i].clientLog+"\n";
                }
                $("#logs").text(value);
            }else{
                tip(data.msg);
            }
        }

    });
    $("#add-bt1").click(function(){
        createwindow2("添加信息", "/pages/Customer-log-add",400,220);
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
