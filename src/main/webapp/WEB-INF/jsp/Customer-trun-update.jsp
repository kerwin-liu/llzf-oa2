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
                <input id="khmc" name="khmc" class="easyui-validatebox textbox " missingMessage="不能为空"  required="true" size="20" style="height: 25px;">
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
        <input id="khsfzh" value="" name="khsfzh" size="54" class="easyui-validatebox textbox" missingMessage="不能为空"  required="true" validType="idcard" style="height: 25px;">
    </div>

    <div class="fitem">
         <span class="item-one">
                <label>客户类型:</label>
               <select id="khlxs" name="khlx">
                    <option value="1">一般客户</option>
                    <option value="2">潜力客户</option>
                     <option value="3">意客客户</option>
                     <option value="4">未有兴趣客户</option>
                </select>
           </span>
        <span class="item-two">
                 <label>手机:</label>
              <input id="khsjh" name="khsjh"  class="easyui-validatebox textbox"  missingMessage="不能为空" validType="mobile" required="true" style="height: 25px;" size="20">
            </span>
    </div>
    <div class="fitem">
        <span class="item-one">
                 <label>QQ:</label>
                <input id="khqq" name="khqq"  class="easyui-validatebox textbox" required="true" missingMessage="不能为空" validType="qq"  style="height: 25px;" size="20">
            </span>
        <span class="item-two">
                <label>昵称:</label>
                <input id="qqnc" name="khqqnc" class="easyui-validatebox textbox" required="true" missingMessage="不能为空"  style="height: 25px;" size="20">
           </span>
    </div>
    <div class="fitem">
            <span class="item-one">
                    <label>微信:</label>
                   <input id="khwx" name="khwx"  class="easyui-validatebox textbox" required="true" missingMessage="不能为空"  style="height: 25px;" size="20">
               </span>
             <span class="item-two">
                    <label>资金(万):</label>
                   <input id="zj" name="khzj"  class="easyui-validatebox textbox" required="true" missingMessage="不能为空" validType="intOrFloat"  style="height: 25px;" size="20">
               </span>
    </div>
    <div class="fitem">
        <label class="item-one">住址:</label>
        <input id="address" name="khdz" class="easyui-validatebox textbox address" required="true"  missingMessage="不能为空" size="54" style="height: 25px;">
    </div>
    <div class="fitem">
        <label>备注:</label>
        <input id="bz" name="bz" size="54" class="easyui-validatebox textbox" required="true" missingMessage="不能为空"   style="height: 25px;">
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
        },
        idcard: {// 验证身份证
            validator: function (value) {
                return /^\d{15}(\d{2}[A-Za-z0-9])?$/i.test(value);
            },
            message: '身份证号码格式不正确'
        },
        length: { validator: function (value, param) {
            var len = $.trim(value).length;
            return len >= param[0] && len <= param[1];
        },
            message: "输入内容长度必须介于{0}和{1}之间."
        },
        mobile: {// 验证手机号码
            validator: function (value) {
                return /^(13|15|18|17)\d{9}$/i.test(value);
            },
            message: '手机号码格式不正确'
        },
        qq: {// 验证QQ,从10000开始
            validator: function (value) {
                return /^[1-9]\d{4,9}$/i.test(value);
            },
            message: 'QQ号码格式不正确'
        },
        intOrFloat : {// 验证整数或小数
            validator : function(value) {
                return /^\d+(\.\d+)?$/i.test(value);
            },
            message : '请输入数字，并确保格式正确'
        }

    });

    var rows= $("#dg").datagrid("getSelections"),
        map=[{"id":1,"text":"一般客户"},
             {"id":2,"text":"潜力客户"},
             {"id":3,"text":"意向客户"},
             {"id":4,"text":"未有兴趣客户"}];
    $("#khlxs").find("option[value='"+rows[0].khlx+"']").attr("selected",true);
    if(rows[0].khxb==0){
        $('input:radio[name=khxb]')[0].checked = true;
    }else if(rows[0].khxb==1){
        $('input:radio[name=khxb]')[1].checked = true;
    }else{
        $('input:radio[name=khxb]')[2].checked = true;
    }

    $("#khId").val(rows[0].khId);
    $("#khmc").val(rows[0].khmc);
    $("#khsjh").val(rows[0].khsjh);
    $("#khwx").val(rows[0].khwx);
    $("#zj").val(rows[0].khzj);
    $("#address").val(rows[0].khdz);
    $("#khwxnc").val(rows[0].khwxnc);

    $("#khqq").val(rows[0].khqq);
    $("#qqnc").val(rows[0].khqqnc);

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

            if(j.code==200){

                createnewwindow('成交客户','/pages/Customer-trun-log',800,520);
               /* $.messager.confirm('确定', '你确定要成交吗?', function (r) {
                    if (r) {
                        var  d = {"khId": $("#khId").val(),"khcjlx":1};
                        $.ajax({
                            url: "/client/update",
                            type:'POST',
                            dataType: 'json',
                            data:d,
                            success: function (data) {
                                console.log(data);
                                if (data.code == 200) {
                                    tip(data.msg);
                                    tbdata(1,30);
                                } else {
                                    tip(data.msg);
                                }
                            }
                        });
                    }
                });*/
            }

        }
        catch (e){

        }

    });

</script>
</body>
</html>
