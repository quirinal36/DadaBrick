package dada.brick.com.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Reply extends Paging{
	int id;
	int writer;
	String writerName;
	String content;
	int parent;
	int boardId;
	Date mdate;
	Date udate;
	
	public static Reply newInstance(int boardId) {
		Reply reply = new Reply();
		reply.setBoardId(boardId);
		return reply;
	}
}
