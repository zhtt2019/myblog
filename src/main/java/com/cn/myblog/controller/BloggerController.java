package com.cn.myblog.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cn.myblog.entity.Blogger;
import com.cn.myblog.entity.ResponseResult;
import com.cn.myblog.service.IBloggerService;

@Controller
@RequestMapping("/user")
public class BloggerController extends BaseController{
	@Resource
	private IBloggerService bloggerService;
	
	
	/**
	 * 显示注册页面
	 * @return
	 */
	@RequestMapping("showRegister")
	public String showRegister(){
		return "register";
	}
	
	/**
	 * 用户注册
	 * @param username
	 * @param password
	 * @return
	 */
	@RequestMapping("register")
	@ResponseBody
	public ResponseResult<Void> register(
			@RequestParam("username") String username,
			@RequestParam("password") String password,
			@RequestParam("info") String info,
			@RequestParam("nickname") String nickname,
			@RequestParam("sign") String sign,
			@RequestParam("imagePath") String imagePath){
		ResponseResult<Void> rr = 
				new ResponseResult<Void>();
		Blogger blogger = new Blogger();
		blogger.setUsername(username);
		blogger.setPassword(password);
		blogger.setInfo(info);
		blogger.setNickname(nickname);
		blogger.setSign(sign);
		blogger.setImagePath(imagePath);
		try{
			bloggerService.register(blogger);
		}catch(Exception e){
			rr.setState(0);
			rr.setMessage("用户名已经存在");
		}
		
		return rr;
		
	}
	
	/**
	 * 显示登录页面
	 * @return view组件名 
	 */
	@RequestMapping("showLogin")
	public String showLogin(){
		return "login";
	}
	
	/**
	 * 验证用户名是否可用
	 */
	@RequestMapping("/checkUsername")
	@ResponseBody
	public ResponseResult<Void> 
		checkUsername(String username){
		ResponseResult<Void> rr = 
				new ResponseResult<Void>();
		if(bloggerService.checkBlogger(username)){
			rr.setState(0);
			rr.setMessage("用户名已存在");
		}else{
			rr.setState(1);
			rr.setMessage("用户名可以使用");
		}
		return rr;
		
	}
	
	@RequestMapping("login")
	@ResponseBody
	public ResponseResult<Void> login(
			String username,String password,
			HttpSession session){
		ResponseResult<Void> rr = 
				new ResponseResult<Void>();
		try{
			Blogger blogger = 
					bloggerService.login(username, password);
			//登录成功后，user对象存到session中
			session.setAttribute("user",blogger);
//			session.setAttribute("username", username);
			rr.setState(1);
			rr.setMessage("登录成功");
		}catch(Exception e){
			rr.setState(0);
			rr.setMessage(e.getMessage());
			
		}
		
		return rr;
	}
	
	/**
	 * 退出
	 * @param session
	 * @return
	 */
	@RequestMapping("/loginout")
	public String exit(HttpSession session){
		//session无条件失效
		session.invalidate();
		return "redirect:../main/showIndex";
	}
	
	/**
	 * 显示个人信息
	 * @return
	 */
	@RequestMapping("/showPersonInfo")
	public String showPersonInfo(){
		return "personInfo";
	}
	
	/**
	 * 修改个人信息
	 * @param session
	 * @param username
	 * @param email
	 * @param gender
	 * @return
	 */
	@RequestMapping("/updateUser")
	@ResponseBody
	public ResponseResult<Void> updateUser(String username,String password,String email,Integer gender,String nickname,HttpSession session){
		ResponseResult<Void> rr = new ResponseResult<Void>();
		System.out.println(username+","+email+","+gender+","+nickname+","+password);
		try{
			bloggerService.updateUser(this.getId(session), username,password, email, gender,nickname);
			
			//设置修改后的user对象
			session.setAttribute("user",
					bloggerService.selectById(this.getId(session)));
			rr.setState(1);
			rr.setMessage("修改成功");
		}catch(Exception e){
			rr.setState(0);
			rr.setMessage(e.getMessage());
		}
		return rr;
	}
	
	
	
	
	
}
