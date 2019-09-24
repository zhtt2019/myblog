<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head lang="en">
<meta charset="UTF-8">
<title>注册页面</title>
 <link href="${pageContext.request.contextPath}//css/header.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/css/animate.css"
	rel="stylesheet" />
<link href="${pageContext.request.contextPath}/css/login.css"
	rel="stylesheet" />
</head>
<body>
	<!-- 页面顶部-->
	<header id="top">
		<div class="top">
			<span>欢迎注册</span>
		</div>
	</header>
	<div class="parent">
		<!--<video src="audio/snow.mp4" width="100%" autoplay loop muted></video>-->
		<div class="container">
			<div class="panel rt">
				<form id="form-register" method="post" action="">
					<div class="txt">
						<p>
							新用户注册 <span> <a
								href="${pageContext.request.contextPath}/user/showLogin">直接登录</a>
							</span>
						</p>
					</div>
					<div class="form-group">
						<label for="username">用户名：</label> <input autocomplete required
							minlength="6" maxlength="9" type="text" placeholder="请输入用户名"
							autofocus name="username" id="username" /> <span
							class="msg-default" id="unamespan"> 用户名长度在6到9位之间 </span>
					</div>
					<div class="form-group">
						<label for="upwd">登录密码：</label> <input required type="password"
							minlength="6" maxlength="12" placeholder="请输入密码" name="password"
							autofocus id="password" /> <span class="msg-default hidden">密码长度在6到12位之间</span>
					</div>
					<div class="form-group">
						<label for="upwdconfirm">确认密码：</label> <input required
							type="password" minlength="6" maxlength="12" placeholder="请确认密码"
							name="upwdconfirm" autofocus id="upwdconfirm" /> <span
							class="msg-default hidden">密码长度在6到12位之间</span>
					</div>

					<div class="form-group">
						<label> </label><input type="button" value="提交注册信息" id="bt-register" />
					</div>
				</form>
			</div>
		</div>
	</div>


	<!--弹出的小广告-->
	<script src="${pageContext.request.contextPath}/js/jquery-3.1.1.min.js"></script>
	<script>
  $('#bt-register').click(function(){
    var lengths=0;
    $('.form-group').each(function(){
      if($(this).find('span').hasClass('msg-success')){
        lengths++;
      }
    });
    if(lengths==5){
    	//发送异步请求给控制器
    	//"data":$("#form-register").serialize();提交表单数据
    	
    	$.ajax({
    		"url":"${pageContext.request.contextPath}/user/register",
    		"data":$("#form-register").serialize(),
    		"type":"POST",
    		"dataType":"json",
    		"success":function(obj){
    			if(obj.state==0){
    				alert(obj.message);
    			}else{
    				//.....登录页面
    				location.href="${pageContext.request.contextPath}/user/showLogin";
    			}
    		}
    	});
    }
    
    
  })
</script>
	<script>
  /*1.对用户名进行验证*/
  username.onblur = function(){
    if(this.validity.valueMissing){
      this.nextElementSibling.innerHTML = '用户名不能为空';
      this.nextElementSibling.className = 'msg-error';
      this.setCustomValidity('用户名不能为空');
    }else if(this.validity.tooShort){
      this.nextElementSibling.innerHTML = '用户名不能少于6位';
      this.nextElementSibling.className = 'msg-error';
      this.setCustomValidity('用户名不能少于6位');
    }else {
      this.nextElementSibling.innerHTML = '用户名格式正确';
      this.nextElementSibling.className = 'msg-success';
      this.setCustomValidity('');
      var data =document.getElementById("username").value;
      if(!data){   //用户没有输入任何内容
        return;
      }
      /**发起异步GET请求，询问服务器用户名是否已经存在**/
      $.ajax({
    	  "url":"${pageContext.request.contextPath}/user/checkUsername",
    	  "data":"username="+$("#username").val(),
    	  "type":"GET",
    	  "dataType":"json",
    	  "success":function(obj){
    		  //alert(obj.state+","+obj.message);
    		  $("#unamespan").html(obj.message);
    		  if(obj.state==0){
    			  $("#unamespan").attr("class","msg-error");
    		  }else{
    			  $("#unamespan").attr("class","msg-success");
    		  }
    	  }
      });
      
    }
  }

  username.onfocus = function(){
    this.nextElementSibling.innerHTML = '用户名长度在6到9位之间';
    this.nextElementSibling.className = 'msg-default';
  }
  password.onfocus = function(){
    this.nextElementSibling.innerHTML = '密码长度在6到12位之间';
    this.nextElementSibling.className = 'msg-default';
  }
  password.onblur = function(){
    if(this.validity.valueMissing){
      this.nextElementSibling.innerHTML = '密码不能为空';
      this.nextElementSibling.className = 'msg-error';
      this.setCustomValidity('密码不能为空');
    }else if(this.validity.tooShort){
      this.nextElementSibling.innerHTML = '密码长度在尽量别少于6位';
      this.nextElementSibling.className = 'msg-error';
      this.setCustomValidity('密码长度在尽量别少于6位');
    }else {
      this.nextElementSibling.innerHTML = '密码格式正确';
      this.nextElementSibling.className = 'msg-success';
      this.setCustomValidity('');
    }
  }
  

  upwdconfirm.onfocus = function(){
    this.nextElementSibling.innerHTML = '密码长度在6到12位之间';
    this.nextElementSibling.className = 'msg-default';
  }
  upwdconfirm.onblur = function(){
    if(this.validity.valueMissing){
      this.nextElementSibling.innerHTML = '密码不能为空';
      this.nextElementSibling.className = 'msg-error';
      this.setCustomValidity('密码不能为空');
    }else if(this.validity.tooShort){
      this.nextElementSibling.innerHTML = '密码长度在尽量别少于6位';
      this.nextElementSibling.className = 'msg-error';
      this.setCustomValidity('密码长度在尽量别少于6位');
    }else {
      this.nextElementSibling.innerHTML = '密码格式正确';
      this.nextElementSibling.className = 'msg-success';
      this.setCustomValidity('');
    }
  }
  
</script>
</body>
</html>