<%@ page contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>个人主页</title>
    <link href="${pageContext.request.contextPath}/css/orders.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/css/personage.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/icon/css/bootstrap.min.css">
	<link href="${pageContext.request.contextPath}/css/icon/css/cropper.min.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/css/icon/css/sitelogo.css" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/icon/css/font-awesome.min.css">
</head>
<body>
<!-- 页面顶部-->
<!-- nav主导航-->
<!-- 我的订单导航栏-->
<div id="nav_order">
    <ul>
        <li><a href="${pageContext.request.contextPath}/main/showIndex">首页<span>&gt;</span>个人中心</a></li>
    </ul>
</div>
<!--我的订单内容区域 #container-->
<div id="container" class="clearfix">
    <!-- 左边栏-->
    <!-- 右边栏-->
    <!--个人信息头部-->
    <div class="rightsidebar_box rt">
        <div class="rs_header">
            <span class="rs_header_active">我的信息</span>
            <!-- <span>
            <a href="${pageContext.request.contextPath}/user/showPassword.do">
                        安全管理
            </a></span>-->
        </div>

        <!--个人信息具体内容 -->
        <div class="rs_content">
            <!--头像-->
            <div class="rs_content_headPortrait">
	                <span class="same">我的头像：</span>
	                <img src="${pageContext.request.contextPath}/images/touxiang.png" alt="" id="icon" width="50px" height="50px"/>
	                <input type="hidden" name="iconPic" value="" id="iconPic">
	                <span class="change_headPortrait same_click" data-toggle="modal" data-target="#avatar-modal" >更改头像</span>
	            </div>
              
            <!--用户名-->
            <form id="personInfo" >
            <div class="rs_content_username">
                <span class="same">用户名：</span>
                <span class="same rs_username">${user.username}</span>
        	 <input id="username" name="username" class="ed_username" value="${user.username}" style="display: none;"/>
                <span class="change_username same_click">更改用户名</span>
            </div>
            <!--昵称-->
            <div class="rs_content_nickname">
                <span class="same">昵称：</span>
           <input id="nickname" name="nickname" class="ed_nickname" value="${user.nickname}" style="display: none;"/>
                <span class="rs_nickname">${user.nickname}</span>
                <span class="same_click change_nickname">更改昵称</span>
            </div>
            <!--性别-->
            <div class="rs_content_sex" style="display:none">
                <span class="same">性别：</span>
                <span class="man selected">
                    <img src="${pageContext.request.contextPath}/images/select.png" alt=""/>男
                </span>
                <span class="women">
                    <img src="${pageContext.request.contextPath}/images/un_select.png" alt=""/>女
                </span>
            </div>
            <div class="rs_content_sex">
                <span class="same">性别：</span>
                <input type="radio" name="gender" id="gender"value="0"
                <c:if test="${user.gender==0}">checked</c:if> >男
                <input type="radio" name="gender" id="gender" value="1"
                <c:if test="${user.gender==1}">checked</c:if>>女
            </div>
            <!-- 更改密码 -->
            <div class="rs_content_password">
                <span class="same">密码：</span>
           <input id="password"name="password"class="ed_password" value="${user.password}" style="display: none;"/>
                <span class="rs_password">${user.password}</span>
                <span class="same_click change_password">更改密码</span>
            </div>
            <!--绑定邮箱-->
            <div class="rs_content_mail">
                <span class="same">绑定邮箱：</span>
           <input 
           id="email"
           name="email"
           class="ed_email" 
           value="${user.email}" 
           style="display: none;"/>
                <span class="rs_mail">${user.email}</span>
                <span class="same_click change_mail">更改邮箱</span>
            </div>
            <!--保存按钮-->
            <div class="save">
               <a href="#" 
               style="color:#fff"
               onclick="btnUpdate()">
                                  保存更改
                </a>
            </div>
          </form>  
        </div>
    </div>
