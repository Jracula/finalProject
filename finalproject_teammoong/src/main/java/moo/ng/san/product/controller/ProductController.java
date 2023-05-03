package moo.ng.san.product.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import common.FileManager;
import moo.ng.san.basket.model.vo.Basket;
import moo.ng.san.board.model.service.BoardService;
import moo.ng.san.board.model.vo.Board;
import moo.ng.san.category.model.vo.Category;
import moo.ng.san.category.model.vo.DetailCategory;
import moo.ng.san.gonggu.model.service.GongguService;
import moo.ng.san.gonggu.model.vo.Gonggu;
import moo.ng.san.gonggu.model.vo.GongguAllInfo;
import moo.ng.san.inquiry.model.service.InquiryService;
import moo.ng.san.inquiry.model.vo.Inquiry;
import moo.ng.san.member.model.vo.Member;
import moo.ng.san.product.model.service.ProductService;
import moo.ng.san.product.model.vo.FileVO;
import moo.ng.san.product.model.vo.Option;
import moo.ng.san.product.model.vo.Product;
import moo.ng.san.product.model.vo.ProductPageData;
import moo.ng.san.product.model.vo.RecentProduct;
import moo.ng.san.product.model.vo.searchBarVO;
import moo.ng.san.review.model.service.ReviewService;
import moo.ng.san.review.model.vo.Review;

@Controller
public class ProductController {
	@Autowired
	private ProductService service;
	@Autowired
	private FileManager fileManager;
	@Autowired
	private InquiryService iqService;
	@Autowired
	private GongguService gongguService;
	@Autowired
	private ReviewService reviewService;
	@Autowired
	private BoardService boardService;
	
	
	
	
	
	
	
	
//	규린작업공간 20~100
	
	@RequestMapping(value="/photoReviewMore.do")
	public String photoReviewMore() {
		return "product/photoReviewMore";
	}
	
	@RequestMapping(value="/productList.do")
	public String productList(int category, Model model, @SessionAttribute(required=false) Member m) {
		// reqPage cateogory
		// 상위 누르면 상위이름 + 하위는 전체 및 상위에 해당하는 모든 하위카테고리
		// 하위 누르면 상위이름 + 해당 하위 이름 및 상위에 해당하는 모든 하위카테고리
		
		System.out.println("카테고리 : " + category);
		
		
		////////// 카테고리 계산 //////////
		int fCategory = 0;
		int sCategory = 0;
		// 11 12 13 14 25 26 27 28 29 210 211 212 313 314 .. 1058 ..1066
		if (category > 10000) {
			// 상위 카테고리 (하위 카테고리 전체)
			fCategory = category % 10000;
//			sCategory = 10000;
			System.out.println("상위 카테고리 : "+fCategory+" 하위 카테고리 : "+sCategory);
		} else if (category > 100) {
			// 네 자리 이상면
			fCategory = category / 100; // 2 3 4 5 6 .. 10 11 12 13
			sCategory = category - fCategory * 100;
			System.out.println("상위 카테고리 : "+fCategory+" 하위 카테고리 : "+sCategory);
		}else {
			// 두 자리면
			fCategory = category / 10;
			sCategory = category % 10;
			System.out.println("상위 카테고리 : "+fCategory+" 하위 카테고리 : "+sCategory);
		}
		
		
		
		// 카테고리별 상품리스트
//		ArrayList<Product> list = service.selectInfiniteScrollProductList(1, 3, fCategory, sCategory, "recent-sort");
		// 하위 카테고리 리스트
		ArrayList<DetailCategory> detailCategoryList = service.selectCategoryNameOnList(fCategory);
		// 해당 카테고리의 총 상품 수
		int totalCount = service.selectProductCount(fCategory, sCategory);
		// 해당 하위 카테고리의 상위 카테고리 이름
		
		
		model.addAttribute("fCategory", fCategory);
		model.addAttribute("sCategory", sCategory);
//		model.addAttribute("list", list);
		model.addAttribute("detailCategoryList", detailCategoryList);
		model.addAttribute("totalCount", totalCount);
		
//		System.out.println(list);
//		System.out.println(detailCategoryList);
		
		
		// 상위 카테고리 페이지일때 해당 카테고리의 인기 상품 리스트
		ArrayList<Product> bestProductList = service.selectBestProductList(fCategory);
		model.addAttribute("bestProductList", bestProductList);
		
		// 최근 본 상품 select
		selectRecentProduct(m, model);
		
		return "product/productList";
	}
	
