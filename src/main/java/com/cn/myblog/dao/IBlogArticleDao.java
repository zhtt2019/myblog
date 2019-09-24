package com.cn.myblog.dao;

import java.util.ArrayList;

import com.cn.myblog.entity.BlogArticle;

public interface IBlogArticleDao {

	// 获取指定文章
	public BlogArticle gainOne(Integer id);

	// 获取数据库所有文章
	public ArrayList<BlogArticle> gainAll();

	// 获取指定类型文章
	public ArrayList<BlogArticle> gainByType(Integer typeId);

	// 删除指定文章
	public int deletebyId(Integer id);

	// 改变文章分类
	public int typeChg(Integer typeId, Integer id);

	// 改变文章内容或标题
	public int updateArticle(BlogArticle blogArticle);

	// 添加新文章
	public int addArticle(BlogArticle blogArticle);

	// 阅读后增加点击量
	public int addClickHit(int id);
	
	//全文搜索
	public ArrayList<BlogArticle> searchArts(String title);

}
