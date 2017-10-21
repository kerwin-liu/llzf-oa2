<%--
  Created by IntelliJ IDEA.
  User: liujingtao
  Date: 2017/10/21
  Time: 13:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html style="width: 100%;height: 100%">
<head>
    <title></title>

</head>
<body>
<div style="width: 48%;height: 100%;float: left;border: 1px solid red"></div>
<div style="width: 48%;height: 100%;float: left;border: 1px solid red"></div>
<script type="text/javascript">
    var row = $("#dg").datagrid("getSelections");
    console.log(row);
</script>
</body>
</html>
