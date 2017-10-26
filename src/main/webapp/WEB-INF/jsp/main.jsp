<%--
  Created by IntelliJ IDEA.
  User: liujingtao
  Date: 2017-10-24
  Time: 20:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html style="width: 100%;height: 100%">
<head>
    <title>首页</title>
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
    <script type="text/javascript" src="../../js/echarts.js"></script>
    <style type="text/css">
        .content{
            width: 100%;
            height: 99%;
            border: 0px solid red;
        }
        .left{
            width: 39.5%;
            height: 100%;
            float: left;
            border: 0px solid red;
        }
        .right-top{
            width: 60%;
            height: 49.7%;
            float: left;
            border: 0px solid red;
        }
        .right-bottom{
            width: 60%;
            height: 49.7%;
            float: left;
            border: 0px solid red;
        }
        .right-top-top{
            width: 49.7%;
            height: 100%;
            float: left;
            border: 0px solid red;
        }
        .right-top-bottom{
            width: 49.7%;
            height: 100%;
            float: left;
            border: 0px solid red;
        }
        table tr td{
            color: #949494;
            font-family: 'Microsoft Yahei', '微软雅黑';
            font-size: 18px;
            text-align: left;
        }
        table tr td:first-child{
            color: #949494;
            font-family: 'Microsoft Yahei', '微软雅黑';
            font-size: 18px;
            text-align: center;
        }
    </style>
</head>
<body>
<div class="content">
    <div class="left">
        <div style="float: left;width: 10%;height: 45px;border: 0px solid red;"></div>
        <div style="float: left;width: 78%;height: 45px;border-bottom: 3px solid #949494;font-size: 30px;font-weight: 900;text-align: center;font-family: 'Microsoft Yahei', '微软雅黑';color: #949494">个人信息</div>
        <div style="float: left;width: 10%;height: 45px;border: 0px solid red;"></div>
        <div style="float: left;width: 99%;height: 80%;margin-top: 0.5%;border: 0px solid red">
            <table border="0" width="100%" style="height: 100%">
                <tr>
                    <td style="width: 45%">
                        姓名：
                    </td>
                    <td id="name">
                        Admin
                    </td>
                </tr>
                <tr>
                    <td>
                        手机号：
                    </td>
                    <td id="sjh">

                    </td>
                </tr>
                <tr>
                    <td>
                        微信号：
                    </td>
                    <td id="wx">

                    </td>
                </tr>
                <tr>
                    <td>
                        QQ：
                    </td>
                    <td id="qq">

                    </td>
                </tr>
                <tr>
                    <td>
                       部门：
                    </td>
                    <td id="mem">

                    </td>
                </tr>
            </table>

        </div>
    </div>
    <div class="right-top">
        <div class="right-top-top" id="day-bar"></div>
        <div class="right-top-bottom" id="month-bar"></div>
    </div>
    <div class="right-bottom" >
        <div id="month-line" style="width: 100%;height: 100%"></div>
    </div>
</div>
</body>
<script type="text/javascript">
var myCharts01 = echarts.init(document.getElementById("day-bar")),
    myCharts02 = echarts.init(document.getElementById("month-bar")),
    myCharts03 = echarts.init(document.getElementById("month-line"));
option00 = {

    title : {
        text : "今天 新加客户-追踪信息 统计",
        subtext : '',
        x : 'center',
        y : 10,
        textStyle : {
            fontSize : 15,
            fontWeight : 'bolder',
            color : '#00c5fd'
        }
    },

    grid : {
        y2 : 28,
        y : 50,
        x : 50,
        x2 : 50,
        borderWidth : 0
    },
    xAxis : [ {
        type : 'category',
        axisLine : {
            show : true,
            lineStyle : {
                color : '#023c51',
            },
        },
        axisTick : {
            show : false
        },
        splitLine : {
            show : true,
            lineStyle : {
                color : 'rgba(2,60,81,0.3)',
            },
        },
        axisLabel : {
            show : true,
            textStyle : {
                color : '#00c5fd'
            }
        },
        data : [ '新加客户', '新加追踪信息']
    } ],
    yAxis : [ {
        type : "value",
        name : "个数",
        max : 100,
        min : 0,
        position : "top",
        splitNumber : 5,
        nameTextStyle : {
            color : '#00c5fd'
        },
        axisLine : {
            show : true,
            lineStyle : {
                color : '#023c51',
            },
        },
        axisTick : {
            show : false
        },
        splitLine : {
            show : true,
            onGap : false,
            lineStyle : {
                color : 'rgba(2,60,81,0.3)',
            },
        },
        axisLabel : {
            formatter : '{value}个',
            textStyle : {
                color : '#00c5fd'
            }
        }
    },{
        type : 'value',
        max : 100,
        position:'right',
        axisLine : {
            show : true,
            lineStyle : {
                color : '#023c51',
            },
        },
        axisTick : {
            show : true
        },
        splitLine : {
            show : false
        },
        axisLabel : {
            show : false
        }
    } ],
    series : [ {
        name : '',
        barWidth : 40,
        type : 'bar',
        data : [ {
            name : '',
            value : 70,
            itemStyle : {
                normal : {
                    label : {
                        show : true,
                        color : '#00c5fd',
                        formatter : function(params) {
                            if (params.data.value == '') {
                                return '';
                            } else {
                                return params.data.value + '个';
                            }
                        },
                        position : "top"
                    },
                    barBorderColor : '#00c5fd',
                    barBorderWidth : 3,
                    barBorderRadius : 100,
                    shadowColor : '#00c5fd',
                    shadowBlur : 20,
                    shadowOffsetX : 0,
                    color :  "rgba(0,0,0,0.0)"

                }
            }
        },{
            name : '',
            value : 70,
            itemStyle : {
                normal : {
                    label : {
                        show : true,
                        color : '#00c5fd',
                        formatter : function(params) {
                            if (params.data.value == '') {
                                return '';
                            } else {
                                return params.data.value + '个';
                            }
                        },
                        position : "top"
                    },
                    color : 'rgba(0,0,0,0.0)',
                    barBorderColor : '#00c5fd',
                    barBorderWidth : 3,
                    barBorderRadius : 100,
                    shadowColor : '#00c5fd',
                    shadowBlur : 20,
                    shadowOffsetX : 0

                }
            }
        }
        ]
    } ]
};

