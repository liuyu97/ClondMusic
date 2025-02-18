<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>绑定手机</title>
    <link rel="stylesheet" href="assets/css/bind.css">
    <link rel="stylesheet" href="assets/css/foot.css">
    <link rel="stylesheet" href="assets/css/header.css">
    <script src="assets/js/jquery.js"></script>
    
    
    <script type="text/javascript">
    
    
    
   	/* 发送验证码 */
    $(function(){
    	$(".getSms").click(function(){
    		
    		var phone = $("input[name='phone']").val();
    		
    		$.ajax({
            	type:"POST",
                url:"/music/Sms",
                data:{
                	phone : phone
                },
                dataType:"json",
                success:function(result) {
                    alert(result);
                }
            });
    		
    		
    		
    	})
    	
    	
    	$(".submit").click(function(){
    		
    		var code = $("input[name='code']").val();
    		
    		$.ajax({
            	type:"POST",
                url:"/music/SmsCode",
                data:{
                	code : code
                },
                dataType:"json",
                success:function(data) {
                	var ad = eval(data);
                	alert(ad.result)
                }
            });
    		
    		
    		
    	})
    	
    	
    })
    
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
                <div><a href="">热门排行榜</a></div>
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


<div class="bind-box">
    <div class="bind-title">
        绑定手机
    </div>
    <hr style="height:1px;border:none;border-top:1px dashed #d5d5d5;" width="95%"/>
    <div class="bind-area">
        <p>手机：<input type="text" name="phone" style="height: 20px;width: 200px">&nbsp;<a href="javascript:;" style="color: red" class="getSms">获取验证码</a>
        </p>

        <p>验证码：<input type="text" name="code" style="height: 20px;width: 50px">
        </p>
        <p>
            <input type="button" value="绑定" class="submit" onclick="javascript:;">
        </p>
    </div>

</div>




<!--底部-->
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
            UBDF1812版权所有2019-2099&nbsp;&nbsp;山西优逸客有限公司运营：晋网文[2019]7418-741号违法和不良信息举报电话：0351-8300110
            举报邮箱：1442286843@qq.com 不服来206教室单挑
        </div>
        <div class="zuihou13"></div>
        <div class="zuihou13"></div>
        <div class="zuihou13"></div>
        <div class="zuihou13"></div>
    </div>
</div>
</body>
</html>