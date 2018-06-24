package com.bitpartner.allspark.domain;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;


public interface CertCodeRepository extends JpaRepository<CertCode, Integer> {

    /**
     * 인증번호 유효성 검사
     * @return
     */
    @Query(value = "select c from CertCode c where c.email = :email and c.code = :certCode")
    public CertCode certCodeCheck(@Param("email") String email, @Param("certCode") String certCode);


    @Query(value = "select c from CertCode c where c.email = :email")
    public CertCode emailCheck(@Param("email") String email);


}
