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
    </style>
</head>
<body>
<div class="datagrid-toolbar" style="height: 31px;width: 100%;border: 0px solid red;">

        <div style="width: 97%;height: 25px;float: left;margin-left: 2%;margin-top: 0.3%;border: 0px solid red">
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


</div>
<div  style="height: 105%;width: 100%;border: 0px solid red;float: left;margin-left: -18px;margin-top: -18px">
    <table id="dg" style="height: 99%;width: 99%;"></table>
</div>
</body>
<script type="text/javascript">
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
            title:'本地客户',
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
                {field : 'IDs',title : 'IDs',checkbox : true,width : 8,align : 'center'},
                {field: 'khId', title: '编号', width: 50, align: 'center',hidden:true},
                {field: 'khmc', title: '姓名', width: 100, align: 'center'},
                {field: 'khxb', title: '性别', width: 100, align: 'center',formatter:function(value, row, index){
                    var type="";
                    if(value==0){
                        type="男";
                    }
                    if(value==1){
                        type="女";
                    }
                    return type;}},
                {field: 'khsjh', title: '手机号', width: 100, align: 'center'},
                {field: 'khsfzh', title: '身份证号', width: 100, align: 'center'},
                {field: 'khwx', title: '微信号', width: 100, align: 'center'},
                {field: 'khwxnc', title: '微信名', width: 100, align: 'center',hidden:true},
                {field: 'khqq', title: 'QQ号', width: 100, align: 'center'},
                {field: 'khlx', title: '客户类型', width: 80, align: 'center',formatter:function(value, row, index){
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
                {field: 'memberId', title: '负责人', width: 100, align: 'center',hidden:true},
                {field: 'name', title: '负责人', width: 100, align: 'center'},
                {field: 'bz', title: '备注', width: 100, align: 'center'},
                {field: 'cjsj', title: '归档日期', width: 180, align: 'center',formatter:function(value, row, index){
                    var time = new Date(value);
                    return date2str(time,'yyyy-MM-dd hh:mm:ss');
                }},
                {field: 'qqnc', title: 'QQ昵称', width: 100, align: 'center',hidden:true},
                {field: 'zj', title: '资金', width: 100, align: 'center',hidden:true},
                {field: 'address', title: '地址', width: 100, align: 'center',hidden:true}
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
        $("#btn1").click(function(){
            var name=$("#name").val(),
                phone=$("#phone").val(),
                type=$("#type").val(),
                qq=$("#qq").val(),
                timeStart=$("#timeStart").val(),
                timeEnd=$("#timeEnd").val(),
                clientId=$("#employee1").val();
            var data={"khcjlx":0};
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

          console.log(data);
            $.ajax({
                url:'/client/getList?pageIndex=1&pageSize=30',
                type:'POST',//OR GET
                data:data,
                dataType:'json',
                success:function(data){
                    console.log(data);
                    $("#dg").datagrid("loadData",{total:data.date.totalCount,rows:data.date.result});
                }
            })
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
                    d[0].selected=true;
                    $("#employee1").combobox({
                        valueField:'id',
                        textField:'text',
                        data:d
                    });
                }else{
                    tip(data.msg);
                }
            }
        })
    }

    function tbdata(pageIndex,pageSize){
        var d = {"khcjlx":1};
        $.ajax({
            url:'/client/getList?pageIndex='+pageIndex+'&pageSize='+pageSize,
            type: "POST",
            dataType:'json',
            data:d,
            success:function(data){
                $("#dg").datagrid("loadData",{total:data.date.totalCount,rows:data.date.result});
            }
        });
    }
</script>
</html>
