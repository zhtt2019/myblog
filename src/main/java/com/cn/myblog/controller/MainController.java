package com.cn.myblog.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cn.myblog.entity.BlogArticle;
import com.cn.myblog.service.IBlogArticleService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
@RequestMapping("/main")
public class MainController {
	@Resource
	private IBlogArticleService blogArticleService;
	
	@RequestMapping("showIndex")
	public String showIndex(HttpServletRequest request) {
		int curr = 1;
		if (request.getParameter("page") != null &&request.getParameter("page") != "") {
			curr = Integer.parseInt(request.getParameter("page"));
		}
		List<BlogArticle> articles =  blogArticleService.selectAll(curr);
		PageInfo<BlogArticle> pageInfo = new PageInfo<BlogArticle>(articles);
		if (curr >= pageInfo.getPages()) {
			curr = pageInfo.getPages();
		}
		request.setAttribute("pageInfo", pageInfo);
//		System.out.println("文章总数："+pageInfo.getTotal());
//		request.setAttribute("allArticles", articles);
		return "index";
	}
	
	//搜索功能
	@RequestMapping("search")
	public String showSearch(@RequestParam("title")String title,HttpServletRequest request) {
		List<BlogArticle> articles =  blogArticleService.searchArts(title);
		request.setAttribute("allArticles", articles);
		return "index";
	}
	
}
