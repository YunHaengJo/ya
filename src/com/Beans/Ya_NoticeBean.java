package com.Beans;

import java.io.Serializable;

public class Ya_NoticeBean implements Serializable {

	private static final long serialVersionUID = -2136411500103387705L;

	private int seq;
	private String title;
	private String content;
	private String upload_dt;
	private int tot_cnt;
	
	public Ya_NoticeBean() {
	}

	public Ya_NoticeBean(int seq, String title, String content, String upload_dt) {
		super();
		this.seq = seq;
		this.title = title;
		this.content = content;
		this.upload_dt = upload_dt;
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

	@Override
	public String toString() {
		return "Ya_NoticeBean [seq=" + seq + ", title=" + title + ", content=" + content + ", upload_dt=" + upload_dt
				+ "]";
	}
	
	
	
}
