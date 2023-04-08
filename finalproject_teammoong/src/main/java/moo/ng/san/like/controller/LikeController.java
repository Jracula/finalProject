package moo.ng.san.like.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import moo.ng.san.like.model.service.LikeService;
import moo.ng.san.like.model.vo.Like;

@Controller
public class LikeController {
	@Autowired
	private LikeService service;
	
	@ResponseBody
	@RequestMapping(value="/productLike.do", method=RequestMethod.POST, produces = "application/json; charset=utf8")
	public String productLike(Like like) {
		int result = service.insertLike(like);
		return "ok";
	}
	@ResponseBody
	@RequestMapping(value="/selectProductLike.do", method=RequestMethod.POST, produces = "application/json; charset=utf8")
	public Like selectProductLike(Like l) {
		System.out.println("likeController like값 : "+l);
		Like like = service.selectProductLike(l);
		return like;
	}
}
