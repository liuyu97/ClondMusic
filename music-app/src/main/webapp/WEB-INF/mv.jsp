<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<!DOCTYPE html>
<html lang="en">
<head>
   <meta charset="UTF-8">
    <title>发现视频</title>
    <link rel="stylesheet" href="assets/css/mv.css">
 	<link rel="stylesheet" href="assets/css/header.css">
<link rel="stylesheet" href="assets/css/login.css">
    <script type="text/javascript" src="assets/js/jquery.js"></script>
    <script src="assets/js/login.js"></script>
    <script src="assets/js/validate.js"></script>
    
    <script type="text/javascript">
         $(document).ready(function(){
        	 var r = $(".denglu-right");
        	 if(${user.id}>0){
        	 r.show();
             $(".pinglun").click(function (){   
                     var i = $(".pinglun").index(this)
                     $(".shipingpinglun").eq(i).slideToggle();
                
             })
        	 }
        	 if(${user.id}==0){
        		 $(".pinglun").click(function (){   
                		 alert("登录后即可查看发表评论哦!") 
                	 })
        	 }
               $(".butt").click(function () {	
                	var butt = $(".butt").index(this);
                    var nei = $(".kaung").eq(butt).val();
                    if(nei==""){
                    	 alert("请输入评论内容!")
                    }
                    else {
                	var mydate = new Date();
                    var str = "" + mydate.getFullYear() + "-";
                  var month = (mydate.getMonth()+1);
                  var date = mydate.getDate();
                  var hours = mydate.getHours();
                  var minutes = mydate.getMinutes();
                  var secondes = mydate.getSeconds();
                    if(month<10){month="0"+month + "-"} 
                    else{month=month + "-"}
                    if(date<10){date="0"+date +" "} 
                    else{date=date +" "}
                    if(hours<10){hours="0"+hours + ":"} 
                    else{hours=hours + ":"}
                    if(minutes<10){minutes="0"+minutes + ":"} 
                    else{minutes=minutes + ":"}
                    if(secondes<10){secondes="0"+secondes} 
                    str = str+month+date+hours+minutes+secondes;
                    
                    var add = $("  <div class="+"lishipinglun"+"> <img src="+"${user.getHeader()}"+" class="+"pinglunHead"+"> <div class="+"pinglunName"+">${user.getNickName() }</div> <div class="+"pinglunName"+"> : "+nei+"</div> <div class="+"pinglunName"+">"+str+"</div> </div>");
                $(".pinglunkuang").eq(butt).after(add)
                var i =$(".none").eq(butt).text();
                var str = $(".pinglun").eq(butt).text().split("(");
                str =str[1].split(")");
               var str0 = parseInt(str[0])+1;
               $(".pinglun").eq(butt).text("评论("+str0+")")
                if(${user.id}>0){
                	 var data = {"userId":${user.getId()},"mvId":i, "content":nei};
               	 }       
                if(${user.id}==0){
               	 var data = {"userId":0,"mvId":i, "content":nei};
              	 }      

 $(".kaung").eq(butt).val("")
   $.ajax({
       type:"POST",
       async:true,    //是否异步
       cache:false,    //是否缓存
       dataType:'text',    //期待返回的数据类型text, json
    /*    contentType : "application/json", */    //如果想以json格式把数据提交到后台的话，这个必须有，否则只会当做表单提交
       url:"MVF",    //传递页面
       data:data,
       /* data: JSON.stringify(data),  */   //json类型
       success:function (data) {
   }
   });
                }
               });
            
            });
        

    </script>
</head>
<body>
<!-- 导航栏 -->
<script>
        $(function () {
            $('.uh').hover(function () {
                $('.pull').css("display","block")
            },function () {
                $('.pull').css("display","none")
                }
            )


            $('.pull').hover(function () {
                $('.pull').css("display","block")
            },function () {
                $('.pull').css("display","none")
            })
        })


    </script>

<header>
    <div class="top">
        <div class="left">
            <div class="logo"><a href=""></a></div>
            <div class="option">
                <div><a href="/music/index">发现音乐</a></div>
                <div><a href="/music/myMusic?userid=${user.getId() }">我的音乐</a></div>
                <div><a href="/music/MV">发现视频</a></div>
                <div><a href="/music/rank">热门排行榜</a></div>
            </div>
        </div>
        <div class="right">
            <a href="/music/search" class="seek" >音乐/视频/用户</a>
            <div class="loginButton" style="display:${none}">
                <a href="javascript:;">用户登陆</a>           
            </div>
           <div class="uh" style="display:${block}">

               <a style="color:none"><img class="userHeader"  src="${user.getHeader()}"></img></a>
            </div>
            	

    	</div>
    	
    	<div class="pull">
            <div class="loginOut" >
                <a  href="/music/myHome">我的主页</a>
            </div>

            <div class="loginOut" >
                <a href="/music/vip">VIP会员</a>
            </div>
            <div class="loginOut" >
                <a href="/music/edit">个人设置</a>
            </div>
            <div class="loginOut" >
                <a href="/music/loginOut">退出</a>
            </div>
        </div>
    	
	</div>

