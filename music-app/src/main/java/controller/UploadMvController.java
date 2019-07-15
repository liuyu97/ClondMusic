package controller;

import java.io.File;
import java.io.IOException;
import java.net.URISyntaxException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.commons.io.FileUtils;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import entity.Sms;
import entity.Mv;
import entity.Type;
import entity.User;
import service.prototype.IMvService;


@Controller
public class UploadMvController {
	
	@Autowired
	private IMvService mvService;
	
	private ModelAndView mv= new ModelAndView();
	
	
	@RequestMapping("/uploadMv")
	public ModelAndView uploadMv(HttpServletRequest req,HttpServletResponse resp){
		mv.setViewName("uploadMv");

		return mv;
	}
	
	@RequestMapping(value="/getMv",method=RequestMethod.POST,produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String getMv(@RequestParam(value = "mvFile", required = false) MultipartFile mvFile,@RequestParam(value = "mvImgFile", required = false) MultipartFile mvImgFile,HttpServletRequest req,HttpServletResponse resp) {
		User user = (User)req.getSession().getAttribute("user");
	
		 System.out.println(user);
		 try {
			 File desMvFile=new File("src/main/webapp/assets/mv/"+mvFile.getOriginalFilename());
				FileUtils.writeByteArrayToFile(desMvFile,mvFile.getBytes());
			
			    Map<String,String> map = new HashMap<String,String>();
				map.put("mvUrl", "assets/mv/"+mvFile.getOriginalFilename());
			 
				JSONObject obj = new JSONObject(map); 
				
				return obj.toString();
			} catch (IOException e) {
				e.printStackTrace();
				return "f";
			}
		 

	}

	@RequestMapping(value="/addMv",method=RequestMethod.POST,produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String addMv(HttpServletRequest req,HttpServletResponse resp){
		User user = (User)req.getSession().getAttribute("user");
		String mvName = req.getParameter("mvName");

		String mvUrl = req.getParameter("mvUrl");

		String description = req.getParameter("description");
		
		int userId=user.getId();
		Mv mv=new Mv();
		mv.setMvName(mvName);
		
		mv.setMvUrl(mvUrl);
		
		mv.setDescription(description);
		
		mv.setUserId(userId);
		System.out.println(mv);
		mvService.addMv(mv);
		
		String data="发布成功";
		return data;
	}
	
	
	

}