</div>
<!-- 头像插件 -->
<div class="modal fade" id="avatar-modal" aria-hidden="true" aria-labelledby="avatar-modal-label" role="dialog" tabindex="-1"> 
    <div class="modal-dialog modal-lg"> 
        <div class="modal-content"> 
            <!--<form class="avatar-form" action="upload-logo.php" enctype="multipart/form-data" method="post">--> 
            <form class="avatar-form"> 
                <div class="modal-header"> 
                    <button class="close" data-dismiss="modal" type="button">×</button> 
                    <h4 class="modal-title" id="avatar-modal-label">上传图片</h4> 
                </div> 
                <div class="modal-body"> 
                    <div class="avatar-body"> 
                        <div class="avatar-upload"> 
                            <input class="avatar-src" name="avatar_src" type="hidden"> 
                            <input class="avatar-data" name="avatar_data" type="hidden"> 
                            <label for="avatarInput" style="line-height: 35px;">图片上传</label> 
                            <button class="btn btn-info"  type="button" style="height: 35px;" onClick="$('input[id=avatarInput]').click();">请选择图片</button> 
                            <span id="avatar-name"></span> 
                            <input class="avatar-input hide" id="avatarInput" name="avatar_file" type="file"></div> 
                        <div class="row"> 
                            <div class="col-md-9"> 
                                <div class="avatar-wrapper"></div> 
                            </div> 
                            <div class="col-md-3"> 
                                <div class="avatar-preview preview-lg" id="imageHead"></div> 
                                <!--<div class="avatar-preview preview-md"></div> 
                        <div class="avatar-preview preview-sm"></div>--> 
                            </div> 
                        </div> 
                        <div class="row avatar-btns"> 
                            <div class="col-md-4"> 
                                <div class="btn-group"> 
                                    <button class="btn btn-info fa fa-undo" data-method="rotate" data-option="-90" type="button" title="Rotate -90 degrees"> 向左旋转</button> 
                                </div> 
                                <div class="btn-group"> 
                                    <button class="btn  btn-info fa fa-repeat" data-method="rotate" data-option="90" type="button" title="Rotate 90 degrees"> 向右旋转</button> 
                                </div> 
                            </div> 
                            <div class="col-md-5" style="text-align: right;">                                 
                                <button class="btn btn-info fa fa-arrows" data-method="setDragMode" data-option="move" type="button" title="移动"> 
                                <span class="docs-tooltip" data-toggle="tooltip" title="" data-original-title="$().cropper("setDragMode", "move")"> 
                                </span> 
                              </button> 
                              <button type="button" class="btn btn-info fa fa-search-plus" data-method="zoom" data-option="0.1" title="放大图片"> 
                                <span class="docs-tooltip" data-toggle="tooltip" title="" data-original-title="$().cropper("zoom", 0.1)"> 
                                  <!--<span class="fa fa-search-plus"></span>--> 
                                </span> 
                              </button> 
                              <button type="button" class="btn btn-info fa fa-search-minus" data-method="zoom" data-option="-0.1" title="缩小图片"> 
                                <span class="docs-tooltip" data-toggle="tooltip" title="" data-original-title="$().cropper("zoom", -0.1)"> 
                                  <!--<span class="fa fa-search-minus"></span>--> 
                                </span> 
                              </button> 
                              <button type="button" class="btn btn-info fa fa-refresh" data-method="reset" title="重置图片"> 
                                    <span class="docs-tooltip" data-toggle="tooltip" title="" data-original-title="$().cropper("reset")" aria-describedby="tooltip866214"> 
                               </button> 
                            </div> 
                            <div class="col-md-3"> 
                                <button id="button_save" class="btn btn-info btn-block avatar-save fa fa-save" type="button" data-dismiss="modal"> 保存修改</button> 
                            </div> 
                        </div> 
                    </div> 
                </div> 
            </form> 
        </div> 
    </div> 
