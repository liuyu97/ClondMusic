package controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.net.URI;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.params.ClientPNames;
import org.apache.http.client.params.CookiePolicy;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.params.DefaultedHttpParams;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import entity.SearchSong;
import entity.User;
import net.sf.json.JSONObject;
import service.prototype.ISeachRecordService;
import service.prototype.ISongService;
import util.HttpClientResult;
import util.HttpClientUtil;

@Controller
public class SearchController {
	
	@Autowired
	private ISeachRecordService seachRecordService;
	
	private ModelAndView mv = new ModelAndView();

	// 进入查询页面
	@RequestMapping("/search")
	public ModelAndView search(HttpServletRequest req,HttpServletResponse resp) {
		List<String> keywords = seachRecordService.keywordTopTen();

		mv.setViewName("search");
		req.setAttribute("keywords",keywords);
		System.out.println(keywords);
		return mv;
	}

	@RequestMapping(value="/searchSong",method=RequestMethod.POST)
	
	public void  searchSong(HttpServletRequest req,HttpServletResponse resp) throws IOException{
		PrintWriter pw = resp.getWriter();
		String keyWord = req.getParameter("keyWord");
		System.out.println(keyWord);
		User user = (User)req.getSession().getAttribute("user");
		if(user==null) {
			user=new User();
		}
		seachRecordService.addOrUpdateSearchRecord(user.getId(),keyWord);
		String url = SearchSong.URL;
		

		HttpClientResult doGet = null;
		try {
			doGet = HttpClientUtil.doGet("https://v1.itooi.cn/netease/search?keyword="+keyWord+"&type=song&pageSize=52&page=0");
			System.out.println(doGet);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		resp.setContentType("test/javascript;charset=utf-8");
		String json = doGet.toString();
		JSONObject ss = JSONObject.fromObject(json);
		pw.write(ss.toString());
		
		 
	}

}
