<%--
  Created by IntelliJ IDEA.
  User: liujingtao
  Date: 2017/10/18
  Time: 20:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

</head>
<body>
<form id="from" action="/client/update" method="post" target="hidden_frame">
    <div class="ftitle">客户信息</div>
    <input id="clientId" name="CliendId" />
    <div class="fitem">
            <span class="item-one">
                <label>姓名:</label>
                <input id="names" name="name" class="easyui-validatebox textbox" required="true" size="20">
            </span>
        <span class="item-two">
                <label>性别:</label>
                <select  id="sex" class="easyui-combobox" name="sex" class="easyui-validatebox" size="20">

                </select>
            <script type="text/javascript">

            </script>
            </span>
    </div>
    <div class="fitem">
          <span class="item-one">
                 <label>手机:</label>
              <input id="phone" name="phone"  class="easyui-validatebox textbox" required="true">
            </span>
        <span class="item-two">
                <label>微信号:</label>
               <input id="weixin" name="weixin"  class="easyui-validatebox textbox" required="true">
           </span>
    </div>
    <div class="fitem">
           <span class="item-one">
                <label>微信名:</label>
                <input id="qqqnc" name="qqqnc" class="easyui-validatebox textbox" required="true">
           </span>
        <span class="item-two">
                 <label>QQ号:</label>
                <input id="qq" name="qq"  class="easyui-validatebox textbox" required="true">
            </span>
    </div>
    <div class="fitem">
           <span class="item-one">
                <label>客户类型:</label>
                 <select class="easyui-combobox" name="type" class="easyui-validatebox" size="20">
                    <option value="1">一般客户</option>
                    <option value="2">潜力客户</option>
                     <option value="3">意客客户</option>
                     <option value="4">未有兴趣客户</option>
                </select>
           </span>
        <span class="item-two">
                 <label>负责人:</label>
                <input name="funds">
        </span>
    </div>
    <div class="fitem">
        <label>身份证:</label>
        <input id="card" value="12134356" name="card" readonly="readonly" size="53" class="easyui-validatebox textbox card" required="true">
    </div>
    <div class="fitem">
        <label>备注:</label>
        <input id="remark" name="remark" size="53">
    </div>
</form>
<iframe name='hidden_frame' id="hidden_frame" style='display: none'></iframe>
<script type="text/javascript">
    var rows= $("#dg").datagrid("getSelections");
    console.log(rows[0].clientId);
    $("#clientId").val(rows[0].clientId);
    $("#names").val(rows[0].name);
    $("#phone").val(rows[0].phone);
    $("#weixin").val(rows[0].weixin);
    $("#qq").val(rows[0].qq);
    $("#qqqnc").val(rows[0].qqqnc);
    $("#card").val(rows[0].card);
    $("#remark").val(rows[0].remark);
    var map=[{"id":"0","name":"男"},{"id":"1","name":"女"}];
    if(rows[0].sex==0){
        map[0].selected=true;
    }else{
        map[1].selected=true;
    }
    $("#sex").combobox({
        valueField:'id',
        textField:'name',
        data:map
    });

    $('#hidden_frame').load(function(){
        var text=$(this).contents().find("body").text();
        // 根据后台返回值处理结果
        try {
            var j=$.parseJSON(text);
            $.messager.alert('提示',j.msg);
            tbdata();
        }
        catch (e){

        }

    });

</script>
</body>
</html>
