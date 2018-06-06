package com.bitpartner.allspark.domain;

import java.util.Date;

import javax.persistence.*;

@Entity
public class Member {
	
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
	
	// 추천인 식별 id
	private long recomMember;
	
	
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

	public long getRecomMember() {
		return recomMember;
	}

	public void setRecomMember(long recomMember) {
		this.recomMember = recomMember;
	}
	

	
}
