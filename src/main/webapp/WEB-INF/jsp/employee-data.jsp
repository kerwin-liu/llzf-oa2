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
        #from {
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
            width: 70px;
        }
        .item-one {
            width: 300px;
            padding-left: 10px;
        }

        .item-two {
            width: 300px;
        }

        select {
            width: 172px;
        }
    </style>
</head>
<body>
<div class="datagrid-toolbar" style="height: 60px;width: 100%;border: 0px solid red;">

    <div style="width: 12%;height: 25px;float: left;margin-left: 2%;border: 0px solid red;margin-top: 0.3%">
        <a id="btn1" class="easyui-linkbutton" data-options="iconCls:'icon-add'">添加员工</a>
    </div>
    <div style="width: 12%;height: 25px;float: left;margin-left: 2%;border: 0px solid red;margin-top: 0.3%">
        <a id="btn2" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">修改资料</a>
    </div>
    <div style="width: 12%;height: 25px;float: left;margin-left: 2%;border: 0px solid red;margin-top: 0.3%">
        <a id="btn3" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="removeUser()">删除员工</a>
    </div>
    <div style="width: 12%;height: 25px;float: left;margin-left: 2%;border: 0px solid red;margin-top: 0.3%">
        <a id="btn4" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save'">开通</a>
    </div>
    <div style="width: 12%;height: 25px;float: left;margin-left: 2%;border: 0px solid red;margin-top: 0.3%">
        <a id="btn5" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save'">查看密码</a>
    </div>
    <div style="width: 12%;height: 25px;float: left;margin-left: 2%;border: 0px solid red;margin-top: 0.3%">
        <a id="btn6" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-reload'">密码重置</a>
    </div>
    <div style="width: 12%;height: 25px;float: left;margin-left: 2%;border: 0px solid red;margin-top: 0.3%">
        <a id="btn11" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-undo'">返回</a>
    </div>
    <div style="width: 97%;height: 25px;float: left;margin-left: 2%;margin-top: 0.3%;border: 0px solid red">
        编号:<input id="number-search" type="text" style="width:80px;"/>
        姓名：<input id="name-search" type="text" style="width:80px;"/>
        手机:<input id="phone-search" type="text" style="width:80px;"/>
        身份证号:<input id="card-search" type="text" style="width:80px;"></input>
        <a id="btn7" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
    </div>


