<%--
  Created by IntelliJ IDEA.
  User: liujingtao
  Date: 2017/10/17
  Time: 14:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta charset="utf-8" />
<title></title>

</head>

<body class="">
	<form id="from" action="/client/upload" method="post"
		enctype="multipart/form-data" target="hidden_frame">
		<table>
			<tr>
				<td><input type="file" name="file"  accept="application/vnd.ms-excel"></td>
			</tr>
			<tr>
				<td>
					<a  href="/client/download" class="easyui-linkbutton"  plain="true" data-options="iconCls:'icon-print'">下载导入模板</a>
				</td>

			</tr>
		</table>
	</form>
	<iframe name='hidden_frame' id="hidden_frame" style='display: none'></iframe>
	<script type="text/javascript">
		$('#hidden_frame').load(function() {
			var text = $(this).contents().find("body").text();
			// 根据后台返回值处理结果
			try {
				var j = $.parseJSON(text);
				if (j.success) {
					tip("导入成功");
					if (window.opener)
					{
					    window.opener.location.reload();
					}
				} else {
					tip(j.msg + "行出错！！请检查");
					
					if (window.opener)
					{
					    window.opener.location.reload();
					}
				}
			} catch (e) {
				// TODO: handle exception
			}

		});
	</script>
</body>
</html>
