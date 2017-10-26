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
<form id="from" action="/member/update" method="post" target="hidden_frame">
    <div class="ftitle">员工信息</div>
    <input id="memberId" name="memberId" style="display: none;"/>
    <div class="fitem">
            <span class="item-one">
                <label>账号:</label>
                <input name="number" id="number" class="easyui-validatebox textbox" missingMessage="不能为空" validType="CHS" required="true" size="20" style="height: 25px;">
            </span>
        <span class="item-two">
                <label>组别:</label>
                     <input id="groups" width="50px;" size="20" name="groups" missingMessage="不能为空" validType="CHS" data-options="required:true" style="height: 25px;">

            </span>
    </div>
    <div class="fitem">
          <span class="item-one">
                 <label>权限:</label>
              <input id="permissions" size="20" name="permissions" missingMessage="不能为空" validType="CHS"  data-options="required:true" style="height: 25px;" >

            </span>
        <span class="item-two">
                <label>性别:</label>
                <input type="radio" class="sex" id="sex0" name="sex" value="0" checked>男
                <input type="radio" class="sex" id="sex1" name="sex" value="1">女
            </span>
    </div>
    <div class="fitem">
           <span class="item-one">
                <label>姓名:</label>
                <input name="name" id="name"class="easyui-validatebox textbox" missingMessage="不能为空" validType="CHS" required="true" style="height: 25px;">
           </span>
        <span class="item-two">
                 <label>手机:</label>
                <input  name="phone" id="phone" class="easyui-validatebox textbox" missingMessage="不能为空" validType="CHS" required="true" style="height: 25px;">
            </span>
    </div>
    <div class="fitem">
           <span class="item-one">
                <label>QQ:</label>
                <input name="qq" id="qq" class="easyui-validatebox textbox" style="height: 25px;">
           </span>
        <span class="item-two">
                 <label>QQ昵称:</label>
                <input name="qqnc" id="qqnc" class="easyui-validatebox textbox" style="height: 25px;">
            </span>
    </div>
    <div class="fitem">
           <span class="item-one">
                <label>微信号:</label>
                <input name="wexin" id="wexin" class="easyui-validatebox textbox" style="height: 25px;">
           </span>
        <span class="item-two">
                 <label>绑定手机:</label>
                <input name="wPhone" id="wPhone" class="easyui-validatebox textbox" style="height: 25px;">
            </span>
    </div>
    <div class="fitem">
             <span class="item-one">
                <label>紧急联系人:</label>
                <input name="jjlxr" id="jjlxr" class="easyui-validatebox textbox" style="height: 25px;">
           </span>
        <span class="item-two">
                 <label>手机号:</label>
                <input name="jjlxrsj" id="jjlxrsj" class="easyui-validatebox textbox" style="height: 25px;">
            </span>
    </div>
    <div class="fitem">
        <label class="item-one">所属关系:</label>
        <%--<input name="ssgx" class="ssgx show-item" size="56">--%>
        <input type="radio" name="sugx" class="sugx" value="父亲">父亲
        <input type="radio" name="sugx" class="sugx" value="母亲" >母亲
        <input type="radio" name="sugx" class="sugx" value="朋友">朋友
        <input type="radio" name="sugx" class="sugx" value="子女">子女
        <input type="radio" name="sugx" class="sugx" value="配偶">配偶
    </div>
    <div class="fitem">
        <label class="item-one">身份证:</label>
        <input name="card" size="56" id="card" class="easyui-validatebox textbox" missingMessage="不能为空" validType="CHS" required="true" style="height: 25px;">
    </div>
    <div class="fitem">
        <label class="item-one">住址:</label>
        <input name="address" id="address" class="easyui-validatebox textbox" size="56" style="height: 25px;">
    </div>
    <div class="fitem">
        <label class="item-one">备注:</label>
        <input name="remark" id="remark" size="56" class="easyui-validatebox textbox" style="height: 25px;">
    </div>


</form>
<iframe name='hidden_frame' id="hidden_frame" style='display: none'></iframe>
<script type="text/javascript">
    var data_url= '/member/getList';
    var rows= $("#dg").datagrid("getSelections");
    console.log(rows);
    var sugx=rows[0].sugx;
    //添加分组的下拉框
    var groupsMap={};
    $.ajax({
        url: '/department/getAll',
        processData: false,
        dataType: 'json',
        success: function (msg) {
            groupsMap = msg.date;
            groupsMap.forEach(function (value,index,array) {
                if(rows[0].groups==value.id){
                    value["selected"]=true;
                }
            });
//            msg.date[0].selected=true;
            console.log(groupsMap);
            $('#groups').combobox({
                valueField:'id',
                textField:'name',
                data:groupsMap
            });
        }
    });
    var permissionsMap={};
    $.ajax({
        url: '/role/getAll',
        dataType:'json',
        processData: false,
        success:function(msg){
            permissionsMap = msg.date;
            permissionsMap.forEach(function (value,index,array) {
                value["text"]=value["rdescribe"];
                if(rows[0].permissions==value.id){
                    value["selected"]=true;
                }
            });
            console.log(permissionsMap);
            $('#permissions').combobox({
                valueField:'id',
                textField:'rdescribe',
                data:permissionsMap
            })
        }
    });
    $("#memberId").val(rows[0].memberId);
    $("#number").val(rows[0].number);
//    $("#groups").val(rows[0].groups);
//    $("#permissions").val(rows[0].permissions);
    $("#name").val(rows[0].name);
    $("#phone").val(rows[0].phone);
    $("#qq").val(rows[0].qq);
    $("#qqnc").val(rows[0].qqnc);
    $("#card").val(rows[0].card);
    $("#address").val(rows[0].address);
    $("#remark").val(rows[0].remark);
    $("#wexin").val(rows[0].wexin);
    $("#wPhone").val(rows[0].wPhone);
    $("#jjlxr").val(rows[0].jjlxr);
    $("#jjlxrsj").val(rows[0].jjlxrsj);
    if(rows[0].sex==0){
        $('input:radio[name=sex]')[0].checked = true;
    }else{
        $('input:radio[name=sex]')[1].checked = true;
    }
    //配偶关系
    debugger;
    if(sugx=="父亲"){
        $('input:radio[name=sugx]')[0].checked = true;
    }else if(sugx=="母亲"){
        $('input:radio[name=sugx]')[1].checked = true;
    }else if(sugx=="朋友"){
        $('input:radio[name=sugx]')[2].checked = true;
    }else if(sugx=="子女"){
        $('input:radio[name=sugx]')[3].checked = true;
    }else if(sugx=="配偶"){
        $('input:radio[name=sugx]')[4].checked = true;
    }else{
        $('input:radio[name=sugx]')[0].checked = true;
    }

    $('#hidden_frame').load(function(){
        var text=$(this).contents().find("body").text();
        // 根据后台返回值处理结果
        try {
            var j=$.parseJSON(text);
            $.messager.alert('提示',j.msg);
            tbdata(data_url,1,30);
        }catch (e){

        }

    });

</script>
</body>
</html>
