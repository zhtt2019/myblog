<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head lang="en">
<meta charset="UTF-8">
<title>个人博客登陆页面</title>
<link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/css/animate.css"
	rel="stylesheet" />
<link href="${pageContext.request.contextPath}/css/login.css"
	rel="stylesheet" />
</head>
<body>
	<!-- 页面顶部-->
	<header id="top">
		<div class="top">
			<span>欢迎登录博客空间</span>
		</div>
	</header>
	<div id="container">
		<div id="cover" class="rt">
			<form id="login-form" method="post" name="form1">
				<div class="txt">
					<p>
						登录我的博客
					</p>
					<div class="text">
						<input type="text" placeholder="请输入您的用户名" name="lname"
							id="username" required> <span><img
							src="${pageContext.request.contextPath}/images/login/yhm.png"></span>
					</div>

					<div class="text">
						<input type="password" id="password" placeholder="请输入您的密码"
							name="lwd" minlength="6" maxlength="15" required> <span><img
							src="${pageContext.request.contextPath}/images/login/mm.png"></span>
					</div>
					<div class="chose">
						<input type="checkbox" class="checkbox" id="ck_rmbUser">自动登录
						<span>忘记密码？</span>
					</div>
					<input class="button_login" type="button" value="登录" id="bt-login" />
				</div>
			</form>
		</div>
	</div>
	<!--错误提示-->
	<div id="showResult"></div>

	<script src="${pageContext.request.contextPath}/js/jquery-3.1.1.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/jquery/jquery.cookie.js"></script>
	<script>
    $("#username").blur(function(){
        var data = $("#username").val();
        if (data == null || data == "") {
            $("#showResult").text("用户名不能为空！");
            $("#showResult").css("color","red");
            return false;
        }
        $.ajax({
            type:"POST",
            url:"${pageContext.request.contextPath}/user/checkUsername",
            data:"username="+data,
            beforeSend:function(XMLHttpRequest)
            {
                $("#showResult").text("正在查询");

            },
            success:function(msg)
            {
                if(msg[9] ==="0"){
                    $("#showResult").text("该用户名可以被使用");
                }else if(msg[9] === '1'){
                    $("#showResult").text("该用户名不存在");
                    $("#showResult").css("color","red");
                }else {
                    $("#showResult").text("系统异常！");
                    $("#showResult").css("color","red");
                }
            },
            error:function()
            {
                //错误处理
            }
        });
    });
</script>
	<script>
	//登录按钮的异步提交
    $('#bt-login').click(function(){
        $.ajax({
        	"url":"${pageContext.request.contextPath}/user/login",
        	"data":"username="+$("#username").val()+"&password="+$("#password").val(),
        	"type":"POST",
        	"dataType":"json",
        	"success":function(obj){
        		//处理自动登录的复选框
        		Save();
        		
        		if(obj.state==1){
        			location="${pageContext.request.contextPath}/main/showIndex";
        		}else{
        			alert(obj.message);
        		}
        	}
        	
        });
    	
    });
</script>
	<script type="text/javascript">
	
    $(document).ready(function () {
        if ($.cookie("rmbUser") == "true") {
            $("#ck_rmbUser").attr("checked", true);
            $("#username").val($.cookie("username"));
            $("#password").val($.cookie("password"));
        }
    });

    //记住用户名密码
    function Save() {
    	//判断复选框是否被选中
        if ($("#ck_rmbUser").prop("checked")) {
            var str_username = $("#username").val();
            console.log(str_username);
            var str_password = $("#password").val();
            $.cookie("rmbUser", "true", { expires: 7 }); //存储一个带7天期限的cookie
            $.cookie("username", str_username, { expires: 7 });
            $.cookie("password", str_password, { expires: 7 });
        }
        else {
            $.cookie("rmbUser", "false", { expire: -1 });
            $.cookie("username", "", { expires: -1 });
            $.cookie("password", "", { expires: -1 });
        }
    };
</script>
</body>
</html>