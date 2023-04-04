<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>여기여기붙어라</title>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="/resources/demos/style.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>제이쿼리 위젯 달력 사용하기</title>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="/resources/demos/style.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script>

	function previewImage(event) {
		var reader = new FileReader();
		reader.onload = function() {
		var output = document.createElement('img');
		output.src = reader.result;
		output.style.maxWidth = '250px';
		output.style.maxHeight = '250px';
		document.querySelector('.image-preview').innerHTML = '';
		document.querySelector('.image-preview').appendChild(output);
		};
		reader.readAsDataURL(event.target.files[0]);
	}

    $( function() {
      $( "#datepicker" ).datepicker({
         dateFormat:"yy-mm-dd"
      });     
    } );
    </script>
	<link rel="stylesheet" href="/resources/css/board/boardWriteFrm.css" />
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" /> 
	<div class="content-wrap">
		<div class="content-board-wrap">
		                <form action="/boardWrite.do" method="get">
		                <table class="writeFrm-input-wrap">
		                	<tr>
		                		<td colspan="4">
		                			<input type="hidden" name="boardWriter" value="${sessionScope.m.memberId }">
		                		</td>
		                	</tr>
		                	<tr>
		                		<td colspan="4">
									<div class="board-wrap">
										<div class="boardFile-wrap">
											<input type="file" name="file" id="file" onchange="previewImage(event)">
											<div class="image-preview"></div>
											<label for="file">
												<div class="btn-upload">썸네일 이미지 등록</div>
											</label>
										</div>
									</div>
								</td>
		                	</tr>
		                	<tr>
		                		<td colspan="4">폼제목<sup>*</sup></td>
		                	</tr>
		                	<tr>
		                        <td colspan="4"><input type="text" name="boardName" class="mid-input" id="title" required></td>
		                    <tr>
		                    <tr>
		                    	<td colspan="4">카테고리<sup>*</sup></td>
		                    </tr>
		                    <tr>
		                    	<td colspan="4">
		                    		<input type="radio" name="categoryNo" id="c" value="1">
		                        	<label for="c">의류</label>
		                        	<input type="radio" name="categoryNo" id="f" value="2">
		                        	<label for="f">음식</label>
		                        	<input type="radio" name="categoryNo" id="t" value="3">
		                        	<label for="t">완구</label>
		                    	</td>
		                    </tr>
		                    <tr>
		                        <td colspan="4">계좌정보<sup>*</sup></td>
		                    </tr>
		                    <tr>
		                        <td colspan="1">이름</td>
		                        <td colspan="1">은행정보</td>
		                        <td colspan="2">계좌번호</td>
		                    </tr>
		                    <tr>
			                    <td>
			                        <input type="text" name="accountName" required>
			                    </td>
			                    <td>
			                        <select class="selec-custom" name="accountBank">
			                            <option value="bank1">은행명 선택</option>
			                            <option value="bank2">NH농협은행</option>
			                            <option value="bank3">KB국민은행</option>
			                            <option value="bank4">신한은행</option>
			                            <option value="bank5">우리은행</option>
			                            <option value="bank6">하나은행</option>
			                            <option value="bank7">IBK기업은행</option>
			                            <option value="bank8">부산은행</option>
			                            <option value="bank9">경남은행</option>
			                            <option value="bank10">대구은행</option>
			                            <option value="bank11">우체국</option>
			                            <option value="bank12">새마을금고</option>
			                            <option value="bank13">SC제일은행</option>
			                            <option value="bank14">광주은행</option>
			                            <option value="bank15">수협</option>
			                            <option value="bank16">전북은행</option>
			                            <option value="bank17">신협은행</option>
			                            <option value="bank18">제주은행</option>
			                            <option value="bank19">케이뱅크</option>
			                            <option value="bank20">카카오뱅크</option>
			                            <option value="bank21">토스뱅크</option>
			                            <option value="bank22">카카오뱅크(미성년자)</option>
			                            <option value="bank23">토스뱅크(미성년자)</option>
			                            <option value="bank24">씨티은행</option>
			                            <option value="bank25">KDB산업</option>
			                            <option value="bank26">은행 정보 없음</option>
			                        </select>
			                    </td>
			                    <td colspan="2">
			                        <input type="text" name="accountWriter" required >
			                    </td>
			                </tr>
		                    <tr>
		                        <td colspan="4">판매기간<sup>*</sup></td>
		                    </tr>
		                    <tr>
		                        <td colspan="2">폼 시작일</td>
		                        <td colspan="2">종료일</td>
		                    </tr>
		                    <tr>
			                    <td colspan="2">
			                        <!-- <input type="text" id="datepicker"  placeholder="폼 시작일" required> -->
			                        <input type="text" id="form-start" placeholder="폼 시작일" name="boardStart" required>
			                    </td>
			                    <td colspan="2">
			                        <!-- <input type="text" id="datepicker"  placeholder="폼 종료일" required> -->
			                        <input type="text" id="form-end" placeholder="폼 종료일" name="boardEnd" required>
			                    </td>
			                </tr>
			                <tr>
		                        <td colspan="4">상세설명<sup>*</sup></td>
		                    </tr>
		                    <tr>
		                        <td colspan="4">
		                            <textarea name="boardContent" required></textarea>
		                        </td>
		                    </tr>
		                    <tr>
		                        <td colspan="4">상세정보입력<sup>*</sup><span>재고를 제외한 상품 정보는 구매 발생 전까지만 수정 가능합니다.</span></td>
		                    </tr>
		                    <tr>
		                        <td colspan="4">상품명<input type="text" id="goods-name" name="detailName"  placeholder="상품명을 입력해 주세요" required></td>
		                    </tr>
		                    <tr>
		                        <td colspan="4">가격<input type="text" id="goods-price" name="detailPrice" placeholder="가격을 입력해 주세요" required></td>
		                    </tr>
		                    <tr>
		                        <td colspan="4">재고<input type="text" id="goods-count" name="detailCount" placeholder="재고를 입력해 주세요" required></td>
		                    </tr>
		                    <tr>
		                        <td colspan="4">판매 상품 리스트<span>(총 1개의 상품)</span></td>
		                    </tr>
		                    <tr>
		                        <td colspan="4"><input type="text" id="goods-name" name="boardPrice" placeholder="상품명" >원</td>
		                    </tr>
		                    <tr>
		                        <td colspan="4">공구 사이트 링크</td>
		                    </tr>
		                    <tr>
		                        <td colspan="4"><input type="text" id="site-link" name="referenceLink" placeholder="공구 사이트 링크"></td>
		                    </tr>
		                    <tr>
		                        <td colspan="4">배송 예정일<sup>*</sup></td>
		                    </tr>
		                    <tr>
		                        <!-- <td><input type="text" id="datepicker"  placeholder="배송을 보낼 날짜를 선택해 주세요." required></td> -->
		                        <td colspan="4"><input type="text" id="delivery-date" name="deliveryDate" placeholder="배송을 보낼 날짜를 선택해 주세요." required></td>
		                    </tr>
		                    <tr>
		                        <td colspan="4">기타 문의사항</td>
		                    </tr>
		                    <tr>
		                        <td colspan="4"><input type="text" id="etc-content" name="boardEtc"  placeholder="문의사항 필요한 경우 작성해 주세요."></td>
		                    </tr>
		                    
		                </table>
		                    <input type="submit" value="폼만들기">
		            </form>
				</div>
		    </div>
</body>
</html>