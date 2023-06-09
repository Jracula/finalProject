<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <!-- 슬릭 슬라이더 제이쿼리 -->
	<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
	<script type="text/javascript" src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
	<!-- 슬릭 슬라이더 -->
	<link rel="stylesheet" href="/resources/slick/slick-theme.css"/>
	<link rel="stylesheet" href="/resources/slick/slick.css"/>
	<!-- 슬라이더 화살표 아이콘 arrow -->
	<script src="https://kit.fontawesome.com/285f888d1c.js" crossorigin="anonymous"></script>
    <!--productView.css-->
    <link rel="stylesheet" href="/resources/css/product/productView.css">
    <!-- <script src="/resources/js/jquery-3.6.0.js"></script> -->
     <!-- 리뷰css  -->
    <link rel="stylesheet" href="/resources/css/product/review.css"/>
    <link rel="stylesheet" href="/resources/css/product/product.css"/>
</head>
<style>
    /* 리뷰css */
		.modal-body>form>.selectBox-widht-explain{
			width: 80%;
			margin: 0 auto;
		}
		.slick-prev:before, .slick-next:before {
        	/* 슬릭 슬라이더 아이콘 */
            color: #565656;
			font-family: 'Font Awesome 5 Free';
            font-weight: 900;
        }
		.all-review-wrap .slick-prev,
		#modal-photo-review-detail .slick-prev{
			left: 10px;
			z-index: 100;
		}
		.all-review-wrap .slick-next,
		#modal-photo-review-detail .slick-next{
			right: 10px;
		}
		.slick-next:before{
			content: '\f054' !important;
		}
		.slick-prev:before{
			content: '\f053' !important;
		}
		.slick-prev.slick-disabled:before,
		.slick-next.slick-disabled:before
		{
			/* 슬릭 슬라이더 첫,마지막페이지 이전,다음 아이콘 숨김 */
    		/* opacity: .25; */
			opacity: 0;
			cursor: default;
		}
        #modal-photo-review-more,
		#modal-photo-review-detail{
			/* 포토후기 더보기, 상세보기 */
            max-width: none;
            width: 800px;
        }
		#modal-photo-review-detail .review-info,
		#modal-photo-review-detail .review-content{
			width: 400px;
		}
		#modal-photo-review-more .photo-review-img{
			width: 150px;
			height: 150px;
		}
		/* 리뷰css 끝 */
    .slick-prev:before, .slick-next:before {
    /* 슬릭 슬라이더 아이콘 */
    color: #565656;
    font-family: 'Font Awesome 5 Free';
    font-weight: 900;
    }
    .slick-prev{
        left: 10px;
        z-index: 100;
    }
    .slick-next {
        right: 10px;
    }
    .slick-next:before{
        content: '\f054' !important;
    }
    .slick-prev:before{
        content: '\f053' !important;
    }
    .slick-prev.slick-disabled:before,
    .slick-next.slick-disabled:before
    {
        /* 슬릭 슬라이더 첫,마지막페이지 이전,다음 아이콘 숨김 */
        /* opacity: .25; */
        opacity: 0;
        cursor: default;
    }
    /* .material-symbols-outlined {
    font-variation-settings:
    'FILL' 0,
    'wght' 400,
    'GRAD' 0,
    'opsz' 48
    } */
    .test {
    color: #f88000;
    font-variation-settings:
    'FILL' 1,
    'wght' 400,
    'GRAD' 0,
    'opsz' 48
    }
    .material-symbols-outlined:hover {
    color: #f88000;
    font-variation-settings:
    'FILL' 1,
    'wght' 400,
    'GRAD' 0,
    'opsz' 48
    }
</style>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<div class="content-wrap">
    <!-- <h3 class="wrap-title">[${SessionScope.m.memberId}]님이 검색하신 상품 목록 입니다.</h3> -->
    <h3 style="text-align: center; margin-bottom: 100px;">[ ${sk} ] 에 대한 검색 결과 입니다.</h3>
        <c:forEach items="${productList }" var="p">
            <div class="posting-item">
                <div class="posting-img">
					<a href="/productView.do?productNo=${p.productNo}">
						<img src="/resources/upload/product/${p.thumbnail }" />
					</a>
                    <div class="gonggu-info">${p.gongguNumber}인 공동구매</div>
                </div>
                <div class="posting-content">
                    <a href="/productView.do?productNo=${p.productNo}">
                        ${p.productName}
                    </a>
					<div class="posting-price-box">
						<p class="price-through"><fmt:formatNumber value="${p.productPrice }"/>원</p>
						<div class="sail-box">
							<p class="sail-percent">${p.productDiscount}%</p>
							<p class="price-sail"><fmt:formatNumber value="${(Math.floor(p.productPrice*(100 - p.productDiscount)/1000)*10)}"/>원</p>
						</div>
					</div>
                    <div class="posting-detail">
                        <div class="posting-icon">
                        </div>
                        <div class="posting-info">
                            <div>
                                <span class="posting-info-box">무료배송</span>
                            </div>
                            <!-- <div class="star-rating">
                                <div class="material-symbols-outlined star-rate">star</div>
                                <div class="rating-average"></div>
                                <div class="review-count">(152)</div>
                            </div> -->
                        </div>
                    </div>
                </div>
            </div>
	    </c:forEach>
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>