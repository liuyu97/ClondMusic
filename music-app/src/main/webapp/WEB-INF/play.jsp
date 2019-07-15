<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>

<html lang="en">
<head>
<meta charset="UTF-8">
<title>播放——${song.getSongName() }-${song.getSongAuthor() }</title>
<link rel="icon" href="assets/images/favicon.ico" type="image/x-icon" />
<link rel="stylesheet" href="assets/css/play.css">
<link rel="stylesheet" href="assets/css/login.css">
<link rel="stylesheet" href="assets/css/header.css">
<script src="assets/js/jquery.js"></script>
<script src="assets/js/index.js"></script>
<script src="assets/js/validate.js"></script>
<script type="text/javascript">
 $(function () {	
 
		 var b = function a(){
				 $.ajax({		
					    type: 'POST',
					    url: '/music/mmm',
					
					    data:{
					    	songId : ${songId}
			          	}, 
			          dataType:"json",
					
					    success:function (data) {
					
					    	var ad = eval(data);
					    	console.log(ad)
							$.each(ad,function(i,n){
								var now = new Date(n.songComment.comment_time.time); 
								var year = now.getFullYear();
								var month = now.getMonth()+1;
								var date = now.getDate();
								var hours = now.getHours();
								var minutes = now.getMinutes();
								var secondes = now.getSeconds();
								if(month<10){month="0"+month + "-"} 
			                    else{month=month + "-"}
			                    if(date<10){date="0"+date +" "} 
			                    else{date=date +" "}
			                    if(hours<10){hours="0"+hours + ":"} 
			                    else{hours=hours + ":"}
			                    if(minutes<10){minutes="0"+minutes + ":"} 
			                    else{minutes=minutes + ":"}
			                    if(secondes<10){secondes="0"+secondes} 
			                    stry = year+"-"+month+date+hours+minutes+secondes;
								var str = "<div class='mymusic-comment-good'><div class='mymusic-comment-good-user'>"
									str += "<img src="+n.user.header+" alt=''></div>"
									str += "<div class='mymusic-comment-good-name'><a href='javascript:;'>"+n.user.nickName+"&nbsp;</a></div>"
									str += "<div class='mymusic-comment-good-text'>"+n.songComment.content+"</div>"
									str += "<div class='mymusic-comment-time'>"+stry+"</div>"
									str += "<div class='mymusic-comment-icon'></div>"
									str += "<div class='mymusic-comment-reply'><a href='javascript:;'>回复</a></div></div>"
									$(".mymy").append(str);	 

							})
					
					    }
					
					   })
		 }
		b()
		
		$('.mymusic-comment-icon-1 button').click(function () {
			
			
			  var comment_text = $('.mymusic-comment-text textarea').val();
			  var number = $(".mymusic-comment-num span").text();
			  number++;
			  if(comment_text == ""){
				  alert("内容不能为空")
				  return false;
				  
			  }
			  
			  if(${user.id}==""){
			   		
			           		 alert("登录后即可查看发表评论哦!") 
			           		$('textarea').val("")
					   		 
			   	 
			  
			           
			   	 }else{
			   		var now = new Date(); 
					var year = now.getFullYear();
					var month = now.getMonth()+1;
					var date = now.getDate();
					var hours = now.getHours();
					var minutes = now.getMinutes();
					var secondes = now.getSeconds();
					if(month<10){month="0"+month + "-"} 
	            else{month=month + "-"}
	            if(date<10){date="0"+date +" "} 
	            else{date=date +" "}
	            if(hours<10){hours="0"+hours + ":"} 
	            else{hours=hours + ":"}
	            if(minutes<10){minutes="0"+minutes + ":"} 
	            else{minutes=minutes + ":"}
	            if(secondes<10){secondes="0"+secondes} 
	            stry = year+"-"+month+date+hours+minutes+secondes;
			    	var add=$("<div class='mymusic-comment-good'><div class='mymusic-comment-good-user'>"
						+"<img src='${user.getHeader()}' alt=''></div>"
						+"<div class='mymusic-comment-good-name'><a href='javascript:;'>${user.getNickName()}&nbsp;</a></div>"
						+"<div class='mymusic-comment-good-text'>"+comment_text+"</div>"
						+"<div class='mymusic-comment-time'>"+stry+"</div>"
						+"<div class='mymusic-comment-icon'></div>"
						+"<div class='mymusic-comment-reply'><a href='javascript:;'>回复</a></div></div>")
			    		$(add).prependTo(".mymy:first");
			    		$(".mymusic-comment-num span").html(number)
			    	
			   $.ajax({
			
			    type: 'POST',
			
			    url: 'http://localhost:8080/music/nnn',
			
			    data:{
	          	comment : comment_text
	          },
	          dataType:"json",
			
			    success:function (data) {
			    	
			    alert(data)
			    	
			    	
			    }
			
			   })
			    $('textarea').val("")
			   		 
			   	 }
			  
			  
			  
		  });
		 });

