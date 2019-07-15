package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import entity.Play;
import entity.PlayRecord;
import entity.Song;
import entity.SongComment;
import entity.SongCommentDTO;
import entity.User;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import service.prototype.IPlayRecordService;
import service.prototype.IPlayService;
import service.prototype.ISongCommentService;
import service.prototype.ISongService;
import service.prototype.IUserService;
import service.prototype.IVipService;
import util.HttpClientResult;
import util.HttpClientUtil;
import util.JsonUtil;

@RestController
public class PlayController {
	
	@Autowired
	private ISongService songService;
	
	@Autowired
	private ISongCommentService songCommentService;
	@Autowired
	private IUserService userService;
		
	@Autowired 
	private IPlayService playService;
	
	@Autowired 
	private IVipService vipService;
	
	@Autowired
	private IPlayRecordService playRecordService;
 
	
	ModelAndView mv=new ModelAndView();
	
	
	
	//进入播放页面
	@RequestMapping(value = "/play")
	@ResponseBody
	public ModelAndView nowPlay(HttpServletRequest req,HttpServletResponse resp,HttpSession session) throws IOException{
		resp.setContentType("text/html; charset=utf-8");
		int num  =0;
		String songid = req.getParameter("songId");
		int songId = Integer.parseInt(songid);
		Song song = songService.searchSong(songId);
		User user = (User)req.getSession().getAttribute("user");
		if(user==null) {
			user=new User();
			user.setId(0);

		}if(song.isVip()==true) {
			if(vipService.findVipByUserId(user.getId())==null){
				System.out.println(111);
				PrintWriter out = resp.getWriter();
				out.print("<script language=\"javascript\">alert('这首歌是vip专享，您还不是尊贵的vip');window.location.href='/music/index'</script>");
				return null;
			} else {
				session.setAttribute("songId", songId);
				
				//添加正在播放
				Play play = new Play();
				play.setSongId(songId);
				play.setUserId(user.getId());	 
				playService.addPlay(play);
				//添加播放记录
				PlayRecord pr = new PlayRecord();
				pr.setUserId(user.getId());
				pr.setSongId(songId);
				playRecordService.addSongRecord(pr);
				
				List<SongComment> songComments = songCommentService.findBySongId(songId);
				
				for (SongComment songComment : songComments) {
					num++;
				}
				mv.addObject("num",num);
				
				mv.addObject("song",song);
				mv.setViewName("play");
				return mv;
			}
			
		}else {
			session.setAttribute("songId", songId);
			
			//添加正在播放
			Play play = new Play();
			play.setSongId(songId);
			play.setUserId(user.getId());	 
			playService.addPlay(play);
			//添加播放记录
			PlayRecord pr = new PlayRecord();
			pr.setUserId(user.getId());
			pr.setSongId(songId);
			playRecordService.addSongRecord(pr);
			
			List<SongComment> songComments = songCommentService.findBySongId(songId);
			
			for (SongComment songComment : songComments) {
				num++;
			}
			mv.addObject("num",num);
			
			mv.addObject("song",song);
			mv.setViewName("play");
			return mv;
		}
	
	}
	
	//
	@RequestMapping("/searchPlay")
	public ModelAndView play(HttpServletRequest req,HttpServletResponse resp){
		String id = req.getParameter("id");
		/*User user = (User)req.getSession().getAttribute("user");

		String comment = req.getParameter("comment");
		System.out.println(comment);
		//添加歌曲评论
		songCommentService.addSongComment(user.getId(), Integer.parseInt(id), comment);*/
		HttpClientResult doGet = null;
		try {
			doGet = HttpClientUtil.doGet("https://v1.itooi.cn/netease/lrc?id="+id);
			Song song = new Song();
			song.setSongWords(doGet.toString());
			song.setSongImage("https://v1.itooi.cn/netease/pic?id="+id);
			song.setSongUrl("https://v1.itooi.cn/netease/url?id="+id+"&quality=flac");
			doGet = HttpClientUtil.doGet("https://v1.itooi.cn/netease/song?id="+id);
			String json = doGet.toString();
			JSONObject ss = JsonUtil.toJson(json);
			String data = ss.getString("data");
			JSONObject songs = JsonUtil.toJson(data);
			String son = songs.getString("songs");
			son = JsonUtil.sub(son);
			songs = JsonUtil.toJson(son);
			String name = songs.getString("name");
			String ar = songs.getString("ar");
			ar = JsonUtil.sub(ar);
			songs = JsonUtil.toJson(ar); 
			String author = songs.getString("name");
			song.setSongName(name);
			song.setSongAuthor(author);
			mv.addObject("song",song);
			mv.setViewName("play");
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return mv;
		
	}
	
	@RequestMapping(value = "/nnn",produces = "text/plain;charset=UTF-8",method = RequestMethod.POST)
	@ResponseBody
	public String hello(HttpServletRequest req,HttpServletResponse resp,HttpSession session) throws IOException{

		String comment = req.getParameter("comment");
		
		songCommentService.addSongComment(((User)(req.getSession().getAttribute("user"))).getId(), (int)session.getAttribute("songId"), comment);
		
		
		
		
		String data = "添加成功";
		return data;
		
	}
	
	@RequestMapping(value = "/mmm",method = RequestMethod.POST)
	public void mmm(HttpServletRequest req,HttpServletResponse resp) throws IOException{
		PrintWriter pw = resp.getWriter();
		User user = null;
		String songId = req.getParameter("songId");
		System.out.println(songId);
		List<SongComment> songComments = songCommentService.findBySongId(Integer.parseInt(songId));
		req.setCharacterEncoding("utf-8");
		
		List<SongCommentDTO> scDTOs = new ArrayList<SongCommentDTO>();
		for (SongComment songComment : songComments) {
			SongCommentDTO scDTO = new SongCommentDTO();
			user = userService.findById(songComment.getUserId());
			scDTO.setSongComment(songComment);
			scDTO.setUser(user);
			scDTOs.add(scDTO);
		}
		resp.setContentType("test/javascript;charset=utf-8");
		JSONArray ss = JSONArray.fromObject(scDTOs);
		pw.write(ss.toString());
		
		
	}
	

}
