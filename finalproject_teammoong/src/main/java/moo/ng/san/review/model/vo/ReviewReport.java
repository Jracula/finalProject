package moo.ng.san.review.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor

public class ReviewReport {
	private int reportNo;
	private int reviewNo;
	private int memberNo;
	private int reportReason;
	private String reportContent;

}
