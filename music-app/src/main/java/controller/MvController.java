package controller;


import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import entity.Mv;
import entity.MvComment;
import entity.User;
import service.prototype.IMvCommenService;
import service.prototype.IMvService;
import service.prototype.IUserService;

@Controller
public class MvController {

	@Autowired
	private IMvService mvService;
	@Autowired
	private IUserService userService;
	@Autowired
	private IMvCommenService mvCommenService;

	ModelAndView mav = null;

	//进入热门视频

	@RequestMapping("/MV")
	public ModelAndView mv(HttpServletRequest req,HttpServletResponse resp) {

		mav = new ModelAndView();
		User user = (User)req.getSession().getAttribute("user");
		if(user==null) {
			user=new User();
			user.setId(0);

		}
		List<Mv> mvs = mvService.searchMvAll();
		mvs = mvSort(mvs);
		mav.getModel().put("mvs", mvs);
		List<User> users = new ArrayList<>();

		List<List<MvComment>> mcss = new ArrayList<>();
		List<List<User>> mcuserss = new ArrayList<>();
		for (Mv mv : mvs) {
			List<MvComment> mcs = mvCommenService.findByMvId(mv.getId());
			List<User> mcusers = new ArrayList<>();
			for (MvComment mvComment : mcs) {
				User us = userService.findById(mvComment.getUserId());
				mcusers.add(us);
			}
			mcss.add(mcs);
			User us = userService.findById(mv.getUserId());

			mcuserss.add(mcusers);
			users.add(us);
		}
		
		mav.getModel().put("users", users);
		mav.getModel().put("mcuserss", mcuserss);
		mav.getModel().put("mcss", mcss);
		mav.setViewName("mv");

		return mav;
	}
	@RequestMapping("/MVF")
	public void mvf(@ModelAttribute("userId") int  userId ,@ModelAttribute("mvId") int mvId ,@ModelAttribute("content") String content) {	
		mvCommenService.addMvComment(new MvComment(userId,mvId,content));
	}
	
	public List<Mv> mvSort(List<Mv> mvs){
		for(int i = 0 ;i<mvs.size()-2;i++){
			for(int j = i;j<mvs.size()-1;j++){

Date date1 =mvs.get(i).getMv_time();
Date date2 = mvs.get(j+1).getMv_time();

if(date1.before(date2)){
	Mv mv = mvs.get(j+1);
	mvs.set(j+1, mvs.get(i));
	mvs.set(i, mv);
}
			
		}

		
	}
		return  mvs;
}
}