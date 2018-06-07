<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<script>
    $(function () {
        $('#applyModal').on('hidden.bs.modal', function () {
            $('form').each(function () {
                this.reset();
                $('#returnAjaxForNameUse').empty().css("color", "#000000");
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

    const createWorker = function () {
        if ($("#returnAjaxForNameUse").html() == "") {
            alert('ID를 입력해주세요!');
            return;
        } else if ($("#returnAjaxForNameUse").html().trim() == "이미 사용중인 유저입니다!") {
            alert('사용중이지 않은 ID를 입력해주세요!');
            return;
        }
        const applyForm = document.applyForm;
        const id = applyForm.id.value;
        const pass = applyForm.pass.value;
        const repass = applyForm.repass.value;
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
        callAjaxForCreate(id, pass, email);
    };

    const callAjaxForCreate = function (id, pass, email) {
        alert(id + "," + pass + "," + email);
        $.ajax({
            type: "post",
            url: "/ico/allspark/recom/apply",
            contentType: "application/json",
            data: JSON.stringify({
                memberId: id,
                memberPassword: pass,
                memberEmail: email
            }),
            success: function (resdata) {
                //alert(resdata.recomUrl);
                //$('#applyModal').modal('hide');
                $("#applyBody").css("display", "none");
                $("#apply_link").val(resdata.recomUrl).attr("type", "text").css("visibility", "visible");
            },
            error: function () {
                alert("Error");
            }
        });
    };
    
    const copyApplyClipboard = function () {
        $('#apply_link').select();
        document.execCommand("copy");
        $('#applyModal').modal('hide');
    }
</script>
<form id="applyForm" name="applyForm" method="post">
    <div class="modal fade" id="applyModal" tabindex="-1" role="dialog"
         aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">회원가입</h4>
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
                                    <input name="pass" type="text" class="form-control"
                                           placeholder="비밀번호 입력">
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-6">
                            <div class="input-group">
								<span class="input-group-addon"><i
                                        class="zmdi zmdi-account"></i></span>
                                <div class="fg-line">
                                    <input name="repass" type="text" class="form-control"
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
                                    <input name="email" type="email" class="form-control"
                                           placeholder="이메일 입력">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-link" onclick="createWorker()">신청완료</button>
                        <button type="button" class="btn btn-link" data-dismiss="modal">닫기</button>
                    </div>
                </div>
                <input style="visibility: hidden;" type="hidden" id="apply_link" class="btn btn-default btn-block" value="링크" onclick="copyApplyClipboard()"/>
            </div>
        </div>
</form>

