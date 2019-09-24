<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>博文列表</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/ArticleList.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/article.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" type="text/css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/laybar.css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.0.3/jquery-confirm.min.css">
<script src="${pageContext.request.contextPath}/js/jquery-1.12.0.min.js" type="text/javascript"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.0.3/jquery-confirm.min.js"
	type="text/javascript"></script>
</head>

<body>
	<script src="${pageContext.request.contextPath}/layui/layui.js" type="text/javascript"></script>
	<script type="text/javascript">
		layui.use('element', function() {
			var element = layui.element();
			//一些事件监听
			element.on('tab(demo)', function(data) {
				console.log(data);
			});
		});
	</script>
	<div class="headerMenu">
		<div class="alignment">
			<div class="headerBlank"></div>
			<div class="headerUser">
				<p class="headerUsertitile">涛哥的个人博客</p>
			</div>
			<div class="menubardiv">
				<ul class="layui-nav" lay-filter="">
					<li class="layui-nav-item"><a
						href="${pageContext.request.contextPath}/list/show?typeId=1">设计</a></li>
					<li class="layui-nav-item layui-this"><a
						href="${pageContext.request.contextPath}/list/show?typeId=2">前端</a></li>
					<li class="layui-nav-item"><a
						href="${pageContext.request.contextPath}/list/show?typeId=3">后端</a></li>
					<li class="layui-nav-item"><a href="javascript:;">Other</a>
						<dl class="layui-nav-child">
							<!-- 二级菜单 -->
							<dd>
								<a href="${pageContext.request.contextPath}/list/show?typeId=4">工具资源</a>
							</dd>
							<dd>
								<a href="${pageContext.request.contextPath}/list/show?typeId=5">bug记录</a>
							</dd>
							<dd>
								<a href="${pageContext.request.contextPath}/list/show?typeId=6">经验总结</a>
							</dd>
							<c:if test="${sessionScope.user ne null}">
								<dd>
									<a href="${pageContext.request.contextPath}/write/show">写文章</a>
								</dd>
							</c:if>
						</dl></li>
				</ul>
			</div>
			<div class="searchFormdiv">
				<form class=" layui-form searchForm" action="">
					<div>
						<button class="layui-btn layui-btn-primary">搜索</button>
					</div>
					<input type="text" name="title" required lay-verify="required"
						placeholder="在所有结果中搜索" autocomplete="off" class="layui-input">
				</form>
			</div>
		</div>
		<div class="login-in-out" style="text-align: center;">
			<ul class="layui-nav" lay-filter="">
				<li class="layui-nav-item"><a href="javascript:;">个人中心</a>
					<dl class="layui-nav-child">
						<!-- 二级菜单 -->
						<c:choose>
							<c:when
								test="${sessionScope.user eq null}">
								<dd>
									<a href="${pageContext.request.contextPath}/user/showLogin">登录</a>
								</dd>
							</c:when>
							<c:otherwise>
								<dd>
									<a href="${pageContext.request.contextPath}/user/showPersonInfo">信息管理</a>
								</dd>
								<dd>
									<a href="${pageContext.request.contextPath}/user/loginout">退出</a>
								</dd>
							</c:otherwise>
						</c:choose>
					</dl></li>
			</ul>
		</div>
	</div>
	<div class="articleListBody">
	<input type="hidden" value="${typeId}" id="tp"/>
		<div class="articleListBody-head">
			<span class="layui-breadcrumb"> <a href="${pageContext.request.contextPath}/main/showIndex">Home</a> <a><cite><c:out
							value="${type}" /></cite></a>
			</span>
		</div>
		<hr />
		<div class="ListContent">
			<table class="layui-table" lay-even="" lay-skin="nob">

				<thead>
					<tr>
						<th style="width: 5 px;"></th>
						<th>标题</th>
						<th>阅读</th>
						<th>日期</th>
						<c:if test="${sessionScope.user.username eq '张涛涛'}">
							<th>状态设置</th>
							<th>操作</th>
						</c:if>
					</tr>
					<!--<c:forEach varStatus="status" items="${allArticles}" var="article">
						<tr>
							<td style="width: 5px;">置顶</td>
							<td><a
								href="${pageContext.request.contextPath}/read/readPad?typeId=${typeId}&id=${article.id}&page=${curr}"
								data-method="offset" data-type="auto" class="">${article.title}</a></td>
							<td>${article.clickHit}</td>
							<td><fmt:formatDate type="date"
									value="${article.releaseDate}" /></td>
							<c:if test="${sessionScope.user.username eq '张涛涛'}">
								<td><select id="${article.id}" class="articleStatus"
									name="articleStatus" lay-verify="">
										<option value="1"
											<c:if test="${article.articleStatus ne 1}">selected="selected"</c:if>>可视</option>
										<option value="0"
											<c:if test="${article.articleStatus eq 1}">selected="selected"</c:if>>不可视</option>
								</select></td>
								<td><a
									href="${pageContext.request.contextPath}/updatePad.do?articleType=${typeId}&updateId=${article.id}&page=${curr}"
									data-method="offset" data-type="auto" class="">编辑</a>|<a
									id="${article.id}" href="javascript:void(0)"
									data-method="offset" data-type="auto" class="layer_btn">分类</a>|<a
									class="top_article"
									href="${pageContext.request.contextPath}/untop.do?articleType=${articleType}&untopId=${article.id}&page=${curr}">取消置顶</a>|<a
									id="${article.id}" class="delete_article"
									href="javascript:void(0)">删除</a></td>
							</c:if>
						</tr>
					</c:forEach>-->
				</thead>
				<tbody id="page_Information">
					<c:forEach varStatus="status" items="${allArticles}" var="article">
						<tr>
							<td style="width: 5px;">${status.count}</td>
							<td><a
								href="${pageContext.request.contextPath}/read/readPad?typeId=${typeId}&id=${article.id}&page=${curr}"
								data-method="offset" data-type="auto" class="layer_btn">${article.title}</a></td>
							<td>${article.clickHit}</td>
							<td><fmt:formatDate type="date" value="${article.releaseDate}" /></td>
							<c:if test="${sessionScope.user.username eq '张涛涛'}">
								<td><select id="${article.id}" class="articleStatus" name="articleStatus">
										<option value="1"
											<c:if test="${article.articleStatus eq 0}">selected="selected"</c:if>>可视</option>
										<option value="0"
											<c:if test="${article.articleStatus eq 1}">selected="selected"</c:if>>不可视</option>
								</select></td>
								<td><a href="${pageContext.request.contextPath}/update/updatePad?updateId=${article.id}&page=${curr}"
									data-method="offset" data-type="auto" class="">编辑</a>|<a
									id="${article.id}" href="javascript:void(0)"
									data-method="offset" data-type="auto" class="layer_btn">分类</a>|<a
									class="top_article"
									href="${pageContext.request.contextPath}/untop.do?articleType=${articleType}&untopId=${article.id}&page=${curr}">取消置顶</a>|<a
									id="${article.id}" class="delete_article"
									href="javascript:void(0)">删除</a>
								</td>
							</c:if>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<div style="background-color: #F6F6F6;" id="demo7"></div>
			<hr />
			<div class="footerBeizhu">
				<div class="footerBeizhuDiv">
					<p>
						<br /> <br /> Welcome to zhttao's exclusive space! <br />
						let's go party party all night !oh oh oh... <br /> @zhttao
					</p>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		//layui表单
		layui.use([ 'form', 'layedit', 'laydate' ],
				function() {
					var form = layui.form(), layer = layui.layer, layedit = layui.layedit, laydate = layui.laydate;
					//监听提交
					form.on('submit(demo1)', function(data) {
						layer.alert(JSON.stringify(data.field), {
							title : '最终的提交信息'
						})
					return false;
					});
				});

		//layui分页与弹出层
		layui.use([ 'laypage', 'layer' ],
				function() {
				var laypage = layui.laypage, layer = layui.layer;
				var $ = layui.jquery;
				//初始化弹出层窗口
				var active = {
					offset : function(othis) {
						var type = othis.data('type'), text = othis.text();
						var id = othis.attr('id');
						layer.open({
								type : 1,
								title : '文章分类',
								area : [ '500px', '400px' ],
								//offset:type,
								id : 'LAY_DEMO' + type,
								content : '<form id="'
									+ id
									+ '" class="layui-form layui-form-pane tanchuang" action="${pageContext.request.contextPath}/list/typeChg?typeId=${typeId}'
									+'&classId='
									+id
									+ '" method="post"><select name="lastType" lay-verify=""><option value="">选择分类</option><option value="1">设计</option><option value="2">前端</option><option value="3">后端</option><option value="4">工具资源</option><option value="5">bug记录</option><option value="6">经验总结</option></select></form>',
								btn : [ 'yes', 'no' ],
								shade : [ 0.8, '#000' ],
								btnAlign : 'c', //按钮居中
								yes : function() {
										$(".tanchuang").submit();
									  },
								btn2 : function() {
										alert('no');
									   },
								cancel : function() {
										layer.closeAll();
									   }
								})

							}
						};
				//初始化分页参数
				laypage({
					cont : 'demo7',
					pages : "${indexSum}",
					skip : true,
					curr : "${curr}",
					jump : function(obj, first) {
							$("#page_Information").empty();
							var typeId = $("#tp").val();
							//ajax获取页面内容
							$.ajax({
								url : "${pageContext.request.contextPath}/list/page",
								type : "post",
								dataType : "html",
								contentType : "application/x-www-form-urlencoded; charset=utf-8",
								timeout : 6000,
								data : {
									"page" : obj.curr,
									"typeId" : typeId
									   },
								//获取成功，为页面新添加元素初始化
								success : function(msg) {
									$("#page_Information").append(msg);
									var form = layui.form(), layer = layui.layer, layedit = layui.layedit, laydate = layui.laydate;
										form.render('select');
										//弹出层
										$('.layer_btn').on('click',function() {
											var othis = $(this), method = othis.data('method');
											active[method] ? active[method].call(this,othis): '';
											var form = layui.form(), layer = layui.layer, layedit = layui.layedit, laydate = layui.laydate;
											form.render('select');
										});
										$('.articleStatus').on('change',function() {
											var id = $(this).attr('id');
											var articleStatus = $(this).val();
											$.ajax({
												url : "${pageContext.request.contextPath}/list/changeStatus",
												type : "post",
												dataType : "html",
												contentType : "application/x-www-form-urlencoded; charset=utf-8",
												timeout : 6000,
												data : {
													"id" : id,
													"status" : articleStatus,
													"typeId" : typeId
													},
												//获取成功，为页面新添加元素初始化
												success : function(msg) {
													alert(msg);
														}
													})
												});
								//删除行为
								$(".delete_article").click(function() {
									var delete_id = $(this).attr("id");
									$.confirm({
										title : '注意!',
										content : '是否要删除本文章!',
										useBootstrap : false,
										buttons : {
											确定 : function() {
												var typeId = $("#tp").val();
												window.location.href = "${pageContext.request.contextPath}/list/deleteArt?typeId="
												+ typeId
												+ "&deleteId="
												+ delete_id
												+ "&page="
												+ obj.curr;
												},
											取消 : function() {
											}
										}
									});
								})
							}
						})
					}
				});
			});
	</script>

</body>
</html>