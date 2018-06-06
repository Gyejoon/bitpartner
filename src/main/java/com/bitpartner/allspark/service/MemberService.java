package com.bitpartner.allspark.service;

import com.bitpartner.allspark.domain.Member;
import org.springframework.data.jpa.repository.Query;

public interface MemberService {

    /**
     * 신청하기
     * @param member
     * @return
     */
    public Member insertMember(Member member);

    /**
     * 추천하기
     * @param memberId
     * @param memberPassword
     * @return
     */
	public Member findByMemberIdAndPass(String memberId, String memberPassword);


    /**
     * 아이디 중복체크
     * @param memberId
     * @return
     */
	public Member findByMemberId(String memberId);


}
