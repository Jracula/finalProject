package moo.ng.san.board.model.vo;

import java.util.ArrayList;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Board {
	private int boardNo;
	private String boardWriter;
	private String boardName;
	private int detailCategoryNo;
	private String boardContent;
	private String boardDate;
	private String accountWriter;
	private String accountName;
	private String accountBank;
	private String boardStart;
	private String boardEnd;
	private String referenceLink;
	private String deliveryDate;
	private String boardEtc;
	private int boardStatus;
	private int boardCount;
	private ArrayList<String> fileList;
	private ArrayList<BoardOption> boardOptionList;
	private ArrayList<BoardJoin> boardJoinList;
	
}




