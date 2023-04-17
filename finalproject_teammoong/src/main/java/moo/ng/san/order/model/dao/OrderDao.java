package moo.ng.san.order.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import moo.ng.san.coupon.model.vo.IssueCoupon;
import moo.ng.san.order.model.vo.Order;

@Repository
public class OrderDao {
	@Autowired
	private SqlSessionTemplate sqlSession;

	public ArrayList<IssueCoupon> selectMemberCouponList(int memberNo) {
		List list = sqlSession.selectList("order.selectMemberCouponList", memberNo);
		
		return (ArrayList<IssueCoupon>) list;
	}

	public int selectMemberCouponCount(int memberNo) {
		int couponCount = sqlSession.selectOne("order.selectMemberCouponCount", memberNo);
		
		return couponCount;
	}

	public Order selectOrderProductList(HashMap<String, Object> map) {
		Order o = sqlSession.selectOne("order.selectOrderProductList", map);
		
		return o;
	}


}