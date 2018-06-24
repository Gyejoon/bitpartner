<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
    $(function () {
        $('#applyModal').on('hidden.bs.modal', function () {
            $('form').each(function () {
                this.reset();
                $('#returnAjaxForNameUse').empty().css("color", "#000000");
                $(".certCode").css("display", "block");
            });
        });
    });

    const checkNameIsUsed = function () {
        const apply_form = document.applyForm;
        const value = apply_form.id.value;
        if (value == '') {
            alert('빈값이 입력되었습니다.');
            return;
        }
        callAjaxForNameUse(value);
    };

    const callAjaxForNameUse = function (value) {
        $.ajax({
            type: "get",
            url: "/ico/allspark/recom/idCheck",
            data: {
                memberId: value
            },
            success: function (resdata) {
                if (resdata.code) {
                    $("#returnAjaxForNameUse").html(resdata.msg);
                } else {
                    $("#returnAjaxForNameUse").html(resdata.msg).css("color", "#ff0000");
                }
            },
            error: function () {
                alert("Error");
            }
        });
    };

    const createMember = function () {
        if ($("#returnAjaxForNameUse").html() == "") {
            alert('ID를 입력해주세요!');
            return;
        } else if ($("#returnAjaxForNameUse").html().trim() == "이미 사용중인 유저입니다!") {
            alert('사용중이지 않은 ID를 입력해주세요!');
            return;
        }
        if($("#certCheck").val() !== "cert") {
            alert("이메일 인증을 해주세요.");
            return;
        }

        const applyForm = document.applyForm;
        const id = applyForm.id.value;
        const pass = applyForm.pass.value;
        const repass = applyForm.repass.value;
        const recomId = applyForm.recomMemberId.value;
        if (pass != repass) {
            alert('비밀번호가 같지 않습니다.');
            applyForm.repass.focus();
            return;
        }
        const email = applyForm.email.value;
        if (pass == "" || email == "") {
            alert('비밀번호, email을 입력해주셔야 합니다.');
            return;
        }
        var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
        // 검증에 사용할 정규식 변수 regExp에 저장

        if (email.match(regExp) == null) {
            alert('이메일 규칙에 맞게 작성해 주십시오.');
            applyForm.email.focus();
            return;
        }

        callAjaxForCreate(id, pass, email, recomId);
    };

    const callAjaxForCreate = function (id, pass, email, recomId) {
        $.ajax({
            type: "post",
            url: "/ico/allspark/recom/apply",
            contentType: "application/json",
            data: JSON.stringify({
                memberId: id,
                memberPassword: pass,
                memberEmail: email,
                recomMemberId : recomId
            }),
            success: function (resdata) {
                $("#apply_desc").css("display", "block");
                $("#applyBody").css("display", "none");
                $("#open_apply_link").css("visibility", "visible");
                $("#apply_link").val(resdata.recomUrl).attr("type", "text");
            },
            error: function () {
                alert("아이디가 없거나, 패스워드가 틀립니다.");
            }
        });
    };

    const copyApplyClipboard = function () {
        $('#apply_link').select();
        document.execCommand("copy");
        $('#applyModal').modal('hide');
        alert("링크가 복사되었습니다.");
    }

    const openApplyLink = function () {
        $("#apply_link").attr("type", "text").css("visibility", "visible");
    }

    const certCodeSend = function() {
        const applyForm = document.applyForm;
        const email = applyForm.email.value;

        var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
        // 검증에 사용할 정규식 변수 regExp에 저장

        if (email.match(regExp) == null) {
            alert('이메일 규칙에 맞게 작성해 주십시오.');
            applyForm.email.focus();
            return;
        }

        $.ajax({
            type: "get",
            url: "/ico/allspark/recom/emailCheck",
            contentType: "application/json",
            data: {
                email: email
            },
            success: function (resdata) {
                if(!resdata.success) {
                    alert("이미 사용중인 이메일입니다.");
                    return;
                }
            },
            error: function () {
                alert("서버 에러");
                return;
            }
        });

        $.ajax({
            type: "get",
            url: "/ico/allspark/recom/certCodeSend",
            contentType: "application/json",
            data: {
                email: email
            },
            success: function (resdata) {
                if(resdata.success) {
                    $(".certCode").css("display", "block");
                    alert("인증번호가 전송되었습니다.");
                } else {
                    alert("이메일 전송이 실패 하였습니다.");
                }
            },
            error: function (err) {
                alert("정확한 이메일을 입력해 주세요.");
            }
        });
    }

    const certCodeCheck = function() {

        const applyForm = document.applyForm;
        const email = applyForm.email.value;
        const code = applyForm.code.value;

        $.ajax({
            type: "post",
            url: "/ico/allspark/recom/certCodeCheck",
            contentType: "application/json",
            data: JSON.stringify({
                email: email,
                code: code
            }),
            success: function(resdata) {
                if(resdata.success) {
                    $("#certCheck").val("cert");
                    alert("인증되었습니다.");
                }else {
                    alert("인증번호가 일치하지 않습니다.");
                }
            },
            error: function() {
                alert("정확한 인증번호를 입력해 주세요.");
            }
        })
    }