</div>
<div style="height: 105%;width: 100%;border: 0px solid red;float: left;margin-left: -18px;margin-top: -18px">
    <table id="dg" style="height: 100px;width: 100px;"></table>
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
    var data_url= '/member/getList';
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
            singleSelect: false,
            fitColumns: true,
            fit: true,
            remoteSort: false,
            pagination: true,
            pageNumber:1,
            pageSize:30,
            pageList : [10,20,30],
            rownumbers: true,
            columns: [[
                {field : 'IDs',title : 'IDs',checkbox : true,width : 8,align : 'center'},
                {field: 'memberId', title: 'ID', checkbox: true, width: 50, align: 'center', hidden: 'true'},
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
                {field: 'groupName', title: '部门', width: 100, align: 'center'},
                {field: 'permissions', title: '权限',align: 'center',hidden: 'true'},
                {field: 'groups', title: '部门id', align: 'center',hidden: 'true'},
                {field: 'address', title: '地址', align: 'center',hidden: 'true'},
                {field: 'remark', title: '备注', align: 'center',hidden: 'true'},
                {field: 'wexin', title: '微信', align: 'center',hidden: 'true'},
                {field: 'wPhone', title: '绑定手机', align: 'center',hidden: 'true'},
                {field: 'jjlxr', title: '紧急联系人', align: 'center',hidden: 'true'},
                {field: 'jjlxrsj', title: '紧急联系人手机号', align: 'center',hidden: 'true'},
                {field: 'sugx', title: '所属关系', align: 'center',hidden: 'true'}
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
                tbdata(data_url,1,pageSize);
            },
            onSelectPage : function(pageNumber, pageSize) {
                var gridOpts = $('#dg').datagrid('options');
                gridOpts.pageNumber = pageNumber;
                gridOpts.pageSize = pageSize;
                findDataByWhere("dg", pageNumber, pageSize);

            }
        });
        $('#dg').datagrid('getPager').pagination({
            pageSize:30,
            pageList:[30,50,100],
            beforePageText : '',
            afterPageText : '/{pages}',
            displayMsg : '{from}-{to}共{total}条',
            showPageList : true,
            showRefresh : true
        });

        $(".datagrid-toolbar").insertBefore(".datagrid-view");
        tbdata(data_url,1,30);
        //添加员工
        $("#btn1").click(function(){
            createwindow("添加员工", "/pages/employee-add",600,450);
        });
        //修改员工
        $("#btn2").click(function(){
            updata();
        });
        //开通用户
        $("#btn4").click(function () {
            debugger;
            var row = $('#dg').datagrid('getSelections');
            if(row.length>1){
                alert("请选中一个用户")
            }else if(row.length==1){
                $.post('/user/creat/'+row[0].memberId,{} , function (result) {
                    if (result.code == 200) {
                        alert(result.msg);
                        setTimeout(function () {
                            tbdata(data_url,1,30);
                        },100);

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
        $("#btn5").click(function () {
            var row = $('#dg').datagrid('getSelections');
            if(row.length==1){
                $.post('/user/getOne/'+row[0].memberId,{} , function (result) {
                    if (result.code == 200) {
                        $('#info').dialog('open').dialog('setTitle', '查看用户密码');
                        $("#userName").html(result.date.userName);
                        $("#password").html(result.date.password);
                    } else {
                        alert(result.msg);
                    }
                }, 'json');
            }else if(row.length>1){
                alert("不支持多选，请选中一个用户");
            }else{
                alert("请选中用户");
            }

        });
        //密码重置
        $("#btn6").click(function () {
            var row = $('#dg').datagrid('getSelections');
            if(row.length==1){
                $.post('/user/passwordReset/'+row[0].memberId,{} , function (result) {
                    if (result.code == 200) {
//                        $('#password-info').dialog('open').dialog('setTitle', '密码重置');
//                        $("#revert-password").html(result.date.password);
                        alert(result.msg);
                        $("#btn5").click();
                    } else {
                        alert(result.msg);
                    }
                }, 'json');
            }else if(row.length>1){
                alert("不支持多选，请选中一个用户");
            }else{
                alert("请选中用户");
            }
        });
        //查询
        $("#btn7").click(function () {
            var data={};
            data["name"]=$("#name-search").val();
            data["phone"]=$("#phone-search").val();
            data['number']=$("#number-search").val();
            data["card"]=$("#card-search").val();
            $.ajax({
                url: '/member/getList?pageIndex=1&pageSize=30',
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

        $("#btn11").click(function(){
            window.history.go(-1);
        });


    });

    function updata(){
        var rows= $("#dg").datagrid("getSelections");
        if(rows.length>1||rows.length==0){
            tip("请选择一条数据进行修改");
        }else{
            createwindow("修改员工", "/pages/employee-update",600,450);
        }
    }
    function removeUser() {
        var row = $('#dg').datagrid('getSelections');
        if(row.length>0){
            var ids=[];
            for(var i=0;i<row.length;i++){
                ids.push(row[i].memberId)
            }
            console.log(ids);
            $.messager.confirm('确定', '你确定要删除员工吗?', function (r) {
                if (r) {
                    $.post('/member/batchDelete', {"ids":JSON.stringify(ids)}, function (result) {
                        //alert(result);
                        if (result.code == 200) {
                            console.log(result);
                            var str=result.msg+"\r"+"删除失败列表："+"\r";
                            if(result.date!=null && result.date.length>0){
                                var json={};
                                for(var i=0;i<result.date.length;i++){
                                    var nameList=json[result.date[i].error];
                                    if(typeof(nameList)=="undefined"){
                                        nameList=[];
                                    }
                                    nameList.push(result.date[i].name);
                                    var s="原因："+result.date[i].error+"\r"+"删除失败人员："+nameList+"\r";
                                    str+=s
                                }
                                alert(str);
                            }else{
                                alert(result.msg);
                            }
                            tbdata(data_url,1,30);
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
