package com.Beans;

import java.io.Serializable;
import java.util.List;

public class Ya_MotelBean implements Serializable {

	private static final long serialVersionUID = 3949393635847514055L;
	
	private int motel_num;
	private String email;
	private String name;
	private String phone;
	private String address;
	private int normal_cnt;
	private int premium_cnt;
	private int normal_pri;
	private int premium_pri;
	private int is_ok;
	private String check_in;
	private String check_out;
	private List<Ya_ImgBean> imgs;
	private int TOT_CNT;
	private int starAVG;
	private int reCnt;
	
	public Ya_MotelBean() {
		
	}
	
	
	
	public Ya_MotelBean(int motel_num, String email, String name, String phone, String address, int normal_cnt,
			int premium_cnt, int normal_pri, int premium_pri, int is_ok, String check_in, String check_out) {
		super();
		this.motel_num = motel_num;
		this.email = email;
		this.name = name;
		this.phone = phone;
		this.address = address;
		this.normal_cnt = normal_cnt;
		this.premium_cnt = premium_cnt;
		this.normal_pri = normal_pri;
		this.premium_pri = premium_pri;
		this.is_ok = is_ok;
		this.check_in = check_in;
		this.check_out = check_out;
	}



	public Ya_MotelBean(int motel_num, String email, String name, String phone, String address, int normal_cnt,
			int premium_cnt, int is_ok, String check_in, String check_out,List<Ya_ImgBean> imgs) {
		super();
		this.motel_num = motel_num;
		this.email = email;
		this.name = name;
		this.phone = phone;
		this.address = address;
		this.normal_cnt = normal_cnt;
		this.premium_cnt = premium_cnt;
		this.is_ok = is_ok;
		this.check_in = check_in;
		this.check_out = check_out;
		this.imgs = imgs;
	}
	
	
	
	
	public int getReCnt() {
		return reCnt;
	}



	public void setReCnt(int reCnt) {
		this.reCnt = reCnt;
	}



	public int getStarAVG() {
		return starAVG;
	}



	public void setStarAVG(int starAVG) {
		this.starAVG = starAVG;
	}



	public int getTOT_CNT() {
		return TOT_CNT;
	}



	public void setTOT_CNT(int tOT_CNT) {
		TOT_CNT = tOT_CNT;
	}



	public int getNormal_pri() {
		return normal_pri;
	}



	public void setNormal_pri(int normal_pri) {
		this.normal_pri = normal_pri;
	}



	public int getPremium_pri() {
		return premium_pri;
	}



	public void setPremium_pri(int premium_pri) {
		this.premium_pri = premium_pri;
	}



	public List<Ya_ImgBean> getImgs() {
		return imgs;
	}

	public void setImgs(List<Ya_ImgBean> imgs) {
		this.imgs = imgs;
	}

	public int getMotel_num() {
		return motel_num;
	}
	public void setMotel_num(int motel_num) {
		this.motel_num = motel_num;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public int getNormal_cnt() {
		return normal_cnt;
	}
	public void setNormal_cnt(int normal_cnt) {
		this.normal_cnt = normal_cnt;
	}
	public int getPremium_cnt() {
		return premium_cnt;
	}
	public void setPremium_cnt(int premium_cnt) {
		this.premium_cnt = premium_cnt;
	}
	public int getIs_ok() {
		return is_ok;
	}
	public void setIs_ok(int is_ok) {
		this.is_ok = is_ok;
	}
	public String getCheck_in() {
		return check_in;
	}
	public void setCheck_in(String check_in) {
		this.check_in = check_in;
	}
	public String getCheck_out() {
		return check_out;
	}
	public void setCheck_out(String check_out) {
		this.check_out = check_out;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "Ya_MotelBean [motel_num=" + motel_num + ", email=" + email + ", name=" + name + ", phone=" + phone
				+ ", address=" + address + ", normal_cnt=" + normal_cnt + ", premium_cnt=" + premium_cnt + ", is_ok="
				+ is_ok + ", check_in=" + check_in + ", check_out=" + check_out + ", imgs=" + imgs + "]";
	}
	
	
	
}
