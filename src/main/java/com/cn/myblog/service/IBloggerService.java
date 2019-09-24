package com.cn.myblog.service;

import com.cn.myblog.entity.Blogger;

public interface IBloggerService {
	boolean checkBlogger(String username);
	void register(Blogger blogger);
	Blogger login(String username,String password);
	void updateUser(Integer id,String username,String password,
			String email,Integer gender,String nickname);
	Blogger selectById(Integer id);
}
