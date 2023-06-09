package moo.ng.san.order.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import moo.ng.san.coupon.model.vo.IssueCoupon;
import moo.ng.san.dayCheck.model.vo.Point;
import moo.ng.san.order.model.dao.OrderDao;
import moo.ng.san.order.model.vo.Order;
import moo.ng.san.pay.model.vo.OrderDetail;
import moo.ng.san.product.model.vo.Product;

@Service
public class OrderService {
	@Autowired
	private OrderDao dao;

	public ArrayList<IssueCoupon> selectMemberCouponList(int memberNo) {
		
		return dao.selectMemberCouponList(memberNo);
	}

	public int selectMemberCouponCount(int memberNo) {
		
		return dao.selectMemberCouponCount(memberNo);
	}

	public ArrayList<Order> selectOrderProductList(int memberNo, int[] productNo, int[] optionNo, int page) {
		
		ArrayList<Order> list = new ArrayList<Order>();
		
		
		for(int i=0;i<productNo.length;i++) {
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("productNo", productNo[i]);
			map.put("optionNo", optionNo[i]);
			map.put("memberNo", memberNo);
			map.put("page", page);

			
			if(optionNo[i] != 0 && page == 0) {
				// 장바구니에 한 상품의 여러 옵션이 있을때
				int basketNo = dao.selectBasketNo(map);
				map.put("basketNo", basketNo);
			}
			
			Order o = dao.selectOrderProductList(map);
			
			list.add(o);
		}
		
//		System.out.println("service : "+list);
		return list;
	}
	
	public ArrayList<Order> selectMoongsanOrderProductList(int[] productNo, int[] optionNo) {
		
		ArrayList<Order> list = new ArrayList<Order>();
		
		
		for(int i=0;i<productNo.length;i++) {
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("productNo", productNo[i]);
			map.put("optionNo", optionNo[i]);
			
			Order o = dao.selectMoongsanOrderProductList(map);
			
			list.add(o);
		}
		
//		System.out.println("service : "+list);
		return list;
	}

	public int insertOrder(int memberNo, int totalPrice, String deliReceiver, String deliPhone, String deliAddr1, String deliRequest, int orderPrice, int issueNo) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("memberNo", memberNo);
		map.put("totalPrice", totalPrice);
		map.put("deliReceiver", deliReceiver);
		map.put("deliPhone", deliPhone);
		map.put("deliAddr1", deliAddr1);
		map.put("orderPrice", orderPrice);
		map.put("deliRequest", deliRequest);
		map.put("issueNo", issueNo);
		
		return dao.insertOrder(map);
	}

	public int selectMaxOrderNo() {
		return dao.selectMaxOrderNo();
	}

	public int insertOrderDetail(int orderNo, int[] productNo, int[] optionInfoNo, int[] orderDetailCnt,
			int[] orderDetailCost, int[] orderSalePrice, int memberNo) {
		
		int result = 0;
		
		for(int i=0;i<productNo.length;i++) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			map.put("orderNo", orderNo);
			map.put("productNo", productNo[i]);
			map.put("optionInfoNo", optionInfoNo[i]);
			map.put("orderDetailCnt", orderDetailCnt[i]);
			map.put("orderDetailCost", orderDetailCost[i]);
			map.put("orderSalePrice", orderSalePrice[i]);
			
			result += dao.insertOrderDetail(map);
			
			// 방금 주문한 상품 -> 장바구니에 있으면 삭제
			map.put("memberNo", memberNo);
			int result2 = dao.deleteCartbyProductNo(map);
			System.out.println("장바구니 삭제.. " + result2);
		}
		
		return result;
	}

	public ArrayList<Order> selectMyOrderList(int memberNo) {
		
		return dao.selectMyOrderList(memberNo);
	}
	
	public Order selectMyOrderDetail(int orderNo) {
		
		return dao.selectMyOrderDetail(orderNo);
	}

	public ArrayList<Order> selectMyOrderProductList(int orderNo) {
		
		return dao.selectMyOrderProductList(orderNo);
	}

	public String selectDoneCouponPrice(int orderNo) {
		
		return dao.selectDoneCouponPrice(orderNo);
	}

	public int updateOrderStatusConfirm(int orderNo) {
		
		return dao.updateOrderStatusConfirm(orderNo);
	}

	public ArrayList<Product> selectReviewCheckList(int orderNo) {
		
		return dao.selectReviewCheckList(orderNo);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//////////////// 진배님
	
	
	public int insertMinusPointEa(Point point) {
		int result = dao.insertMinusPointEa(point);
		return result;
	}

	public int insertPlusPointEa(Point point) {
		int result = dao.insertPlusPointEa(point);
		return result;
	}

	public int updateCoupon(int issueNo) {
		int result = dao.updateCoupon(issueNo);
		return result;
	}

	public ArrayList<OrderDetail> selectOrderDetail(int orderNo) {
		ArrayList<OrderDetail> orderDetailList = dao.selectOrderDetail(orderNo);
		return orderDetailList;
	}

	public String selectProduct(int productNo) {
		String productName = dao.selectProduct(productNo);
		return productName;
	}

	public Order selectOrder(int orderNo) {
		Order order = dao.selectOrder(orderNo);
		return order;
	}

	public int cancelOrder(int orderNo, int memberNo) {
		int result = dao.cancelOrder(orderNo);
		if(result>0) {
			int minusPoint = dao.selectMinusPoint(orderNo);
			Point point = new Point();
			point.setMemberNo(memberNo);
			point.setOrderNo(orderNo);
			if(minusPoint != 0) {
				point.setPointEa(minusPoint);
				result = dao.insertRetunPointEa(point);
			}
			int plusPoint = dao.selectPlusPoint(orderNo);
			if(result >0) {
				if(plusPoint != 0) {
					point.setPointEa(plusPoint);
					result = dao.insertPaybackPointEa(point);					
				}
				if(result>0) {
					Order order = dao.selectOrder(orderNo);
					int issueNo = order.getIssueNo();
					if(issueNo != 0) {
						result = dao.cancelCoupon(issueNo); 
					}					
				}
			}
		}
		return result;
	}



}
