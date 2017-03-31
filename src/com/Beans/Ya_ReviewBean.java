package com.Beans;

import java.io.Serializable;

public class Ya_ReviewBean implements Serializable {

	private static final long serialVersionUID = 5421377229702100525L;
	
	private int seq;
	private int motel_num;
	private String nickname;
	private String upload_dt;
	private int facility;
	private int service;
	private int clean;
	private String content;
	private int reference;
	private int step;
	private int depth;
	private int del;
	private int tot_cnt;
	
	public Ya_ReviewBean() {}

	public Ya_ReviewBean(int seq, int motel_num, String nickname, String upload_dt, int facility, int service, int clean,
			String content, int reference, int step, int depth, int del) {
		super();
		this.seq = seq;
		this.motel_num = motel_num;
		this.nickname = nickname;
		this.upload_dt = upload_dt;
		this.facility = facility;
		this.service = service;
		this.clean = clean;
		this.content = content;
		this.reference = reference;
		this.step = step;
		this.depth = depth;
		this.del = del;
	}

	public Ya_ReviewBean(int seq, int motel_num, String nickname, String upload_dt, int facility, int service,
			int clean, String content, int reference, int step, int depth, int del, int tot_cnt) {
		super();
		this.seq = seq;
		this.motel_num = motel_num;
		this.nickname = nickname;
		this.upload_dt = upload_dt;
		this.facility = facility;
		this.service = service;
		this.clean = clean;
		this.content = content;
		this.reference = reference;
		this.step = step;
		this.depth = depth;
		this.del = del;
		this.tot_cnt = tot_cnt;
	}
	
	public Ya_ReviewBean(int motel_num, String nickname, int facility, int service,
			int clean, String content) {
		super();
		this.seq = seq;
		this.motel_num = motel_num;
		this.nickname = nickname;
		this.upload_dt = upload_dt;
		this.facility = facility;
		this.service = service;
		this.clean = clean;
		this.content = content;
		this.reference = reference;
		this.step = step;
		this.depth = depth;
		this.del = del;
		this.tot_cnt = tot_cnt;
	}

	public int getTot_cnt() {
		return tot_cnt;
	}

	public void setTot_cnt(int tot_cnt) {
		this.tot_cnt = tot_cnt;
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

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getUpload_dt() {
		return upload_dt;
	}

	public void setUpload_dt(String upload_dt) {
		this.upload_dt = upload_dt;
	}

	public int getFacility() {
		return facility;
	}

	public void setFacility(int facility) {
		this.facility = facility;
	}

	public int getService() {
		return service;
	}

	public void setService(int service) {
		this.service = service;
	}

	public int getClean() {
		return clean;
	}

	public void setClean(int clean) {
		this.clean = clean;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getReference() {
		return reference;
	}

	public void setReference(int reference) {
		this.reference = reference;
	}

	public int getStep() {
		return step;
	}

	public void setStep(int step) {
		this.step = step;
	}

	public int getDepth() {
		return depth;
	}

	public void setDepth(int depth) {
		this.depth = depth;
	}

	public int getDel() {
		return del;
	}

	public void setDel(int del) {
		this.del = del;
	}

	@Override
	public String toString() {
		return "Ya_ReviewBean [seq=" + seq + ", motel_num=" + motel_num + ", nickname=" + nickname + ", upload_dt="
				+ upload_dt + ", facility=" + facility + ", service=" + service + ", clean=" + clean + ", content="
				+ content + ", reference=" + reference + ", step=" + step + ", depth=" + depth + ", del=" + del
				+ ", tot_cnt=" + tot_cnt + "]";
	}
}
