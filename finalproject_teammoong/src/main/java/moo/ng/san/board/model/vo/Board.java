package moo.ng.san.board.model.vo;

import javax.annotation.sql.DataSourceDefinition;

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
	private int categoryNo;
	private String boardContent;
	private int boardPrice;
	private String boardDate;
	private String accountWriter;
	private String accountName;
	private String accountBank;
	private String boardStart;
	private String boardEnd;
	private String boardDetail;
	private String referenceLink;
	private String deliveryDate;
	private int boardSatus;
	
}