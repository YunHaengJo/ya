package com.Beans;

import java.io.Serializable;

public class Ya_ImgBean implements Serializable {

	private static final long serialVersionUID = -7926820539322969138L;
	
	private int seq;
	private int motel_num;
	private String img_name;
	private int img_auth;
	
	public Ya_ImgBean() {
	}

	public Ya_ImgBean(int seq, int motel_num, String img_name, int img_auth) {
		
		this.seq = seq;
		this.motel_num = motel_num;
		this.img_name = img_name;
		this.img_auth = img_auth;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public int getMotel_num() {
		return motel_num;
	}

	public void setMotel_num(int motel_num) {
		this.motel_num = motel_num;
	}

	public String getImg_name() {
		return img_name;
	}

	public void setImg_name(String img_name) {
		this.img_name = img_name;
	}

	public int getImg_auth() {
		return img_auth;
	}

	public void setImg_auth(int img_auth) {
		this.img_auth = img_auth;
	}

	@Override
	public String toString() {
		return "Ya_ImgBean [seq=" + seq + ", motel_num=" + motel_num + ", img_name=" + img_name + ", img_auth="
				+ img_auth + "]";
	}
	
	
	
	

}