	@ResponseBody
	@RequestMapping(value="/productMore.do", produces = "application/json;charset=utf-8")
	public String productMore(int start, int amount, int fCategoryNo, int sCategoryNo, String sortType) {
		//start : startHidden, amount : 3, detailCategoryNo: sCategoryNo
		//ProductPageData ppd
		
//		ProductPageData ppd = new ProductPageData();
//		ppd.setStart(start);
//		ppd.setAmount(amount);
//		ppd.setDetailCategoryNo(sCategory1);
		
		System.out.println("sCategoryNo : "+sCategoryNo);
		System.out.println(sortType);
		
		ArrayList<Product> list = service.selectInfiniteScrollProductList(start, amount, fCategoryNo, sCategoryNo, sortType);
		
		System.out.println(list);
		
		return new Gson().toJson(list);
	}
	
	
	
	// 장바구니
	@RequestMapping(value="/shoppingCart.do")
	public String shoppingCart(@SessionAttribute(required=false) Member m, Model model) {
		// 세션에서 가져옴
		int memberNo = m.getMemberNo();
		
		// 장바구니 리스트
		ArrayList<Basket> basketList = service.selectBasketList(memberNo);
		model.addAttribute("basketList", basketList);
		
		if(basketList.size() == 0) {
			System.out.println(basketList);			
		}else {
			System.out.println(basketList+"!!");
		}
		
		return "product/shoppingCart";
	}
	
	
		
