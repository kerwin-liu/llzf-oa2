<%--
  Created by IntelliJ IDEA.
  User: liujingtao
  Date: 2017/10/17
  Time: 14:20
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
    <script type="text/javascript" src="../../js/jquery.js"></script>
    <%--<script type="text/javascript" src="../../js/jquery.easyui.min.js"></script>--%>

    <script type="text/javascript" src="../../js/jquery-easyui-1.5.1/jquery.min.js"></script>
    <script type="text/javascript" src="../../js/jquery-easyui-1.5.1/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../../js/tools.js"></script>
    <script type="text/javascript" src="../../js/My97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript" src="../../js/dataformat.js"></script>
    <style type="text/css">
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
        .datagrid-toolbar-a{
            width: 8.1%;
            height: 25px;
            float: left;
            margin-left: 1%;
            border: 0px solid red;
            margin-top: 0.3%
        }
    </style>
</head>
<body>
<div class="datagrid-toolbar" style="height: 65px;width: 100%;border: 0px solid red;">

   <%-- <div class="datagrid-toolbar-a" >
        <a id="btn1" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'">添加客户</a>
    </div>--%>
    <div class="datagrid-toolbar-a">
        <a id="btn2" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">修改资料</a>
    </div>
<%--
    <div class="datagrid-toolbar-a">
        <a id="btn3" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-clear'">成交客户</a>
    </div>--%>

    <div class="datagrid-toolbar-a">
        <a id="btn4" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-large-shapes'">客户追踪</a>
    </div>
    <div class="datagrid-toolbar-a">
        <a id="btn5" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">删除客户</a>
    </div>
    <div class="datagrid-toolbar-a">
        <a id="btn6" href="/client/queryToExcel?khcjlx=0"  class="easyui-linkbutton" data-options="iconCls:'icon-print'">数据导出</a>
    </div>
  <%--  <div class="datagrid-toolbar-a">
        <a id="btn9" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'">数据导入</a>
    </div>--%>
    <div class="datagrid-toolbar-a">
        <a id="btn10" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-large-clipart'">客户移交</a>
    </div>
    <div class="datagrid-toolbar-a">
        <a id="btn11" href="#" class="easyui-linkbutton" style="width: 100px" data-options="iconCls:'icon-undo'">新转入客户</a>
    </div>
    <div class="datagrid-toolbar-a">
        <a id="btn12" href="#" class="easyui-linkbutton"  style="margin-left: 12%" data-options="iconCls:'icon-undo'">返回</a>
    </div>
    <div style="width: 97%;height: 25px;float: left;margin-left: 2%;margin-top: 0.3%;border: 0px solid red">
       <%-- 客户类型:<select id="type" style="width:80px;">
        <option value=""></option>
        <option value="1">一般客户</option>
        <option value="2">潜力客户</option>
        <option value="3">意客客户</option>
        <option value="4">未有兴趣客户</option>
    </select>--%>
           姓名：<input id="khmc" type="text" style="width:80px;"/>
           手机:<input id = "khsjh" type="text" style="width:80px;"/>
           QQ:<input id="khqq" type="text" style="width:80px;"/>
           日期:<input id="cjsjQ" type="text" name="historySearchTime" readonly="readonly" style="width:80px;"/>
           至 <input id="cjsjZ" type="text" name="nowSearchTime" style="width:80px;"/>
           负责人：<input id="memberId" name="mem" style="width:80px;" />
           <a id="btn8" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
    </div>




   <%--   <div style="width: 97%;height: 25px;float: left;margin-left: 2%;margin-top: 0.3%;border: 0px solid red">
            客户类型:<select id="type" style="width:80px;">
            <option value="1">一般客户</option>
            <option value="2">潜力客户</option>
            <option value="3">意客客户</option>
            <option value="4">未有兴趣客户</option>
        </select>
            姓名：<input id="name" type="text" style="width:80px;"/>
            手机:<input id = "phone" type="text" style="width:80px;"/>
            QQ:<input id="qq" type="text" style="width:80px;"/>
            日期:<input id="timeStart" type="text" name="historySearchTime" readonly="readonly" style="width:80px;"/>
            至 <input id="timeEnd" type="text" name="nowSearchTime" style="width:80px;"/>
            负责人：<input id="employee1" name="mem" style="width:80px;" />
            <a id="btn1" href="" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
        </div>
--%>

</div>
<div  style="height: 105%;width: 100%;border: 0px solid red;float: left;margin-left: -18px;margin-top: -18px">
    <table id="dg" style="height: 99%;width: 99%;"></table>
