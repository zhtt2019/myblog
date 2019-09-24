package com.cn.myblog.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.cn.myblog.dao.IBlogArticleDao;
import com.cn.myblog.entity.BlogArticle;
import com.cn.myblog.service.IBlogArticleService;
import com.github.pagehelper.PageHelper;

@Service
@Transactional
public class BlogArticleService implements IBlogArticleService {
	@Resource
	private IBlogArticleDao blogArticleDao;

	public BlogArticle gainOne(Integer id) {
		// TODO Auto-generated method stub
		return blogArticleDao.gainOne(id);
	}

	public ArrayList<BlogArticle> gainAll() {
		// TODO Auto-generated method stub
		return blogArticleDao.gainAll();
	}

	public ArrayList<BlogArticle> gainByType(Integer typeId) {
		// TODO Auto-generated method stub
		return blogArticleDao.gainByType(typeId);
	}

	public int deletebyId(Integer id) {
		// TODO Auto-generated method stub
		return blogArticleDao.deletebyId(id);
	}

	public int typeChg(Integer typeId, Integer id) {
		// TODO Auto-generated method stub
		return blogArticleDao.typeChg(typeId, id);
	}

	public int updateArticle(BlogArticle blogArticle) {
		// TODO Auto-generated method stub
		return blogArticleDao.updateArticle(blogArticle);
	}

	public int addArticle(BlogArticle blogArticle) {
		// TODO Auto-generated method stub
		return blogArticleDao.addArticle(blogArticle);
	}

	public int addClickHit(int id) {
		// TODO Auto-generated method stub
		return blogArticleDao.addClickHit(id);
	}

	@Override
	public ArrayList<BlogArticle> searchArts(String title) {
		// TODO Auto-generated method stub
		return blogArticleDao.searchArts(title);
	}

	@Override
	public List<BlogArticle> selectAll(int page) {
		PageHelper.startPage(page,5);
		List<BlogArticle> articles =  blogArticleDao.gainAll();
		return articles;
	}

}
