package com.bitpartner.allspark.domain;

import com.bitpartner.allspark.Constant;
import sun.misc.BASE64Encoder;

import java.io.Serializable;
import java.util.Base64;
import java.util.Date;

import javax.persistence.*;

@Entity
public class Member implements Serializable {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long id;
	
	// 신청자 아이디
	@Column(name = "memberId", nullable = false, updatable = false, insertable = true)
	private String memberId;
	
	// 신청자 패스워드
	@Column(name = "memberPassword", nullable = false, updatable = false, insertable = true)
	private String memberPassword;
	
	// 신청자 이메일
	@Column(name = "memberEmail", nullable = false, updatable = false, insertable = true)
	private String memberEmail;
	
	// 신청일
	@Column(name = "regDate", nullable = false, updatable = false, insertable = true)
	private Date regDate;

	// 추천인 memberId
	private String recomMemberId;
	
    @PrePersist
    void preInsert() {
    	this.regDate = new Date();
    }

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getMemberPassword() {
		return memberPassword;
	}

	public void setMemberPassword(String memberPassword) {
		this.memberPassword = memberPassword;
	}

	public String getMemberEmail() {
		return memberEmail;
	}

	public void setMemberEmail(String memberEmail) {
		this.memberEmail = memberEmail;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public String getRecomMemberId() {
		return recomMemberId;
	}

	public void setRecomMemberId(String recomMemberId) {
		this.recomMemberId = recomMemberId;
	}

}
