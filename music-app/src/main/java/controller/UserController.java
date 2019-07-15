package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;

import entity.PlayRecordSong;
import entity.Song;
import entity.User;
import service.prototype.IPlayRecordService;
import service.prototype.ISongService;
import service.prototype.IUserService;

@Controller
public class UserController {
	@Autowired
	private IPlayRecordService playRecordService;
	@Autowired
	private ISongService songService;
	
	@Autowired
	private IUserService userService;
	ModelAndView mv =null;
	private User user=null;
	
	@RequestMapping("/index")
	public ModelAndView index(HttpServletRequest req,HttpServletResponse resp){
		
		mv = new ModelAndView();
		mv.setViewName("index");
		List<PlayRecordSong> newHotSongs10=playRecordService.findSongAndCountInWeekLimitTen();
		List<PlayRecordSong> newHotSongs8=new ArrayList<PlayRecordSong>();
		for(int i=0;i<8;i++) {
			newHotSongs8.add(newHotSongs10.get(i));
		}
		List<Song> originalSongs = songService.findByTypeId(6);

		
	

		List<Song> newSongs = songService.newSong();
		List<Song> newSongs10=new ArrayList<Song>();
		for(int i=0;i<10;i++) {
			newSongs10.add(newSongs.get(i));
		}
		mv.addObject("newHotSongs8",newHotSongs8);
		mv.addObject("newHotSongs10",newHotSongs10);
		mv.addObject("originalSongs",originalSongs);
		mv.addObject("newSongs10",newSongs10);
		
		Cookie[] cookies = req.getCookies();
		
		for (Cookie cookie : cookies) {
			if(cookie.getName().equals("username")){
				String username = cookie.getValue();
				req.setAttribute("username", username);
			}
			if(cookie.getName().equals("password")){
				String password = cookie.getValue();
				req.setAttribute("password", password);
			}
			
			
		}
		
		
		return mv;
	}
	
	@RequestMapping(value ="/login",method=RequestMethod.POST)
	public void login(HttpServletRequest req,HttpServletResponse resp) throws Exception{
		String account = req.getParameter("userNumber");
		String aaa = req.getParameter("account");
		
		if(!account.equals("请输入账号") && aaa.equals("请输入账号")){
			String password = req.getParameter("password");
			List<User> user = userService.findByAccount(account);	
			mv=new ModelAndView();
			if(user.size()==0){			
				String erro="用户名不存在";
				String display = "block";
				
				List<PlayRecordSong> newHotSongs10=playRecordService.findSongAndCountInWeekLimitTen();
				List<PlayRecordSong> newHotSongs8=new ArrayList<PlayRecordSong>();
				for(int i=0;i<8;i++) {
					newHotSongs8.add(newHotSongs10.get(i));
				}
				List<Song> originalSongs = songService.findByTypeId(6);

				
			

				List<Song> newSongs = songService.newSong();
				List<Song> newSongs10=new ArrayList<Song>();
				for(int i=0;i<10;i++) {
					newSongs10.add(newSongs.get(i));
				}
				req.setAttribute("newHotSongs8",newHotSongs8);
				req.setAttribute("newHotSongs10",newHotSongs10);
				req.setAttribute("originalSongs",originalSongs);
				req.setAttribute("newSongs10",newSongs10);
				
				
				
				
				req.getSession().setAttribute("display",display);
				req.getSession().setAttribute("erro", erro);
				resp.sendRedirect("index");
			
				
			}else if(user.get(0).getPassword().equals(password)){
				String block = "block";

				String none = "none";

				/*List<PlayRecordSong> newHotSongs10=playRecordService.findSongAndCountInWeekLimitTen();
				List<PlayRecordSong> newHotSongs8=new ArrayList<PlayRecordSong>();
				for(int i=0;i<8;i++) {
					newHotSongs8.add(newHotSongs10.get(i));
				}
				List<Song> originalSongs = songService.findByTypeId(6);

			

				List<Song> newSongs = songService.newSong();
				List<Song> newSongs10=new ArrayList<Song>();
				for(int i=0;i<10;i++) {
					newSongs10.add(newSongs.get(i));
				}
				
				mv.addObject("newHotSongs8",newHotSongs8);
				mv.addObject("newHotSongs10",newHotSongs10);
				mv.addObject("originalSongs",originalSongs);
				mv.addObject("newSongs10",newSongs10);
				req.getSession().setMaxInactiveInterval(60*30);
				
				
				*/
				req.getSession().removeAttribute("display");
				req.getSession().removeAttribute("erro");
				req.getSession().setAttribute("block",block);
				req.getSession().setAttribute("none",none);
				req.getSession().setAttribute("user", user.get(0));
				resp.sendRedirect("index");
				//coolie记住密码
				String autoLogin = req.getParameter("autoLogin");
				
				if(autoLogin==null){
					
				}else{
					
					Cookie cookie1 = new Cookie("username", account);
					cookie1.setMaxAge(60*60*24*10);
					Cookie cookie2 = new Cookie("password", password);
					cookie2.setMaxAge(60*60*24*10);
					resp.addCookie(cookie1);
					resp.addCookie(cookie2);
				}
				
				
				
				
			}else{
				String nopass="密码不正确";
				
				String display = "block";
				req.setAttribute("display",display);
				req.setAttribute("nopass", nopass);
				resp.sendRedirect("index");

			}
		}else{
			account = req.getParameter("account");
			List<User> users = userService.findByAccount(account);
			/*List<PlayRecordSong> newHotSongs10=playRecordService.findSongAndCountInWeekLimitTen();
			List<PlayRecordSong> newHotSongs8=new ArrayList<PlayRecordSong>();
			for(int i=0;i<8;i++) {
				newHotSongs8.add(newHotSongs10.get(i));
			}
			List<Song> originalSongs = songService.findByTypeId(6);

		

			List<Song> newSongs = songService.newSong();
			List<Song> newSongs10=new ArrayList<Song>();
			for(int i=0;i<10;i++) {
				newSongs10.add(newSongs.get(i));
			}*/
			if(users.size()==0){
				System.out.println(account);
				String pwd = req.getParameter("pwd");
				System.out.println(pwd);
				user = new User();
				user.setcreate_date(new Date());
				user.setHeader("assets/images/header.jpg");
				user.setAccount(account);
				
				user.setPassword(pwd);
				userService.addUser(user);
				resp.sendRedirect("index");
				String block = "block";

				String none = "none";
				req.getSession().setAttribute("block",block);
				req.getSession().setAttribute("none",none);
				req.getSession().setAttribute("user", user);				
			}else{
				String already="用户名已存在";
				String display = "block";
				req.setAttribute("display",display);
				String sign = display;
				req.setAttribute("sign",sign);
				String login = "none";
				req.setAttribute("login",login);	
				req.setAttribute("already", already);
				resp.sendRedirect("index");

	
			}
			
			
		}
		
		
		
	}
	
	
	@RequestMapping("/loginOut")
	public void loginOut(HttpServletRequest req,HttpServletResponse resp) throws IOException{
		
	
		req.getSession().removeAttribute("user");
		req.getSession().invalidate();

		resp.sendRedirect("index");
		
	}


}
