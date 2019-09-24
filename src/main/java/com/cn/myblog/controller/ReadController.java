package com.cn.myblog.controller;

import java.io.File;
import java.io.IOException;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringEscapeUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cn.myblog.entity.BlogArticle;
import com.cn.myblog.service.IBlogArticleService;
import com.cn.myblog.util.FileIO;

@Controller
@RequestMapping("/read")
public class ReadController {
	@Resource
	private IBlogArticleService articleService;

	@RequestMapping("/readPad")
	public String readPad(@RequestParam("typeId") Integer typeId, @RequestParam("id") int id,
			HttpServletRequest request) {
//		HttpSession session = request.getSession();
//		if (session.getAttribute("username") == null || session.getAttribute("username") == "") {
//			return "redirect:/login.do";
//		}
		articleService.addClickHit(id);
		BlogArticle blogArticle = articleService.gainOne(id);
		blogArticle.setTypeId(typeId);
//		blogArticle.setContent(StringEscapeUtils.unescapeHtml(blogArticle.getContent()));
		request.setAttribute("blogArticle", blogArticle);
		if(request.getParameter("page")!=null) {
		request.setAttribute("page", request.getParameter("page"));
		}
		System.out.println("readController中content" + blogArticle.getContent());
		return "readPad";
	}

	@RequestMapping("/getData")
	public void getData(@RequestParam("typeId") int typeId, @RequestParam("id") int id,
			HttpServletRequest request, HttpServletResponse response) throws IOException {
		String type = "";
		if(typeId==1) {
			type="设计";
		}else if(typeId==2) {
			type="前端";
		}else if(typeId==3) {
			type="后端";
		}else if(typeId==4) {
			type="工具资源";
		}else if(typeId==5){
			type="bug记录";
		}else {
			type="经验总结";
		}
		File file = new File("E:/MyBlog/"+type+"/" + id);
		FileIO fileIO = new FileIO();
		String content = "";
		content = fileIO.fileRead(file);
		try {
			response.setContentType("text/xml;charset=UTF-8");
			response.setHeader("Cache-Control", "no-cache");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(content);
		} catch (IOException e) {
			e.printStackTrace();
		}

	}
	
	@RequestMapping("/readDetail")
	public String readPad( @RequestParam("id") int id,HttpServletRequest request) {
		articleService.addClickHit(id);
		BlogArticle blogArticle = articleService.gainOne(id);
//		blogArticle.setContent(StringEscapeUtils.unescapeHtml(blogArticle.getContent()));
		request.setAttribute("blogArticle", blogArticle);
		System.out.println("readDetail中content" + blogArticle.getContent());
		return "articleDetail";
	}
	
}
