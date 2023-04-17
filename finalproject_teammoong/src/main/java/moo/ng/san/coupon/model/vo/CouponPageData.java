package moo.ng.san.coupon.model.vo;

import java.util.ArrayList;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CouponPageData {
	private ArrayList<IssueCoupon> couponList;
	private String pageNavi;
}
