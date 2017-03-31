package com.Beans;

import java.io.Serializable;

public class Ya_QnaBean implements Serializable {

	private static final long serialVersionUID = 3626200979458834932L;
	
	private int seq;
	private String email;
	private String title;
	private String content;
	private String upload_dt;
	private int refer;
	private int step;
	private int depth; 
	private int del;
	private int is_ans;
	private int tot_cnt;
	
	public Ya_QnaBean() {
	}

	public Ya_QnaBean(int seq, String email, String title, String content, String upload_dt, int refer, int step,
			int depth, int del, int is_ans) {
		super();
		this.seq = seq;
		this.email = email;
		this.title = title;
		this.content = content;
		this.upload_dt = upload_dt;
		this.refer = refer;
		this.step = step;
		this.depth = depth;
		this.del = del;
		this.is_ans = is_ans;
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

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getUpload_dt() {
		return upload_dt;
	}

	public void setUpload_dt(String upload_dt) {
		this.upload_dt = upload_dt;
	}

	public int getRefer() {
		return refer;
	}

	public void setRefer(int refer) {
		this.refer = refer;
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

	public int getIs_ans() {
		return is_ans;
	}

	public void setIs_ans(int is_ans) {
		this.is_ans = is_ans;
	}

	@Override
	public String toString() {
		return "Ya_QnaBean [seq=" + seq + ", email=" + email + ", title=" + title + ", content=" + content
				+ ", upload_dt=" + upload_dt + ", refer=" + refer + ", step=" + step + ", depth=" + depth + ", del="
				+ del + ", is_ans=" + is_ans + ", tot_cnt=" + tot_cnt + "]";
	}

	
	
	
	
	

}
