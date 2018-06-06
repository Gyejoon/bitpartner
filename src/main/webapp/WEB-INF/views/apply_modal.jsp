<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<script>
    const checkNameIsUsed = function() {
        const worker_form = document.workerForm;
        const value = worker_form.id.value;
        if (value == '') {
            alert('빈값이 입력되었습니다.');
            return;
        }
        callAjaxForNameUse(value);
    };

    const callAjaxForNameUse = function(value) {
        $.ajax({
            type : "post",
            url : "check_name_ajax",
            data : {
                workerId : value
            },
            success : function(resdata) {
                $("#returnAjaxForNameUse").html(resdata);
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
                        <!-- 아이디 -->
                        <div class="col-xs-6">
                            <div class="input-group">
								<span class="input-group-addon"><i
                                        class="zmdi zmdi-account"></i></span>
                                <div class="fg-line">
                                    <input name="name" type="text" class="form-control"
                                           placeholder="이름 입력" value="">
                                </div>
                            </div>
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

