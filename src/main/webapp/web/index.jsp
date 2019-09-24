<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>zhtt博客主页</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/index2.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css" type="text/css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/article.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" type="text/css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/laybar.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/slider.css" />
</head>

<body>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery1.42.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.SuperSlide.2.1.1.js"></script>
	<script src="${pageContext.request.contextPath}/js/jquery-1.12.0.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/gdlb.js"></script>
	<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
	<script>
		layui.use('element', function() {
			var element = layui.element();
			//一些事件监听
			element.on('tab(demo)', function(data) {
				console.log(data);
			});
		});
	</script>

	<div class="pageHeader">
		<div class="headerMenu">
			<div class="alignment">
				<div class="headerBlank"></div>
				<div class="headerUser">
					<p class="headerUsertitile">归来仍是少年</p>
				</div>
				<div class="menubardiv">
					<ul class="layui-nav" lay-filter="">
					<li class="layui-nav-item"><a href="${pageContext.request.contextPath}/list/show?typeId=1">设计</a></li>
					<li class="layui-nav-item layui-this"><a href="${pageContext.request.contextPath}/list/show?typeId=2">前端</a></li>
					<li class="layui-nav-item"><a href="${pageContext.request.contextPath}/list/show?typeId=3">后端</a>
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
							<c:if test="${sessionScope.user.username eq '张涛涛'}">
							<dd>
								<a href="${pageContext.request.contextPath}/write/show">写文章</a>
							</dd>
						    </c:if>
							
						</dl></li>
				</ul>
				</div>
				<div class="searchFormdiv">
					<form class=" layui-form searchForm" action="${pageContext.request.contextPath}/main/search">
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
		<div class="headerPic">
			<div id="ban1">
				<div class="banner">
					<ul class="img">
						<li><a href="#"><img src="${pageContext.request.contextPath}/images/1.jpg"></a></li>
						<li><a href="#"><img src="${pageContext.request.contextPath}/images/2.jpg"></a></li>
						<li><a href="#"><img src="${pageContext.request.contextPath}/images/3.jpg"></a></li>
					</ul>

					<ul class="num">
					</ul>

					<div class="btn btn_l">&lt;</div>
					<div class="btn btn_r">&gt;</div>

				</div>

			</div>
		</div>
	</div>
	<!--
        主页添加文章内容
        -->
	<div class="pageContent">
		<div class="content">
			<div class="contentDiv content_text">				
					<c:forEach varStatus="status" items="${pageInfo.list}" var="article">
						<!--wz-->
			           <div class="wz">
			            <h3><a href="${pageContext.request.contextPath}/read/readDetail?id=${article.id}">${article.title}</a></h3>
			             <dl>
			               <dt>
			               	<c:choose> 
							  <c:when test="${article.typeId==1}"><img src="${pageContext.request.contextPath}/img/11.png" width="200"  height="153" alt="">  </c:when> 
							  <c:when test="${article.typeId==2}"><img src="${pageContext.request.contextPath}/img/22.png" width="200"  height="153" alt=""></c:when> 
							  <c:when test="${article.typeId==3}"><img src="${pageContext.request.contextPath}/img/33.png" width="200"  height="153" alt=""></c:when> 
							  <c:when test="${article.typeId==4}"><img src="${pageContext.request.contextPath}/img/44.png" width="200"  height="153" alt=""></c:when> 
							  <c:when test="${article.typeId==5}"><img src="${pageContext.request.contextPath}/img/55.png" width="200"  height="153" alt=""></c:when> 
							  <c:otherwise><img src="${pageContext.request.contextPath}/img/66.png" width="200"  height="153" alt=""></c:otherwise> 
							</c:choose> 
			               </dt>
			               <dd>
			               	 <div class="dd_text_1">${article.content}</div>
			                 <div class="dd_text_2">
			               <span class="left sj" style="background:url('${pageContext.request.contextPath}/images/sj.png') 5px 7px no-repeat;">${article.releaseDateStr }</span>
			               <span class="left fl">分类:<a href="${pageContext.request.contextPath}/list/show?typeId=${article.typeId}">
			               
			               <c:choose> 
							  <c:when test="${article.typeId==1}">设计  </c:when> 
							  <c:when test="${article.typeId==2}">前端</c:when> 
							  <c:when test="${article.typeId==3}">后端</c:when> 
							  <c:when test="${article.typeId==4}">工具资源</c:when> 
							  <c:when test="${article.typeId==5}">bug记录</c:when> 
							  <c:otherwise>经验总结</c:otherwise> 
							</c:choose> 
			               
			               </a></span>
			               <span class="left yd"><a href="${pageContext.request.contextPath}/read/readDetail?id=${article.id}" title="阅读全文">阅读全文</a></span>
			               </div> 
			               </dd>
			             </dl>
			            </div>
			             <!--wz end-->
	       			</c:forEach>
	       			<br><br><br><br><br><br><br><br><br><br><br><br>
	       	<!--显示分页信息-->
	        <!--点击分页-->
	            <div aria-label="Page navigation" style="width:800px;height:50px;text-align: center;font-size:15px;position:absolute;left:550px;top:1110px;">
	                <ul class="pagination" style="display:table-cell;white-space: nowrap;width:250px;height:40px;color:#F00">
	                    <li style="display:table-cell;text-align: center;width:69px;"><a href="${pageContext.request.contextPath}/main/showIndex?page=1">首页</a></li>
	                    <!--上一页-->
	                    <li style="display:table-cell;text-align: center;">
	                        <c:if test="${pageInfo.hasPreviousPage}">
	                            <a href="${pageContext.request.contextPath}/main/showIndex?page=${pageInfo.pageNum-1}" aria-label="Previous">
	                                <span aria-hidden="true">«</span>
	                            </a>
	                        </c:if>
	                    </li>
	                    <!--循环遍历连续显示的页面，若是当前页就高亮显示，并且没有链接-->
	                    <c:forEach items="${pageInfo.navigatepageNums}" var="page_num">
	                        <c:if test="${page_num == pageInfo.pageNum}">
	                            <li class="active" style="display:table-cell;text-align: center;width:40px;"><a href="#">${page_num}</a></li>
	                        </c:if>
	                        <c:if test="${page_num != pageInfo.pageNum}">
	                            <li style="display:table-cell;text-align: center;width:40px;"><a href="${pageContext.request.contextPath}/main/showIndex?page=${page_num}">${page_num}</a></li>
	                        </c:if>
	                    </c:forEach>
	                    <!--下一页-->
	                    <li style="display:table-cell;text-align: center;width:40px;">
	                        <c:if test="${pageInfo.hasNextPage}">
	                            <a href="${pageContext.request.contextPath}/main/showIndex?page=${pageInfo.pageNum+1}"
	                               aria-label="Next">
	                                <span aria-hidden="true">»</span>
	                            </a>
	                        </c:if>
	                    </li>
	                    <li style="display:table-cell;text-align: center;width:50px;"><a href="${pageContext.request.contextPath}/main/showIndex?page=${pageInfo.pages}">尾页</a></li>
	                    <li style="text-align: center;">当前第 ${pageInfo.pageNum} 页.总共 ${pageInfo.pages} 页.一共 ${pageInfo.total} 条记录</li>
	                </ul>
	            </div>
	   		<!--分页信息结束 -->
	       			
			</div>
		</div>
		
		<div class="contentFooter">
			<div class="contentFooterDiv">
				<div class="left">
					<a href="#"><img src="${pageContext.request.contextPath}/img/Big box.png"></a>
				</div>
				<div class="right">
					<a href="#"><img src="${pageContext.request.contextPath}/img/Big box copy.png"></a>
				</div>
			</div>
		</div>
	</div>

	<div class="pageFooter">
		
		<div class="footerBeizhu">
			<div class="footerBeizhuDiv">
				<p>
					<br /> <br /> Welcome to jeker_chend's exclusive space! <br />
					let's go party party all night !oh oh oh... <br /> @zhtt
				</p>
			</div>
		</div>
	</div>

</body>

</html>
