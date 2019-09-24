package com.cn.myblog.controller;

import javax.servlet.http.HttpSession;

import com.cn.myblog.entity.Blogger;

//获取登录的用户id值
public class BaseController {
	public Integer getId(HttpSession session){
		//获取session中的user 对象
		Blogger blogger = (Blogger)session.
				getAttribute("user");
		if(blogger==null){
			return null;
		}else{
			//返回userid
			return blogger.getId();
		}
	}

}




