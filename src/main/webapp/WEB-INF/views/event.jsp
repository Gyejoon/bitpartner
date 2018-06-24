<%@ taglib prefix="margin-right" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="margin-bottom" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<!--[if IE 9 ]><html class="ie9"><![endif]-->
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="theme-color" content="#fec108">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>AllSpark EVENT</title>

    <!-- favicon -->
    <link rel="icon" href="/img/logo/allspark_favicon.png"/>

    <!-- Vendor CSS -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/material-design-iconic-font/2.2.0/css/material-design-iconic-font.min.css">
    <!-- CSS -->
    <link href="/css/style.css" rel="stylesheet">

    <!-- jquery -->
    <script src="/js/jquery-2.1.1.min.js"></script>

    <!-- captcha -->
    <%--<script src='https://www.google.com/recaptcha/api.js'/>--%>
</head>
<body>
<!-- header start -->
<header id="header">
    <!-- header inner start -->
    <ul class="header-inner">
        <!-- title logo start -->
        <li id="logo" class="logo visible" style="">
            <a href="event"><img src="/img/logo/allspark_logo.png" alt="logo"></a>
        </li>
        <!-- title logo end -->
    </ul>
    <!-- header inner end -->
</header>
<!-- header end -->

<!-- main start -->
<section id="main">

    <!-- contetnt start -->
    <section id="content">
        <div class="container">
            <div class="row">
                <div class="col-sm-12">
                    <div class="card-deco card">
                        <div class="card-header">
                            <h2><b>[Allspark Korea Speacial event]</b></h2>
                        </div>
                        <div class="card-body card-padding">
                            <h4>
                                1. 참여자 이벤트 : 회원가입 및 신청 후 프리세일<br/>
                                2. 추천자 이벤트 : 추천링크를 통해 추천받은사람<br/>
                                3. E-mail은 추구 이벤트 진행에 사용될 예정이니 정확히(1인 1계정) 입력 부탁드립니다.<br/>
                                4. 조건확인 및 문의<br/>
                                - 공식(한국) <a style="color: black;"
                                          href="https://t.me/allspark_korea"><b>텔레그램 참여하기</b></a><br/>
                                - 이메일 : <a style="color: black;"
                                         href="mailto:bitpartnerkorea@gmail.com"><b>bitpartnerkorea@gmail.com</b></a>
                            </h4>
                        </div>
                        <div class="card-header">
                            <h2><b>[Allspark ICO 프리세일 공지]</b></h2>
                        </div>
                        <div class="card-body card-padding">
                            <h4>
                                1. 심볼 : ASK (Wanchain Dapp)<br/>
                                2. 기간 : ~ 07월 15일 23:59 (이후 퍼블릭 전환)<br/>
                                3. 퍼블릭 가격: <b>1 ETH = 3000 ASK</b><br/>
                                4. 프리세일 가격 : <b>1 ETH = 3750 ASK (20% 할인)</b><br/>
                                5. 참여단위 : <b>MIN 50 ETH, MAX 2,000 ETH</b><br/>
                                6. 링크<br/>
                                - 공식페이지 : <a style="color: black;"
                                           href="http://www.allsparkchain.com"><b>올스파크 홈페이지로 가기</b></a><br/>
                                - 백서(영문) : <a style="color: black;"
                                            href="http://allsparkchain.com/pdf/AllSparkWhitePaper.pdf"><b>다운로드</b></a><br/>
                                - 백서(한글) : <a style="color: black;"
                                            href="http://www.allsparkchain.com/pdf/AllSparkWhitePaperK.pdf"><b>다운로드</b></a><br/>
                                - 올스파크 소개 : <a style="color: black;"
                                             href="https://m.blog.naver.com/715fas/221304719137"><b>소개 블로그로 가기</b></a>
                            </h4>
                        </div>
                        <div class="card-header">
                            <h2><b>[신청 및 추천하기]</b></h2>
                        </div>
                        <div class="card-body card-padding">
                            <button style="margin-left: 1em; margin-bottom: 1em; margin-right: 1em;"
                                    class="btn btn-default" data-toggle="modal" href="#applyModal">
                                회원가입
                            </button>
                            <button style="margin-left: 0.5em; margin-bottom: 1em;"
                                    class="btn btn-default"
                                    data-toggle="modal" href="#recomModal">로그인
                            </button>
                            <div>
                                <%@include file="apply_modal.jsp" %>
                            </div>
                            <div>
                                <%@include file="recom_modal.jsp" %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-sm-12">
                    <div class="card">
                        <div class="card-body card-padding">
                            <div>
                                <img width="100%" src="/img/intro/intro.png" alt="소개 이미지">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- contetnt end -->
</section>
<!-- main end -->

<a href="https://t.me/allspark_korea">
    <img src="/img/logo/telegram_logo.png" class="float-button">
</a>

<!-- footer start -->
<footer id="footer">
    Copyright &copy;Bitcoin Korea
</footer>
<!-- footer end -->

<!-- Javascript Libraries -->
<script src="/vendors/bower_components/jquery/dist/jquery.min.js"></script>
<script src="/vendors/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>

<script src="/vendors/bower_components/moment/min/moment.min.js"></script>
<script src="/vendors/bower_components/eonasdan-bootstrap-datetimepicker/build/js/bootstrap-datetimepicker.min.js"></script>
<script src="/vendors/bootstrap-growl/bootstrap-growl.min.js"></script>
<script src="/vendors/bower_components/Waves/dist/waves.min.js"></script>
<script src="/vendors/bower_components/flot/jquery.flot.js"></script>
<script src="/vendors/bower_components/flot/jquery.flot.resize.js"></script>
<script src="/vendors/bower_components/flot.curvedlines/curvedLines.js"></script>
<script src="/vendors/sparklines/jquery.sparkline.min.js"></script>
<script src="/vendors/bower_components/jquery.easy-pie-chart/dist/jquery.easypiechart.min.js"></script>


<script src="/js/functions.js"></script>
<!--script src="js/demo.js"></script-->


</body>
</html>
