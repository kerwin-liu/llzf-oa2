<%--
  Created by IntelliJ IDEA.
  User: xixin
  Date: 2017/10/17
  Time: 22:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html style="height: 100%;width: 100%">
<head>
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="../../js/jquery-easyui-1.5.1/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="../../js/jquery-easyui-1.5.1/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="../../js/jquery-easyui-1.5.1/demo/demo.css">
    <%--<script type="text/javascript" src="../../js/jquery.easyui.min.js"></script>--%>

    <script type="text/javascript" src="../../js/jquery-easyui-1.5.1/jquery.min.js"></script>
    <script type="text/javascript" src="../../js/jquery-easyui-1.5.1/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../../js/tools.js"></script>
    <script type="text/javascript" src="../../js/employee.js"></script>
    <style type="text/css">
        #fm {
            margin: 0;
            padding: 10px 30px;
        }

        .ftitle {
            font-size: 14px;
            font-weight: bold;
            color: #666;
            padding: 5px 0;
            margin-bottom: 10px;
            border-bottom: 1px solid #ccc;
        }

        .fitem {
            margin-bottom: 5px;
        }

        .fitem label {
            display: inline-block;
            width: 50px;
        }
        .item-one{
            width: 200px;
        }
        .item-two{
            width: 200px;
        }
        select{
            width: 172px;
        }
    </style>
</head>
<body>
<div class="datagrid-toolbar" style="height: 60px;width: 100%;border: 0px solid red;">

    <div style="width: 14%;height: 25px;float: left;margin-left: 2%;border: 0px solid red;margin-top: 0.3%">
        <a id="btn1" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="newUser()">添加员工</a>
    </div>
    <div style="width: 14%;height: 25px;float: left;margin-left: 2%;border: 0px solid red;margin-top: 0.3%">
        <a onclick="editUser()" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">修改</a>
    </div>
    <div style="width: 14%;height: 25px;float: left;margin-left: 2%;border: 0px solid red;margin-top: 0.3%">
        <a id="btn5" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="removeUser()">删除员工</a>
    </div>
    <div style="width: 14%;height: 25px;float: left;margin-left: 2%;border: 0px solid red;margin-top: 0.3%">
        <a id="btn6" href="ss" class="easyui-linkbutton" data-options="iconCls:'icon-print'">数据导出</a>
    </div>
    <div style="width: 14%;height: 25px;float: left;margin-left: 2%;border: 0px solid red;margin-top: 0.3%">
        <a id="btn7" href="ss" class="easyui-linkbutton" data-options="iconCls:'icon-reload'">密码重置</a>
    </div>
    <div style="width: 14%;height: 25px;float: left;margin-left: 2%;border: 0px solid red;margin-top: 0.3%">
        <a href="ss" class="easyui-linkbutton" data-options="iconCls:'icon-save'">查看资料</a>
    </div>
    <div style="width: 97%;height: 25px;float: left;margin-left: 2%;margin-top: 0.3%;border: 0px solid red">
        姓名：<input id="name" type="text" style="width:80px;"/>
        手机:<input type="text" style="width:80px;"/>
        QQ:<input type="text" style="width:80px;"/>
        身份证号:<select id="card"  type="text" style="width:80px;"></select>
        日期:<input type="text" style="width:80px;"/> 至 <input type="text" style="width:80px;"/>
        <a id="btn8" href="" class="easyui-linkbutton" data-options="iconCls:'icon-search'">点击选择</a>
    </div>


</div>
<div  style="height: 105%;width: 100%;border: 0px solid red;float: left;margin-left: -18px;margin-top: -18px">
    <table id="dg" style="height: 100px;width: 100px;"></table>
