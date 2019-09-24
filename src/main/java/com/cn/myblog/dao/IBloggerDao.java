package com.cn.myblog.dao;

import org.apache.ibatis.annotations.Param;

import com.cn.myblog.entity.Blogger;

public interface IBloggerDao {
	/**
	 * 注册前验证用户是否已存在
	 * @param username
	 * @return
	 */
	Blogger selectByUsername(String username);
	/**
	 * 博主注册
	 * @param blogger
	 */
	void insert(Blogger blogger);
	
	
    Blogger login(@Param("username")String username, @Param("password")String password);
    
    Blogger selectById(Integer id);
    
    void update(Blogger blogger);
}
