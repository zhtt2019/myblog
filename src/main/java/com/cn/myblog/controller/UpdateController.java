package com.cn.myblog.controller;

import java.io.IOException;
import java.util.Calendar;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cn.myblog.entity.BlogArticle;
import com.cn.myblog.service.IBlogArticleService;
import com.cn.myblog.util.FileIO;


@Controller
@RequestMapping("/update")
public class UpdateController {
	@Resource
	private IBlogArticleService articleService;

	@RequestMapping("/updatePad")
	public String updatePad(@RequestParam("typeId") Integer typeId, @RequestParam("updateId") int updateId,
			HttpServletRequest request) {
		// HttpSession session = request.getSession();
		// if (session.getAttribute("username") == null ||
		// session.getAttribute("username") == "") {
		// return "redirect:/login.do";
		// }
//		System.out.println("updateController.typeId"+typeId);
		BlogArticle blogArticle = articleService.gainOne(updateId);
		blogArticle.setTypeId(typeId);
		// 修改文章时间 为修改时间
		// blogArticle.setReleaseDate(Calendar.getInstance().getTime());
		request.setAttribute("blogArticle", blogArticle);
		request.setAttribute("page", request.getParameter("page"));
//		System.out.println("updateController.article.typeId:"+blogArticle.getTypeId());
		return "updatePad";
	}

	@RequestMapping("/doUpdate")
	public String update(@RequestParam("articleId") String articleId, @RequestParam("textcontent") String textcontent,
			@RequestParam("typeId") String typeId, @RequestParam("title") String title,
			HttpServletRequest request, HttpServletResponse response) throws IOException {
		FileIO io = new FileIO();
		// String textContent = "";
//		System.out.println("|"+articleId+"|");
		BlogArticle article = articleService.gainOne(Integer.parseInt(articleId));
		Calendar calendar = Calendar.getInstance();
		article.setTypeId(Integer.parseInt(typeId));
		article.setTitle(title);
		article.setReleaseDate(calendar.getTime());
		article.setArticleStatus(0);
		article.setContent(textcontent);
		// 文章基本信息写入数据库
		articleService.updateArticle(article);
		System.out.println("数据库最新content"+article.getContent());
		// 文章内容写入文件系统(修改)
		// textContent = request.getParameter("textcontent");
		io.fileWrite(textcontent, Integer.parseInt(typeId), article.getId());
		return "redirect:../read/readPad?typeId=" + typeId + "&id=" + article.getId()+"&page=" +request.getParameter("page") ;
	}

//	 @RequestMapping("/getData")
//	 public void getData(@RequestParam("typeId") int typeId,
//	 @RequestParam("id") int id,
//	 HttpServletRequest request, HttpServletResponse response) throws
//	 IOException {
//	 File file = new File("F:/MyBlog/"+articleType+"/" + articleId + ".txt");
//	 fileIO fileIO = new fileIO();
//	 String content = "";
//	 content = fileIO.fileRead(file);
//	 try {
//	 response.setContentType("text/xml;charset=UTF-8");
//	 response.setHeader("Cache-Control", "no-cache");
//	 response.setCharacterEncoding("UTF-8");
//	 response.getWriter().write(content);
//	 } catch (IOException e) {
//	 e.printStackTrace();
//	 }
	
//	 }
	
}
