package com.cn.myblog.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

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
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
@RequestMapping("/list")
public class ListController {
	@Resource
	private IBlogArticleService blogArticleService;
	private FileIO fileio = new FileIO();
	
	@RequestMapping("/show")
	public String List(@RequestParam("typeId") Integer typeId, HttpServletRequest request,HttpSession session) {
		List<BlogArticle> allArticles = new ArrayList<BlogArticle>();
		PageInfo<BlogArticle> page = new PageInfo<BlogArticle>();
		int curr = 1;
		String type = "";
		if (request.getParameter("page") != null &&request.getParameter("page") != "") {
			curr = Integer.parseInt(request.getParameter("page"));
		}
		PageHelper.startPage(1, 10);
		allArticles = blogArticleService.gainByType(typeId);
		page = new PageInfo<BlogArticle>(allArticles);
		if (curr >= page.getPages()) {
			curr = page.getPages();
		}
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
		request.setAttribute("indexSum", page.getPages());
		request.setAttribute("type", type);
		request.setAttribute("typeId", typeId);
		request.setAttribute("curr", curr);
		request.setAttribute("allArticles", allArticles);
		return "articleList";
	}

	@RequestMapping("/page")
	public void page(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		List<BlogArticle> allArticles = new ArrayList<BlogArticle>();
		PageInfo<BlogArticle> page = new PageInfo<BlogArticle>();
		String data = "";
		String panduan = "";
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
		int pageindex = Integer.parseInt(request.getParameter("page"));
//		System.out.println("pageindex的值为：" + pageindex);
		Integer typeId = Integer.parseInt(request.getParameter("typeId"));
//		System.out.println("typeId的值为：" + typeId);
		PageHelper.startPage(pageindex, 10);
		allArticles = blogArticleService.gainByType(typeId);
//		System.out.println("allArticle的长度：" + allArticles.size());
		page = new PageInfo<BlogArticle>(allArticles);
//		System.out.println("allArticle的长度：" + allArticles.size());
		for (int i = 1; i <= allArticles.size(); i++) {
//			System.out.println(dateFormat.format(allArticles.get(i - 1).getReleaseDate()));
			data += "<tr>" + "<td>" + i + "</td>" + "<td><a href=\"../read/readPad?typeId=" + typeId
					+ "&id=" + allArticles.get(i - 1).getId() + "&page=" + pageindex + "\""
					+ " data-method=\"offset\" data-type=\"auto\" class=\"\">" + allArticles.get(i - 1).getTitle()
					+ " </a></td>" + "<td>" + allArticles.get(i - 1).getClickHit() + "</td>" + "<td>"
					+ dateFormat.format(allArticles.get(i - 1).getReleaseDate()) + "</td>";
			if (session.getAttribute("user") != null) {
				panduan = "<td>" + "<select id=\"" + allArticles.get(i - 1).getId()
						+ "\" class=\"articleStatus\" name=\"articleStatus\" lay-verify=\"\">" + "<option value=\"1\""
					    + ">可视</option>"
						+ "<option value=\"0\""
						+ ">不可视</option>" + "</select>" + "</td>" + "<td>"
						+ "<a  href=\"../update/updatePad?typeId="+typeId
						+ "&updateId=" + allArticles.get(i - 1).getId() + "&page=" + pageindex
						+ "\" data-method=\"offset\" data-type=\"auto\" class=\"\">编辑</a>|<a id=\""
						+ allArticles.get(i - 1).getId()
						+ "\" href=\"javascript:void(0)\" data-method=\"offset\" data-type=\"auto\" class=\"layer_btn\">分类</a>|<a class=\"top_article\"  href=\"/MyBlog/top.do?articleType="
						+ typeId + "&topId=" + allArticles.get(i - 1).getId()
						+ "&page=" + pageindex + "\"" + ">置顶</a>|<a id=" + "\"" + allArticles.get(i - 1).getId() + "\""
						+ " class=\"delete_article\"  href=\"javascript:void(0)\">删除</a>" + "</td>" + "</tr>";
				data = data + panduan;
			}
		}
		try {
			response.setContentType("text/xml;charset=UTF-8");
			response.setHeader("Cache-Control", "no-cache");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(data);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@RequestMapping("/deleteArt")
	public String Dalete(@RequestParam("deleteId") int deleteId, @RequestParam("typeId") Integer typeId,HttpServletRequest request) throws IOException {
		blogArticleService.deletebyId(deleteId);
		fileio.deleteFile(typeId, deleteId);
		return "redirect:/list/show?typeId=" + typeId + "&page=" + request.getParameter("page");
	}

	@RequestMapping("/typeChg")
	public String typeChange(@RequestParam("lastType") String lastType, @RequestParam("classId") int classId,
			@RequestParam("typeId") String typeId, HttpServletRequest request) throws IOException {
//		System.out.println("之前文章类型"+typeId);
//		System.out.println("最新文章类型"+lastType);
//		System.out.println(request.getParameter(lastType));
//		System.out.println(request.getParameter("articleType"));
		blogArticleService.typeChg(Integer.parseInt(lastType), classId);
		fileio.changeFile(lastType,Integer.parseInt(typeId), classId);
		return "redirect:/list/show?typeId=" + typeId;
	}
	
	@RequestMapping("/changeStatus")
	public void changeStatus(@RequestParam("id") int id, @RequestParam("status") int status, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws IOException {
		BlogArticle blogArticle = blogArticleService.gainOne(id);
//		System.out.println("status中数据库中的typeId"+blogArticle.getTypeId());
		blogArticle.setArticleStatus(status);
		blogArticle.setTypeId(Integer.parseInt(request.getParameter("typeId")));
//		System.out.println("status中插入后的typeId"+blogArticle.getTypeId());
		blogArticleService.updateArticle(blogArticle);
		response.setContentType("text/xml;charset=UTF-8");
		response.setHeader("Cache-Control", "no-cache");
		response.setCharacterEncoding("UTF-8");
		try {
			response.getWriter().write("修改成功");
		} catch (Exception e) {
			response.getWriter().write("修改失败");
			e.printStackTrace();
		}
	}
	
}
