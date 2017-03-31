package com.Beans;

import java.io.Serializable;

public class Ya_MemberBean implements Serializable {

	private static final long serialVersionUID = -8715409216440006715L;
	
	private String email;
	private String password;
	private String nickname;
	private int auth;
	private int point;
	private int is_ok;
	private int Motel_num;
	private int tot_cnt;
	
	public Ya_MemberBean() {
	}

	public Ya_MemberBean(String email, String password, String nickname, int auth, int point, int is_ok) {
		super();
		this.email = email;
		this.password = password;
		this.nickname = nickname;
		this.auth = auth;
		this.point = point;
		this.is_ok = is_ok;
	}

	public Ya_MemberBean(String email, String password, String nickname, int auth, int point, int is_ok,
			int motel_num) {
		super();
		this.email = email;
		this.password = password;
		this.nickname = nickname;
		this.auth = auth;
		this.point = point;
		this.is_ok = is_ok;
		this.Motel_num = motel_num;
	}


	public int getTot_cnt() {
		return tot_cnt;
	}

	public void setTot_cnt(int tot_cnt) {
		this.tot_cnt = tot_cnt;
	}

	public int getMotel_num() {
		return Motel_num;
	}

	public void setMotel_num(int motel_num) {
		Motel_num = motel_num;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public int getAuth() {
		return auth;
	}

	public void setAuth(int auth) {
		this.auth = auth;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	public int getIs_ok() {
		return is_ok;
	}

	public void setIs_ok(int is_ok) {
		this.is_ok = is_ok;
	}

	@Override
	public String toString() {
		return "Ya_MemberBean [email=" + email + ", password=" + password + ", nickname=" + nickname + ", auth=" + auth
				+ ", point=" + point + ", is_ok=" + is_ok + ", Motel_num=" + Motel_num + "]";
	}
}
