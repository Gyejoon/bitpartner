<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        const recomId = recomForm.recomMemberId.value;
        if (id == "") {
            alert("ID를 입력해주세요!");
            return;
        }
        if (pass == "") {
            alert("비밀번호를 입력해주세요!");
            return;
        }
        AjaxForLogin(id, pass, recomId);
    };

    const AjaxForLogin = function (id, pass, recomId) {
        $.ajax({
            type: "post",
            url: "/ico/allspark/recom/recommend",
            contentType: "application/json",
            data: JSON.stringify({
                memberId: id,
                memberPassword: pass,
                recomMemberId: recomId
            }),
            success: function (resdata) {
                $("#before_noti").css("display", "none");
                $("#recom_desc").css("display", "block");
                $("#recomBody").css("display", "none");
                $("#recom_id").html("축하합니다!");
                $("#_recom_id").html("추천인 ID : " + resdata.member.memberId);
                $("#open_recom_link").css("visibility", "visible");
                $("#recom_link").val(resdata.recomUrl).attr("type", "text");
            },
            error: function () {
                alert("아이디가 없거나, 패스워드가 틀립니다.");
            }
        });
    };

    const copyRecomClipboard = function () {
        $('#recom_link').select();
        document.execCommand("copy");
        $('#recomModal').modal('hide');
        alert("링크가 복사되었습니다.");
    }

    const openRecomLink = function () {
        $("#recom_link").attr("type", "text").css("visibility", "visible");
    }
</script>
<form name="recomForm" method="post">
    <input type="hidden" value="<%=request.getAttribute("recomdId")%>" name="recomMemberId">
    <div class="modal fade" id="recomModal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-sm">
            <div class="modal-content card-deco">
                <div class="modal-header">
                    <h4 id="recom_id" class="modal-title">로그인</h4>
                    <br/>
                    <div id="before_noti">
                        <small>
                            <b>1.추천링크 생성을 위해 로그인을 해주세요.</b><br/>
                            <b>2.아이디가 없으신 경우 신청하기를 통해 회원가입 후 진행해주세요.</b>
                        </small>
                    </div>

                </div>
                <div id="recomBody" class="modal-body">
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
                                    <input name="pass" type="password" class="form-control"
                                           placeholder="비밀번호 입력">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-link" onclick="loginMember()">로그인
                        </button>
                        <button type="button" class="btn btn-link" data-dismiss="modal">닫기</button>
                    </div>
                </div>
                <div id="recom_desc" style="display: none" class="modal-body">
                    <p>ALLSPARK&nbsp;Korea Special Event 신청을 완료하셨습니다.<br/><br/>추천 Event 혜택도 받아가세요!
                    </p>
                    <div id="_recom_id"></div>
                    <br/>
                </div>
                <div class="modal-footer">
                    <input type="button" style="visibility: hidden;" class="btn bgm-bluegray"
                           id="open_recom_link" value="링크만들기" onclick="openRecomLink()">
                    <input style="visibility: hidden;" type="hidden" id="recom_link"
                           class="btn btn-default btn-block" value="링크"
                           onclick="copyRecomClipboard()"/>
                </div>
            </div>
        </div>
</form>

