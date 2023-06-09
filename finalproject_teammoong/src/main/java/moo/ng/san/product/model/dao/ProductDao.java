package moo.ng.san.product.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import moo.ng.san.basket.model.vo.Basket;
import moo.ng.san.board.model.vo.Board;
import moo.ng.san.category.model.vo.Category;
import moo.ng.san.category.model.vo.DetailCategory;
import moo.ng.san.product.model.vo.FileVO;
import moo.ng.san.product.model.vo.Option;
import moo.ng.san.product.model.vo.Product;
import moo.ng.san.product.model.vo.RecentProduct;
import moo.ng.san.product.model.vo.searchBarVO;

@Repository
public class ProductDao {
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Transactional
	public int insertProduct(Product p) {
		int result = sqlSession.insert("product.insertProduct",p);
		return result;
	}

	public int selectProductNo() {
		int productNo = sqlSession.selectOne("product.selectProductNo");
		return productNo;
	}
	@Transactional
	public int insertFile(FileVO file) {
		int result = sqlSession.insert("product.insertFile",file);
		return result;
	}

	public Product selectProductByProductNo(int productNo) {
		Product p = sqlSession.selectOne("product.selectProductByProductNo", productNo);
		return p;
	}

	public ArrayList<String> selectProductImg(int productNo) {
		List list = sqlSession.selectList("product.selectProductImg",productNo);
		return (ArrayList<String>)list;
	}

	public ArrayList<Product> selectProductList() {
		List list = sqlSession.selectList("product.selectProductList");
		return (ArrayList<Product>)list;
	}


	public ArrayList<String> selectProductFiles(int productNo) {
		List list = sqlSession.selectList("product.selectProductFilelist",productNo);
		return (ArrayList<String>)list;
	}
	
	
	
	
	
	
	
	
	
//	규린작업공간 20~100
	
	public ArrayList<Product> selectInfiniteScrollProductList(HashMap<String, Object> map) {
		List list = sqlSession.selectList("product.selectInfiniteScrollProductList", map);
		
		return (ArrayList<Product>)list;
	}

	public ArrayList<DetailCategory> selectCategoryNameOnList(int fCategory) {
		List list = sqlSession.selectList("category.selectCategoryNameOnList", fCategory);
		
		return (ArrayList<DetailCategory>)list;
	}

	public int selectProductCount(HashMap<String, Object> map) {
		
		int totalCount = sqlSession.selectOne("product.selectProductCount", map);
		
		return totalCount;
	}

	public ArrayList<Option> selectOptionList(int productNo) {
		List list = sqlSession.selectList("product.selectOptionList", productNo);
		
		return (ArrayList<Option>)list;
	}

	public int insertShoppingCart(HashMap<String, Object> map) {
		int result = sqlSession.insert("product.insertShoppingCart", map);
		
		return result;
	}

	public int selectOptionGroupNo(int productNo) {
		int optionGroupNo = sqlSession.selectOne("product.selectOptionGroupNo", productNo);
		
//		System.out.println("Dao의 optionGroupNo : "+optionGroupNo);
		
		return optionGroupNo;
	}

	public int selectRecentBasketNo() {
		int recentBasketNo = sqlSession.selectOne("product.selectRecentBasketNo");
		
		return recentBasketNo;
	}

	public int insertShoppingCartOption(HashMap<String, Object> map) {
		int result = sqlSession.insert("product.insertShoppingCartOption", map);
		
		return result;
	}

	public ArrayList<Basket> selectBasketList(int memberNo) {
		List list = sqlSession.selectList("product.selectBasketList", memberNo);
		
		return (ArrayList<Basket>)list;
	}

	public int insertRecentProduct(HashMap<String, Object> map) {
		int result = sqlSession.insert("product.insertRecentProduct", map);
		
		return result;
	}

	public ArrayList<RecentProduct> selectRecentProductList(int memberNo) {
		List list = sqlSession.selectList("product.selectRecentProductList", memberNo);
		
		return (ArrayList<RecentProduct>)list;
	}

	public RecentProduct selectUniqueRecentProduct(HashMap<String, Object> map) {
		RecentProduct rp = sqlSession.selectOne("product.selectUniqueRecentProduct", map);
		
		return rp;
	}

	public int deletRecentProduct(HashMap<String, Object> map) {
		int result = sqlSession.insert("product.deleteRecentProduct", map);
		
		return result;
	}

	public Basket selectBasketCount(HashMap<String, Object> map) {
		Basket b = sqlSession.selectOne("product.selectBasketCount", map);
		
		return b;
	}

	public int updateBasketCount(HashMap<String, Object> map) {
		int result = sqlSession.update("product.updateBasketCount", map);
		
		return result;
	}

	public int deleteCart(int no) {
		int result = sqlSession.delete("product.deleteCart", no);
		
		return result;
	}

	public ArrayList<Category> selectCategoryList() {
		
		List list = sqlSession.selectList("category.selectCategoryList");
		
		System.out.println("dao : "+list);
		
		return (ArrayList<Category>)list;
	}

	public ArrayList<Product> selectBestProductList(HashMap<String, Object> map) {
		List list = sqlSession.selectList("product.selectBestProductList", map);
		
		return (ArrayList<Product>)list;
	}

	public ArrayList<Product> selectHighSaleProductList() {
		List list = sqlSession.selectList("product.selectHighSaleProductList");
		
		return (ArrayList<Product>)list;
	}

	public ArrayList<Product> selectSoldOutProductList() {
		List list = sqlSession.selectList("product.selectSoldOutProductList");
		
		return (ArrayList<Product>)list;
	}

	public ArrayList<Product> searchProductList(searchBarVO sb) {
		List list = sqlSession.selectList("product.searchProductList",sb);
		return (ArrayList<Product>)list;
	}

	public ArrayList<Board> searchBoardList(searchBarVO sb) {
		// TODO Auto-generated method stub
		return null;
	}

	public ArrayList<Product> selectgongguNumberProductList(int i) {
		List list = sqlSession.selectList("product.selectgongguNumberProductList",i);
		return (ArrayList<Product>)list;
	}

	public ArrayList<Product> selectCategoryProductList(int i) {
		List list = sqlSession.selectList("product.selectCategoryProductList",i);
		return (ArrayList<Product>)list;
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
//	명훈작업공간 120~200
}
