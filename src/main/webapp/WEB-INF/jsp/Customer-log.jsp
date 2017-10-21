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
        <table border="0">
            <tr style="width: 100%">
                <td width="130px">业务员:</td>
                <td style="width:25%;" colspan="3"></td>

            </tr>
            <tr>
                <td>客户姓名:</td>
                <td width="130px"></td>
                <td style="width:25%;">客户手机:</td>
                <td style="width:25%;"></td>
            </tr>
            <tr>
                <td>客户类型:</td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
            <tr>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
            <tr>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
            <tr>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
            <tr>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
            <tr>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
            <tr>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
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
    var url="";
    $.ajax({
        url:url,
        type:'POST',//OR GET
        success:function(data){

        }
    });
    $("#add-bt1").click(function(){
        createwindow2("添加客户", "/pages/Customer-add",600,320);
    });

    function createwindow2(title, addurl,width,height) {
        width = width?width:700;
        height = height?height:400;
        if(width=="100%" || height=="100%"){
            width = window.top.document.body.offsetWidth;
            height =window.top.document.body.offsetHeight-100;
        }
        var dd = $("#dd");
        if(dd.length==0){
            $("body").append("<div id='dd'></div>");
            dd = $("#dd");
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
                    saveObj($(this));

                }
            },{
                text:'关闭',
                iconCls:'icon-cancel',
                handler:function(){
                    closeObj($(this));
                }
            }]

        });


    }

</script>
</body>
</html>
