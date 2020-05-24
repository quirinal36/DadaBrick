package dada.brick.com.vo;

import java.sql.Date;
import java.util.UUID;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PhotoInfo implements Cloneable{
	public static PhotoInfo newInstance(int boardId) {
		PhotoInfo result = new PhotoInfo();
		result.setBoardId(boardId);
		return result;
	}
	public static PhotoInfo newInstance(int productId, int id) {
		PhotoInfo result = new PhotoInfo();
		result.setProductId(productId);
		result.setId(id);
		return result;
	}
	public static PhotoInfo newInstance(MultipartFile mpf) {
		PhotoInfo result = new PhotoInfo();
		
		String newFilenameBase = UUID.randomUUID().toString();
        String originalFileExtension = mpf.getOriginalFilename().substring(mpf.getOriginalFilename().lastIndexOf("."));
        String newFilename = newFilenameBase + originalFileExtension;
		String contentType = mpf.getContentType();
		
		result.setName(mpf.getOriginalFilename());
		result.setNewFilename(newFilename);
		result.setSize((int)mpf.getSize());
		result.setContentType(contentType);
        
		return result;
	}
	int id;
	int uploader;
	int productId;
	Date wdate;
	String url;
	String name;
	String thumbnailFilename;
	String newFilename;
	int size;
	int thumbnailSize;
	String thumbnailUrl;
	String contentType;
	String search;
	int orderById;
	int boardId;
	
	@Override
	public Object clone() throws CloneNotSupportedException {
		return super.clone();
	}
}