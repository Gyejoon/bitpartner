package com.bitpartner.allspark.service;

import com.bitpartner.allspark.SHA256;
import com.bitpartner.allspark.domain.Member;
import com.bitpartner.allspark.domain.MemberRepository;
import org.apache.tomcat.util.security.MD5Encoder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import sun.security.provider.MD5;

@Service
public class MemberServiceImpl implements MemberService {

    @Autowired
    private MemberRepository memberRepository;

    @Override
    public Member insertMember(Member member) {

        String memberPassword = member.getMemberPassword();

        String encodedMemberPassword = SHA256.getEncSHA256(memberPassword);

        member.setMemberPassword(encodedMemberPassword);

        return memberRepository.save(member);
    }

    @Override
    public Member findByMemberIdAndPass(String memberId, String memberPassword) {

        String encodedMemberPassword = SHA256.getEncSHA256(memberPassword);

        return memberRepository.findByMemberIdAndPass(memberId, encodedMemberPassword);
    }

    @Override
    public Member findByMemberId(String memberId) {
        return memberRepository.findByMemberId(memberId);
    }

    @Override
    public Member emailCheck(String email) {
        return memberRepository.emailCheck(email);
    }


}
