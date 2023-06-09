package moo.ng.san.askItem.model.vo;

import java.util.ArrayList;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AskItem {
	private int corpNo;
	private String regNo;//
	private String corpName;//
	private String repName;
	private String corpAddr1;
	private String corpAddr2;
	private String corpType;
	private String corpItem;
	private String contName;
	private String depart;
	private String positionJob;
	private String contPhone;
	private String contMail;
	private String homepage;
	private String askTitle;
	private String askContent;
	private String askDate;
	private ArrayList<AskItemCategory>categoryList; // 필요없는듯?
	private ArrayList<DocuVO>fileList;
	
	private String categoryName;
	
}
