function tbdata(data_url,pageIndex,pageSize) {
    $.ajax({
        url:data_url+"?pageIndex="+pageIndex+"&pageSize="+pageSize,
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