</script>
</head>
<body class="play">










	<!-- 导航栏 -->
	<script>
		$(function() {
			$('.uh').hover(function() {
				$('.pull').css("display", "block")
			}, function() {
				$('.pull').css("display", "none")
			})

			$('.pull').hover(function() {
				$('.pull').css("display", "block")
			}, function() {
				$('.pull').css("display", "none")
			})
		})
	</script>

	<header>
		<div class="top">
			<div class="left">
				<div class="logo">
					<a href=""></a>
				</div>
				<div class="option">
					<div>
						<a href="/music/index">发现音乐</a>
					</div>
					<div>
						<a href="/music/myMusic?userid=${user.getId() }">我的音乐</a>
					</div>
					<div>
						<a href="/music/MV">发现视频</a>
					</div>
					<div>
						<a href="/music/rank">热门排行榜</a>
					</div>
				</div>
			</div>
			<div class="right">
				<a href="/music/search" class="seek">音乐/视频/用户</a>
				<div class="loginButton" style="display:${none}">
					<a href="javascript:;">用户登陆</a>
				</div>
				<div class="uh" style="display:${block}">

					<a style="color: none"><img class="userHeader"
						src="${user.getHeader()}"></img></a>
				</div>


			</div>

			<div class="pull">
				<div class="loginOut">
					<a href="/music/myHome">我的主页</a>
				</div>

				<div class="loginOut">
					<a href="/music/vip">VIP会员</a>
				</div>
				<div class="loginOut">
					<a href="/music/edit">个人设置</a>
				</div>
				<div class="loginOut">
					<a href="/music/loginOut">退出</a>
				</div>
			</div>

		</div>

	</header>


	<!-- 歌词播放 -->
	<script type="text/javascript">
		$(function() {

			var medisArray = new Array(); // 定义一个新的数组
			function createLrc() {

				var medis = document.getElementById('mymusic-words').innerText;
				var medises = medis.split("\n"); // 用换行符拆分获取到的歌词

				$.each(medises, function(i, item) { // 遍历medises，并且将时间和文字拆分开，并push进自己定义的数组，形成一个对象数组
					var t = item.substring(item.indexOf("[") + 1, item
							.indexOf("]"));
					medisArray
							.push({

								t : (t.split(":")[0] * 60 + parseFloat(t
										.split(":")[1])).toFixed(3),
								c : item.substring(item.indexOf("]") + 1,
										item.length)
							});
				});
				var ul = $("#text");
				// 遍历medisArray，并且生成li标签，将数组内的文字放入li标签
				$.each(medisArray, function(i, item) {
					var li = $("<li style='list-style: none;'>");
					li.html(item.c);
					ul.append(li);
				});
			}
			createLrc();
			var fraction = 0.5;
			var topNum = 0;
			function lineHeight(lineno) {
				var ul = $("#text");
				var $ul = document.getElementById('text');
				// 令正在唱的那一行高亮显示
				if (lineno > 0) {
					$(ul.find("li").get(topNum + lineno - 1)).removeClass(
							"lineheight");
				}
				var nowline = ul.find("li").get(topNum + lineno);
				$(nowline).addClass("lineheight");

				// 实现文字滚动
				var _scrollTop;
				$ul.scrollTop = 0;
				if ($ul.clientHeight * fraction > nowline.offsetTop) {
					_scrollTop = 0;
				} else if (nowline.offsetTop > ($ul.scrollHeight - $ul.clientHeight
						* (1 - fraction))) {
					_scrollTop = $ul.scrollHeight - $ul.clientHeight;
				} else {
					_scrollTop = nowline.offsetTop - $ul.clientHeight
							* fraction;
				}
				//以下声明歌词高亮行固定的基准线位置成为 “A”
				if ((nowline.offsetTop - $ul.scrollTop) >= $ul.clientHeight
						* fraction) {
					//如果高亮显示的歌词在A下面，那就将滚动条向下滚动，滚动距离为 当前高亮行距离顶部的距离-滚动条已经卷起的高度-A到可视窗口的距离
					$ul.scrollTop += Math.ceil(nowline.offsetTop
							- $ul.scrollTop - $ul.clientHeight * fraction);

				} else if ((nowline.offsetTop - $ul.scrollTop) < $ul.clientHeight
						* fraction
						&& _scrollTop != 0) {
					//如果高亮显示的歌词在A上面，那就将滚动条向上滚动，滚动距离为 A到可视窗口的距离-当前高亮行距离顶部的距离-滚动条已经卷起的高度
					$ul.scrollTop -= Math.ceil($ul.clientHeight * fraction
							- (nowline.offsetTop - $ul.scrollTop));

				} else if (_scrollTop == 0) {
					$ul.scrollTop = 0;
				} else {
					$ul.scrollTop += $(ul.find('li').get(0)).height();
				}
			}
			;
			
			$("#player")[0].ontimeupdate = function() {
				var lineNo = 0;
				while(lineNo<=medisArray.length - 1){
					if (parseFloat(medisArray[lineNo].t) <= $("#player")[0].currentTime.toFixed(3)
					&& $("#player")[0].currentTime.toFixed(3) <= parseFloat(medisArray[lineNo + 1].t)) {
						$("#text li").removeClass("lineheight");
						lineHeight(lineNo);
					}
					lineNo++;
				}
			};
		})
	</script>

	<div class="play-box">
		<div class="my-music-song">
			<div class="my-music-list-music ll-music">
				<div class="mymusic-title">
					<img src="${song.getSongImage()}" alt="">
					<div class="mymusic-title-img">
						<img src="./assets/images/30.png" alt="">
					</div>
					<div class="mymusic-title-text">${song.getSongName() }</div>
					<div class="mymusic-title-username">
						歌手: <a href="https://www.baidu.com/s?wd=${song.getSongAuthor() }">${song.getSongAuthor() }</a>
					</div>
					<div class="mymusic-btns">
						<div class="mymusic-btns1">
							<img src="./assets/images/24.png" alt="">
						</div>
						<div class="mymusic-btns2">
							<img src="assets/images/27.png" alt="">
						</div>
						<div class="mymusic-btns3">
							<img src="./assets/images/28.png" alt="">
						</div>
						<div class="mymusic-btns4">
							<img src="./assets/images/25.png" alt="">
						</div>
						<div class="mymusic-btns5">
							<img src="./assets/images/29.png" alt="">
						</div>
						<div class="mymusic-btns6">
							<img src="./assets/images/1.png" alt="">
						</div>

					</div>


				</div>

				<div class="play-music">
					<audio id="player" controls="controls" autoplay="autoplay"
						preload="auto">

						<source src="${song.getSongUrl()}" type="audio/ogg">
					</audio>
					<ul id="text"
						style="overflow: auto; height: 700px; width: 400px; margin-left: -70px; text-align: center;"">
					</ul>
				</div>

				<textarea  id="mymusic-words" name="textfield" cols="70" rows="10" 
					style="display: none;" >${song.getSongWords() }</textarea>

				<div class="mymusic-comment">
					<div class="mymusic-c">
						<div class="mymusic-comment-title">评论</div>
						<div class="mymusic-comment-num">
							共 <span>${num}</span> 条评论
						</div>
					</div>
					<div class="mymusic-comment-text">
						<div class="mymusic-comment-img">
							<img src="${user.getHeader() }" alt=""
								style="width: 100%; height: 100%;">
						</div>
						<textarea name="comm" id="" cols="10" rows="10" placeholder="评论"
							class="mymusic-comment-content"></textarea>
					</div>
					<div class="mymusic-comment-icon">
						<div class="mymusic-comment-icon-1">
							<div class="mymusic-comment-icon-2">140</div>
							<button class="mymusic-comment-icon-3" type='submit'>评论</button>
						</div>
					</div>
				</div>
				<div class="mymusic-comment-t">精彩评论</div>

				<div class="mymy"></div>


			</div>
		</div>
		<div class="my-music-right"></div>
	</div>
</body>
</html>