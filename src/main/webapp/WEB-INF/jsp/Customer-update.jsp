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
    <input id="khId" name="khId" style="display: none;"/>
    <div class="fitem">
            <span class="item-one">
                <label>姓名:</label>
                <input id="khmc" name="khmc" class="easyui-validatebox textbox " missingMessage="不能为空" validType="CHS" required="true" size="20" style="height: 25px;">
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
        <input id="khsfzh" value="" name="khsfzh" size="54" class="easyui-validatebox textbox" style="height: 25px;">
    </div>

    <div class="fitem">
         <span class="item-one">
                <label>客户类型:</label>
               <input name="khlx" id="khlx" class="easyui-combobox" missingMessage="不能为空" validType="CHS" required="true" size="20" width="50"/>
           </span>
        <span class="item-two">
                 <label>手机:</label>
              <input id="khsjh" name="khsjh"  class="easyui-validatebox textbox"  missingMessage="不能为空" validType="CHS" required="true" style="height: 25px;" size="20">
            </span>
    </div>
    <div class="fitem">
        <span class="item-one">
                 <label>QQ:</label>
                <input id="khqq" name="khqq"  class="easyui-validatebox textbox" required="true"missingMessage="不能为空" validType="CHS"  style="height: 25px;" size="20">
            </span>
        <span class="item-two">
                <label>QQ昵称:</label>
                <input id="qqnc" name="qqnc" class="easyui-validatebox textbox" style="height: 25px;" size="20">
           </span>
    </div>
    <div class="fitem">
            <span class="item-one">
                    <label>微信:</label>
                   <input id="khwx" name="khwx"  class="easyui-validatebox textbox" style="height: 25px;" size="20">
               </span>
             <span class="item-two">
                    <label>资金:</label>
                   <input id="zj" name="zj"  class="easyui-validatebox textbox" style="height: 25px;" size="20">
               </span>
    </div>
    <div class="fitem">
        <label class="item-one">住址:</label>
        <input id="address" name="address" class="easyui-validatebox textbox address" size="54" style="height: 25px;">
    </div>
    <div class="fitem">
        <label>备注:</label>
        <input id="bz" name="bz" size="54" class="easyui-validatebox textbox" style="height: 25px;">
    </div>

</form>
<iframe name='hidden_frame' id="hidden_frame" style='display: none'></iframe>
<script type="text/javascript">
    var rows= $("#dg").datagrid("getSelections"),
        map=[{"id":1,"text":"一般客户"},
             {"id":2,"text":"潜力客户"},
             {"id":3,"text":"意向客户"},
             {"id":4,"text":"未有兴趣客户"}];
    map[(rows[0].khlx)*1-1].selected=true;
    $('#khlx').combobox({
        valueField:'id',
        textField:'text',
        data:map
    });
    if(rows[0].khxb==0){
        $('input:radio[name=khxb]')[0].checked = true;
    }else if(rows[0].sex==1){
        $('input:radio[name=khxb]')[1].checked = true;
    }else{
        $('input:radio[name=khxb]')[2].checked = true;
    }
    $("#khId").val(rows[0].khId);
    $("#khmc").val(rows[0].khmc);
    $("#khsjh").val(rows[0].khsjh);
    $("#khwx").val(rows[0].khwx);
    $("#zj").val(rows[0].zj);
    $("#address").val(row[0].address);
    $("#khwxnc").val(rows[0].khwxnc);
    $("#khqq").val(rows[0].khqq);
    $("#qqnc").val(rows[0].qqnc);

    $("#khqqnc").val(rows[0].khqqnc);
    $("#khsfzh").val(rows[0].khsfzh);
    $("#bz").val(rows[0].bz);
    if(rows[0].khxb==0){
        $('input:radio[name=khxb]')[0].checked = true;
    }else{
        $('input:radio[name=khxb]')[1].checked = true;
    }

    $('#hidden_frame').load(function(){
        var text=$(this).contents().find("body").text();
        // 根据后台返回值处理结果
        try {
            var j=$.parseJSON(text);
            $.messager.alert('提示',j.msg);
            tbdata(1,30);
        }
        catch (e){

        }

    });

</script>
</body>
</html>
