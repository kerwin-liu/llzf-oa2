<%--
  Created by IntelliJ IDEA.
  User: xixin
  Date: 2017/10/17
  Time: 22:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
    <script type="text/javascript" src="../../js/My97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript" src="../../js/dataformat.js"></script>
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

        .item-one {
            width: 200px;
        }

        .item-two {
            width: 200px;
        }

        select {
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
        <a id="btn10" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save'">开通</a>
    </div>
    <div style="width: 14%;height: 25px;float: left;margin-left: 2%;border: 0px solid red;margin-top: 0.3%">
        <a id="btn9" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save'">查看密码</a>
    </div>
    <div style="width: 14%;height: 25px;float: left;margin-left: 2%;border: 0px solid red;margin-top: 0.3%">
        <a id="btn7" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-reload'">密码重置</a>
    </div>
    <div style="width: 97%;height: 25px;float: left;margin-left: 2%;margin-top: 0.3%;border: 0px solid red">
        姓名：<input id="name" type="text" style="width:80px;"/>
        手机:<input id="phone" type="text" style="width:80px;"/>
        QQ:<input id="qq" type="text" style="width:80px;"/>
        身份证号:<select id="card" type="text" style="width:80px;"></select>
        日期:<input id="historyTime" type="text" name="historySearchTime" readonly="readonly" style="width:80px;"/>
        至 <input id="nowTime" type="text" name="nowSearchTime" readonly="readonly" style="width:80px;"/>
        <a id="btn8" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'">点击选择</a>
    </div>


</div>
<div style="height: 105%;width: 100%;border: 0px solid red;float: left;margin-left: -18px;margin-top: -18px">
    <table id="dg" style="height: 100px;width: 100px;"></table>
</div>
<div class="dlg-div" style="display: none;">
    <div id="dlg" class="easyui-dialog" style="width:600px;height:320px;padding:10px 20px"
         closed="true" buttons="#dlg-buttons">
        <div class="ftitle">员工信息</div>
        <form id="fm" method="post" action="">
            <div class="fitem">
            <span class="item-one">
                <label>账号:</label>
                <input name="number" value="123" class="easyui-validatebox textbox number" required="true" size="20">
            </span>
                <span class="item-two">
                <label>组别:</label>
                <select id="groups" class="easyui-combobox" name="groups" class="easyui-validatebox groups" size="20">
                    <option value="1" selected>一部</option>
                    <option value="2">二部</option>
                </select>
            </span>
            </div>
            <div class="fitem">
          <span class="item-one">
                 <label>权限:</label>
                <select id="permissions" class="easyui-combobox" name="permissions" class="easyui-validatebox permissions" size="20">
                    <option value="1">管理员</option>
                    <option value="2">部长</option>
                    <option value="3" selected>员工</option>
                </select>
            </span>
                <span class="item-two">
                <label>性别:</label>
                <select id="sex" class="easyui-combobox" name="sex" class="easyui-validatebox sex" size="20">
                    <option value=0>男</option>
                    <option value=1>女</option>
                </select>
           </span>
            </div>
            <div class="fitem">
           <span class="item-one">
                <label>姓名:</label>
                <input value="test" name="name" class="easyui-validatebox textbox name" required="true">
           </span>
                <span class="item-two">
                 <label>手机:</label>
                <input value="123455" name="phone" class="easyui-validatebox textbox phone" required="true">
            </span>
            </div>
            <div class="fitem">
           <span class="item-one">
                <label>QQ:</label>
                <input name="qq" class="qq">
           </span>
                <span class="item-two">
                 <label>QQ昵称:</label>
                <input name="qqnc" class="qqnc">
            </span>
            </div>
            <div class="fitem">
                <label>身份证:</label>
                <input value="12134356" name="card" size="53" class="easyui-validatebox textbox card" required="true">
            </div>
            <div class="fitem">
                <label>住址:</label>
                <input name="address" class="address" size="53">
            </div>
            <div class="fitem">
                <label>备注:</label>
                <input name="remark" class="remark" size="53">
            </div>
        </form>
        <div id="dlg-buttons">
            <a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveUser()">保存</a>
            <a href="#" class="easyui-linkbutton" iconCls="icon-cancel"
               onclick="javascript:$('#dlg').dialog('close')">取消</a>
        </div>
    </div>
</div>
<div class="info-div" style="display: none;">
    <div id="info" class="easyui-dialog" style="width:300px;height:200px;padding:10px 20px"
         closed="true">
        <div class="ftitle">用户信息</div>
        <div class="fitem">
            <span class="item-one">
                <label>用户名:</label>
                <span id="userName"></span>
            </span>
        </div>
        <div class="fitem">
               <span class="item-one">
                     <label>密码:</label>
                     <span id="password"></span>
                </span>
        </div>
    </div>
</div>
<div class="password-div" style="display: none;">
    <div id="password-info" class="easyui-dialog" style="width:300px;height:200px;padding:10px 20px"
         closed="true">
        <div class="ftitle">重置密码</div>
        <div class="fitem">
            <label>密码:</label>
            <span id="revert-password"></span>
        </div>
    </div>
</div>
</body>

<script type="text/javascript">
    $(function () {
        var myDate = new Date();
        var historyTimeString= date2str(getBeforeTimeByMinute(myDate,-60),'yyyy-MM-dd hh:mm:ss'),
            nowTimeString= date2str(myDate,'yyyy-MM-dd hh:mm:ss');
        // $("input[name='historySearchTime']").val(historyTimeString);
        $("input[name='historySearchTime']").attr("class","Wdate").attr("style","height:20px;width:140px;").click(function(){WdatePicker({
            dateFmt:'yyyy-MM-dd HH:mm:ss',
        });});
        //$("input[name='nowSearchTime']").val(nowTimeString);
        $("input[name='nowSearchTime']").attr("class","Wdate").attr("style","height:20px;width:140px;").click(function(){WdatePicker({
            dateFmt:'yyyy-MM-dd HH:mm:ss',
        });});
        $("#dg").datagrid({
            title: '员工信息表',
            singleSelect: true,
            fitColumns: true,
            fit: true,
            remoteSort: false,
            pagination: true,
            pageNumber:1,
            pageSize:10,
            pageList : [10,20,30],
            rownumbers: true,
            columns: [[
                {field: 'memberId', title: 'ID', checkbox: true, width: 8, align: 'center', hidden: 'true'},
                {field: 'number', title: '编号', width: 100, align: 'center'},
                {field: 'name', title: '姓名', width: 100, align: 'center'},
                {field: 'sex', title: '性别', width: 100, align: 'center',formatter:function(value, row, index){
                    var sex="";
                    if(row.sex==0){
                        sex="男";
                    }else if(row.sex==1){
                        sex="女";
                    }
                    return sex;
                }},
                {field: 'phone', title: '手机号', width: 100, align: 'center'},
                {field: 'wexin', title: '微信号', width: 100, align: 'center'},
                {field: 'qq', title: 'QQ号', width: 100, align: 'center'},
                {field: 'qqnc', title: 'QQ昵称', width: 100, align: 'center'},
                {field: 'card', title: '身份证号', width: 100, align: 'center'},
                {field: 'open', title: '状态', width: 100, align: 'center',formatter:function(value, row, index){
                    var open="";
                    if(row.open==0){
                        open="未开通";
                    }else if(row.open==1){
                        open="已开通";
                    }
                    return open;
                }},
                {field: 'group', title: '管理分组', width: 100, align: 'center'},
                {
                    field: 'obj', title: '操作', align: 'center', width: 28, formatter: function (value, row, index) {
                    return "<a id='de' onclick=deletes('" + row.memberId + "')>删除</a>";
                }
                }
            ]]
        }).datagrid("getPager").pagination({
            onBeforeRefresh : function(pageNumber, pageSize) {
//				var $getPager = $("#dg").datagrid('getPager');
//	            var $pagination = $($getPager).pagination("options");
//            	$pagination.pageNumber = 1;
            },
            onRefresh : function(pageNumber, pageSize) {

            },
            onChangePageSize:function(pageSize){
                var $getPager = $("#dg").datagrid('getPager');
                var $pagination = $($getPager).pagination("options");

            },
            onSelectPage : function(pageNumber, pageSize) {
                var gridOpts = $('#dg').datagrid('options');
                gridOpts.pageNumber = pageNumber;
                gridOpts.pageSize = pageSize;
                findDataByWhere("dg", pageNumber, pageSize);

            }
        });
        $('#dg').datagrid('getPager').pagination({
            beforePageText : '',
            afterPageText : '/{pages}',
            displayMsg : '{from}-{to}共{total}条',
            showPageList : false,
            showRefresh : true
        });

        $(".datagrid-toolbar").insertBefore(".datagrid-view");
        tbdata();
        //查询
        $("#btn8").click(function () {
            var data={};
            data["name"]=$("#name").val();
            data["phone"]=$("#phone").val();
            data['qq']=$("#qq").val();
            data["card"]=$("#card").val();
            data["time"]=$("#time").val();
            $.ajax({
                url: '/member/getList?pageIndex=1&pageSize=10',
                type: "POST",
                dataType: 'json',
                data:data,
                success: function (data) {
                    if (data.code == 200) {
                        console.log(data.date.result);
                        $("#dg").datagrid("loadData", {total: data.date.totalCount, rows: data.date.result});
                    }
                }
            });
        });
        //开通用户
        $("#btn10").click(function () {
            var row = $('#dg').datagrid('getSelected');
            if(row){
                $.post('/user/creat/'+row.memberId,{} , function (result) {
                    if (result.code == 200) {
                        alert(result.msg);
                    } else {
                        alert(result.msg);
                     /*   $.messager.show({
                            title: '错误',
                            msg: result.msg
                        });*/
                    }
                }, 'json');
            }else{
                alert("请选中用户")
            }

        });
        //查看用户密码
        $("#btn9").click(function () {
            var row = $('#dg').datagrid('getSelected');
            if(row){
                $.post('/user/getOne/'+row.memberId,{} , function (result) {
                    if (result.code == 200) {
                        $('#info').dialog('open').dialog('setTitle', '查看用户密码');
                        $("#userName").html(result.date.userName);
                        $("#password").html(result.date.password);
                    } else {
                        alert(result.msg);
                    }
                }, 'json');
            }else{
                alert("请选中用户");
            }

        });

        //密码重置
        $("#btn7").click(function () {
            var row = $('#dg').datagrid('getSelected');
            if(row){
                $.post('/user/passwordReset/'+row.memberId,{} , function (result) {
                    if (result.code == 200) {
//                        $('#password-info').dialog('open').dialog('setTitle', '密码重置');
//                        $("#revert-password").html(result.date.password);
                        alert(result.msg);
                    } else {
                        alert(result.msg);
                    }
                }, 'json');
            }else{
                alert("请选中用户");
            }
        })
    });
    function tbdata() {
        $.ajax({
            url: '/member/getList?pageIndex=1&pageSize=10',
            type: "POST",
            processData: false,
            dataType: 'text',
            success: function (data) {
                data = data.replace(/id\":(\d+),/g,"id\":\"$1\",");
                data = JSON.parse(data);
                console.log(data);
                if (data.code == 200) {

                    $("#dg").datagrid("loadData", {total: data.date.totalCount, rows: data.date.result});
                }
            }
        })
    }

    var url;
    function newUser() {
        $('#dlg').dialog('open').dialog('setTitle', '添加用户');
        $('#fm').form('clear');
        url = '/member/save';
    }
    function editUser() {
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            $('#dlg').dialog('open').dialog('setTitle', '编辑用户');
            $('#fm').form('load', row);
            url = '/member/update?id=' + row.memberId;
        }
    }
    function saveUser() {
        var data = {};
        data["number"] = $(".number").val();
        data["groups"] = $('#groups').find("option:selected").val();
        data["permissions"]=$('#permissions').find("option:selected").val();
        data["sex"]=$('#sex').find("option:selected").val();
        data["name"]=$(".name").val();
        data["phone"]=$(".phone").val();
        data["qq"]=$(".qq").val();
        data["qqnc"]=$(".qqnc").val();
        data["card"]=$(".card").val();
        data["address"]=$(".address").val();
        data["remark"]=$(".remark").val();
        $.ajax({
            url: url,
            dataType: 'json',
            data: data,
            type: "POST",
            success: function (data) {
                if (data.code == 200) {
                    $('#dlg').dialog('close');		// close the dialog
//                    $('#dg').datagrid('reload');	// reload the user data
                    tbdata();
                } else {
                    alert(data.msg);
                }
            }
        })
    }
    function removeUser() {
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            $.messager.confirm('确定', '你确定要删除此员工吗?', function (r) {
                if (r) {
                    $.post('/member/delete/' + row.memberId, {}, function (result) {
                        //alert(result);
                        if (result.code == 200) {
                            tbdata();
//                            $('#dg').datagrid('reload');	// reload the user data
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
                $.post('/member/delete/' + id, {}, function (result) {
                    if (result.code == 200) {
                        tbdata();
//                        $('#dg').datagrid('reload');	// reload the user data
                    } else {
                        alert(result.msg);
                    }
                }, 'json');
            }
        });
    }

    function findDataByWhere(id, pageNumber, pageSize) {
        var content="{";
        $tbody = $("#"+id+"");
        $tbody.find(':input, select').each(function(i){
            var $this = $(this), name = $this.attr('id'), val = $this.val();
            content += '"'+name+'":"'+val+'",';
        });
        content=content.substring(0,content.length-1);
        content+="}";
        var pages = '{"page":' +  pageNumber + ', "rows":' + pageSize + '}';
        if (pageNumber.length == 0 || pageSize == 0) {
            pages = '';
        }
        var url = '/member/getList?pageIndex='+pageNumber+'&pageSize='+pageSize;
        console.log(url);
        $.ajax({
            url:url,
            type: "POST",
            dataType:'json',
            success:function(data){
                console.log(data);
                $("#dg").datagrid("loadData",{total:data.date.totalCount,rows:data.date.result});
            }
        });
    }
</script>
</html>
