package dada.brick.com.vo;

import java.util.Date;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
public class Board extends Paging{
	public static final int TYPE_NOTICE = 1;
	public static final int TYPE_NEWS = 2;
	public static final int TYPE_MEMBER = 3;
	public static final int TYPE_SPEAKER = 4;
	public static final int TYPE_FREE = 5;
	
	public static final int TYPE_GROUP = 7;
	public static final int PAGE_SIZE_NORMAL = 10;
	public static final int PAGE_SIZE_CARD = 9;
	
	public static Board newInstance(int id, int boardType) {
		Board board = new Board();
		board.setId(id);
		board.setBoardType(boardType);
		return board;
	}
	public static Board newInstance(int id) {
		Board board = new Board();
		board.setId(id);
		return board;
	}
	int id;
	String title;
	String content;
	Date wdate;
	Date udate;
	int writer;
	int boardType;
	String writerName;
	int fileCnt;
	int pictureCnt;
	int viewCount;
	int replyCnt;
	String boardName;
	String language;
	
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.JSON_STYLE);
	}
}
