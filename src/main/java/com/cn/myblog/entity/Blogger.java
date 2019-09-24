package com.cn.myblog.entity;

public class Blogger {
	private Integer id;
	private String username;
	private String password;
	private String info;
	private String nickname;
	private String sign;
	private String imagePath;
	private Integer gender;
	private String email;
	
	public Blogger() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getInfo() {
		return info;
	}

	public void setInfo(String info) {
		this.info = info;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getSign() {
		return sign;
	}

	public void setSign(String sign) {
		this.sign = sign;
	}

	public String getImagePath() {
		return imagePath;
	}

	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}

	
	public Integer getGender() {
		return gender;
	}

	public void setGender(Integer gender) {
		this.gender = gender;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Override
	public String toString() {
		return "Blogger [id=" + id + ", username=" + username + ", password=" + password + ", info=" + info
				+ ", nickname=" + nickname + ", sign=" + sign + ", imagePath=" + imagePath + ", gender=" + gender
				+ ", email=" + email + "]";
	}

	
	
}
