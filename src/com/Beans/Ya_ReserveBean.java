package com.Beans;

import java.io.Serializable;

public class Ya_ReserveBean implements Serializable {

	private static final long serialVersionUID = -7446770830466597598L;

	private int seq;
	private int motel_num;
	private String email;
	private String name;
	private String room_type;
	private String pay_dt;
	private String use_dt;
	private int price;
	private int state;
	private int point;
	private String mt_name;
	private int tot_cnt;
	private int noroomCnt;
	private int preroomCnt;
	
	
	public Ya_ReserveBean() {}

	public Ya_ReserveBean(int seq, int motel_num, String email, String name, String room_type, String pay_dt,
			String use_dt, int price, int state, int point) {
		super();
		this.seq = seq;
		this.motel_num = motel_num;
		this.email = email;
		this.name = name;
		this.room_type = room_type;
		this.pay_dt = pay_dt;
		this.use_dt = use_dt;
		this.price = price;
		this.state = state;
		this.point = point;
	}
	
	public Ya_ReserveBean(int seq, int motel_num, String email, String name, String room_type, String pay_dt,
			String use_dt, int price, int state, int point, String mt_name) {
		super();
		this.seq = seq;
		this.motel_num = motel_num;
		this.email = email;
		this.name = name;
		this.room_type = room_type;
		this.pay_dt = pay_dt;
		this.use_dt = use_dt;
		this.price = price;
		this.state = state;
		this.point = point;
		this.mt_name = mt_name;
	}

	public Ya_ReserveBean(int seq, int motel_num, String email, String name, String room_type, String pay_dt,
			String use_dt, int price, int state, int point, String mt_name, int tot_cnt) {
		super();
		this.seq = seq;
		this.motel_num = motel_num;
		this.email = email;
		this.name = name;
		this.room_type = room_type;
		this.pay_dt = pay_dt;
		this.use_dt = use_dt;
		this.price = price;
		this.state = state;
		this.point = point;
		this.mt_name = mt_name;
		this.tot_cnt = tot_cnt;
	}
	
	

	public int getNoroomCnt() {
		return noroomCnt;
	}

	public void setNoroomCnt(int noroomCnt) {
		this.noroomCnt = noroomCnt;
	}

	public int getPreroomCnt() {
		return preroomCnt;
	}

	public void setPreroomCnt(int preroomCnt) {
		this.preroomCnt = preroomCnt;
	}

	public int getTot_cnt() {
		return tot_cnt;
	}

	public void setTot_cnt(int tot_cnt) {
		this.tot_cnt = tot_cnt;
	}

	public String getMt_name() {
		return mt_name;
	}

	public void setMt_name(String mt_name) {
		this.mt_name = mt_name;
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

	public String getRoom_type() {
		return room_type;
	}

	public void setRoom_type(String room_type) {
		this.room_type = room_type;
	}

	public String getPay_dt() {
		return pay_dt;
	}

	public void setPay_dt(String pay_dt) {
		this.pay_dt = pay_dt;
	}

	public String getUse_dt() {
		return use_dt;
	}

	public void setUse_dt(String use_dt) {
		this.use_dt = use_dt;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	@Override
	public String toString() {
		return "Ya_ReserveBean [seq=" + seq + ", motel_num=" + motel_num + ", email=" + email + ", name=" + name
				+ ", room_type=" + room_type + ", pay_dt=" + pay_dt + ", use_dt=" + use_dt + ", price=" + price
				+ ", state=" + state + ", point=" + point + ", mt_name=" + mt_name + ", tot_cnt=" + tot_cnt + "]";
	}	
}
