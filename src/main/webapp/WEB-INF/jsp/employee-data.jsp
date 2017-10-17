<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="en">
<head>
    <title>员工信息管理</title>
</head>
<body>
<table id="dg" title="员工信息表" style="width:1000px;height:550px"
       url="/member/getList"
       toolbar="#toolbar" pagination="true"
       fitColumns="true" singleSelect="true">
    <thead>
    <tr>
        <th field="number" width="50">编号</th>
        <th field="name" width="50">姓名</th>
        <th field="sex" width="50">性别</th>
    </tr>
    </thead>
</table>
<div id="toolbar">
    <a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newItem()">新增</a>
    <a href="#" class="easyui-linkbutton" iconCls="icon-update" plain="true" onclick="newItem()">修改</a>
    <a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroyItem()">删除</a>
</div>

</body>
<<script type="text/javascript" src="../../js/jquery.js"></script>
<%--<script type="text/javascript" src="../../js/jquery.easyui.min.js"></script>--%>
<script type="text/javascript" src="http://www.w3cschool.cc/try/jeasyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="http://www.w3cschool.cc/try/jeasyui/datagrid-detailview.js"></script>
<script type="text/javascript">
    $(function(){
        $('#dg').datagrid({
            view: detailview,
            detailFormatter:function(index,row){
                return '<div class="ddv"></div>';
            },
            onExpandRow: function(index,row){
                var ddv = $(this).datagrid('getRowDetail',index).find('div.ddv');
                ddv.panel({
                    border:false,
                    cache:true,
                    href:'member/getList?index='+index,
                    onLoad:function(){
                        $('#dg').datagrid('fixDetailRowHeight',index);
                        $('#dg').datagrid('selectRow',index);
                        $('#dg').datagrid('getRowDetail',index).find('form').form('load',row);
                    }
                });
                $('#dg').datagrid('fixDetailRowHeight',index);
            }
        });
    });
    function saveItem(index){
        var row = $('#dg').datagrid('getRows')[index];
        var url = row.isNewRecord ? '/member/save' : '/member/updae?id='+row.id;
        $('#dg').datagrid('getRowDetail',index).find('form').form('submit',{
            url: url,
            onSubmit: function(){
                return $(this).form('validate');
            },
            success: function(data){
                data = eval('('+data+')');
                data.isNewRecord = false;
                $('#dg').datagrid('collapseRow',index);
                $('#dg').datagrid('updateRow',{
                    index: index,
                    row: data
                });
            }
        });
    }
    function cancelItem(index){
        var row = $('#dg').datagrid('getRows')[index];
        if (row.isNewRecord){
            $('#dg').datagrid('deleteRow',index);
        } else {
            $('#dg').datagrid('collapseRow',index);
        }
    }
    function destroyItem(){
        var row = $('#dg').datagrid('getSelected');
        if (row){
            $.messager.confirm('确认','你确定要移除此员工吗？',function(r){
                if (r){
                    var index = $('#dg').datagrid('getRowIndex',row);
                    $.post('/member/delete',{id:row.id},function(){
                        $('#dg').datagrid('deleteRow',index);
                    });
                }
            });
        }
    }
    function newItem(){
        $('#dg').datagrid('appendRow',{isNewRecord:true});
        var index = $('#dg').datagrid('getRows').length - 1;
        $('#dg').datagrid('expandRow', index);
        $('#dg').datagrid('selectRow', index);
    }
</script>
</html>
