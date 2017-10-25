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
<form id="from" action="/client/save" method="post" target="hidden_frame">
    <div class="ftitle">客户信息</div>
    <div class="fitem">
            <span class="item-one">
                <label>姓名:</label>
                <input name="name" class="easyui-validatebox textbox" required="true" size="20" style="height: 25px;">
            </span>
        <span class="item-two">
                <label>性别:</label>
                <input type="radio" class="sex" id="sex0" name="sex" value="0" checked>男
                <input type="radio" class="sex" id="sex1" name="sex" value="1">女
            </span>
    </div>
    <div class="fitem">
          <span class="item-one">
                 <label>手机:</label>
              <input name="phone"  class="easyui-validatebox textbox" required="true" style="height: 25px;" size="20">
            </span>
        <span class="item-two">
                <label>微信号:</label>
               <input name="weixin"  class="easyui-validatebox textbox" required="true" style="height: 25px;" size="20">
           </span>
    </div>
    <div class="fitem">
           <span class="item-one">
                <label>微信名:</label>
                <input name="qqqnc" class="easyui-validatebox textbox" required="true" style="height: 25px;" size="20">
           </span>
        <span class="item-two">
                 <label>QQ号:</label>
                <input name="qq"  class="easyui-validatebox textbox" required="true" style="height: 25px;" size="20">
            </span>
    </div>
    <div class="fitem">
           <span class="item-one">
                <label>客户类型:</label>
                 <select class="easyui-combobox" name="type" class="easyui-validatebox" size="20">
                    <option value="1" selected>一般客户</option>
                    <option value="2">潜力客户</option>
                     <option value="3">意客客户</option>
                     <option value="4">未有兴趣客户</option>
                </select>
           </span>
        <span class="item-two">
                 <label>负责人:</label>
                <input name="funds" style="height: 25px;" size="20">
        </span>
    </div>
    <div class="fitem">
        <label>身份证:</label>
        <input value="12134356" name="card" size="55" class="" required="true" style="height: 25px;">
    </div>
    <div class="fitem">
        <label>备注:</label>
        <input name="remark" size="55" style="height: 25px;">
    </div>
</form>
<iframe name='hidden_frame' id="hidden_frame" style='display: none'></iframe>
<script type="text/javascript">
    $('#hidden_frame').load(function(){
        var text=$(this).contents().find("body").text();
        // 根据后台返回值处理结果
        try {
            var j=$.parseJSON(text);
            $.messager.alert('提示',j.msg);
            tbdata();
        }catch (e){

        }

    });

</script>
</body>
</html>