option03 = {
    tooltip: {
        trigger: 'axis',
        formatter: function(params) {
            var value=params[0].name + '<br/>';
            for(var i=0;i<params.length;i++){
                value +=params[i].seriesName + ' : ' + params[i].value + '个<br/>';
            }
            return value;
        }
    },
    title : {
        text : "本周每天  新加客户-追踪信息 统计",
        x:'center',
        y:10,
        textStyle: {
            fontSize: 15,
            fontWeight: 'bolder',
            color: '#00c5fd'
        }
    },
    legend: {
        show: true,
        x:'right',
        data:['新加客户数','新加追踪数']
    },
    backgroundColor:'rgba(20,67,111,0.0)',
    xAxis : [
        {
            type : 'category',
            splitNumber :30,
            boundaryGap : true,
            axisLine : {
                show : true,
                lineStyle:{
                    color:'#023c51',
                }
            },
            axisTick : {
                show : true,
                alignWithLabel: true,
                lineStyle:{
                    color:'#023c51',
                }
            },
            axisLabel : {
                show : true,
                textStyle: {
                    color:'#00c5fd'
                }
            },
            splitLine : {
                show : true,
                lineStyle:{
                    color:'rgba(2,60,81,0.3)',
                }
            },
            data : ['2017-10-00','2017-10-01','2017-10-02']
        }
    ],
    yAxis : [
        {
            type : "value",
            name:'新加客户数',
            position : "top",
            splitNumber :10,
            nameTextStyle : {
                color : '#00c5fd'
            },
            axisLabel : {
                show: true,
                formatter: function(data){
                        return data+"个";
                },
                textStyle: {
                    color:'#00c5fd'
                }
            },splitLine : {
            show : true,

            lineStyle:{
                color:'rgba(2,60,81,0.3)',
            }
        },
            axisLine: {
                show : true,
                lineStyle:{
                    color:'#023c51',
                }
            }
        },
        {
            type : 'value',
            name:'新加追踪数',
            position : "top",
            splitNumber :10,
            nameTextStyle : {
                color : '#fddc00'
            },
            axisLabel : {
                show: true,
                formatter: function(data){

                        return data+"个";

                },
                textStyle: {
                    color:'#fddc00'
                }
            },
            splitLine : {
            show : false,
            lineStyle:{
                color:'rgba(2,60,81,0.3)',
            }
        },
            axisLine: {
                show : true,
                lineStyle:{
                    color:'#023c51',
                }
            }
        }
    ],
    grid : {
        y2 : 30,
        y : 50,
        x:40,
        x2:50,
        borderWidth : 0
    },
    series : [
        {
            name:'新加客户数',
            type:'line',
            yAxisIndex: 0,
            symbol : "circle",
            smooth : false,
            showAllSymbol:true,
            symbolSize:1,
            data:[5,43,28],
            itemStyle : {
                normal : {
                    color : "#00c5fd",
                    //areaStyle: {type: 'default',color:'rgba(2,60,81,1)'}
                }
            }
        },
        {
            name:'新加追踪数',
            type:'line',
            yAxisIndex: 1,
            symbol : "circle",
            smooth : false,
            showAllSymbol:true,
            symbolSize:1,
            data:[10,31,24],
            itemStyle : {
                normal : {
                    color : "#fddc00",
                    //areaStyle: {type: 'default',color:'rgba(253,220,0,0.7)'}
                }
            }
        }

    ]
};



myCharts01.setOption(option00);
option00.title.text="本周  新加客户-追踪信息 统计";
myCharts02.setOption(option00);
myCharts03.setOption(option03);

$(function(){
   $.ajax({
       url:'/user/get',
       dataType:'json',
       success:function(data){
        console.log(data);
        $("#name").html(data.date.name);
       }
   })

});

</script>
</html>
