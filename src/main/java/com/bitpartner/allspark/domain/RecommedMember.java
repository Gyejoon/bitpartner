package com.bitpartner.allspark.domain;

import javax.persistence.*;
import java.io.Serializable;

/**
 * 추천인
 */
@Entity
public class RecommedMember implements Serializable {

    // 추천인 식별 id
    @Id
    private Long recomId;

    // 추천인으로 등록된 member의 식별 id
    private Long recommedId;


}
