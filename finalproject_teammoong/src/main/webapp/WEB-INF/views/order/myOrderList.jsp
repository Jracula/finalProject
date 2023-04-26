<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 구매내역</title>
    <!--productView.css-->
    <link rel="stylesheet" href="/resources/css/member/myOrderList.css">
</head>

<body>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<div class="content-wrap">
		<div class="mypage-wrap">
		
		<jsp:include page="/WEB-INF/views/common/myPageMenu.jsp" />
		
		<div class="mypage-right">
			<div class="mypage-right-title">내 구매내역</div>
			<div class="mypage-content">
				<!-- 단일상품 / 여러상품일때 구분 필요 -->

				<!-- foreach -->
				<div class="myorder-order-item">
					<div class="myorder-product-count">
						<div class="myorder-order-status">결제완료</div>
						<!-- <div style="height: 15px;"></div> -->
					</div>
					<div class="myorder-product-img">
						<a href="/productView.do?productNo=${i.productNo}">
							<img src="/resources/upload/product/${i.thumbnail }" />
						</a>
						<div class="ab-product-count">
							<span>8</span>
						</div>
					</div>
					<div class="myorder-order-title-box">
						<div class="myorder-product-title">
							<a href="/productView.do?productNo=${i.productNo}">
								<!-- ${i.productName } -->
								[4월 한정 파격특가][우리동네과일가게]저탄소 GAP 파파야멜론 750g (2입) 
							</a>
						</div>
						<!-- <div class="myorder-product-option">
							${i.optionDetailName }
							푸실리 파스타
						</div> -->
					</div>
					<!-- <div class="myorder-product-volume">
						${i.basketCount}
					</div> -->
					<div class="myorder-total-price">총 50,000 원</div>
					<div class="myorder-order-info">
						<div class="myorder-order-date">2023/04/25</div>
						<div class="myorder-product-total-count">총 8건</div>
						<div class="myorder-order-detail">
							<form action="/myOrderView.do">
								<button id="order-detail-btn">주문상세<div class="material-symbols-outlined">chevron_right</div></button>
							</form>
						</div>
						
					</div>
				</div>
				
				<div class="myorder-order-item">
					<div class="myorder-product-count">
						<!-- <div>총 8건</div> -->
						<!-- <div style="height: 20px;"></div> -->
						<div class="myorder-order-status">배송준비중</div>
						<!-- <div style="height: 15px;"></div> -->
					</div>
					<div class="myorder-product-img">
						<a href="/productView.do?productNo=${i.productNo}">
							<img src="/resources/upload/product/${i.thumbnail }" />
						</a>
						<!-- <div class="ab-product-count">
							<span>8</span>
						</div> -->
					</div>
					<div class="myorder-order-title-box">
						<div class="myorder-product-title">
							<a href="/productView.do?productNo=${i.productNo}">
								<!-- ${i.productName } -->
								[4월 한정 파격특가][우리동네과일가게]저탄소 GAP 파파야멜론 750g (2입) 
							</a>
						</div>
						<!-- <div class="myorder-product-option">
							${i.optionDetailName }
							푸실리 파스타
						</div> -->
					</div>
					<!-- <div class="myorder-product-volume">
						${i.basketCount}
					</div> -->
					<div class="myorder-total-price">50,000 원</div>
					<div class="myorder-order-info">
						<div class="myorder-order-date">2023/04/25</div>
						<div class="myorder-order-detail">
							<form action="#">
								<button id="order-detail-btn">주문상세<div class="material-symbols-outlined">chevron_right</div></button>
							</form>
						</div>
					</div>
				</div>


			</div>
		</div>
	</div>
	
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>