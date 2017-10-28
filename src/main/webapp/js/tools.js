var iframe;


/**
 * 创建窗口
 * 
 * @param title
 * @param addurl
 * @param saveurl
 */
function createnewwindow(title, addurl,width,height) {
	width = width?width:700;
	height = height?height:400;
	if(width=="100%" || height=="100%"){
		width = window.top.document.body.offsetWidth;
		height =window.top.document.body.offsetHeight-100;
	}
	var dd = $("#dd");
	if(dd.length==0){
		$("body").append("<div id='dd'></div>");
		dd = $("#dd");
	}
	dd.dialog({
	    title: title,   
	    width: width,   
	    height: height,   
	    closed: false,
        zIndex:100,
	    cache: false,   
	    href: addurl,   
	    modal: true,
	    buttons:[{
			text:'关闭',
            iconCls:'icon-cancel',
			handler:function(){
				closeObj($(this));
			}
		}]

	});   


}
/**
* 创建带下一步窗口
*
* @param title
* @param addurl
* @param saveurl
*/
function createTrunWindow(title, addurl,width,height) {
    width = width?width:700;
    height = height?height:400;
    if(width=="100%" || height=="100%"){
        width = window.top.document.body.offsetWidth;
        height =window.top.document.body.offsetHeight-200;
    }
    var dd = $("#dd");
    if(dd.length==0){
        $("body").append("<div id='dd'></div>");
        dd = $("#dd");
    }
    dd.dialog({
        title: title,
        width: width,
        height: height,
        closed: false,
        zIndex:100,
        cache: false,
        href: addurl,
        modal: true,
        buttons:[{
            text:'下一步',
            iconCls:'icon-ok',
            handler:function(){
                saveObj($(this));

            }
        },{
            text:'关闭',
            iconCls:'icon-cancel',
            handler:function(){
                closeObj($(this));
            }
        }]

    });


}

/**
 * 创建添加或编辑窗口
 * 
 * @param title
 * @param addurl
 * @param saveurl
 */
function createwindow(title, addurl,width,height) {
	width = width?width:700;
	height = height?height:400;
	if(width=="100%" || height=="100%"){
		width = window.top.document.body.offsetWidth;
		height =window.top.document.body.offsetHeight-100;
	}
	var dd = $("#dd");
	if(dd.length==0){
		$("body").append("<div id='dd'></div>");
		dd = $("#dd");
	}
	
	dd.dialog({   
	    title: title,   
	    width: width,   
	    height: height,   
	    closed: false,   
	    cache: false,   
	    href: addurl,
        zIndex:100,
	    modal: true,
	    buttons:[{
			text:'提交',
            iconCls:'icon-ok',
			handler:function(){
				saveObj($(this));
				
			}
		},{
			text:'关闭',
            iconCls:'icon-cancel',
			handler:function(){
				closeObj($(this));
			}
		}]

	});   


}
/**
 * 执行保存
 * 
 */
function saveObj(obj) {
	var from = obj;
	for(var i=0;i<from.length;i++){
		var c = $(from[i]).children("#dd");
		if(c.length==0){
			saveObj($(from[i].parentNode));
		}else{
			if(sub(c.children("#from"))){
                var ss=c.children("#from").form('validate');
                if(ss){
                    c.children("#from").submit();
                    c.dialog('close');
				}else{
                    return;
				}
			}
			return;
		}
	}
}

function sub(obj){
	var ss=obj.children("table");
	for(var i=0;i<ss.length;i++){
		var tbody =$(ss[i]).children("tbody");
		for(var k=0;k<tbody.length;k++){
			var tr = $(tbody[i]).children("tr");
			for(var j=0;j<tr.length;j++){
				var td = $(tr[i]).children("td");
				for(var h=0;h<td.length;h++){
					var span = $(td[h]).children("span");
					for(var g=0;g<span.length;g++){
						if($(span[g]).css("color")=="rgb(255, 0, 0)"){
							return false;
						}
					}
				}
			}
		}
	}
	return true;
}

/**
 * 执行关闭
 */
function closeObj(obj) {
	var from = obj;
	for(var i=0;i<from.length;i++){
		var c = $(from[i]).children("#dd");
		if(c.length==0){
			closeObj($(from[i].parentNode));

		}else{
			c.dialog('close');
			return;
		}
	}
}


function tip(text){
    $.messager.show({
        title: '提示',
        msg: text
    });
}