</div>
<div class="dlg-div" style="display: none;">
    <div id="dlg" class="easyui-dialog" style="width:600px;height:320px;padding:10px 20px"
         closed="true" buttons="#dlg-buttons">
        <div class="ftitle">员工信息</div>
        <form id="fm" method="post" novalidate>
            <div class="fitem">
            <span class="item-one">
                <label>账号:</label>
                <input name="number" class="easyui-validatebox textbox" required="true" size="20">
            </span>
                <span class="item-two">
                <label>组别:</label>
                <select class="easyui-combobox" name="groups" class="easyui-validatebox" size="20">
                    <option value="1" selected>一部</option>
                    <option value="2">二部</option>
                </select>
            </span>
            </div>
            <div class="fitem">
          <span class="item-one">
                 <label>权限:</label>
                <select class="easyui-combobox" name="permissions" class="easyui-validatebox" size="20">
                    <option value="1">管理员</option>
                    <option value="2">部长</option>
                    <option value="3" selected>员工</option>
                </select>
            </span>
                <span class="item-two">
                <label>性别:</label>
                <select class="easyui-combobox" name="sex" class="easyui-validatebox" size="20">
                    <option value="man">男</option>
                    <option value="woman">女</option>
                </select>
           </span>
            </div>
            <div class="fitem">
           <span class="item-one">
                <label>姓名:</label>
                <input name="name" class="easyui-validatebox textbox" required="true">
           </span>
                <span class="item-two">
                 <label>手机:</label>
                <input name="phone"  class="easyui-validatebox textbox" required="true">
            </span>
            </div>
            <div class="fitem">
           <span class="item-one">
                <label>QQ:</label>
                <input name="qq">
           </span>
                <span class="item-two">
                 <label>QQ昵称:</label>
                <input name="qqnc">
            </span>
            </div>
            <div class="fitem">
                <label>身份证:</label>
                <input name="card" size="53"  class="easyui-validatebox textbox" required="true">
            </div>
            <div class="fitem">
                <label>住址:</label>
                <input name="address" size="53">
            </div>
            <div class="fitem">
                <label>备注:</label>
                <input name="remark" size="53">
            </div>
        </form>
    </div>
    <div id="dlg-buttons">
        <a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveUser()">保存</a>
        <a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">取消</a>
    </div>
</div>
</body>

<script type="text/javascript">
    $(function(){
        $("#dg").datagrid({
            title:'员工信息表',
            singleSelect: false,
            fitColumns: true,
            fit: true,
            rownumbers: true,
            remoteSort: false,
            columns: [[
                {field: 'Ids', title: 'ID', checkbox: true, width: 8, align: 'center',hidden: 'true'},
                {field: 'memberId', title: '编号', width: 100, align: 'center'},
                {field: 'name', title: '姓名', width: 100, align: 'center'},
                {field: 'sex', title: '性别', width: 100, align: 'center'},
                {field: 'phone', title: '手机号', width: 100, align: 'center'},
                {field: 'wexin', title: '微信号', width: 100, align: 'center'},
                {field: 'qq', title: 'QQ号', width: 100, align: 'center'},
                {field: 'qqnc', title: 'QQ昵称', width: 100, align: 'center'},
                {field: 'card', title: '身份证号', width: 100, align: 'center'},
                {field: 'group', title: '管理分组', width: 100, align: 'center'},
                {
                    field: 'obj', title: '操作', align: 'center', width: 28, formatter: function (value, row, index) {
                    return "<a id='de' onclick=deletes('" + row.ID + "')>删除</a>";
                }
                }
            ]]
        });
        $(".datagrid-toolbar").insertBefore(".datagrid-view");
        tbdata();
    });
    function tbdata(){
        $.ajax({
            url:'/member/getList',
            type:"POST",
            dataType:'json',
            success:function(data){
                console.log(data);
                if(data.code==200){
                    console.log(data.date.result);
                    $("#dg").datagrid("loadData",{total:data.date.totalCount,rows:data.date.result});
                }
            }
        })
    }

    var url;
    function newUser() {
        debugger;
        $('#dlg').dialog('open').dialog('setTitle', '添加用户');
        $('#fm').form('clear');
        url = '/member/save';
    }
    function editUser() {
        debugger;
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            $('#dlg').dialog('open').dialog('setTitle', '编辑用户');
            $('#fm').form('load', row);
            url = '/member/update?id=' + row.memberId;
        }
    }
    function saveUser() {
        debugger;
        $('#fm').form('submit', {
            url: '',
            onSubmit: function () {
                return $(this).form('validate');
            },
            success: function (result) {
                var result = eval('(' + result + ')');
                if (result.success) {
                    $('#dlg').dialog('close');		// close the dialog
                    $('#dg').datagrid('reload');	// reload the user data
                } else {
                    $.messager.show({
                        title: 'Error',
                        msg: result.msg
                    });
                }
            }
        });
    }
    function removeUser() {
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            $.messager.confirm('确定', '你确定要删除此员工吗?', function (r) {
                if (r) {
                    $.post('/member/delete/'+row.memberId, {}, function (result) {
                        //alert(result);
                        if (result.code==200) {
                            tbdata();
                            $('#dg').datagrid('reload');	// reload the user data
                        } else {
                            $.messager.show({	// show error message
                                title: '错误',
                                msg: result.msg
                            });
                        }
                    }, 'json');
                }
            });
        }
    }
    function deletes(id) {
        $.messager.confirm('确定', '你确定要删除此员工吗?', function (r) {
            if (r) {
                $.post('/member/delete/'+row.memberId, {}, function (result) {
                    if (result.code==200) {
                        tbdata();
                        $('#dg').datagrid('reload');	// reload the user data
                    } else {
                        $.messager.show({	// show error message
                            title: '错误',
                            msg: result.msg
                        });
                    }
                }, 'json');
            }
        });
    }


</script>
</html>
