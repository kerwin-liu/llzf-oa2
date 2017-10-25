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
    <script type="text/javascript" src="../../js/employee.js"></script>
    <script type="text/javascript" src="../../js/jquery-easyui-1.5.1/jquery.min.js"></script>
    <script type="text/javascript" src="../../js/jquery-easyui-1.5.1/jquery.easyui.min.js"></script>
    <style>
    </style>
</head>
<body>
<form id="from" action="/member/save" method="post" target="hidden_frame">
    <div class="ftitle">员工信息</div>
    <div class="fitem">
            <span class="item-one">
                <label>账号:</label>
                <input name="number" class="easyui-validatebox textbox number" required="true" size="20" style="height: 25px;">
            </span>
            <span class="item-two">
                <label>组别:</label>
                     <input id="groups" width="50px;" size="20" name="groups" data-options="required:true" style="height: 25px;">
                <script type="text/javascript">
                  //添加分组的下拉框
                  $.ajax({
                      url: '/department/getAll',
                      processData: false,
                      dataType: 'json',
                      success: function (msg) {
                          var map = msg.date;
                          msg.date[0].selected=true;
                          console.log(map);
                          $('#groups').combobox({
                              valueField:'id',
                              textField:'name',
                              data:map
                          });
                      }
                  });
                </script>
            </span>
    </div>
    <div class="fitem">
          <span class="item-one">
                 <label>权限:</label>
              <input id="permissions" size="20" name="permissions" data-options="required:true" style="height: 25px;" >
                 <script type="text/javascript">
                   $.ajax({
                       url: '/role/getAll',
                       dataType:'json',
                       processData: false,
                       success:function(msg){
                           var map = msg.date;
                           map.forEach(function (value,index,array) {
                               value["text"]=value["rdescribe"];
                               if(index==0){
                                   value["selected"]=true;
                               }
                           });
                           console.log(map);
                           $('#permissions').combobox({
                               valueField:'id',
                               textField:'rdescribe',
                               data:map
                           })
                       }
                   });
                </script>
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
                <input name="name" class="easyui-validatebox textbox name" required="true" style="height: 25px;">
           </span>
            <span class="item-two">
                 <label>手机:</label>
                <input  name="phone" class="easyui-validatebox textbox phone" required="true" style="height: 25px;">
            </span>
    </div>
    <div class="fitem">
           <span class="item-one">
                <label>QQ:</label>
                <input name="qq" class="qq" style="height: 25px;">
           </span>
        <span class="item-two">
                 <label>QQ昵称:</label>
                <input name="qqnc" class="qqnc" style="height: 25px;">
            </span>
    </div>
    <div class="fitem">
           <span class="item-one">
                <label>微信号:</label>
                <input name="wexin" class="wexin" style="height: 25px;">
           </span>
        <span class="item-two">
                 <label>绑定手机:</label>
                <input name="wPhone" class="wPhone" style="height: 25px;">
            </span>
    </div>
    <div class="fitem">
             <span class="item-one">
                <label>紧急联系人:</label>
                <input name="jjlxr" class="jjlxr" style="height: 25px;">
           </span>
        <span class="item-two">
                 <label>手机号:</label>
                <input name="jjlxrsj" class="jjlxrsjm" style="height: 25px;">
            </span>
    </div>
    <div class="fitem">
        <label class="item-one">所属关系:</label>
        <%--<input name="ssgx" class="ssgx show-item" size="56">--%>
        <input type="radio" name="sugx" class="sugx" value="父亲" checked>父亲
        <input type="radio" name="sugx" class="sugx" value="母亲" >母亲
        <input type="radio" name="sugx" class="sugx" value="朋友">朋友
        <input type="radio" name="sugx" class="sugx" value="子女">子女
        <input type="radio" name="sugx" class="sugx" value="配偶">配偶
    </div>
    <div class="fitem">
        <label class="item-one">身份证:</label>
        <input name="card" size="56" class="easyui-validatebox textbox card" required="true" style="height: 25px;">
    </div>
    <div class="fitem">
        <label class="item-one">住址:</label>
        <input name="address" class="address" size="56" style="height: 25px;">
    </div>
    <div class="fitem">
        <label class="item-one">备注:</label>
        <input name="remark" class="remark" size="56" style="height: 25px;">
    </div>


</form>
<iframe name='hidden_frame' id="hidden_frame" style='display: none'></iframe>
<script type="text/javascript">
    $('#hidden_frame').load(function () {
        var data_url='/member/getList?pageIndex=1&pageSize=10';
        var text = $(this).contents().find("body").text();
        // 根据后台返回值处理结果
        try {
            var j = $.parseJSON(text);
            $.messager.alert('提示', j.msg);
            tbdata(data_url);
        } catch (e) {

        }

    });
</script>
</body>
</html>
