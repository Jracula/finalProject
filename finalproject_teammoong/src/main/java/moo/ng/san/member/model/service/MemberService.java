package moo.ng.san.member.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import moo.ng.san.board.model.dao.BoardDao;
import moo.ng.san.board.model.vo.Board;
import moo.ng.san.board.model.vo.BoardJoin;
import moo.ng.san.board.model.vo.BoardOrder;
import moo.ng.san.board.model.vo.BoardPageData;
import moo.ng.san.dayCheck.model.vo.Point;
import moo.ng.san.member.model.dao.MemberDao;
import moo.ng.san.member.model.vo.Member;
import moo.ng.san.member.model.vo.Out;

@Service
public class MemberService {

	@Autowired
	private MemberDao dao;
	@Autowired
	private JavaMailSender mailSender;
	
	
	public Member selectOneMember(Member member) {
		return dao.selectOneMember(member);
	}//selectOneMember

	
	public Member selectOneMember(String memberId) {
		return dao.selectOneMember(memberId);
	}//아이디 중복확인을 위한
	
	@Transactional
	public int insertMember(Member m) {
		int result = 0;
		result = dao.insertMember(m);
		if(result>0) {
			result += dao.insertFirstPoint(m);
		}
		return result;
	}//insertMember

	public Point selectTotalPoint(int memberNo) {
		return dao.selectTotalPoint(memberNo);
	}

	@Transactional
	public int updateMember(Member member) {
		return dao.updateMember(member);
	}
	
	
	@Transactional
	public int updateNewPwMember(Member member) {
		return dao.updateNewPwMember(member);
	}

	
	public String sendMail(String memberEmail) {
		
		//★인증을 위한 랜덤코드 생성
		//영어 소문자+영어 대문자+숫자 = 8자리
		Random r = new Random();
		StringBuffer code = new StringBuffer();
		for(int i=0 ; i<8 ; i++) {
			// 0 ~ 9 : r.nextInt(10); // 0부터 [매개변수]까지의 개수 중 랜덤한 수 하나
			// A ~ Z : (char)(r.nextInt(26)+65); //알파벳 26개, 아스키코드 시작번호 65번부터.
			// a ~ Z : (char)(r.nextInt(26)+97);
			
			int flag = r.nextInt(3); //0,1,2
				if(flag==0) {
					//0~9
					int randomNumber = r.nextInt(10);
					code.append(randomNumber);
				}else if(flag==1) {
					//A~Z
					char randomChar = (char)(r.nextInt(26)+65);
					code.append(randomChar);
				}else if(flag==2) {
					//a~z
					char randomChar = (char)(r.nextInt(26)+97);
					code.append(randomChar);
				}
		}//8바퀴 돌아서 8자리
		
		
		String subject = "뭉쳐야산다 인증코드";
		String content = "<h2>안녕하세요. 뭉쳐야산다입니다.<br>비밀번호 인증코드:<br>"+code+"</h2>";
		String from = "janetcode65@gmail.com";
		String to = memberEmail;
		
		try {
			
			MimeMessage mail = mailSender.createMimeMessage();
			MimeMessageHelper mailHelper = new MimeMessageHelper(mail, true, "UTF-8");
			
			/*
			 * 단순한 텍스트 메세지만 사용시엔 아래의 코드도 사용 가능 MimeMessageHelper mailHelper = new
			 * MimeMessageHelper(mail,"UTF-8");
			 */

			mailHelper.setFrom("뭉쳐야산다 <"+from+">");
			// 빈에 아이디 설정한 것은 단순히 smtp 인증을 받기 위해 사용 따라서 보내는이(setFrom())반드시 필요
			// 보내는이와 메일주소를 수신하는이가 볼때 모두 표기 되게 원하신다면 아래의 코드를 사용하시면 됩니다.
			// mailHelper.setFrom("보내는이 이름 <보내는이 아이디@도메인주소>");
			mailHelper.setTo(to);
			mailHelper.setSubject(subject);
			mailHelper.setText(content, true);
			// true는 html을 사용하겠다는 의미입니다.

			/*
			 * 단순한 텍스트만 사용하신다면 다음의 코드를 사용하셔도 됩니다. mailHelper.setText(content);
			 */

			mailSender.send(mail);

		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// true는 멀티파트 메세지를 사용하겠다는 의미
		
		return code.toString();
		
	}//sendMail

	

	public int processOutMember(Out o) {
		int result = dao.insertOutReason(o);
		if(result>0) {
			result += dao.updateMemberStatus(o.getMemberId());
		}
		return result;
	}//processOutMember


	
	
	
	
	
	
	public BoardPageData selectMyWriteList(int reqPage, String memberId) {
				// 한 페이지당 보여줄 게시물 수 : 5
				int numPerPage = 5;
				int end = reqPage * numPerPage;
				int start = end - numPerPage + 1;
				//계산된 start, end를 가지고 게시물 목록 조회
				HashMap<String, Object> map = new HashMap<String, Object>();
				map.put("start", start);
				map.put("end", end);
				map.put("memberId", memberId);
				ArrayList<Board> list = dao.selectMyBoardList(map);
				
				//pageNavi 제작시작
				//전체페이지 수 계산필요 -> 전체 게시물 수 조회
				int totalCount = dao.selectBoardCount(memberId);
				//전체게시물로 전체페이지수 계산
				int totalPage = (int)Math.ceil(totalCount/(double)numPerPage);
				//페이지 네비 사이즈
				int pageNaviSize = 5;
				
				int pageNo =1;
				if(reqPage>3) {
					pageNo = reqPage-2;
				}
				//페이지네비 생성시작
				String pageNavi = "";
				//이전버튼
				if(pageNo != 1) {
					pageNavi +="<a href='/boardList.do?reqPage="+(pageNo-1)+"'>[이전]</a>";
				}
				//페이지 숫자 생성
				for(int i=0;i<pageNaviSize;i++) {
					if(pageNo == reqPage) {
						pageNavi +=	"<span>"+pageNo+"</span>";
					}else {
						pageNavi += "<a href='/boardList.do>reqPage="+pageNo+"'>"+pageNo+"</a>";
					}
					pageNo++;
					if(pageNo > totalPage) {
						break;
					}
				}
				//다음 버튼
				if(pageNo <= totalPage) {
					pageNavi +="<a href='/boardList.do?reqPage="+pageNo+"'>[다음]</a>";
				}
				BoardPageData bpd = new BoardPageData(list, pageNavi);
				return bpd;
	}//selectMyWriteList


	public void updateMemberNewPhone(Member member) {
		dao.updateMemberNewPhone(member);
	}


	public ArrayList<BoardJoin> selectMyJoiner(int boardNo) {
		ArrayList<BoardJoin> list = dao.selectMyJoiner(boardNo);
		for(int i=0 ; i<list.size() ; i++) {
			ArrayList<BoardOrder> orderList = dao.selectJoinerOrder(list.get(i).getJoinNo()); 
			list.get(i).setBoardOrderList(orderList);
		}
		return list;
	}

	


	
}//MemberService