</script>
<form id="applyForm" name="applyForm" method="post">
    <input type="hidden" value="<%=request.getAttribute("recomdId")%>" name="recomMemberId">
    <div class="modal fade" id="applyModal" tabindex="-1" role="dialog"
         aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content card-deco">
                <div class="modal-header">
                    <h4 id="apply_id" class="modal-title">회원가입</h4>
                </div>
                <div id="applyBody" class="modal-body">
                    <div class="row">
                        <!-- 아이디 -->
                        <div class="col-xs-6">
                            <div class="input-group">
								<span class="input-group-addon"><i
                                        class="zmdi zmdi-account"></i></span>
                                <div class="fg-line">
                                    <input name="id" type="text" class="form-control"
                                           placeholder="아이디 입력" value="">
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-6">
                            <button type="button" class="btn btn-primary"
                                    onclick="checkNameIsUsed()">중복확인
                            </button>
                            <label style="margin-left: 10px;" id="returnAjaxForNameUse"></label>
                        </div>
                    </div>
                    <div class="row">
                        <!-- 비밀번호 -->
                        <div class="col-xs-6">
                            <div class="input-group">
								<span class="input-group-addon"><i
                                        class="zmdi zmdi-account"></i></span>
                                <div class="fg-line">
                                    <input name="pass" type="password" class="form-control"
                                           placeholder="비밀번호 입력">
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-6">
                            <div class="input-group">
								<span class="input-group-addon"><i
                                        class="zmdi zmdi-account"></i></span>
                                <div class="fg-line">
                                    <input name="repass" type="password" class="form-control"
                                           placeholder="비밀번호 확인">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <!-- 이메일 -->
                        <div class="col-xs-6">
                            <div class="input-group">
								<span class="input-group-addon"><i
                                        class="zmdi zmdi-email"></i></span>
                                <div class="fg-line">
                                    <input name="email" minlength="3" maxlength="64" type="email" class="form-control"
                                           required placeholder="username@example.com" placeholder="이메일 입력" pattern=".+@+.">
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-6">
                            <button type="button" class="btn btn-primary"
                                    onclick="certCodeSend()">인증번호 전송
                            </button>
                            <label style="margin-left: 10px;" id=""></label>
                        </div>
                    </div>

                    <div class="row certCode" style="display: none;">
                        <div class="col-xs-6">
                            <div class="fg-line">
                                <input name="code" minlength="3" maxlength="64" type="text" class="form-control"
                                       required placeholder="인증번호 입력">
                            </div>
                        </div>

                        <div class="col-xs-6">
                            <button type="button" class="btn btn-primary"
                                    onclick="certCodeCheck()">인증번호 확인
                            </button>
                        </div>
                    </div>

                    <input type="hidden" id="certCheck" value="">

                    <div class="g-recaptcha" data-sitekey="6LfrvV4UAAAAADNtv94xDLTH0ObZOAZfrFpoG3-h"></div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-link" onclick="createMember()">신청완료</button>
                        <button type="button" class="btn btn-link" data-dismiss="modal">닫기</button>
                    </div>
                </div>
                <div id="apply_desc" style="display: none" class="modal-body">
                    <p>ALLspark Korea Special Event 신청을 완료하셨습니다.<br/>추천 Event 혜택도 받아가세요!</p>
                </div>
                <input type="button" style="visibility: hidden;" class="btn btn-link" id="open_apply_link" value="링크만들기" onclick="openApplyLink()">
                <input style="visibility: hidden;" type="hidden" id="apply_link" class="btn btn-default btn-block" value="링크" onclick="copyApplyClipboard()"/>
            </div>
        </div>
</form>

