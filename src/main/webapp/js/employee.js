var url;
function newUser() {
    alert(222)
    $('#dlg').dialog('open').dialog('setTitle', '添加用户');
    $('#fm').form('clear');
    url = '/member/save';
}
function editUser() {
    alert(333)
    var row = $('#dg').datagrid('getSelected');
    if (row) {
        $('#dlg').dialog('open').dialog('setTitle', '编辑用户');
        $('#fm').form('load', row);
        url = '/member/update?id=' + row.id;
    }
}
function saveUser() {
    alert(4444)
    $('#fm').form('submit', {
        url: 'pages/member/save',
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
    alert(55555)
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