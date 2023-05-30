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
    <c:if test="${not empty sessionScope.m }">
        <jsp:include page="/WEB-INF/views/common/stickyRight.jsp" />
    </c:if>



    

<div class="content-wrap">

	<c:if test="${sessionScope.m.memberStatus eq 0 }">
		<h5>관리자 메뉴</h5>
		<form action="#" id="adminProductDelete">
			<button class="btn btn-pri size02" style="display: inline-block; margin-top:10px;">상품삭제</button>
		</form>
	</c:if>
	
	
	<c:if test="${not empty sessionScope.m }">
			<!-- <form action="/orderSheet.do" method="post">
				<input type="hidden" name="productNo">
				<input type="hidden" name="optionNo">
				<button>주문하기</button>
                <input type="hidden" id="option-list-null" value="${optionList}">
			</form> -->
		<!-- <button type="button" id="put-in-cart-btn">장바구니 담기</button> -->
	</c:if>
        <div class="top-info-box">
            <div class="img-box">
            <c:forEach items="${p.fileList }" var="i">
                <img src="/resources/upload/product/${i.filepath }" style="border-radius: 20px;">
            </c:forEach>
            </div>
            <div class="first-info-box">
                <div class="product-name"><a>${p.productName }</a></div>
                <div class="price-box-top">
                <div class="price-box1">
                    <div class="product-discount">
                        <a>${p.productDiscount}%</a>
                    </div>
                </div>
                    <div class="flex-price-box">
                    <div class="price-box2">
                        <div class="no-discount-price">
                            <a style="text-decoration: line-through;"><fmt:formatNumber value="${p.productPrice}"/></a>
                            <span>원</span>
                        </div>
                        <div class="real-price"><span class="product-price"></span><span class="product-price-currency"> 원</span></div>
                    </div>
                    <div class="icon-box">
                        <div class="like-icon">
                            <a name="like" class="likeBtn">
                                <!-- <c:if test="${productNo eq boardNo}"> -->
                                <span class="likeBtn material-symbols-outlined">favorite</span>
                                <!-- </c:if> -->
                            </a>
                        </div>
                        <!-- <div class="share-icon">
                            <a href="#">
                                <span class="material-symbols-outlined">share</span>
                            </a>
                        </div> -->
                    </div>
                </div>
                </div>
                <div class="flex-wrap">
                    <div class="flex-box">
                        <div class="info-title-box">
                            <a class="info-title">택배배송</a>
                        </div>
                        <div class="info-content ic1">
                            <ul>
                                <li class="delivery-info">무료배송<span>(뭉쳐야산다 모든제품 무료배송)</span></li>
                                <li>공동구매 완료되면 배송시작</li>
                            </ul>
                        </div>
                    </div>

                    <div class="flex-box">
                        <div class="info-title-box">
                            <a class="info-title">배송기간</a>
                        </div>
                        <div class="info-content">
                            <ul>
                                <li>1일내 도착 확률 ------------- <span class="delivery-percent">88%</span></li>
                                <li>3일내 도착 확률 ------------- <span class="delivery-percent">91%</span></li>
                                <li>5일내 도착 확률 ------------- <span class="delivery-percent">95%</span></li>
                            </ul>
                        </div>
                    </div>
                    
                    <!-- <div class="flex-box">
                        <div class="info-title-box">
                            <a class="info-title">적립금액</a>
                        </div>
                        <div>
                            <ul class="info-content">
                                <li>1일내 도착 확률 : 88%</li>
                                <li>3일내 도착 확률 : 91%</li>
                                <li>5일내 도착 확률 : 97%</li>
                            </ul>
                        </div>
                    </div> -->

                    <div class="flex-box option-list-box">
                        <div class="info-title-box">
                            <a class="info-title">옵션</a>
                        </div>
                        <div>
                            <ul class="info-content">
                                <li><select class="select-custom product-option">
                                    <option value="0" selected>상품 옵션을 선택해주세요</option>
                                    <c:forEach items="${optionList }" var="po">
                                        <option value="${po.optionInfoNo }">${po.optionDetailName }</option>
                                        <!-- ( +<fmt:formatNumber value="${po.optionPrice }"/>원 ) -->
                                    </c:forEach>
                                </select></li>
                            </ul>
                        </div>
                    </div>
                    <div class="flex-box">
                        <div class="info-title-box">
                            <a class="info-title">수량</a>
                        </div>
                        <div class="info-content">
                            <div class="product-view-volume">
                                <button type="button" class="minus-count">-</button>
                                <input type="text" name="pop_out" value="1" readonly="readonly" style="text-align:center;"/>
                                <button type ="button" class="plus-count">+</button>
                            </div>
                        </div>
                    </div>
                    <div class="flex-btn">
                        <div>
                            <div class="cart-btn">
                                <!-- <button type="button" id="put-in-cart-btn">장바구니 담기</button> -->
                                <span id="put-in-cart-btn" class="material-symbols-outlined" style="font-variation-settings:'FILL' 0">add_shopping_cart</span>
                            </div>
                        </div>
                        <div class="form-box">
                            <div class="one-btn">
                                <form action="/orderSheet.do" method="post">
                                    <input type="hidden" name="productNo">
                                    <input type="hidden" name="optionNo">
                                    <button class="btn btn-white size02">혼자구매하기</button>
                                    <input type="hidden" id="option-list-null" value="${optionList}">
                                    <input type="hidden" name="page" value="0">
                                </form>
                            </div>
                            <div class="moong-btn">
                                <form action="/moongsanOrder.do" method="post">
                                    <input type="hidden" name="productNo">
                                    <input type="hidden" name="optionNo">
                                    <input type="hidden" name="memberNo" value="${sessionScope.m.memberNo}">
                                    <button class="btn btn-pri size02">뭉쳐야산다</button>
                                    <input type="hidden" id="option-list-null" value="${optionList}">
                                    <input type="hidden" name="btnDivision" value="main">
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="gonggu-board-logo"><h3>뭉쳐야 산다!</h3></div>
        	<c:if test="${empty gongguList}">
        	<div class="gonggu-board">
        		<h6>현재 진행중인 공동구매가 없습니다</h6>
                <h6>뭉쳐야산다 버튼을 통해 공동구매를 진행해 보세요!</h6>
        	</div>
        	</c:if>
        	<c:if test="${gongguList ne null}">
            <div class="gonggu-board">
            <c:forEach items="${gongguList }" var="g">
            <div class="all-flex-wrap">
                <div class="left-flex-wrap">
                    <div class="user-img"><img src="/resources/upload/member/${g.memberPath}" style="width: 50px; height: 50px;"></div>
                    <div class="user-id"><a href="#">${g.memberId}</a></div>
                    <div class="gonggu-number">(${g.joinCount}/${g.totalCount})</div>
                    <input type="hidden" class="joinCount" value="${g.joinCount}">
                    <input type="hidden" class="totalCount" value="${g.totalCount}">
                </div>
                <div class="right-flex-wrap">
                    <div class="right-flex-info">
                        <div class="number-info">${g.totalCount - g.joinCount}명 <span>남음</span></div>
                    </div>
                    <c:if test="${sessionScope.m.memberId eq g.memberId }">
                    <form action="/updateGonggu.do" method="post">
                    <input type="hidden" name="gongguNo" value="${g.gongguNo}">
                    <input type="hidden" name="memberNo" value="${sessionScope.m.memberNo}">
                    <button type="submit" class="btn btn-pri size01" id="orderBtn">뭉산취소</button>
                    </form>
                    </c:if>
                    <c:if test="${sessionScope.m.memberId ne g.memberId }">
                        <div class="form-box">
                            <div>
                                <form action="/moongsanOrder.do" method="post" class="subMoongsanOrderBtn">
                                    <input type="hidden" name="productNo">
                                    <input type="hidden" name="optionNo">
                                    <input type="hidden" name="memberNo" value="${sessionScope.m.memberNo}">
                                    <button class="btn btn-pri size01" id="orderBtn">주문참여</button>
                                    <input type="hidden" id="option-list-null" value="${optionList}">
                                    <input type="hidden" name="gongguNo" value="${g.gongguNo}">
                                    <input type="hidden" name="btnDivision" value="sub">
                                </form>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>
        </c:forEach>
        </div>
        </c:if>
        
        
        <div class="quick-scroll-bar">
            <table>
                <tr>
                    <td><a href="#" class="product-info-btn">상품설명</a></td>
                    <td><a href="#" class="product-review-btn">리뷰보기</a></td>
                    <td><a href="#" class="product-inquiry-btn">문의하기</a></td>
                </tr>
            </table>
        </div>
        <div class="product-content-logo product-info-box"></div>
        <div class="product-content-wrap" style="border-bottom: 1px solid #e1e4e5;">
            ${p.productContent}
        </div>
        <div class="product-review-logo product-review"></div>
        <!-- <button type="button" id="insertReview" class="btn btn-pri size01" data-modal="#modalReview">리뷰하기</button> -->
        <div class="content-wrap" style="padding-top: 0;">
            <!-- <pre>
                남은 거 : 포토후기 더보기 > 상세보기 이미지 왜 바로 안뜨는지? 나중에 뜨는지?
            </pre>
                <h1>포토후기</h1>
                <!-- 최근 5개의 리뷰만 노출 -->
                <!-- <div class="photo-review-wrap">
                    <div class="photo-review-list">
                        <div class="photo-review-item">
                            <div class="photo-review-img">
                                <img src="/resources/img/review/banana_review1.jpg" />
                            </div>
                        </div>
                        <div class="photo-review-item">
                            <div class="photo-review-img">
                                <img src="/resources/img/review/banana_review2.jpg" />
                            </div>
                        </div>
                        <div class="photo-review-item">
                            <div class="photo-review-img">
                                <img src="/resources/img/review/banana_review3.jpg" />
                            </div>
                        </div>
                        <div class="photo-review-item">
                            <div class="photo-review-img">
                                <img src="/resources/img/review/banana_review3.jpg" />
                            </div>
                        </div>
                        <div class="photo-review-item">
                            <div class="photo-review-img">
                                <img src="/resources/img/review/banana_review3.jpg" />
                                <div class="photo-review-more" data-modal="#modal-photo-review-more">더보기</div>
                            </div>
                        </div>
                    </div>
                </div> -->
        
                <h2># 리뷰</h2>
                <div class="all-review-wrap">
                    <div class="review-header">
                        <!-- <div class="review-count">총 121건</div> -->
                        <!-- <div class="review-navi">
                            <div class="review-filter" data-modal="#modal-review-filter">
                                <span class="material-symbols-outlined">tune</span>
                                필터
                            </div>
                            <div class="review-range">
                                <span class="material-symbols-outlined">swap_vert</span>
                                정렬
                                <div class="review-range-view">
                                    <div class="review-range-thing">최신순</div>
                                    <div class="review-range-thing">인기순</div>
                                    <div class="review-range-thing">별점낮은순</div>
                                    <div class="review-range-thing">별점높은순</div>
                                </div>
                            </div>
                        </div> -->
                    </div>
                    <div class="review-mid">
                        <c:forEach items="${reviewList }" var="i">
                        <div class="review-box">
                            <div class="review-img">
                                <c:forEach items="${i.fileList }" var="f">
                                    <img src="/resources/upload/review/${f.filepath}" />
                                </c:forEach>
                            </div>
                            <div class="review-right">
                                <div class="review-info">
                                    <div class="review-rating">
                                        <!-- 리뷰 별점 -->
                                        <c:forEach var="index" begin="1" end="${i.rating}" step="1">
                                                <div class="material-symbols-outlined star-rate">star</div>
                                        </c:forEach>
                                        <c:if test="${ (i.rating*2) % 2 == 1 }">
                                            <div class="material-symbols-outlined star-rate">star_half</div>
                                        </c:if>
                                        <!-- <div class="rating-number">${i.rating}</div> -->
                                    </div>
                                    <div class="review-option">
                                        <div class="review-writer" style="padding-right: 20px; font-size: 12px; display: flex; align-items: center;">
                                            <div class="material-symbols-outlined" style="color: #9e9e9e; font-size: 20px; margin-right: 5px;">account_circle</div>
                                            <div>${i.reviewWriter}</div>
                                        </div>
                                        <div class="review-report" data-modal="#modal-report-btn">
                                            <span class="material-symbols-outlined">warning</span>
                                            <input type="hidden" id="reviewNoTest" value="${i.reviewNo}">
                                        </div>
                                        <div class="review-enroll-date">${i.reviewDate}</div>
                                    </div>
                                </div>
                                <div class="review-content">${i.reviewContent}</div>
                                <div class="review-like">
                                    <!-- <div> -->
                                        <input type="hidden" value="${i.rating}">
                                        <c:if test="${SessionScope.m.memberId eq i.reviewWriter }">
                                        	<form action="/deleteReview.do" method="post">
                                        		<button type="button" class="btn btn-pri size01">삭제</button>
                                        	</form>
                                        </c:if>
                                    <!-- </div> -->
                                </div>
                            </div>
                        </div> 
                    </c:forEach>
                      <!-- 신고하기 모달 -->
                <div id="modal-report-btn" class="modal modal-pri report-modal">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h6>리뷰 신고하기</h6>
                        </div>
                        <div class="modal-body">
                            <!--내용영역-->
                            <!-- <h5>내용타이틀</h5> -->
                            <!-- <form action="/test.do"> -->
                                <div class="report-form">
                                    <!-- 
                                        <label class="radio-container">
                                        <input type="radio" name="deli-address" id="member-address">
                                        <span class="custom-radio"></span>
                                        기본 배송지
                                        </label>
                                    -->
                                    <div>
                                        <label class="radio-container">
                                            <input type="radio" name="reportReason" value="1">
                                            <span class="custom-radio"></span>
                                            상품관련 비방 내용
                                        </label>
                                    </div>
                                    <div>
                                        <label class="radio-container">
                                            <input type="radio" name="reportReason" value="2">
                                            <span class="custom-radio"></span>
                                            음란, 욕설 등 부절적한 내용
                                        </label>
                                    </div>
                                    <div>
                                        <label class="radio-container">
                                            <input type="radio" name="reportReason" value="3">
                                            <span class="custom-radio"></span>
                                            개인, 판매자 상업적 홍보
                                        </label>
                                    </div>
                                    <div>
                                        <label class="radio-container">
                                            <input type="radio" name="reportReason" value="4">
                                            <span class="custom-radio"></span>
                                            상품과 관계없는 내용
                                        </label>
                                    </div>
                                    <div>
                                        <label class="radio-container">
                                            <input type="radio" name="reportReason" value="5">
                                            <span class="custom-radio"></span>
                                            개인정보 노출
                                        </label>
                                    </div>
                                    <div>
                                        <label class="radio-container">
                                            <input type="radio" name="reportReason" value="6">
                                            <span class="custom-radio"></span>
                                            저작권 불법도용(이미지,동영상)
                                        </label>
                                    </div>
                                    <div>
                                        <label class="radio-container">
                                            <input type="radio" name="reportReason" value="7">
                                            <span class="custom-radio"></span>
                                            상품 후기 취지에 어긋난 이용(복사글 등)
                                        </label>
                                    </div>
                                    <div>
                                        <label class="radio-container">
                                            <input type="radio" name="reportReason" value="8">
                                            <span class="custom-radio"></span>
                                            직접 입력
                                        </label>
                                    </div>
                                    <div>
                                        <textarea class="report-direct-input" name="reportContent" disabled></textarea>
                                    </div>
                                </div>
                            <!-- </form> -->
                            <!--//내용영역-->
                        </div>
                        <div class="area-btn center">
                            <input type="hidden" class="reviewNoVal">
                            <input type="hidden" name="memberNo" value="${sessionScope.m.memberNo}">
                            <a class="btn btn-pri size01 reviewReportBtn" type="button" id="review-filter-btn" rel="modal:close">확인</a>
                            <a rel="modal:close" class="btn btn-sec size01 report-modal-close">닫기</a>
                        </div>
                    </div>
                </div>
            </div>
                        <!-- <div class="review-box">
                            <div class="review-img">
                                <!-- <img src="/resources/img/product/lactofit.jpg" /> -->
                            <!-- </div>
                            <div class="review-right">
                                <div class="review-info">
                                    <div class="review-rating">
                                        <div class="material-symbols-outlined star-rate">star</div>
                                        <div class="material-symbols-outlined star-rate">star</div>
                                        <div class="material-symbols-outlined star-rate">star</div>
                                        <div class="material-symbols-outlined star-rate">star</div>
                                        <div class="material-symbols-outlined star-rate">star</div>
                                    </div>
                                    <div class="review-option">
                                        <div class="review-report" data-modal="#modal-report-btn">
                                            <span class="material-symbols-outlined">warning</span>
                                        </div>
                                        <div class="review-enroll-date">2023-04-03</div>
                                    </div>
                                </div>
                                <div class="review-content">이미지없는 리뷰입니다. 이미지없는 리뷰입니다. 이미지없는 리뷰입니다. 이미지없는 리뷰입니다. </div>
                                <div class="review-like">
                                    <div>
                                        <span class="material-symbols-outlined review-like-on">add_reaction</span>
                                        <span class="material-symbols-outlined">sentiment_very_satisfied</span>
                                        <a>도움이 돼요</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="review-box">
                            <div class="review-img">
                                <img src="/resources/img/product/lactofit.jpg" />
                            </div>
                            <div class="review-right">
                                <div class="review-info">
                                    <div class="review-rating">
                                        <div class="material-symbols-outlined star-rate">star</div>
                                        <div class="material-symbols-outlined star-rate">star</div>
                                        <div class="material-symbols-outlined star-rate">star</div>
                                        <div class="material-symbols-outlined star-rate">star</div>
                                        <div class="material-symbols-outlined star-rate">star</div>
                                    </div>
                                    <div class="review-option">
                                        <div class="review-report" data-modal="#modal-report-btn">
                                            <span class="material-symbols-outlined">warning</span>
                                        </div>
                                        <div class="review-enroll-date">2023-04-03</div>
                                    </div>
                                </div>
                                <div class="review-content">어쩌고 저쩌고 좋아요!! 어쩌고 저쩌고 좋아요!! 어쩌고 저쩌고 좋아요!! 어쩌고 저쩌고 좋아요!!</div>
                                <div class="review-like">
                                    <div>
                                        <span class="material-symbols-outlined review-like-on">add_reaction</span>
                                        <span class="material-symbols-outlined">sentiment_very_satisfied</span>
                                        <a>도움이 돼요</a>
                                    </div>
                                </div>
                            </div>
                        </div> -->
                    </div>
                </div>
        
        
        
        
                <div class="gonggu-content-wrap">
                    <div class="gonggu-content-title">
                    </div>
                    <div class="product-inquiry-logo product-inquiry"><h2># 문의사항</h2></div>
                    <div class="inquiry-box">
                        <table class="inquiry-table">
                            <tr>
                                <th>제목</th>
                                <th>작성자</th>
                                <th>작성일</th>
                                <th>답변상태</th>
                            </tr>
                            <c:forEach items="${iqList }" var="iq">
                                <tr> 
                                    <!-- 관리자 답글 조회시 필요한 문의사항 번호 추출용 -->
                                    <input type="hidden" value="${iq.inquiryNo}">
                                    <td class="inquiry-content-btn">${iq.inquiryTitle }</td>
                                    <td>${iq.inquiryWriter }</td>
                                    <td>${iq.inquiryDate }</td>
                                    <c:if test="${iq.inquiryStatus eq  0}">
                                        <td>답변대기</td>
                            </c:if>
                                <c:if test="${iq.inquiryStatus eq  1}">
                                    <td>답변완료</td>
                                </c:if>
                            </tr>
                            <tr class="inquiry-content" style="border: none;">
                                <td colspan="4" value="${iq.inquiryWriter}" style="text-align: left; border: none;"><span style="padding-right: 10px;"><img src="/resources/img/product/inquiryQ (2).png" style="width: 30px; height: 30px;"></span>${iq.inquiryContent}</td>
                            </tr>
                            <tr class="admin-content" style="border: none;">
                                
                            </tr>
                            <tr class="udBtn" style="border: none;">
                                <td colspan="4" style="border: none;">
                                    <div class="btn-flex-wrap">
                                        <!-- 문의사항 update에 사용할 inquiryNo를 위한 input -->
                                        <input type="hidden" id="inquiryNo" value="${iq.inquiryNo}">
                                        <!-- 문의사항 각 게시글의 첫번째 수정버튼 -->
                                        <c:choose>
                                            <c:when test="${sessionScope.m.memberId eq iq.inquiryWriter}">
                                                <button class="btn btn-pri size01 updateBtn" data-modal="#modalBasic">수정</button>
                                            </c:when>
                                            <c:when test="${sessionScope.m.memberStatus eq 0}">
                                                <button class="btn btn-pri size01 adminModal" data-modal="#adminModal">답글</button>
                                            </c:when>
                                        </c:choose>
                                        <!-- 문의사항 각 게시글의 첫번째 삭제버튼 -->
                                        <button class="btn btn-white size01" id="delBtn" data-modal="#modalDelete">삭제</button>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                    <div class="insertInquiry">
                        <!-- 문의하기 작성 버튼 -->
                        <button type="button" id="insertInquiry" class="btn btn-pri size01" data-modal="#modalBasic2">문의하기</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- 필터 모달 -->
        <div id="modal-review-filter" class="modal modal-sec">
            <div class="modal-content">
                <div class="modal-header">
                    <h6>상품 옵션</h6>
                </div>
                <div class="modal-body">
                    <!--내용영역-->
                    <!-- <h5>내용타이틀</h5> -->
                    <form action="/test.do">
                            <div class="selectBox-widht-explain">
                                <select class="select-custom review-color" id="review-color" style="margin-bottom: 30px;">
                                    <option value="0" selected>색상</option>
                                    <option value="white">White</option>
                                    <option value="black">Black</option>
                                </select>
                                <select class="select-custom review-size" id="review-size">
                                    <option value="0" selected>사이즈</option>
                                    <option value="240">240</option>
                                    <option value="245">245</option>
                                </select>
                            </div>
                    </form>
                    <!--//내용영역-->
                </div>
                <div class="area-btn center">
                    <a class="btn btn-pri size01" type="button" id="review-filter-btn" rel="modal:close">확인</a>
                    <a href="" rel="modal:close" class="btn btn-sec size01">닫기</a>
                </div>
            </div>
        </div>
        <!-- 포토후기 더보기 -->
        <div id="modal-photo-review-more" class="modal modal-pri">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h6>포토후기</h6>
                        </div>
                        <div class="modal-body">
                            <!--내용영역-->
                            <div class="photo-review-wrap">
                                <div class="photo-review-list">
                                    <div class="photo-review-item">
                                        <div class="photo-review-img" data-modal="#modal-photo-review-detail">
                                            <img src="/resources/img/review/banana_review1.jpg" />
                                        </div>
                                    </div>
                                    
                                </div>
                            </div>
                            <!--//내용영역-->
                        </div>
                    </div>
                </div>
        
                <!-- 포토후기 더보기 > 상세보기 -->
                <div id="modal-photo-review-detail" class="modal modal-pri">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h6>포토리뷰 상세보기</h6>
                        </div>
                        <div class="modal-body">
                            <!--내용영역-->
                            <div class="review-box">
                                <div class="review-img">
                                    <img src="/resources/img/review/banana_review1.jpg" />
                                    <img src="/resources/img/review/banana_review2.jpg" />
                                    <img src="/resources/img/review/banana_review3.jpg" />
                                </div>
                                <div class="review-right">
                                    <div class="review-info">
                                        <div class="review-rating">
                                            <div class="material-symbols-outlined star-rate">star</div>
                                            <div class="material-symbols-outlined star-rate">star</div>
                                            <div class="material-symbols-outlined star-rate">star</div>
                                            <div class="material-symbols-outlined star-rate">star</div>
                                            <div class="material-symbols-outlined star-rate">star_half</div>
                                        </div>
                                        <div class="review-option">
                                            <div class="review-report">
                                                <span class="material-symbols-outlined">warning</span>
                                            </div>
                                            <div class="review-enroll-date">2023-04-03</div>
                                        </div>
                                    </div>
                                    <div class="review-content">어쩌고 저쩌고 좋아요!! 어쩌고 저쩌고 좋아요!! 어쩌고 저쩌고 좋아요!! 어쩌고 저쩌고 좋아요!! 어쩌고 저쩌고 좋아요!! 어쩌고 저쩌고 좋아요!! 어쩌고 저쩌고 좋아요!! 어쩌고 저쩌고 좋아요!! 어쩌고 저쩌고 좋아요!! 어쩌고 저쩌고 좋아요!! 어쩌고 저쩌고 좋아요!! 어쩌고 저쩌고 좋아요!! 어쩌고 저쩌고 좋아요!! 어쩌고 저쩌고 좋아요!! 어쩌고 저쩌고 좋아요!! 어쩌고 저쩌고 좋아요!! 어쩌고 저쩌고 좋아요!! 어쩌고 저쩌고 좋아요!! 어쩌고 저쩌고 좋아요!! 어쩌고 저쩌고 좋아요!! 어쩌고 저쩌고 좋아요!! 어쩌고 저쩌고 좋아요!! 어쩌고 저쩌고 좋아요!! 어쩌고 저쩌고 좋아요!! 어쩌고 저쩌고 좋아요!! 어쩌고 저쩌고 좋아요!! 어쩌고 저쩌고 좋아요!! 어쩌고 저쩌고 좋아요!! 어쩌고 저쩌고 좋아요!! 어쩌고 저쩌고 좋아요!! 어쩌고 저쩌고 좋아요!! 어쩌고 저쩌고 좋아요!! 어쩌고 저쩌고 좋아요!! 어쩌고 저쩌고 좋아요!! 어쩌고 저쩌고 좋아요!! 어쩌고 저쩌고 좋아요!! 어쩌고 저쩌고 좋아요!! 어쩌고 저쩌고 좋아요!! 어쩌고 저쩌고 좋아요!! 어쩌고 저쩌고 좋아요!!어쩌고 저쩌고 좋아요!! 어쩌고 저쩌고 좋아요!! 어쩌고 저쩌고 좋아요!! 어쩌고 저쩌고 좋아요!!어쩌고 저쩌고 좋아요!! 어쩌고 저쩌고 좋아요!! 어쩌고 저쩌고 좋아요!! 어쩌고 저쩌고 좋아요!!</div>
                                    <div class="review-like">
                                        <div>
                                            <span class="material-symbols-outlined review-like-on">add_reaction</span>
                                            <span class="material-symbols-outlined">sentiment_very_satisfied</span>
                                            <a>도움이 돼요</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!--//내용영역-->
                        </div>
                        <div class="back-photo-review-more" data-modal="#modal-photo-review-more">
                            <span class="material-symbols-outlined">grid_view</span>
                            <div>사진 목록보기</div>
                        </div>
                    </div>
                </div>
              
     <!--리뷰작성 모달 시작-->
     <div id="modalReview" class="modal modal-pri" style="max-width: none;">
        <!-- <form action="/insertReview.do" method="post" enctype="multipart/form-data"> -->
        <div class="modal-content">
            <div class="modal-header">
                <h6>리뷰작성</h6>
            </div>
                <input type="hidden" name="reviewWriter" value="${sessionScope.m.memberId}">
                <input type="hidden" name="productNo" value="${p.productNo}">
            <div class="modal-body">
                <!--내용영역-->
                <div style="display: flex;">
                    <div>
                        <div id="root">
                            <h5>사진등록</h5>
                            <div class="contents">
                              <div class="upload-box">
                                <div id="drop-file" class="drag-file">
                                  <img src="https://img.icons8.com/pastel-glyph/2x/image-file.png" alt="파일 아이콘" class="image" >
                                  <p class="message">사진 드래그 업로드</p>
                                  <img src="" alt="미리보기 이미지" class="preview">
                                </div>
                                <label class="file-label" for="chooseFile">사진선택</label>
                                <input class="file" name="reviewFile" id="chooseFile" type="file" onchange="dropFile.handleFiles(this.files)" accept="image/png, image/jpeg, image/gif, image/jpg" multiple>
                              </div>
                            </div>
                          </div>
                        <!-- <input type="file" name="reviewFile" multiple onchange="readURL(this)"> -->
                        <!-- <img id="preview"> -->
                    </div>
                    <div style="width: 100%; margin-left: 10px;">
                        <div>
                        <fieldset class="rate" style="padding: 0;"><h5 style="padding-bottom: 10px;">별점</h5>
                            <input type="radio" id="rating10" name="rating" value="5"><label for="rating10" title="5점"></label>
                            <input type="radio" id="rating9" name="rating" value="4.5"><label class="half" for="rating9" title="4.5점"></label>
                            <input type="radio" id="rating8" name="rating" value="4"><label for="rating8" title="4점"></label>
                            <input type="radio" id="rating7" name="rating" value="3.5"><label class="half" for="rating7" title="3.5점"></label>
                            <input type="radio" id="rating6" name="rating" value="3"><label for="rating6" title="3점"></label>
                            <input type="radio" id="rating5" name="rating" value="2.5"><label class="half" for="rating5" title="2.5점"></label>
                            <input type="radio" id="rating4" name="rating" value="2"><label for="rating4" title="2점"></label>
                            <input type="radio" id="rating3" name="rating" value="1.5"><label class="half" for="rating3" title="1.5점"></label>
                            <input type="radio" id="rating2" name="rating" value="1"><label for="rating2" title="1점"></label>
                            <input type="radio" id="rating1" name="rating" value="0.5"><label class="half" for="rating1" title="0.5점"></label>
                        </fieldset>
                        </div>
                        <br>
                        <h5>리뷰내용</h5>
                        <textarea name="reviewContent" style="height:65%; "></textarea>
                    </div>
                </div>
            </div>
            <div class="area-btn right">
                <!-- class="btn btn-pri size01 reviewInsertBtn" id="reviewInsertBtn" -->
                <button type="submit" class="btn btn-sec size01">작성</button>
                <a href="" rel="modal:close" class="btn btn-sec size01">닫기</a>
            </div>
        </div>
    </form>
    </div>
     <!-- 문의사항 삭제 모달 시작 -->
     <div id="modalDelete" class="modal modal-pri">
        <div class="modal-content">
            <div class="modal-header">
                <h6>문의사항 삭제</h6>
            </div>
            <div class="modal-body">
                <!--내용영역-->
                <h5>문의사항을 삭제하시겠습니까?</h5>
                <p class="inquiry-modal-sub-info">⁕ 삭제된 문의사항은 저장되지 않으며 복구 할 수 없습니다.</p>
                <!--//내용영역-->
            </div>
            <div class="area-btn center">
                <button class="btn btn-pri size01 deleteButton" type="button">삭제</button>
                <a href="" rel="modal:close" class="btn btn-sec size01">닫기</a>
            </div>
        </div>
    </div>
    <!-- 문의사항 삭제 모달 끌 -->
    <!-- 문의사항 답글 모달 시작 -->
    <div id="adminModal" class="modal modal-pri">
        <div class="modal-content">
            <div class="modal-header">
                <h6>문의사항 답글</h6>
            </div>
            <div class="modal-body">
                <!--내용영역-->
                <h5>[<span class="userId"></span>]님의 문의내용</h5>
                <textarea name="userContent" readonly></textarea>
                <h5>답글내용 입력</h5>
                <textarea name="adminContent"></textarea>
                <input type="hidden" class="adminInquiryNo" value="">
            </div>
            <div class="area-btn right">
                <button class="btn btn-pri size01 adminInsert" type="button" id="adminInsert">답글</button>
                <a href="" rel="modal:close" class="btn btn-sec size01">닫기</a>
            </div>
        </div>
    </div>
    <!-- 문의사항 답글 모달 끌 -->
    <!-- 문의사항 수정 모달 시작 -->
    <div id="modalBasic" class="modal modal-pri">
        <div class="modal-content">
            <div class="modal-header">
                <h6>문의사항 수정</h6>
            </div>
            <div class="modal-body">
                <!--내용영역-->
                <h5>수정할 내용을 입력해 주세요.</h5>
                <textarea name="inquiryContent"></textarea>
                <input type="hidden" class="testNumber" valur="">
            </div>
            <div class="area-btn right">
                <button class="btn btn-pri size01 updateDoneBtn" type="button" id="modalUpdateBtn">수정완료</button>
                <a href="" rel="modal:close" class="btn btn-sec size01">닫기</a>
            </div>
        </div>
    </div>
    <!-- 문의사항 수정 모달 끌 -->
    <!-- 문의사항 작성 모달 시작 -->
    <div id="modalBasic2" class="modal modal-pri">
        <div class="modal-content">
            <div class="modal-header">
                <h6>문의사항 작성</h6>
            </div>
            <div class="modal-body">
                <!--내용영역-->
                <h5>문의사항을 작성해 주세요</h5>
                <p class="inquiry-modal-sub-info">⁕ 문의사항 수정은 답변대기 상태에서만 가능합니다.</p>
                <br>
                <h6>제목</h6>
                <input type="text" name="inquiryTitle">
                <h6>문의 내용</h6>
                <textarea name="inquiryContent1" style="height: 200px;"></textarea>
            </div>
            <div class="area-btn right">
                <button class="btn btn-pri size01 modalInsertBtn" type="button" id="modalInsertBtn">작성하기</button>
                <a href="" rel="modal:close" class="btn btn-sec size01">닫기</a>
            </div>
        </div>
    </div>
    <!-- 문의사항 작성 모달 끝 -->
