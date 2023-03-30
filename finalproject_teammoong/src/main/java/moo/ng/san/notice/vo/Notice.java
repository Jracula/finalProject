package moo.ng.san.notice.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Notice {
	private int noticeNo;
	private String noticeWriter;
	private String noticeContent;
	private String noticeDate;
	private int noticeStatus;
	private int readCount;
}
