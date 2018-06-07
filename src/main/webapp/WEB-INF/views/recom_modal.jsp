<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<script>
    $(function () {
        $('#recomModal').on('hidden.bs.modal', function () {
            $('form').each(function () {
                this.reset();

            });
        });
    });

    const loginMember = function () {
      const recomForm = document.recomForm;
      const id = recomForm.id.value;
      const pass = recomForm.pass.value;
      if(id == ""){
          alert("ID를 입력해주세요!");
      }
        if(pass == ""){
            alert("비밀번호를 입력해주세요!");
        }
      AjaxForLogin(id, pass);
    };

    const AjaxForLogin = function (id, pass) {
        $.ajax({
            type : "post",
            url : "/ico/allspark/recom/login",
            data : JSON.stringify({
                memberId : id,
                memberPassword : pass
            }),
            success : function (result) {
                alert(result);
                $('#applyModal').modal('hide');
            },
            error : function() {
                alert("Error");
            }
        });
    };

</script>
<form name="recomForm" method="post">
    <div class="modal fade" id="recomModal" tabindex="-1" role="dialog"
         aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">회원가입</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <!-- 아이디 -->
                        <div class="col-xs-12">
                            <div class="input-group">
								<span class="input-group-addon"><i
                                        class="zmdi zmdi-account"></i></span>
                                <div class="fg-line">
                                    <input name="id" type="text" class="form-control"
                                           placeholder="아이디 입력" value="">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <!-- 비밀번호 -->
                        <div class="col-xs-12">
                            <div class="input-group">
								<span class="input-group-addon"><i
                                        class="zmdi zmdi-account"></i></span>
                                <div class="fg-line">
                                    <input name="pass" type="text" class="form-control"
                                           placeholder="비밀번호 입력">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-link" onclick="loginMember()">신청완료
                        </button>
                        <button type="button" class="btn btn-link" data-dismiss="modal">닫기</button>
                    </div>
                </div>
            </div>
        </div>
</form>