</header>



<!--登陆-->

<div class="login" style="display:${display}">
    <div class="login-top">登陆
    <div class="close">×</div>
    </div>
    <div class="login-top sign" style="display: none;">注册
    <div class="close">×</div>
    </div>

    <div class="login-bottom">
        <form action="/music/login" method="post">
            <table style="display: ${login}" style align="center"  >
                <tr>
                    <td>账号：</td>
                    <td class="hint"><input type="text" value="${username}" name="userNumber" class="text">
                    <span style="float:left;color: red">${erro}</span></td>
                </tr>
                <tr>
                    <td>密码：</td>
                    <td class="hint" align="top"> <input type="password" value="${password }" name="password">
                     <span style="float:left;color: red">${nopass}</span></td>
                </tr>
                <tr>
                    <td style="font-size: 10px">记住账号密码 <input type="checkbox" name="autoLogin" value="autoLogin"></td>
                    <td style="font-size: 10px;float: right;"><a href="">忘记密码？</a></td>
                </tr>
                <tr>

                    <td colspan="2" align="center">
                        <input type="button" value="注册" class="button">
                        <input type="submit" value="登陆" class="button">
                    </td>
                </tr>
            </table>
            <table style="display: ${sign}"  class="signPage" align="center" >
                <tr>
                    <td>账号：</td>
                    <td class="hint"><input type="text" value="请输入账号" name="account" class="text">
                    <span style="color:red">${already}</span>
                    </td>
                </tr>
                <tr>
                    <td>密码：</td>
                    <td class="hint"><input type="password"  name="pwd" id="pd"></td>
                </tr>
                <tr>
                    <td>确认密码：</td>
                    <td class="hint"><input type="password"name="pwd2" ></td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <input type="submit" value="注&nbsp&nbsp册" class="button signButton">
                    </td>
                </tr>
            </table>

        </form>
    </div>
</div>



<div class="denglu">
<div class="denglu-left">

<c:forEach items="${mvs}" var="mv" varStatus="vs" >  
 <div class="yemian">
         <div class="usermp4">
        <img src="${users.get(vs.index).getHeader()}" class="touxiang">
        <div class="xingming">${users.get(vs.index).getNickName()}</div>
 <div class="none">${mv.getId()}</div>
        <div class="time">${mv.getMv_time().toString().substring(0,19)}</div>
        <div class="ganyan">${mv.getDescription()}</div>
    <video controls class="shiping0">
        <source src="${mv.getMvUrl()}"  type="video/mp4">
        您的浏览器不支持 HTML5 video 标签。
    </video>
        <a href="javascript:;" class="pinglun">评论(${mcss.get(vs.index).size()})</a>
    </div>
    
        <div class="shipingpinglun">
        <div class="pinglunkuang">
            <textarea class="kaung" placeholder="评论"></textarea>
            <input value="评论" type="button" class="butt">
        </div>
        <c:forEach items="${mcss.get(vs.index)}" var="mc" varStatus="vs0" >  
        <div class="lishipinglun">
            <img src="${mcuserss.get(vs.index).get(vs0.index).getHeader()}" class="pinglunHead">
            <div class="pinglunName">${mcuserss.get(vs.index).get(vs0.index).getNickName()}</div>
            <div class="pinglunName">${mc.getContent()}</div>
            <div class="pinglunName">${mc.getComment_time().toString().substring(0,19)}</div>
        </div>
        </c:forEach>  
        <div class="lishipinglun0"></div>   
    </div>
        </div>
</c:forEach>
    
    </div>















    <div class="denglu-right" style="display: none">
        <div class="user">
         <img src="${user.getHeader()}" class="userImage">
            <div class="userName"><b>${user.getNickName()}</b></div>
            <a href="/music/uploadMv" class="shi1">上传</a>
            <a href="" class="shi1">评论</a>
        </div>

    </div>
    </div>
    <div class="clearfloat"></div>
<div class="clearfloat"></div>

</div>

<div class="zuihou">
    <div class="zuihou1">
        <div class="zuihou11"></div>
        <a href="">关于网易</a>&nbsp;&nbsp;|&nbsp;&nbsp;
        <a href="">客户服务</a>&nbsp;&nbsp;|&nbsp;&nbsp;
        <a href="">服务条款</a>&nbsp;&nbsp;|&nbsp;&nbsp;
        <a href="">隐私政策</a>&nbsp;&nbsp;|&nbsp;&nbsp;
        <a href="">版权投诉指引</a>&nbsp;&nbsp;|&nbsp;&nbsp;
        <a href="">意见反馈</a>&nbsp;&nbsp;|
        <div class="zuihou12">
            UBDF1812版权所有©2019-2099&nbsp;&nbsp;山西优逸客有限公司运营：晋网文[2019]7418-741号违法和不良信息举报电话：0351-8300110 举报邮箱：1442286843@qq.com 不服来206教室单挑
        </div>
        <div class="zuihou13"></div>
        <div class="zuihou13"></div>
        <div class="zuihou13"></div>
        <div class="zuihou13"></div>
    </div>
</div>

</body>
</html>

