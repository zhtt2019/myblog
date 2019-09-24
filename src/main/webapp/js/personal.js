
/*****************************************************地址管理页面js********************************************************/


/*****************************************************个人信息管理页面js********************************************************/

/**
 * 这是个人信息页面js
 */
// 跳页面
function toPage(page){
	window.location.href=page;
}


/**
 * 性别选择男
 */
$(".man").click(function(){
	if(!$(".man").hasClass("selected")){
		$(".man").addClass("selected");
		$(".man img").attr("src","../images/personage/select.png");
		$(".women").removeClass("selected");
		$(".women img").attr("src","../images/personage/un_select.png");
	}
})

/**
 * 性别选择女
 */
$(".women").click(function(){
	if(!$(".women").hasClass("selected")){
		$(".women").addClass("selected");
		$(".women img").attr("src","../images/personage/select.png");
		$(".man").removeClass("selected");
		$(".man img").attr("src","../images/personage/un_select.png");
	}
})
/**
 * 更改用户名，变成可编辑状态
 */
$(".change_username").click(function(){
	var parent = $(".change_username").parent();
	$(parent).children(".rs_username").hide();
	var name = $(parent).children(".rs_username").html();
	$(parent).children(".ed_username").val(name);
	$(parent).children(".ed_username").show();
})

/**
 * 更改邮箱，变成可编辑状态
 */
$(".change_mail").click(function(){
	var parent = $(".change_mail").parent();
	$(parent).children(".rs_mail").hide();
	var email = $(parent).children(".rs_mail").html();
	$(parent).children(".ed_email").val(email);
	$(parent).children(".ed_email").show();
})

/**
 * 更改昵称，变成可编辑状态
 */
$(".change_nickname").click(function(){
	var parent = $(".change_nickname").parent();
	$(parent).children(".rs_nickname").hide();
	var nickname = $(parent).children(".rs_nickname").html();
	$(parent).children(".ed_nickname").val(nickname);
	$(parent).children(".ed_nickname").show();
})

/**
 * 更改密码，变成可编辑状态
 */
$(".change_password").click(function(){
	var parent = $(".change_password").parent();
	$(parent).children(".rs_password").hide();
	var password = $(parent).children(".rs_password").html();
	$(parent).children(".ed_password").val(password);
	$(parent).children(".ed_password").show();
})

