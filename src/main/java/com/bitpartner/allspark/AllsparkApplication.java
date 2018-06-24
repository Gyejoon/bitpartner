package com.bitpartner.allspark;

import com.bitpartner.allspark.domain.Member;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.boot.autoconfigure.orm.jpa.HibernateJpaAutoConfiguration;
import org.springframework.context.annotation.ComponentScan;

import javax.persistence.GeneratedValue;

@SpringBootApplication
@ComponentScan
public class AllsparkApplication {
    public static void main(String[] args) {
        SpringApplication.run(AllsparkApplication.class, args);
    }
}