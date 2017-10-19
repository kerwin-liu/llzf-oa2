//时间格式化
Date.prototype.format = function (format,value) {
	/*
	 * eg:format="yyyy-MM-dd hh:mm:ss";
	 */
	if (!format) {
		format = "yyyy-MM-dd hh:mm:ss";
	}
	if(value==''||value==null){
		return '';
	}
	var strdata=value.replace(/-/g,"/");
	var index=strdata.indexOf(".");
	if(index>0)
	{
		strdata=strdata.substr(0,index);
	}
	var date= new Date(Date.parse(strdata));
	var o = {
		"M+" : date.getMonth() + 1, // month
		"d+" : date.getDate(), // day
		"h+" : date.getHours(), // hour
		"m+" : date.getMinutes(), // minute
		"s+" : date.getSeconds(), // second
		"q+" : Math.floor((date.getMonth() + 3) / 3), // quarter
		"S" : date.getMilliseconds()
		// millisecond
	};
	
	if (/(y+)/.test(format)) {
		format = format.replace(RegExp.$1, strdata.substr(4-RegExp.$1.length,RegExp.$1.length));
	}
	
	for (var k in o) {
		if (new RegExp("(" + k + ")").test(format)) {
			format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
		}
	}
	return format;
};

//格式化显示日期时间
//参数x : 待显示的日期时间，示例： new Date()
//参数y: 需要显示的格式，示例：yyyy-MM-dd hh:mm:ss
function date2str(x, y) {
	var z = {
	   y: x.getFullYear(),
	   M: x.getMonth() + 1,
	   d: x.getDate(),
	   h: x.getHours(),
	   m: x.getMinutes(),
	   s: x.getSeconds()
	};
	return y.replace(/(y+|M+|d+|h+|m+|s+)/g, function(v) {
	   return ((v.length > 1 ? "0" : "") + eval('z.' + v.slice(-1))).slice(-(v.length > 2 ? v.length : 2))
	});
};



// 获得传入时间前时间 nowTime传入时间 minutes相差分钟数
function getBeforeTimeByMinute(nowTime,minutes){
	var beforeTime = new Date(nowTime.getTime() + minutes*60*1000);
	return beforeTime;
};
//获得传入时间前时间 nowTime传入时间 second相差秒数
function getBeforeTimeBySecond(nowTime,second){
	var beforeTime = new Date(nowTime.getTime() + second*1000);
	return beforeTime;
};

function getTimeStamp(datastr){
	var date = new Date(datastr.replace(/-/g,"/"));
	return date;
}



function getNewDayTabName(tabName){
	var myDate = new Date();
	//调用dataformat.js的时间转化方法
	var curTime= date2str(myDate,'yyyy-MM-dd hh:mm:ss');
	curTime=curTime.substring(0, 10);
	var arr = curTime.split('-');
	curTime='';
	for (var i = 0; i < arr.length; i++) {
		curTime+=arr[i];
	}
	return tabName+'_'+curTime;
}


