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
    </script>
</head>

<body>
<h2>员工信息管理</h2>
<table id="dg" title="员工信息管理" class="easyui-datagrid" style="width:700px;height:250px"
       url="/member/getList"
       toolbar="#toolbar" pagination="true"
       rownumbers="true" fitColumns="true" singleSelect="true">
    <thead>
    <tr>
        <th field="number" width="50">编号</th>
        <th field="name" width="50">姓名</th>
        <th field="sex" width="50">性别</th>
        <th field="phone" width="50">手机</th>
        <th field="card" width="50">身份证</th>
        <th field="qq" width="50">ＱＱ</th>
        <th field="wexin" width="50">微信账号</th>
        <th field="groups" width="50">管理分组</th>
    </tr>
    </thead>
</table>
<div id="tb" style="padding:3px">
    <span>员工账号:</span>
    <input id="number" style="line-height:26px;border:1px solid #ccc">
    <%--    <span>手机:</span>
        <input id="phone" style="line-height:26px;border:1px solid #ccc">
        <span>身份证:</span>
        <input id="card" style="line-height:26px;border:1px solid #ccc">
        <span>姓名:</span>
        <input id="name" style="line-height:26px;border:1px solid #ccc">
        <span>注册日期:</span>
        <input id="time" class="easyui-datebox" data-options="sharedCalendar:'#cc'">--%>
    <a href="#" class="easyui-linkbutton" plain="true" onclick="doSearch()">查询</a>
</div>
<div id="toolbar">
    <a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newUser()">新增</a>
    <a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editUser()">编辑</a>
    <a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="removeUser()">删除</a>
</div>


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
