package moo.ng.san.order.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.google.gson.Gson;

import moo.ng.san.basket.model.vo.Basket;
import moo.ng.san.coupon.model.service.CouponService;
import moo.ng.san.coupon.model.vo.IssueCoupon;
import moo.ng.san.dayCheck.model.vo.Point;
import moo.ng.san.gonggu.model.vo.Gonggu;
import moo.ng.san.member.model.service.MemberService;
import moo.ng.san.member.model.vo.Member;
import moo.ng.san.order.model.service.OrderService;
import moo.ng.san.order.model.vo.Order;
import moo.ng.san.pay.model.vo.OrderDetail;
import moo.ng.san.product.model.service.ProductService;
import moo.ng.san.product.model.vo.Product;

@Controller
public class OrderController {
	@Autowired
	private OrderService service;
	@Autowired
	private MemberService memberService;
	@Autowired
	private ProductService productService;
	
	@RequestMapping(value="/orderSheet.do")
	public String orderSheet(int[] productNo, int[] optionNo, int page, @SessionAttribute(required=false) Member m, Model model) {
		// 세션에서 가져옴
		int memberNo = m.getMemberNo();
		
		model.addAttribute("page", page);
		
		// 뷰 page : 상품 하나의 수량들 , 장바구니 : 0 
		// 구매하려는 상품 조회 (배열)
		ArrayList<Order> orderProductList = service.selectOrderProductList(m.getMemberNo(), productNo, optionNo, page);
		model.addAttribute("orderProductList", orderProductList);
		
//		System.out.println(orderProductList);
		
		// 보유 쿠폰 개수
		int couponCount = service.selectMemberCouponCount(memberNo);
		model.addAttribute("couponCount", couponCount);
		// 보유 쿠폰 리스트
		ArrayList<IssueCoupon> couponList = service.selectMemberCouponList(memberNo);
		model.addAttribute("couponList",couponList);
		
		// 현재 적립금 조회
		Point point = memberService.selectTotalPoint(memberNo);
		model.addAttribute("point", point);
		
		return "order/orderSheet";
	}
	
	@RequestMapping(value="/moongsanOrder.do")
	public String moongsanOrder(int[] productNo, int[] optionNo, @SessionAttribute(required=false) Member m, Model model, String btnDivision, Gonggu g) {
			
			// 세션에서 가져옴
			int memberNo = m.getMemberNo();
			
			// 구매하려는 상품 조회 (배열)
			ArrayList<Order> orderProductList = service.selectMoongsanOrderProductList(productNo, optionNo);
			model.addAttribute("orderProductList", orderProductList);
			
//		System.out.println(orderProductList);
			
			// 보유 쿠폰 개수
			int couponCount = service.selectMemberCouponCount(memberNo);
			model.addAttribute("couponCount", couponCount);
			// 보유 쿠폰 리스트
			ArrayList<IssueCoupon> couponList = service.selectMemberCouponList(memberNo);
			model.addAttribute("couponList",couponList);
			
			// 현재 적립금 조회
			Point point = memberService.selectTotalPoint(memberNo);
			model.addAttribute("point", point);
			
			//버튼구분 보내기
			model.addAttribute("btnDivision",btnDivision);
			model.addAttribute("g",g);
			
			return "order/moongsanOrder";
			
	}

	@RequestMapping(value="/myOrderList.do")
	public String myOrderList(@SessionAttribute(required=false) Member m, Model model) {
		
		// 주문 내역 리스트
		ArrayList<Order> myOrderList = service.selectMyOrderList(m.getMemberNo());
		model.addAttribute("myOrderList", myOrderList);
		
		
		return "order/myOrderList";
	}
	
	@RequestMapping(value="/myOrderDetail.do")
	public String myOrderDetail(int orderNo, Model model) {
		
		// 주문 테이블 주문 상세
		Order o = service.selectMyOrderDetail(orderNo);
		model.addAttribute("o", o);
		
		// 구매한 상품 리스트
		ArrayList<Order> orderProductList = service.selectMyOrderProductList(orderNo);
		model.addAttribute("orderProductList", orderProductList);
		
		// 사용한 쿠폰 가격
		String couponPrice = service.selectDoneCouponPrice(orderNo);
		model.addAttribute("couponPrice", couponPrice);
		
		return "order/myOrderDetail";
	}
	
