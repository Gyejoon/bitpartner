package com.bitpartner.allspark.common;

import java.util.Objects;

public class MailEntity {

    private String from;
    private String fromNm;
    private String to;
    private String subject;
    private String message;


    public MailEntity() {}
    public MailEntity(String from, String fromNm, String to, String subject, String message) {
        this.from = from;
        this.fromNm = fromNm;
        this.to = to;
        this.subject = subject;
        this.message = message;
    }

    @Override
    public String toString() {
        return "MailEntity{" +
                "from='" + from + '\'' +
                ", fromNm='" + fromNm + '\'' +
                ", to='" + to + '\'' +
                ", subject='" + subject + '\'' +
                ", message='" + message + '\'' +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        MailEntity that = (MailEntity) o;
        return Objects.equals(from, that.from) &&
                Objects.equals(fromNm, that.fromNm) &&
                Objects.equals(to, that.to) &&
                Objects.equals(subject, that.subject) &&
                Objects.equals(message, that.message);
    }

    @Override
    public int hashCode() {

        return Objects.hash(from, fromNm, to, subject, message);
    }

    public String getFrom() {
        return from;
    }

    public void setFrom(String from) {
        this.from = from;
    }

    public String getFromNm() {
        return fromNm;
    }

    public void setFromNm(String fromNm) {
        this.fromNm = fromNm;
    }

    public String getTo() {
        return to;
    }

    public void setTo(String to) {
        this.to = to;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
