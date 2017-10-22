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
<form id="from" action="/saveLog" target="hidden_frame">
    <div class="ftitle">追踪信息</div>
    <input id="clientId" type="text" name="clientId" style="display: none;"/>
    <div class="fitem">
            <span class="item-one">
                <label>时间:</label>
                <input type="text" name="time" readonly="readonly" style="width:80px;"/>
            </span>
    </div>
    <div class="fitem">
         <span class="item-one">
                <label>内容:</label>
                <input name="clientLog" type="text" style="width:280px;"/>
         </span>
    </div>
</form>
<iframe name='hidden_frame' id="hidden_frame" style='display: none'></iframe>
<script type="text/javascript">
    $("#clientId").val($("#id").val())
    $("input[name='time']").attr("class","Wdate").attr("style","height:20px;width:140px;").click(function(){WdatePicker({
        dateFmt:'yyyy-MM-dd HH:mm:ss',
    });});
    $('#hidden_frame').load(function(){
        var text=$(this).contents().find("body").text();
        // 根据后台返回值处理结果
        try {
            var j=$.parseJSON(text);
            $.messager.alert('提示',j.msg);
            $.ajax({
                url:'/client/getLog/'+id,
                dataType:'json',
                success:function(data){
                    if(data.code==200){
                        var list = data.date;
                        var value = "";
                        $("#logs").text("");
                        for(var i=0;i<list.length;i++) {
                            var time = new Date(list[i].time);
                            value+=date2str(time,'yyyy-MM-dd hh:mm:ss')+"   "+list[i].clientLog+"\n";
                        }
                        $("#logs").text(value);
                    }else{
                        tip(data.msg);
                    }
                }

            });
        }catch (e){

        }

    });

</script>
</body>
</html>