	// 주문내역 상품리스트 모달 ajax
	@ResponseBody
	@RequestMapping(value="/myOrderProductList.do", produces = "application/json;charset=utf-8")
	public String myOrderProductList(int orderNo) {
		
		// 구매한 상품 리스트
		ArrayList<Order> orderProductList = service.selectMyOrderProductList(orderNo);
//		model.addAttribute("orderProductList", orderProductList);
		
		return new Gson().toJson(orderProductList);
	}
	
	
//	주문하기
	@RequestMapping(value="/order.do")
	public String order(@SessionAttribute(required=false) Member m, 
			int totalPrice, int issueNo, int minusPointEa, int plusPointEa, String deliReceiver, String deliPhone, String deliAddr1, String deliAddr2, String deliRequest
			, int[] productNo, int[] optionInfoNo, int[] orderDetailCnt, int[] orderDetailCost, int[] orderSalePrice, int orderPrice, Model model) {
		
		String deliAddr = deliAddr1+deliAddr2;
		// 오더 테이블엔 상품 번호 필요 없을 듯
		int result = service.insertOrder(m.getMemberNo(), totalPrice, deliReceiver, deliPhone, deliAddr, deliRequest, orderPrice, issueNo);
		
		if(result>0) {
			
			// order detail
			// 최근 insert된 orderNo
			int orderNo = service.selectMaxOrderNo();
			
			
			// 주문내역에 금액관련 두개 있어야할 듯 1. 실 결제금액 -> 적립금/쿠폰 금액 들어간 totalPrice 2. 주문서당 총 상품금액 (할인가) OrderPrice
			result = service.insertOrderDetail(orderNo, productNo, optionInfoNo, orderDetailCnt, orderDetailCost, orderSalePrice, m.getMemberNo());
			
			if(result> (productNo.length-1)) {
				Point point = new Point();
				point.setMemberNo(m.getMemberNo());
				point.setOrderNo(orderNo);;
				
				if(minusPointEa != 0) {
					point.setPointEa(minusPointEa);
					System.out.println("minusPointEa : "+point.getPointEa());
					result = service.insertMinusPointEa(point);					
				}
				if(issueNo !=0) {
					result = service.updateCoupon(issueNo);
				}
				point.setPointEa(plusPointEa);
				System.out.println("plusPointEa : "+point.getPointEa());
				result = service.insertPlusPointEa(point);
			}

		}
		int orderNo = service.selectMaxOrderNo();
		return "redirect:/payComplite.do?orderNo=" + orderNo + "&productNo=" + Arrays.toString(productNo).replaceAll("[\\[\\]\\s]", "");

	}
	
	@RequestMapping(value="/orderConfirm.do")
	public String orderConfirm(int orderNo) {
		
		// 배송중, 배송완료 -> 구매확정 상태 변경
		int result = service.updateOrderStatusConfirm(orderNo);
		
		if(result>0) {
			System.out.println("구매확정 성공");
		}else {
			System.out.println("구매확정 실패");
		}
		
		return "redirect:/myOrderDetail.do?orderNo="+orderNo;
	}
	
	@ResponseBody
	@RequestMapping(value="/reviewCheck.do", produces = "application/json;charset=utf-8")
	public String reviewCheck(int orderNo) {
		
		// 리뷰 썼는지 체크 ajax
		ArrayList<Product> reviewCheckList = service.selectReviewCheckList(orderNo);
		
		return new Gson().toJson(reviewCheckList);
	}


	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	///////////// 진배님
	
	@RequestMapping(value="/payComplite.do")
	public String payComplite(int orderNo, int productNo[], Model model) {
		
		Order order = service.selectOrder(orderNo);
		ArrayList<OrderDetail> orderDetailList = service.selectOrderDetail(orderNo);
		System.out.println(productNo.length);
		int orderCnt = (productNo.length -1);
		String productName = service.selectProduct(productNo[0]);
		
		model.addAttribute("orderDetailList", orderDetailList);
		model.addAttribute("order",order);
		model.addAttribute("orderCnt",orderCnt);
		model.addAttribute("productName",productName);
		return "order/payComplite";
	}
	
	@ResponseBody
	@RequestMapping(value="/payCancel.do")
	public String payCancel(int orderNo, int memberNo) {
		int result = service.cancelOrder(orderNo, memberNo);
		if(result>0) {
			return "success";
		}else {
			return "error";
		}
		
	}
	
}
