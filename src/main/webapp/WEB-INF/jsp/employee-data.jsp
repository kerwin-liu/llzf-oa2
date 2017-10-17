<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="en">
<head>
    <title>员工信息管理</title>
    <link rel="stylesheet" type="text/css" href="http://www.jeasyui.net/Public/js/easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="http://www.jeasyui.net/Public/js/easyui/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="http://www.jeasyui.net/Public/js/easyui/demo/demo.css">
    <script type="text/javascript" src="../../js/jquery.js"></script>
    <%--<script type="text/javascript" src="../../js/jquery.easyui.min.js"></script>--%>
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.4.4.min.js"></script>
    <script type="text/javascript" src="http://www.jeasyui.net/Public/js/easyui/jquery.easyui.min.js"></script>
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
    <script type="text/javascript">
        var url;
        function newUser() {
            $('#dlg').dialog('open').dialog('setTitle', 'New User');
            $('#fm').form('clear');
            url = '/member/save';
        }
        function editUser() {
            var row = $('#dg').datagrid('getSelected');
            if (row) {
                $('#dlg').dialog('open').dialog('setTitle', 'Edit User');
                $('#fm').form('load', row);
                url = '/member/update?id=' + row.id;
            }
        }
        function saveUser() {
            $('#fm').form('submit', {
                url: url,
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
                        $.post('/member/delete', {id: row.id}, function (result) {
                            if (result.success) {
                                $('#dg').datagrid('reload');	// reload the user data
                            } else {
                                $.messager.show({	// show error message
                                    title: 'Error',
                                    msg: result.msg
                                });
                            }
                        }, 'json');
                    }
                });
            }
        }
        function doSearch() {
            $('#tt').datagrid('load', {
                itemid: $('#itemid').val(),
                productid: $('#productid').val()
            });
        }
        $(function(){
            $("#dg").datagrid({
                title:'员工信息表',
                singleSelect: false,
                fitColumns: true,
                fit: true,
                rownumbers: true,
                remoteSort: false,
                columns: [[
                    {field: 'memberId', title: 'IDs', checkbox: true, width: 8, align: 'center'},
                    {field: 'number', title: '编号', width: 100, align: 'center', hidden: 'true'},
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

        })
    </script>
</head>
<body>
<h2>员工信息管理</h2>
<div id="toolbar"　class="datagrid-toolbar" style="width: 100%;border: 0px solid red;">

    <div style="width: 14%;height: 25px;float: left;margin-left: 2%;border: 0px solid red;margin-top: 0.3%">
        <a id="btn1" class="easyui-linkbutton" data-options="iconCls:'icon-add'"  onclick="newUser()">添加员工</a>
    </div>
    <div style="width: 14%;height: 25px;float: left;margin-left: 2%;border: 0px solid red;margin-top: 0.3%">
        <a id="btn2" class="easyui-linkbutton" data-options="iconCls:'icon-edit'"　onclick="editUser()">修改资料</a>
    </div>
    </div>
    <div style="width: 14%;height: 25px;float: left;margin-left: 2%;border: 0px solid red;margin-top: 0.3%">
        <a id="btn5"  class="easyui-linkbutton" data-options="iconCls:'icon-add'"　onclick="removeUser()">删除员工</a>
    </div>
    <div style="width: 14%;height: 25px;float: left;margin-left: 2%;border: 0px solid red;margin-top: 0.3%">
        <a id="btn6" href="ss" class="easyui-linkbutton" data-options="iconCls:'icon-add'">数据导出</a>
    </div>

    <div style="width: 97%;height: 25px;float: left;margin-left: 2%;margin-top: 0.3%;border: 0px solid red">
       <span>类型:</span>
        <input type="text"/>
        <span>员工账号:</span>
        <input id="number" style="line-height:26px;border:1px solid #ccc" size="10">
        <span>手机:</span>
        <input id="phone" style="line-height:26px;border:1px solid #ccc"  size="10">
        <span>身份证:</span>
        <input id="card" style="line-height:26px;border:1px solid #ccc"  size="10">
        <span>姓名:</span>
        <input id="name" style="line-height:26px;border:1px solid #ccc"  size="10">
        <span>注册日期:</span>
        <input id="time" class="easyui-datetimebox" data-options="sharedCalendar:'#cc'"  size="10" style="line-height:26px;border:1px solid #ccc">
    </div>


</div>
<div id="dg" style="height: 99%;width: 99%;border: 1px solid red;float: left;margin-left: 0.3%"></div>
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
</body>
</html>