</div>
</body>
<script type="text/javascript">
    var his = [],index=0;
    $(function(){
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
        });
        });
        $("#dg").datagrid({
            title:'成交客户',
            singleSelect: false,
            fitColumns: true,
            fit: true,
            remoteSort: false,
            pagination: true,
            pageNumber:1,
            pageSize:10,
            pageList : [10,20,30],
            rownumbers: true,
            columns: [[
                {field : 'IDs',title : 'IDs',checkbox : true,width : 8,align : 'left'},
                {field: 'khId', title: '编号', width: 50, align: 'left',hidden:true},
                {field: 'khmc', title: '姓名', width: 100, align: 'left'},
                {field: 'khxb', title: '性别', width: 50, align: 'left',formatter:function(value, row, index){
                    var type="";
                    if(value==0){
                        type="男";
                    }
                    if(value==1){
                        type="女";
                    }
                    return type;}},
                {field: 'khsjh', title: '手机号', width: 150, align: 'left'},
                {field: 'khsfzh', title: '身份证号', width: 100, align: 'left'},
                {field: 'khwx', title: '微信号', width: 100, align: 'left'},
                {field: 'khwxnc', title: '微信名', width: 100, align: 'left',hidden:true},
                {field: 'khqq', title: 'QQ号', width: 100, align: 'left'},
                {field: 'khqqnc', title: '昵称', width: 100, align: 'left'},
                {field: 'khlx', title: '客户类型', width: 80, align: 'left',hidden:true,formatter:function(value, row, index){
                    var type="";
                    if(value==1){
                        type="一般客户";
                    }
                    if(value==2){
                        type="潜力客户";
                    }
                    if(value==3){
                        type="意向客户";
                    }
                    if(value==4){
                        type="未有兴趣客户";
                    }
                    return type;
                }},
                {field: 'memberId', title: '负责人', width: 100, align: 'left',hidden:true},
                {field: 'name', title: '负责人', width: 100, align: 'left'},
                {field: 'bz', title: '备注', width: 100, align: 'left'},
                {field: 'khzj', title: '资金', width: 100, align: 'left'},
                {field: 'khdz', title: '地址', width: 100, align: 'left'},
                {field: 'cjsj', title: '归档日期', width: 180, align: 'left',formatter:function(value, row, index){
                    var time = new Date(value);
                    return date2str(time,'yyyy-MM-dd hh:mm:ss');
                }}


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
                tbdata(1,pageSize);
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
        tbdata(1,30);
        select1();
        //修改客户
        $("#btn2").click(function(){
            updata();
        });
        //成交客户
        $("#btn3").click(function(){
            truns();
        });
        //客户追踪
        $("#btn4").click(function(){
            trace();
        });
        //删除客户
        $("#btn5").click(function(){
            deletes();
        });
//转入客户
        $("#btn11").click(function(){
            var data={"byzd":1};
            $.ajax({
                url:'/client/getList?pageIndex=1&pageSize=30',
                type:'POST',//OR GET
                data:data,
                dataType:'json',
                success:function(data){
                    $("#dg").datagrid("loadData",{total:data.date.totalCount,rows:data.date.result});
                }
            })
        });
        //
        $("#btn12").click(function(){
            if(index==0){
                $("#khlx").val("");
                $("#khmc").val("");
                $("#khsjh").val("");
                $("#khqq").val("");
                $("#cjsjQ").val("");
                $("#cjsjZ").val("");
                $("#_easyui_textbox_input1").val("");
                $("#memberId").combobox("unselect",$("#memberId").val());
                tbdata(1,30);
            }else{
                his.splice(index,1);
                index = index-1;
                if(index==0){
                    $("#khlx").val("");
                    $("#khmc").val("");
                    $("#khsjh").val("");
                    $("#khqq").val("");
                    $("#cjsjQ").val("");
                    $("#cjsjZ").val("");
                    $("#_easyui_textbox_input1").val("");
                    $("#memberId").combobox("unselect",$("#memberId").val());
                    tbdata(1,30);
                }else {
                    for (var key in his[index - 1]) {
                        console.log(key == "memberId");
                        if (key == "memberId") {
                            $("#memberId").combobox("select", his[index - 1][key]);
                        } else {
                            $("#" + key).val(his[index - 1][key]);
                        }
                    }
                }
            }
            tbdata(1,30);
        });

        $("#btn10").click(function(){
            var rows= $("#dg").datagrid("getSelections");
            if(rows.length==0){
                tip("请选择至少一条数据进行移交");
            }else {
                createnewwindow("移交客户", "/pages/Customer-allot", 600, 350);
            }
        });
        $("#btn8").click(function(){
            tbdata(1,30);
            exports();
        });
    });
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
        tbdata(pageNumber,pageSize);
    }
    function select1(){
        var url="/member/getAll";
        $.ajax({
            url:url,
            type:'POST',//OR GET
            dataType:'json',
            success:function(data){
                if(data.code==200){
                    var value = data.date,
                        d=[];
                    for (var i=0;i<value.length;i++){
                        d.push({"id":value[i].memberId,"text":value[i].name});
                    }
                    $("#memberId").combobox({
                        valueField:'id',
                        textField:'text',
                        data:d
                    });
                }else{
                    tip(data.msg);
                }
            }
        });
    }

    function truns(){
        var rows= $("#dg").datagrid("getSelections");
        if(rows.length==0){
            tip("请选择一条数据进行修改");
        }else{
            createTrunWindow('成交客户','/pages/Customer-trun-update',600,350);
        }
    }

    function updata(){
        var rows= $("#dg").datagrid("getSelections");
        if(rows.length>1||rows.length==0){
            tip("请选择一条数据进行修改");
        }else{
            createwindow("修改客户", "/pages/Customer-update",600,350);
        }
    }

    function trace(){
        var rows= $("#dg").datagrid("getSelections");
        if(rows.length>1||rows.length==0){
            tip("请选择一条数据进行修改");
        }else{
            createnewwindow("客户追踪", "/pages/Customer-log",700,520);
        }
    }

    function deletes(){
        var rows= $("#dg").datagrid("getSelections");
        if(rows.length==0){
            tip("请至少选择一条数据进行删除");
        }else{
            var ids=[];
            for (var i=0;i<rows.length;i++){
                ids.push(rows[i].khId);
            }
            $.messager.confirm('确定', '你确定要删除吗?', function (r) {
                if (r) {
                    $.post('/client/batchDelete/', {"ids":JSON.stringify(ids)}, function (result) {
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
                            tbdata(1,30);
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


    function exports(){
        var name=$("#name").val(),
            phone=$("#phone").val(),
            /*type=$("#type").val(),*/
            qq=$("#qq").val(),
            timeStart=$("#timeStart").val(),
            timeEnd=$("#timeEnd").val(),
            clientId=$("#employee1").val();
        var data={"khcjlx":1};
        if(clientId){
            data["memberId"]=clientId;
            $("#btn6").attr("href",$("#btn6").attr("href")+"&memberId="+clientId);
        }
        if(type){
            data["khlx"]=type;
            $("#btn6").attr("href",$("#btn6").attr("href")+"&khlx="+type);
        }
        if(name){
            data["khmc"]=name;
            $("#btn6").attr("href",$("#btn6").attr("href")+"&khmc="+name);
        }
        if(phone){
            data["khsjh"]=phone;
            $("#btn6").attr("href",$("#btn6").attr("href")+"&khsjh="+phone);
        }
        if(qq){
            data["khqq"]=qq;
            $("#btn6").attr("href",$("#btn6").attr("href")+"&khqq="+qq);
        }if(timeStart){
            data["cjsjQ"]=timeStart;
            $("#btn6").attr("href",$("#btn6").attr("href")+"&cjsjQ="+timeStart);
        }if(timeEnd){
            data["cjsjZ"]=timeEnd;
            $("#btn6").attr("href",$("#btn6").attr("href")+"&cjsjZ="+timeEnd);
        }


        /* $(this).attr("href","/client/queryToExcel");*/
        /* $.get('');*/
        /* $.ajax({
         url:'/client/queryToExcel',
         dataType:'json',
         data:data,
         success:function(data){
         console.log(data);
         },
         error:function(data){
         }
         })*/
    }
    function tbdata(pageIndex,pageSize){
        var name=$("#name").val(),
            phone=$("#phone").val(),
            type=$("#type").val(),
            qq=$("#qq").val(),
            timeStart=$("#timeStart").val(),
            timeEnd=$("#timeEnd").val(),
            clientId=$("#employee1").val();
        var data={"khcjlx":1};
        if(clientId){
            data["memberId"]=clientId;
        }
        if(type){
            data["khlx"]=type;
        }
        if(name){
            data["khmc"]=name;
        }
        if(phone){
            data["khsjh"]=phone;
        }
        if(qq){
            data["khqq"]=qq;
        }if(timeStart){
            data["cjsjQ"]=timeStart;
        }if(timeEnd){
            data["cjsjZ"]=timeEnd;
        }
        his.push(data);
        index =index+1;
        $.ajax({
            url:'/client/getList?pageIndex='+pageIndex+'&pageSize='+pageSize,
            type: "POST",
            dataType:'json',
            data:data,
            success:function(data){
                $("#dg").datagrid("loadData",{total:data.date.totalCount,rows:data.date.result});
            }
        });
    }
</script>
</html>
