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
<div class="writerpad">
		<ul>
			<li>${blogArticle.title}</li>
		</ul>
		<button id="return_key" data-method="offset" data-
			class="layui-btn ">返回</button>
	</div>
	
	<textarea id="content" name="content"
		style="width: 100%; height:450px;position:relative;top:70px;">${blogArticle.content}</textarea>
	
	<script type="text/javascript">
        var editor = UE.getEditor('content',{
            //这里可以选择自己需要的工具按钮名称,此处全部隐藏
            toolbars:[[]],
            allowDivTransToP: false
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
	$("#return_key").click(
		function() {
			window.location.href = "${pageContext.request.contextPath}/main/showIndex";
		})
</script>


</html>