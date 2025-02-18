<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>搜索</title>
<link rel="icon" href="assets/images/favicon.ico" type="image/x-icon" />
<link rel="stylesheet" href="assets/css/search.css">
<link rel="stylesheet" href="assets/css/login.css">
<script src="assets/js/jquery.js"></script>
<link rel="stylesheet" href="assets/css/header.css">
<link rel="stylesheet" href="assets/css/foot.css">
<script src="assets/js/validate.js"></script>
<script src="assets/js/login.js"></script>
<script type="text/javascript">
	$(function() {
		var songs;
		$(".searchSong").click(function() {
			var keyWord = $("input[name = 'keyWord']").val();
			$(".keywords").hide();
				$("ul").empty();
				$(".search-box-center").empty();
			$.ajax({
				type : "POST",
				url : "/music/searchSong",
				data : {
					keyWord : keyWord
				},
				dataType : "json",
				success : function(data) {
					var ad = eval(data);
					 songs = ad.data.songs
					console.log(songs)
					var search = "搜索<span>"+keyWord+"</span>,找到<span style='color: rgb(100,100,255);'>"+songs.length+"</span>首单曲";
					$(".search-box-center").append(search);
					$.each(songs,function(i,n){
						var str= "<li class='search-bottom-li'><div class='search-bottom-li-1'>"
							str+="<div class='search-bottom-li-2'></div>"
							str+="<div class='search-bottom-li-3'><a href='/music/searchPlay?id="+n.id+"'>"+n.name+"</a></div>"
							str+="<div class='search-bottom-li-4'><a href=''>"+n.ar[0].name+"</a></div></div></li>"
							$("ul").append(str);
					
							if(i==12){
								return false;
							}

					})
				}
			});

		})

	$(".keyword").on("click",function(){
		$("input[name = 'keyWord']").val($(this).text())
		$(".searchSong").click();
	})
	 $(".search-bottom-num").click(function() {
		 $("ul").empty();
		 var j  = $(".search-bottom-num").index(this);
		 var k = j*13;
		 console.log(k)
		 var m = k;
		  $.each(songs,function(i,n){
			  if(i>=k){
				  var str= "<li class='search-bottom-li'><div class='search-bottom-li-1'>"
						str+="<div class='search-bottom-li-2'></div>"
						str+="<div class='search-bottom-li-3'><a href='/music/searchPlay?id="+n.id+"'>"+n.name+"</a></div>"
						str+="<div class='search-bottom-li-4'><a href=''>"+n.ar[0].name+"</a></div></div></li>"
						$("ul").append(str);
			  }
						
					
							if(i==k+12){
								return false;
							}

					})
	})
	
	
	
	
	})
</script>



</head>
<body>
	
	<script>
		$(function() {
			var a = $(".search-bottom-num")
			var num = 0

			a.click(function() {
				num = a.index(this)
				a.css("background", "#fff")
				a.eq(num).css("background", "rgb(100,100,255)")
			})
		})
	</script>
	
	
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












	<div class="search">
		<div class="search-box">
			<div class="search-box-top">
				<input type="text"  name="keyWord" placeholder="搜索"> <a
					href="javascript:;" class="searchSong">
					<div class="search-box-top1"></div>
				</a>
			</div>
			<div class="search-box-center">
				
			</div>
			<div class="search-box-bottom">
			<div class="keywords">
			<c:forEach items="${keywords}" 	var="keyword" varStatus="id">
			<div class="keyword">${keyword}</div>
			</c:forEach>
			</div>
				<ul class="search-bottom">
				
					
					<!-- <li class="search-bottom-li">
						<div class="search-bottom-li-1">
							<div class="search-bottom-li-2"></div>
							<div class="search-bottom-li-3">
								<a href="">cccc</a>
							</div>
							<div class="search-bottom-li-4">
								<a href="">cccc</a>
							</div>
						</div>
					</li> -->
					
				</ul>
				<div class="search-bottom-1">
					<a href="javascript:;"><div class="search-bottom-up-page">
							< 上一页</div></a>
					<div class="search-bottom-num sbn">1</div>
					<div class="search-bottom-num">2</div>
					<div class="search-bottom-num">3</div>
					<div class="search-bottom-num">4</div>
					<a href="javascript:;"><div class="search-bottom-down-page">
							下一页 ></div></a>
				</div>

			</div>
		</div>
	</div>
	
	
	
	
	<!--底部-->
	<div class="zuihou">
		<div class="zuihou1">
			<div class="zuihou11"></div>
			<a href="">关于网易</a>&nbsp;&nbsp;|&nbsp;&nbsp; <a href="">客户服务</a>&nbsp;&nbsp;|&nbsp;&nbsp;
			<a href="">服务条款</a>&nbsp;&nbsp;|&nbsp;&nbsp; <a href="">隐私政策</a>&nbsp;&nbsp;|&nbsp;&nbsp;
			<a href="">版权投诉指引</a>&nbsp;&nbsp;|&nbsp;&nbsp; <a href="">意见反馈</a>&nbsp;&nbsp;|
			<div class="zuihou12">
				UBDF1812版权所有2019-2099&nbsp;&nbsp;山西优逸客有限公司运营：晋网文[2019]7418-741号违法和不良信息举报电话：0351-8300110
				举报邮箱：1442286843@qq.com 不服来206教室单挑</div>
			<div class="zuihou13"></div>
			<div class="zuihou13"></div>
			<div class="zuihou13"></div>
			<div class="zuihou13"></div>
		</div>
	</div>
</body>
</html>