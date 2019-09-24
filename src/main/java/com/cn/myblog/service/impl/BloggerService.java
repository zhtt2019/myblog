package com.cn.myblog.service.impl;

import javax.annotation.Resource;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.cn.myblog.dao.IBloggerDao;
import com.cn.myblog.entity.Blogger;
import com.cn.myblog.service.IBloggerService;


@Service
@Transactional
public class BloggerService implements IBloggerService{
	@Resource
	private IBloggerDao bloggerDao;
	
	public boolean checkBlogger(String username) {
		Blogger blogger = bloggerDao.selectByUsername(username);
		if(blogger==null) {
			return false;
		}else {
			return true;
		}
	}
	
	public void register(Blogger blogger) {
		// TODO Auto-generated method stub
		if(bloggerDao.selectByUsername(blogger.getUsername())==null) {
			bloggerDao.insert(blogger);
		}else {
			try {
				throw new Exception("用户名已存在");
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	public Blogger login(String username, String password) {
		Blogger blogger = bloggerDao.selectByUsername(username);
		if(blogger==null) {
			try {
				throw new Exception("该用户不存在");
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		// TODO Auto-generated method stub
	    return bloggerDao.login(username,password);
	}

	@Override
	public void updateUser(Integer id, String username,String password, String email, Integer gender,String nickname) {
		Blogger user = new Blogger();
		//判读用户名是否存在
		Blogger u1 = bloggerDao.selectByUsername(username);
		if(u1==null){
			user.setUsername(username);
		}else{
			//用户名存在
			Blogger u2 = bloggerDao.selectById(id);
			if(u2!=null){
				//不修改登录用户名
				if(u2.getUsername().equals(username)){
					
				}else{
					try {
						throw new Exception("用户名已经存在");
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			}			
		}
		user.setId(id);
		user.setUsername(username);
		user.setPassword(password);
		user.setEmail(email);
		user.setGender(gender);
		user.setNickname(nickname);
		bloggerDao.update(user);
		
	}

	@Override
	public Blogger selectById(Integer id) {
		// TODO Auto-generated method stub
		return bloggerDao.selectById(id);
	}

	
}
