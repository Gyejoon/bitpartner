package com.bitpartner.allspark.domain;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

public interface MemberRepository extends JpaRepository<Member, Long>{

    @Query(value = "select * from member u where u.member_id = :memberId and u.member_password = :memberPassword", nativeQuery = true)
    public Member findByMemberIdAndPass(@Param("memberId") String memberId, @Param("memberPassword") String memberPassword);

    @Query(value = "select * from member u where u.member_id = :memberId", nativeQuery = true)
    public Member findByMemberId(@Param("memberId") String memberId);

}