</div> 
<!-- 品质保障，私人定制等-->
<!-- 页面底部-->

</body>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.page.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/orders.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/personal.js"></script>
<script src="${pageContext.request.contextPath}/js/icon/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/icon/cropper.js"></script>
<script src="${pageContext.request.contextPath}/js/icon/sitelogo.js"></script>
<script src="${pageContext.request.contextPath}/js/icon/html2canvas.min.js" type="text/javascript" charset="utf-8"></script> 
<script type="text/javascript">

//修改个人信息异步提交

function btnUpdate(){
	$.ajax({
		"url":"${pageContext.request.contextPath}/user/updateUser",
		"data":$("#personInfo").serialize(),
		"type":"POST",
		"dataType":"json",
		"success":function(obj){
			alert(obj.state+","+obj.message);
			if(obj.state==1){
				location="${pageContext.request.contextPath}/user/showPersonInfo";
			}else{
				alert(obj.state+","+obj.message);
			}
		}
	});
	
	
}


//做个下简易的验证  大小 格式  
    $('#avatarInput').on('change', function(e) {
        var filemaxsize = 1024 * 5;//5M 
        var target = $(e.target); 
        var Size = target[0].files[0].size / 1024; 
        if(Size > filemaxsize) { 
            alert('图片过大，请重新选择!'); 
            $(".avatar-wrapper").childre().remove; 
            return false; 
        } 
        if(!this.files[0].type.match(/image.*/)) { 
            alert('请选择正确的图片!') 
        } else { 
            var filename = document.querySelector("#avatar-name"); 
            var texts = document.querySelector("#avatarInput").value; 
            var teststr = texts; //你这里的路径写错了 
            testend = teststr.match(/[^\\]+\.[^\(]+/i); //直接完整文件名的 
            filename.innerHTML = testend; 
        } 
     
    }); 
 
    $(".avatar-save").on("click", function() { 
        var img_lg = document.getElementById('imageHead'); 
        // 截图小的显示框内的内容 
        html2canvas(img_lg, { 
            allowTaint: true, 
            taintTest: false, 
            onrendered: function(canvas) { 
                canvas.id = "mycanvas"; 
                //生成base64图片数据 
                var dataUrl = canvas.toDataURL("image/png"); 
                var newImg = document.createElement("img"); 
                newImg.src = dataUrl; 
                imagesAjax(dataUrl) 
            } 
        }); 
    }) 
    function imagesAjax(src) { 
        var data = {}; 
        data.img = src; 
        $.ajax({ 
            url: "", 
            data: data, 
            type: "POST", 
            dataType: 'json', 
            success: function(re) {
            	if (re) {
	                if(re.status == 200) {
	                    $('#icon').attr('src',re.data.url );
	                    $('#iconPic').val(re.data.url);
	                }else {
						alert("上传失败")
					} 
					
				}
            } 
        });
    } 
</script>
<script type="text/javascript">
$("#icon").click(function() {
	window.open($(this).attr("src"));
})
</script> 
<!--<script>
	$(".x").click(function(){
		$(".modal").hide();
	})
	$(".change_headPortrait").click(function(){
		$(".modal").show();
	})
</script>-->
<script>
	$("#button_save").click(function(){
		var url = $("#imageHead img").attr("src");
		$('#icon').attr('src',url);
	})
	

$(function(){
	//所有的dd隐藏
	 $("#leftsidebar_box dd").hide();
	//让账号管理显示
	 $("#leftsidebar_box .count_managment dd").show();
	//所有的自定义列表的标题后边的图片 myOrder2.png
	$("#leftsidebar_box dt img").attr("src","../images/myOrder/myOrder2.png");
    //设置账号管理的图片和其他的三个不相同
	$("#leftsidebar_box .count_managment").find('img').attr("src","../images/myOrder/myOrder1.png");
     
});	
	
</script>
</html>