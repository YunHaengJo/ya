package com.Beans;

import java.io.Serializable;

public class Ya_ZzimBean implements Serializable {

	private static final long serialVersionUID = 8409032947793183762L;
	
	private int seq;
	private String email;
	private int motel_num;
	private String address;
	private int normal_pri;
	private int premium_pri;
	private String img_name;
	private String name;
	private int tot_cnt;
	
	public Ya_ZzimBean() {
	}

	public Ya_ZzimBean(int seq, String email, int motel_num) {
		super();
		this.seq = seq;
		this.email = email;
		this.motel_num = motel_num;
	}

	public Ya_ZzimBean(int seq, String email, int motel_num, String address, int normal_pri, int premium_pri,
			String img_name, String name) {
		super();
		this.seq = seq;
		this.email = email;
		this.motel_num = motel_num;
		this.address = address;
		this.normal_pri = normal_pri;
		this.premium_pri = premium_pri;
		this.img_name = img_name;
		this.name = name;
	}

	public Ya_ZzimBean(int seq, String email, int motel_num, String address, int normal_pri, int premium_pri,
			String img_name, String name, int tot_cnt) {
		super();
		this.seq = seq;
		this.email = email;
		this.motel_num = motel_num;
		this.address = address;
		this.normal_pri = normal_pri;
		this.premium_pri = premium_pri;
		this.img_name = img_name;
		this.name = name;
		this.tot_cnt = tot_cnt;
	}

	public int getTot_cnt() {
		return tot_cnt;
	}

	public void setTot_cnt(int tot_cnt) {
		this.tot_cnt = tot_cnt;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
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

	public String getImg_name() {
		return img_name;
	}

	public void setImg_name(String img_name) {
		this.img_name = img_name;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public int getMotel_num() {
		return motel_num;
	}

	public void setMotel_num(int motel_num) {
		this.motel_num = motel_num;
	}

	@Override
	public String toString() {
		return "Ya_ZzimBean [seq=" + seq + ", email=" + email + ", motel_num=" + motel_num + ", address=" + address
				+ ", normal_pri=" + normal_pri + ", premium_pri=" + premium_pri + ", img_name=" + img_name + ", name="
				+ name + ", tot_cnt=" + tot_cnt + "]";
	}
}
