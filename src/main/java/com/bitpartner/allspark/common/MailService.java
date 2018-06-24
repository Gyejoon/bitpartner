package com.bitpartner.allspark.common;

import org.apache.commons.mail.DefaultAuthenticator;
import org.apache.commons.mail.Email;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;

/**
 * 메일 서비스 모듈
 */
public class MailService {

    private String smtpAddr;
    private int smtpPort;
    private String userID;
    private String userPW;
    private boolean isSSL;


    public MailService(){}

    public MailService(String smtpAddr, int smtpPort, String userID, String userPW, boolean isSSL) {
        this.smtpAddr = smtpAddr;
        this.smtpPort = smtpPort;
        this.userID = userID;
        this.userPW = userPW;
        this.isSSL = isSSL;
    }

    public int send(MailEntity mailEntity) {
        Email email = new HtmlEmail();

        email.setDebug(true);
        email.setHostName(this.smtpAddr);
        email.setSmtpPort(this.smtpPort);
        email.setAuthenticator(new DefaultAuthenticator(this.userID, this.userPW));
        email.setSSLOnConnect(this.isSSL);

        try{
            email.setFrom(mailEntity.getFrom(), mailEntity.getFromNm());
            email.setSubject(mailEntity.getSubject());
            email.setMsg(mailEntity.getMessage());
            email.addTo(mailEntity.getTo());
            email.send();
        }catch (EmailException e) {
            e.printStackTrace();
        }

        return 0;
    }


}


