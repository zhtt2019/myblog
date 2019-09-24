<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>写博客</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/ueditor/themes/default/css/ueditor.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" type="text/css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/laybar.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/article.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/Wordpad.css" />

<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor/ueditor.all.min.js"></script>
<!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
<!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor/lang/zh-cn/zh-cn.js"></script>

<style type="text/css">
    .clear {
        clear: both;
    }
</style>

</head>
<body>
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
	<div class="writerpad">
		<ul>
			<li>现在开始你的博客之旅吧！</li>
		</ul>
		<button id="release" data-method="offset" data-type="auto"
			class="layui-btn ">发表文章</button>
	</div>
	<div class="article_Title" style="">
		<input id="text_title" type="text" name="title" required
			lay-verify="required" placeholder="请输入文章标题" autocomplete="off"
			class="layui-input">
	</div>
	<div id="editor">
		<textarea id="content" name="content"
		style="width: 800px; height: 400px; margin: 0 auto;"></textarea>
	</div>

	<script type="text/javascript">
        var ue = UE.getEditor('content');
    </script>
	
</body>
<script src="${pageContext.request.contextPath}/js/jquery-1.12.0.min.js"></script>

<script type="text/javascript">

var ue = UE.getEditor('content');
ue.addListener("ready", function () {
	$.ajax({
		url:"${pageContext.request.contextPath}/write/getData",
		type:"get",
		contentType : "application/x-www-form-urlencoded; charset=utf-8",
		success : function(msg) {
			//alert(textcontent);
		}
	});
	
});
</script>
<script type="text/javascript">
	window.onbeforeunload = function() {
		var textcontent = ue.getAllHtml();
		$.ajax({
			url : "${pageContext.request.contextPath}/write/setData",
			type : "post",
			dataType : "html",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			timeout : 6000,
			data : {
				"textcontent" : textcontent
			},
			//获取成功，为页面新添加元素初始化
			success : function(msg) {
				//alert(textcontent);
			}
		})
		return (textcontent);//IE 谷歌浏览器提示（opera浏览器只有刷新时提示）
		//ajax获取页面内容
	}
	layui.use(
		[ 'layer', 'form', 'layedit', 'laydate' ],
		function() { //独立版的layer无需执行这一句
			var $ = layui.jquery, layer = layui.layer; //独立版的layer无需执行这一句
			var texttitle = $("#text_title").val();
			var active = {
					offset : function(othis) {
						var type = othis.data('type'), text = othis.text();
						var id = othis.attr('id');
						var content = ue.getContent();
						layer.open({
							type : 1,
							title : '分类设置',
							area : [ '500px', '400px' ],
							//offset:type,
							id : 'LAY_DEMO' + type,
							content : '<form id="'
							  + id
							  + '" class="layui-form layui-form-pane tanchuang" action="${pageContext.request.contextPath}/write/save?title='
							  + texttitle
							  + '" method="post"><select id="typeId" name="typeId" lay-verify=""><option>请选择文章分类</option><option value="1">设计</option><option value="2">前端</option><option value="3">后端</option><option value="4">工具资源</option><option value="5">bug记录</option><option value="6">经验总结</option></select>'
							  + '<input type="hidden" name="textcontent" id="info"></form>',
							btn : [ '发布', '取消' ],
							shade : [ 0.8, '#000' ],
							btnAlign : 'c', //按钮居中
							yes : function() {
							//储存文章
							if (($("#typeId").val() == null || $("#typeId").val() == "")) {
								alert("分类设置")
							} else {
								if (content==null || content ==""){
									alert('请先填写内容!');
									}else{
									$("#info").val(content);
									$(".tanchuang").submit();
									}
							}

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
				   $('#release').on('click',function() {
						texttitle = $("#text_title").val()
				        if (texttitle == "" || texttitle == null) {
							alert("请输入文章标题")
						} else {
							var othis = $(this), method = othis.data('method');
						    active[method] ? active[method].call(this, othis) : '';
						    var form = layui.form(), layer = layui.layer, layedit = layui.layedit, laydate = layui.laydate;
							form.render('select');
				        }
					});
				})
</script>

</html>