<input type="hidden" id="productPrice" value="${p.productPrice}">
<input type="hidden" id="productDiscount" value="${p.productDiscount}">
<input type="hidden" id="loginMember" value="${sessionScope.m.memberNo}">
<input type="hidden" id="loginMemberId" value="${sessionScope.m.memberId}">
<input type="hidden" id="productNo" value="${p.productNo}">
<input type="hidden" id="likeNo" value="${l.likeNo}">
<!-- <input type="hidden" id="productContent" value="${p.productContent}"> -->


<c:forEach items="${reviewList }" var="i">
	${i.reviewContent }
</c:forEach>




<jsp:include page="/WEB-INF/views/common/footer.jsp" />




</body>
<script src="/resources/js/productView.js"></script>	
    	<!-- 슬릭 슬라이더 js -->
	<script type="text/javascript" src="/resources/slick/slick.min.js"></script>
    <!--리뷰js-->
    <script src="/resources/js/review.js"></script>
    <!-- 상품 상세 js -->

        <script>
            $(".review-report").children().on("click",function(){
                console.log($("#reviewNoTest").val());
                var reviewNoVal = $(this).next().val();
                $(".reviewNoVal").val(reviewNoVal);
            });
            //신고 insert
            $(".reviewReportBtn").on("click",function(){
                console.log("신고제출 작동");
                var reviewNo = $(".reviewNoVal").val();
                var memberNo = $("[name=memberNo]").val();
                var reportReason = $("input:radio[name=reportReason]:checked").val();
                if($("[name=reportContent]").val() == ''){
                    var reportContent = 0;
                } else {
                    var reportContent = $("[name=reportContent]").val();
                }
                console.log(reviewNo);
                console.log(memberNo);
                console.log(reportReason);
                console.log(reportContent);
                $.ajax({
                    url : "/insertReportAjax.do",
                    type : "post",
                    data : {reviewNo : reviewNo, memberNo:memberNo, reportReason : reportReason, reportContent : reportContent},
                    success : function(data){
                        if(data == 'success'){
                            insertReportAlert();
                        }
                    }
                    
                });
            });
            // 상품 옵션 select
            $( function() {
                $( ".product-option" ).selectmenu();
            });
            $( ".product-option" ).on("selectmenuchange", function(){
                console.log($(this).val());
            });

            // 장바구니 담기
            $("#put-in-cart-btn").on("click", function(){
                const productNo = $("#productNo").val();
                const optionNo = $( ".product-option" ).val();
                const cnt = $("[name=pop_out]").val();
                
                if(optionNo == 0 && $(".info-content").find("option").length > 1){
                    optionjQueryAlert('info'); 
                    // alert("옵션을 선택하세요");
                }else{
                    // alert 띄우고 insert -> OK 누르면 insert 되게 하기 위해 함수 생성해서 번호들 넘겨줌
                    jQueryAlert('warning',"", productNo, optionNo, cnt);
                }

            });
            function processResult(result, productNo, optionNo, cnt) {
                // 페이지 이동 및 db처리
                location.href="/putInShoppingCart.do?productNo="+productNo+"&optionNo="+optionNo+"&cnt="+cnt;
            }





            // 옵션 없는 상품은 출력 안함
            $(document).ready(function(){
                if($(".info-content").find("option").length == 1){
                    $(".option-list-box").hide();
                }
            });

            // 폼 제출
            $(".form-box>div>form").submit(function (e) {
                const productNo = $("#productNo").val();
                const optionNo = $( ".product-option" ).val();
                
                if(optionNo == 0 && $(".info-content").find("option").length > 1){
                    // 옵션 선택 안됐을 때 && 옵션이 있는 상품
                    optionjQueryAlert('info');
					// alert("옵션을 선택하세요");

					// 폼 제출 막음
					e.preventDefault();
                    return false;
                }else{
                    // 옵션이 없거나 옵션 선택된 경우 제출
                    $("[name=productNo]").val(productNo);
                    $("[name=optionNo]").val(optionNo);
                    // 수량
                    $("[name=page]").val($("[name=pop_out]").val());
                }
			});

            // 공동구매 폼 제출
            $(".moong-btn>form").submit(function (e) {

                const optionNo = $( ".product-option" ).val();

                if(Number($("[name=pop_out]").val()) != 1){
                    // 수량이 1이 아닐때
                    gongujQueryAlert('error'); // 수량 체크

                    e.preventDefault();
                    return false;
                }else{
                    // 수량이 1이면

                    if(optionNo == 0 && $(".info-content").find("option").length > 1){
                        // 옵션 선택 안됐을 때 && 옵션이 있는 상품

                        optionjQueryAlert('info'); // 옵션 체크

                        // 폼 제출 막음
                        e.preventDefault();
                        return false;
                    }else{
                        gonguTwojQueryAlert('error', this);

                        e.preventDefault();
                        return false;
                    }
                }
            });



            // 장바구니 담기시 성공 alert 띄우고 페이지 이동
            //알림 관련 기능
        // $(function () {
            // $("#alert01").on("click", function () {
            //     jQueryAlert('success',"성공내용성공내용성공내용");
            // });
            // $("#alert02").on("click", function () {
            //     jQueryAlert('error',"에러내용에러내용에러내용에러내용");
            // });
            // $("#put-in-cart-btn").on("click", function () {
            //     jQueryAlert('warning',"장바구니에 담았어요!");
            // });
            // $("#alert04").on("click", function () {
            //     jQueryAlert('info',"정보내용정보내용정보내용정보내용");
            // });

            function jQueryAlert(type, msg, p, o, c) {
                let $type = type;
                let messageBox = msg;
                switch ($type) {
                    // case 'success':
                    // messageBox = $.parseHTML('<div class="alert__success"></div>');
                    // break;
                    // case 'error':
                    // messageBox = $.parseHTML('<div class="alert__error"></div>');
                    // break;
                    case 'warning':
                    messageBox = $.parseHTML('<div class="alert__warning" style="line-height:100px;text-align:center;"><div class="title" style="margin-bottom:10px;color:var(--primary);padding:0;">뭉쳐야산다</div><br>장바구니에 담으시겠습니까?</div>');
                    break;
                }
                $("body").append(messageBox);
                $(messageBox).dialog({
                    dialogClass :$type,
                    open: $(messageBox).append(msg),
                    draggable: false,
                    modal: true,
                    buttons: [
                        {
                            text: "담기",
                            style: "margin-right:5px",
                            click: function(){
                                $(this).dialog("close");

                                // OK 버튼 눌렀을 때 insert 하기 위해 콜백함수 실행
                                processResult(true, p, o, c);
                            }
                        },
                        {
                            text: "취소",
                            click: function(){
                                $(this).dialog("close");
                            }
                        }
                    ],
                    show: {
                        effect: 'fade',
                        duration: 200 //at your convenience
                    },
                    hide: {
                        effect: 'fade',
                        duration: 200 //at your convenience
                    }
                });
            };



            // 옵션 선택 안됐을때 alert
            function optionjQueryAlert(type) {
                let $type = type;
                // let messageBox = msg;
                switch ($type) {
                    case 'info':
                    messageBox = $.parseHTML('<div class="alert__info" style="line-height:100px;text-align:center;"><div class="title" style="margin-bottom:10px;color:var(--info);padding:0;">뭉쳐야산다</div><br>옵션을 선택해주세요!</div>');
                    break;
                }
                $("body").append(messageBox);
                $(messageBox).dialog({
                    dialogClass :$type,
                    // open: $(messageBox).append(msg),
                    draggable: false,
                    modal: true,
                    buttons: {
                        "닫기": function () {
                            $(this).dialog("close");
                        }
                    },
                    show: {
                        effect: 'fade',
                        duration: 200 //at your convenience
                    },
                    hide: {
                        effect: 'fade',
                        duration: 200 //at your convenience
                    }
                });
            };


            // 공동구매 (뭉산) 수량 1개만 가능하므로 그 이외를 입력했을때
            function gongujQueryAlert(type) {
                let $type = type;
                // let messageBox = msg;
                switch ($type) {
                    case 'error':
                    messageBox = $.parseHTML('<div class="alert__error" style="text-align:center;"><div class="title" style="margin-bottom:10px;color:var(--error);padding:0;">뭉쳐야산다</div><div style="margin: 50px auto;"><div>공동구매 제품은 1인 1개 구매제한 입니다.</div><div style="margin-top:10px;">수량을 1개만 선택해주세요 !</div></div></div>');
                    break;
                }
                $("body").append(messageBox);
                $(messageBox).dialog({
                    dialogClass :$type,
                    // open: $(messageBox).append(msg),
                    draggable: false,
                    modal: true,
                    buttons: {
                        "닫기": function () {
                            $(this).dialog("close");
                        }
                    },
                    show: {
                        effect: 'fade',
                        duration: 200 //at your convenience
                    },
                    hide: {
                        effect: 'fade',
                        duration: 200 //at your convenience
                    }
                });
            };

            // 공동구매 진행시 기본 alert
            function gonguTwojQueryAlert(type, form) {
                let $type = type;
                // let messageBox = msg;
                switch ($type) {
                    // case 'success':
                    // messageBox = $.parseHTML('<div class="alert__success"></div>');
                    // break;
                    // case 'error':
                    // messageBox = $.parseHTML('<div class="alert__error"></div>');
                    // break;
                    case 'error':
                    messageBox = $.parseHTML('<div class="alert__error" style="text-align:center;"><div class="title" style="margin-bottom:10px;color:var(--error);padding:0;">뭉쳐야산다</div><div style="margin-bottom: 50px;margin-top: 20px;"><h6 style="margin-bottom:40px;">< 공동구매 안내 ></h6><div>상품하단에 위치한 뭉쳐야산다 게시판에서 <button type="button" class="btn btn-pri size01" style="display:inline-block;cursor:auto;">주문참여</button><br>버튼 클릭시 더욱 빠르게 배송받아보실수 있습니다.</div><div style="margin-top:20px;">진행 버튼 클릭시 뭉쳐야산다 게시글이 생성됩니다.</div></div></div>');
                    break;
                }
                $("body").append(messageBox);
                $(messageBox).dialog({
                    dialogClass :$type,
                    // open: $(messageBox).append(msg),
                    draggable: false,
                    modal: true,
                    width: 500,
                    buttons: [
                        {
                            text: "진행",
                            style: "margin-right:5px",
                            click: function(){
                                $(this).dialog("close");

                                form.submit();
                            }
                        },
                        {
                            text: "취소",
                            click: function(){
                                $(this).dialog("close");
                            }
                        }
                    ],
                    show: {
                        effect: 'fade',
                        duration: 200 //at your convenience
                    },
                    hide: {
                        effect: 'fade',
                        duration: 200 //at your convenience
                    }
                });
            };




            // 주문 수량 증감
            $(".product-view-volume>button").on("click", function(){
                let inputCount = $(this).parent().find("input[name='pop_out']");
                let inputCountVal = Number(inputCount.val());
                // 상품 재고
                const productEa = 10;

                if($(this).hasClass("plus-count")){
                    if(inputCountVal < productEa){
                        inputCount.val(Number(inputCountVal)+1).trigger('change');
                    }
                }else{
                    if(inputCountVal > 1 ){
                        inputCount.val(Number(inputCountVal)-1).trigger('change');
                    }
                }
            });


            // 리뷰 등록 시간 떼기
            $(function () {
                const date = $(".review-enroll-date");

                console.log(date.length);
                for(let i=0;i<date.length;i++){
                    $(".review-enroll-date").eq(i).text(date.eq(i).text().substring(0, 10));
                }

            });
            
            
            // 관리자 상품 삭제
            $("#adminProductDelete").submit(function (e) {
                const productNo = $("#productNo").val();

				// 폼 제출 막음
				e.preventDefault();
				
				productDeleteAlert('error', this);
				
			});
			
         	// 상품 삭제 alert
    		function productDeleteAlert(type, form) {
    		let $type = type;
    		switch ($type) {
    			case 'error':
    			messageBox = $.parseHTML('<div class="alert__error" style="text-align:center;"><div class="title" style="margin-bottom:10px;color:var(--error);padding:0;">뭉쳐야산다</div><div style="margin: 50px auto;"><div style="margin-top:10px;">관리자 권한으로 선택한 상품을 삭제하시겠습니까?</div></div></div>');			
    			break;
    		}
    		$("body").append(messageBox);
    		$(messageBox).dialog({
    			dialogClass :$type,
    			// open: $(messageBox).append(msg),
    			draggable: false,
    			modal: true,
    			width: 400,
    			buttons: [
    				{
    					text: "삭제",
    					style: "margin-right:5px",
    					click: function(){
    						$(this).dialog("close");

    						form.submit();
    					}
    				},
    				{
    					text: "취소",
    					click: function(){
    						$(this).dialog("close");
    					}
    				}
    			],
    			show: {
    				effect: 'fade',
    				duration: 200 //at your convenience
    			},
    			hide: {
    				effect: 'fade',
    				duration: 200 //at your convenience
    			}
    		});
    	};

        </script>
        
</html>