package com.cn.myblog.controller;

import java.io.IOException;
import java.util.Calendar;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cn.myblog.entity.BlogArticle;
import com.cn.myblog.service.IBlogArticleService;
import com.cn.myblog.util.FileIO;
import org.apache.commons.lang.StringEscapeUtils;

@Controller
@RequestMapping("/write")
public class WriteController {
	@Resource
	private IBlogArticleService blogArticleService;
	
	@RequestMapping("/show")
	public String write(HttpServletRequest request) {
		HttpSession session = request.getSession();
		if (session.getAttribute("user") == null) {
			return "redirect:../user/showLogin";
		}
		return "wordedit";
	}
	
	@RequestMapping("/save")
	// 服务器储存文章过程
	public String save(@RequestParam("textcontent") String content, @RequestParam("typeId") Integer typeId,
			@RequestParam("title") String title, HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		FileIO io = new FileIO();
		System.out.println("save中的content"+content);
		// String textContent = "";
		BlogArticle article = new BlogArticle();
		Calendar calendar = Calendar.getInstance();
		article.setTypeId(typeId);
		article.setTitle(title);
		article.setContent(content);
		article.setClickHit(0);
		article.setReleaseDate(calendar.getTime());
		// 文章基本信息写入数据库
		blogArticleService.addArticle(article);
//		System.out.println(article.getId());
		// 文章内容写入文件系统
		// textContent = request.getParameter("textcontent");
		io.fileWrite(content, typeId, article.getId());
		return "redirect:../read/readPad?typeId=" + typeId + "&id=" + article.getId();
	}

	@RequestMapping("/getData")
	public void getData(HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession();
		String content = "";
		if (null != session.getAttribute("articleContent")) {
			content = (String) session.getAttribute("articleContent");
		}
//		System.out.println("getData中的content："+content);
		response.setContentType("text/xml;charset=UTF-8");
		response.setHeader("Cache-Control", "no-cache");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(content);
	}

	@RequestMapping("/setData")
	public void setData(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String data = request.getParameter("textcontent");
//		System.out.println("setData中的content："+data+"----------------");
		HttpSession session = request.getSession();
		session.setAttribute("articleContent", data);
		// String content = "";
		// if (null != session.getAttribute("articleContent")) {
		// content = (String) session.getAttribute("articleContent");
		// }
		response.setContentType("text/xml;charset=UTF-8");
		response.setHeader("Cache-Control", "no-cache");
		response.setCharacterEncoding("UTF-8");
		// response.getWriter().write(content);
	}
	
}
