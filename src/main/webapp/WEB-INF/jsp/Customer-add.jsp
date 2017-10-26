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
                <input name="khmc" class="easyui-validatebox textbox " missingMessage="不能为空" validType="CHS" required="true" size="20" style="height: 25px;">
            </span>
        <span class="item-two">
                <label>性别:</label>
                <input type="radio" class="sex" id="sex0" name="khxb" value="0">男
                <input type="radio" class="sex" id="sex1" name="khxb" value="1">女
                <input type="radio" class="sex" id="sex2" name="khxb" value="2" checked>未知
            </span>
    </div>
    <div class="fitem">
        <label>身份证:</label>
        <input value="" name="khsfzh" size="54" class="easyui-validatebox textbox" validType="n16-18" style="height: 25px;">
    </div>
    <div class="fitem">
         <span class="item-one">
                <label>客户类型:</label>
                 <select class="easyui-combobox" name="khlx" class="easyui-validatebox"   missingMessage="不能为空" validType="CHS" required="true" size="20" width="50">
                    <option value="1" selected>一般客户</option>
                    <option value="2">潜力客户</option>
                     <option value="3">意客客户</option>
                     <option value="4">未有兴趣客户</option>
                </select>
           </span>
          <span class="item-two">
                 <label>手机:</label>
              <input name="khsjh"  class="easyui-validatebox textbox"  missingMessage="不能为空" validType="m" required="true" style="height: 25px;" size="20">
            </span>
    </div>
    <div class="fitem">
        <span class="item-one">
                 <label>QQ:</label>
                <input name="khqq"  class="easyui-validatebox textbox" required="true"missingMessage="不能为空" validType="n"  style="height: 25px;" size="20">
            </span>
        <span class="item-two">
                <label>QQ昵称:</label>
                <input name="qqnc" class="easyui-validatebox textbox" style="height: 25px;" size="20">
           </span>
    </div>
    <div class="fitem">
            <span class="item-one">
                    <label>微信:</label>
                   <input name="khwx"  class="easyui-validatebox textbox" style="height: 25px;" size="20">
               </span>
        <span class="item-two">
                    <label>资金:</label>
                   <input name="zj"  class="easyui-validatebox textbox" style="height: 25px;" size="20">
               </span>
    </div>
    <div class="fitem">
        <label class="item-one">住址:</label>
        <input name="address" class="easyui-validatebox textbox address" size="54" style="height: 25px;">
    </div>
    <div class="fitem">
        <label>备注:</label>
        <input name="bz" size="54" class="easyui-validatebox textbox" style="height: 25px;">
    </div>
</form>
<iframe name='hidden_frame' id="hidden_frame" style='display: none'></iframe>
<script type="text/javascript">
    $.extend($.fn.validatebox.defaults.rules, {
        //验证汉字
        CHS: {
            validator: function (value) {
                return /^[\u0391-\uFFE5]+$/.test(value);
            },
            message: '只能输入汉字'
        }
    })

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