	@RequestMapping(value="/putInShoppingCart.do")
	public String putInShoppingCart(int productNo, String optionNo, int cnt, @SessionAttribute(required=false) Member m) {
		// 세션에서 가져옴
		int memberNo = m.getMemberNo();
		
		// 옵션 있으면 옵션 값, 없으면 0
		int optionNumber = Integer.parseInt(optionNo);
				
		// 장바구니 담기 전에 이미 있는 상품과 옵션인지 체크.. 옵션까지 확인해야함
		// 이미 있으면 수량 불러와서 +1, 없으면 insert
		Basket b = service.selectBasketCount(memberNo, productNo, optionNumber);
		
		// 장바구니에 없을때
		if(b == null) {
			// 장바구니 담기
			int result = service.insertShoppingCart(memberNo, productNo, cnt);
			
			if(result>0 && optionNumber != 0) {
				// 옵션이 있는 상품은 장바구니 옵션 테이블에 insert
				
				// 옵션 그룹 넘버 조회
				int optionGroupNo = service.selectOptionGroupNo(productNo);			
				// 최근에 insert된 장바구니 번호(max)
				int recentBasketNo = service.selectRecentBasketNo();
				
				// 장바구니 옵션 테이블 insert
				result = service.insertShoppingCartOption(recentBasketNo, optionGroupNo, optionNumber);
			}
		}else {
			// 현재 수량 + cnt
			int result = service.updateBasketCount(b.getBasketNo(), cnt);
			
			if(result>0) {
				return "redirect:/productView.do?productNo="+productNo;
			}else {
				return "redirect:/";
			}
			
		}
		
		
		
		return "redirect:/productView.do?productNo="+productNo;
	}

	
	// 최근 본 상품 select 콜백
	public void selectRecentProduct(Member m, Model model) {
		if(m != null) {			
			ArrayList<RecentProduct> recentProductList = service.selectRecentProductList(m.getMemberNo());
			model.addAttribute("recentProductList", recentProductList);
		}
	}
	
	
	// 인기 상품 리스트
	@RequestMapping(value="/bestProductList.do")
	public String bestProductList(String categoryNo, Model model, @SessionAttribute(required=false) Member m) {
//		System.out.println("categoryNo : "+categoryNo);
		
		// 카테고리 리스트
		ArrayList<Category> categoryList = service.selectCategoryList();		
		model.addAttribute("categoryList", categoryList);		
		
		int iCategoryNo = 0;
		if(categoryNo != null) {
			iCategoryNo = Integer.parseInt(categoryNo);			
		}
		
		// 인기 상품 리스트
		ArrayList<Product> bestProductList = service.selectBestProductList(iCategoryNo);
		model.addAttribute("bestProductList", bestProductList);
		
		// 카테고리 구분
		model.addAttribute("sCategory", iCategoryNo);

		// 최근 본 상품 select
		selectRecentProduct(m, model);
		
		return "product/bestProductList";
	}
	
	
	// 장바구니 삭제
	@RequestMapping(value="/deleteCart.do")
	public String deleteCart(int[] basketNo) {
		
		int result = service.deleteCart(basketNo);
		
		if(result == basketNo.length) {
			return "redirect:/shoppingCart.do";
		}else {
			return "redirect:/";
		}		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
//	명훈작업공간 120~200
	
	@RequestMapping(value="/insertProductFrm.do")
	public String insertProductFrm() {
		return "product/insertProductFrm";
	}
	
	@RequestMapping(value="/insertProduct.do")
	public String insertProduct(Product p, MultipartFile[] productFile, HttpServletRequest request) {
		ArrayList<FileVO> fileList = new ArrayList<FileVO>();
		if(!productFile[0].isEmpty()) {
			String savePath = request.getSession().getServletContext().getRealPath("resources/upload/product/");
			for(MultipartFile file : productFile) {
				String filepath = fileManager.upload(savePath, file);
				FileVO fileVO = new FileVO();
				fileVO.setFilepath(filepath);
				fileList.add(fileVO);
			}
		}
		int result = service.insertProduct(p, fileList);
		if(result == (fileList.size()+1)) {
			return "redirect:/insertProductFrm.do";
		} else {
			return "redirect:/insertProductFrm.do";
		}
	}
	@RequestMapping(value="/productView.do")
	public String productView(Product product, int productNo, Model model, @SessionAttribute(required=false) Member m) {
		System.out.println("productController에서 product값"+product);
		Product p = service.selectProductByProductNo(productNo);
		ArrayList<Inquiry> list = iqService.selectInquiryList(productNo);
	
		model.addAttribute("p",p);
		model.addAttribute("iqList", list);
		
//		 명훈이임
		ArrayList<GongguAllInfo> gongguList = gongguService.selectGongguList(productNo);
		System.out.println("productController에서 gongguList값 :"+gongguList);
//		for (int i = 0; i<gongguList.size(); i++) {
//			System.out.println("productController에서 gongguList값 :"+gongguList.get(i).getGongguNo());
//			int cnt = gongguService.selectGongguPayCount(gongguList.get(i).getGongguNo());
//			gongguList.get(i).setUseCnt(cnt);
//			System.out.println("productController에서 cnt값 :"+cnt);
			System.out.println("productController에서 gongguList값 :"+gongguList);
//		}
		//리뷰리스트
		ArrayList<Review> reviewList = reviewService.selectReviewListByProductNo(productNo);
		model.addAttribute("reviewList",reviewList);
		model.addAttribute("gongguList",gongguList);
		// 옵션 조회 (규린)
		ArrayList<Option> optionList = service.selectOptionList(productNo);
		model.addAttribute("optionList", optionList);
		
//		System.out.println("optionList : " + optionList);
		
		
		if(m!=null) {
			int memberNo = m.getMemberNo();
		
			// 중복 있는 지 select 하고 있으면 delete
			int result = service.selectUniqueRecentProduct(memberNo, productNo);
			
//			System.out.println("최근 본 상품 delete 결과 : "+result);
			
			// 최근 본 상품 insert
			result = service.insertRecentProduct(memberNo, productNo);
			
//			System.out.println("최근 본 상품 insert 결과 : "+result);
		}
		
		
		// 최근 본 상품 select
		selectRecentProduct(m, model);
//		if(m != null) {			
//			ArrayList<RecentProduct> recentProductList = service.selectRecentProductList(m.getMemberNo());
//			model.addAttribute("recentProductList", recentProductList);
//		}
		
		
		return "product/productView";			
	}
	@GetMapping("/main.do")
	public String selectProductList(Model model, @SessionAttribute(required=false) Member m) {
		
		// (임시) 상품리스트
		ArrayList<Product> productList = service.selectProductList();
		model.addAttribute("productList",productList);
		
		// 인기 상품 리스트
		ArrayList<Product> bestProductList = service.selectBestProductList(0);
		model.addAttribute("bestProductList", bestProductList);

		// 최근 본 상품 select
		selectRecentProduct(m, model);
		
		// 핫딜
		
		// 재고 없는 상품 리스트
		ArrayList<Product> soldOutList = service.selectSoldOutProductList();
		model.addAttribute("soldOutList", soldOutList);
		
		// 할인률 높은 상품 리스트
		ArrayList<Product> highSaleList = service.selectHighSaleProductList();
		model.addAttribute("highSaleList", highSaleList);
		
		// 2인 공동구매
		ArrayList<Product> gongguTwoList = service.selectgongguNumberProductList(2);
		model.addAttribute("gongguTwoList", gongguTwoList);
		
		// 5인 공동구매
		ArrayList<Product> gongguFiveList = service.selectgongguNumberProductList(5);
		model.addAttribute("gongguFiveList", gongguFiveList);
		
		// 식품 카테고리 상품 리스트
		ArrayList<Product> category3List = service.selectCategoryProductList(3);
		model.addAttribute("category3List", category3List);
		
		// 공동구매 진행
		
		
		return "common/main";
	}
	@RequestMapping(value="/uploadSummernoteImageFile.do", produces = "application/json; charset=utf8")
	@ResponseBody
	public String uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile, HttpServletRequest request )  {
		JsonObject jsonObject = new JsonObject();
		
        /*
		 * String fileRoot = "C:\\summernote_image\\"; // 외부경로로 저장을 희망할때.
		 */
		
		// 내부경로로 저장
		String contextRoot = new HttpServletRequestWrapper(request).getRealPath("/");
		String fileRoot = contextRoot+"resources/productContentImg/";
		
		String originalFileName = multipartFile.getOriginalFilename();	//오리지날 파일명
		String extension = originalFileName.substring(originalFileName.lastIndexOf("."));	//파일 확장자
		String savedFileName = UUID.randomUUID() + extension;	//저장될 파일 명
		
		File targetFile = new File(fileRoot + savedFileName);	
		try {
			InputStream fileStream = multipartFile.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, targetFile);	//파일 저장
			jsonObject.addProperty("url", "/resources/productContentImg/"+savedFileName); // contextroot + resources + 저장할 내부 폴더명
			jsonObject.addProperty("responseCode", "success");
				
		} catch (IOException e) {
			FileUtils.deleteQuietly(targetFile);	//저장된 파일 삭제
			jsonObject.addProperty("responseCode", "error");
			e.printStackTrace();
		}
		String a = jsonObject.toString();
		return a;
	}
	@RequestMapping(value="/searchBar.do")
	public String searchBar(searchBarVO sb, Model model) {
		
		System.out.println("productController에서 sb 값"+sb);
		System.out.println("productController에서 searchKeyword 값 : "+sb.getSearchKeyword());
		
		if(sb.getSelectBox() == 1) {
			
			ArrayList<Product> productList = service.searchProductList(sb);
			model.addAttribute("searchBox",sb.getSelectBox());
			model.addAttribute("sk",sb.getSearchKeyword());
			model.addAttribute("productList",productList);
			
		} else if(sb.getSelectBox() == 2) {
			
			ArrayList<Board> boardList = boardService.searchBoardList(sb);
			model.addAttribute("searchBox",sb.getSelectBox());
			model.addAttribute("sk",sb.getSearchKeyword());
			model.addAttribute("boardList",boardList);
			
			return "board/searchBoardList";
			
		}
		return "product/searchProductList";
	}

	
}
