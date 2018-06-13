<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<!--[if IE 9 ]><html class="ie9"><![endif]-->
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="theme-color" content="#fec108">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>AllSpark EVNET</title>

	<!-- favicon -->
	<link rel="icon" href="/img/logo/allspark_favicon.png"/>

	<!-- Vendor CSS -->
	<link href="/vendors/bower_components/animate.css/animate.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/material-design-iconic-font/2.2.0/css/material-design-iconic-font.min.css">
	<!-- CSS -->
	<link href="/css/style.css" rel="stylesheet">

    <!-- jquery -->
    <script src="/js/jquery-2.1.1.min.js"></script>

    <!-- captcha -->
    <script src='https://www.google.com/recaptcha/api.js'/>
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

					<div class="card">
                        <div class="card-header">
                            <h2>제목
                                <small>내용</small>
                            </h2>
                        </div>

                        <div class="card-body card-padding">
                            <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
                                <!-- Indicators -->
                                <ol class="carousel-indicators">
                                    <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
                                    <li data-target="#carousel-example-generic" data-slide-to="1"></li>
                                    <li data-target="#carousel-example-generic" data-slide-to="2"></li>
                                </ol>

                                <!-- Wrapper for slides -->
                                <div class="carousel-inner" role="listbox">
                                    <div class="item active">
                                        <img src="/img/headers/2.png" alt="">
                                        <div class="carousel-caption">
                                            <h3>First Slide Label</h3>
                                            <p>Some sample text goes here...</p>
                                        </div>
                                    </div>
                                    <div class="item">
                                        <img src="/img/headers/1.png" alt="">
                                    </div>
                                    <div class="item">
                                        <img src="/img/headers/3.png" alt="">
                                    </div>
                                </div>

                                <!-- Controls -->
                                <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
                                    <span class="zmdi zmdi-chevron-left" aria-hidden="true"></span>
                                    <span class="sr-only">Previous</span>
                                </a>
                                <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
                                    <span class="zmdi zmdi-chevron-right" aria-hidden="true"></span>
                                    <span class="sr-only">Next</span>
                                </a>
                            </div>
                        </div>
                    </div>

                    <div class="card">
                        <div class="card-header">
                            <h2>Bounty란?</h2>
                        </div>

                        <div class="card-body card-padding">
                            <p class="lead">부제목</p>
                            <p>내용</p>
                            <button class="btn btn-default" data-toggle="modal" href="#applyModal">신청하기</button>
                            <button style="margin-left: 0.5em;" class="btn btn-default" data-toggle="modal" href="#recomModal">추천하기</button>
                            <div><%@include file="apply_modal.jsp"%></div>
                            <div><%@include file="recom_modal.jsp"%></div>
                        </div>

                    </div>


				</div>
			</div>
		</div>
	</section>
	<!-- contetnt end -->
</section>
<!-- main end -->


<!-- footer start -->
<footer id="footer">
	Copyright &copy; 푸터

	<ul class="f-menu">
		<li><a href="">메인</a></li>
		<li><a href="">who we are</a></li>
	</ul>
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
