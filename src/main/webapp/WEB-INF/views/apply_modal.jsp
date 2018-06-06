<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<script>
    const checkNameIsUsed = function() {
        const apply_form = document.applyForm;
        const value = apply_form.id.value;
        if (value == '') {
            alert('빈값이 입력되었습니다.');
            return;
        }
        callAjaxForNameUse(value);
    };

    const callAjaxForNameUse = function(value) {
        $.ajax({
            type : "get",
            url : "/ico/allspark/recom/idCheck",
            data : {
                memberId : value
            },
            success : function(resdata) {
                $("#returnAjaxForNameUse").html(resdata);
            },
            error : function() {
                alert("Error");
            }
        });
    };

    const createWorker = function() {
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
        callAjaxForCreate(id, pass, email);
    };

    const callAjaxForCreate = function(id, pass, email) {
        $.ajax({
            type : "post",
            url : "/ico/allspark/recom/apply",
            data : {
                id : id,
                pass : pass,
                email : email
            },
            success : function(resdata) {
                alert(resdata);
                $('#applyModal').modal('hide');
                $( "#grid" ).pqGrid("refreshDataAndView" );
            },
            error : function() {
                alert("Error");
            }
        });
    };
</script>
<form name="applyForm" method="post">
    <div class="modal fade" id="applyModal" tabindex="-1" role="dialog"
         aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">회원가입</h4>
                </div>
                <div class="modal-body">
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
                                    <input name="email" type="text" class="form-control"
                                           placeholder="이메일 입력">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-link" onclick="createWorker()">신청완료
                        </button>
                        <button type="button" class="btn btn-link" data-dismiss="modal">닫기</button>
                    </div>
                </div>
            </div>
        </div>
</form>

