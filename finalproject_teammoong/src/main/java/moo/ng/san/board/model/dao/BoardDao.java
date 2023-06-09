package moo.ng.san.board.model.dao;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import moo.ng.san.board.model.vo.Board;
import moo.ng.san.board.model.vo.BoardJoin;
import moo.ng.san.board.model.vo.BoardOption;
import moo.ng.san.board.model.vo.BoardOrder;
import moo.ng.san.board.model.vo.FileVO;
import moo.ng.san.category.model.vo.Category;
import moo.ng.san.member.model.vo.Member;
import moo.ng.san.product.model.vo.searchBarVO;

@Repository
public class BoardDao {
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public ArrayList<Board> selectBoardList(HashMap<String, Object> map) {
		System.out.println(map);
		List list = sqlSession.selectList("board.selectBoardList",map);
		return (ArrayList<Board>)list;
	}
	public int selectBoardCount() {
		int totalCount = sqlSession.selectOne("board.totalCount");
		return totalCount;
	}
	public int insertBoard(Board b) {
		int result = sqlSession.insert("board.insertBoard",b);
		System.out.println(result);
		return result;
	}
	public int insertFile(FileVO file) {
		int result = sqlSession.insert("board.insertFile",file);
		System.out.println(result);
		return result;
	}
	public Board selectOneBoard(int boardNo) {
		Board b = sqlSession.selectOne("board.selectOneBoard",boardNo);
		return b;
	}
	public ArrayList<FileVO> selectFileList(int boardNo) {
		List list = sqlSession.selectList("board.selectFileList",boardNo);
		return (ArrayList<FileVO>)list;
	}
	public ArrayList<String> selectBoardImg() {
		List list = sqlSession.selectList("board.selectBoardImg");
		System.out.println("Board Dao fileList : "+list);
		return (ArrayList<String>)list;
	}
	public ArrayList<BoardOption> selectOptionList(int boardNo) {
		List list = sqlSession.selectList("board.selectOptionList",boardNo);
		return (ArrayList<BoardOption>)list;
	}
	
	public int insertBoardOption(BoardOption o) {
		int result = sqlSession.insert("board.insertOption",o);
		return result;
	}
	public int insertBoardJoin(BoardJoin bj) {
		int result = sqlSession.insert("board.insertBoardJoin",bj);
		System.out.println(result);
		return result;
	}
	public ArrayList<BoardJoin> selectBoardJoinList(int memberNo) {
		List list = sqlSession.selectList("board.selectBoardJoinList",memberNo);
		return (ArrayList<BoardJoin>)list;
	}
	public BoardJoin selectOneBoardJoin(int joinNo) {
		BoardJoin bj = sqlSession.selectOne("board.selectOneBoardJoin", joinNo);
		return bj;
	}
	public int boardDelete(int boardNo) {
		int result = sqlSession.delete("board.boardDelete",boardNo);
		return result;
	}
	public int updateBoardCount(Board b) {
		int result = sqlSession.update("board.boardReadCount",b);
		return result;
	}
	public int boardFileDelete(int boardNo) {
		int result = sqlSession.delete("board.boardFileDelete",boardNo);
		return result;
	}
	public int insertBoardOrderList(HashMap<String, Object> map) {
		int result = sqlSession.insert("board.insertBoardOrderList",map);
		return result;
	}
//	public ArrayList<BoardOrder> selectListBoardOrder(int joinNo) {
//		List list = sqlSession.selectList("board.selectListBoardOrder",joinNo);
//		return (ArrayList<BoardOrder>)list;
//	}
	public ArrayList<Board> selectBoardYourPage(String memberId) {
		List list = sqlSession.selectList("board.selectBoardYourPage",memberId);
		return (ArrayList<Board>)list;
	}
	public Member selectMemberId(String memberId) {
		Member m = sqlSession.selectOne("board.selectMemberId", memberId);
		return m;
	}

	public ArrayList<Category> selectCategoryList() {
		List list = sqlSession.selectList("category.selectCategoryList");
		
		System.out.println("dao : "+list);
		
		return (ArrayList<Category>)list;
	}
	public ArrayList<Board> selectBoardAllList(HashMap<String, Object> map) {
		List list = sqlSession.selectList("board.selectBoardList", map);
		return (ArrayList<Board>)list;
	}
	public int updateBoardDetailCount(HashMap<String, Object> map) {
		int result = sqlSession.update("board.updateBoardDetailCount",map);
		return result;		
	}
	public int selectJoinNo() {
		int joinNo = sqlSession.selectOne("board.selectJoinNo");
		return joinNo;
	}


	public ArrayList<Board> searchBoardList(searchBarVO sb) {
		List list = sqlSession.selectList("board.searchBoardList",sb);
		return (ArrayList<Board>)list;
	}

	

}
