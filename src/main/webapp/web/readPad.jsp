<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>博客:${ blogArticle.title}</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/ueditor/themes/default/css/ueditor.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" type="text/css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/laybar.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/article.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/Wordpad.css" />
</head>

<body>
<script src="${pageContext.request.contextPath}/js/jquery-1.12.0.min.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor/ueditor.all.min.js"></script>
<!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
<!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor/lang/zh-cn/zh-cn.js"></script>
<script src="layui/layui.js"></script>
<script>
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
				<p class="headerUsertitile">Stubborn Blog</p>
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
							<c:if test="${sessionScope.user.username eq '张涛涛'}">
							<dd>
								<a href="${pageContext.request.contextPath}/write/show">写文章</a>
							</dd>
						    </c:if>
						</dl></li>
				</ul>
			</div>
			<div class="searchFormdiv">
				<form class=" layui-form searchForm">
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
								<dd>
									<a href="${pageContext.request.contextPath}/user/loginout">退出</a>
								</dd>
							</c:otherwise>
						</c:choose>
					</dl></li>
			</ul>
		</div>
	</div>
	<div class="writerpad">
		<ul>
			<li>${blogArticle.title}</li>
		</ul>
		<button id="return_key" data-method="offset" data-
			class="layui-btn ">返回</button>
	</div>
	
	<textarea id="content" name="content"
		style="width: 100%; height:450px;position:relative;top:70px;" type="text/html">${blogArticle.content}</textarea>
	
	<script type="text/javascript">
        var editor = UE.getEditor('content',{
            //这里可以选择自己需要的工具按钮名称,此处全部隐藏
            toolbars:[[]],
        });
        editor.ready(function() {
            //不可编辑
            editor.setDisabled();
        });
        
    </script>

</body>
<script src="${pageContext.request.contextPath}/js/jquery-1.12.0.min.js"></script>
<script type="text/javascript">
window.onload = function(){
	$.ajax({
		url:"${pageContext.request.contextPath}/read/getData",
		dataType:"json",
		type:"post",
		data:{typeId:"${blogArticle.typeId}",id:"${blogArticle.id}"},
		contentType : "application/x-www-form-urlencoded; charset=utf-8",
		success : function(msg) {
			console.log(msg);
		},
	    error:function(){
	    	console.log("访问getData失败");
	    }
	});
}
</script>
<script type="text/javascript">
	var page = "${page}";
	$("#return_key").click(
		function() {
			if (page==""||page==null) {
				window.location.href = "${pageContext.request.contextPath}/list/show?typeId=${blogArticle.typeId}";
			} else {
				window.location.href = "${pageContext.request.contextPath}/list/show?typeId=${blogArticle.typeId}&page="+page;
			}
		})
</script>
</html>