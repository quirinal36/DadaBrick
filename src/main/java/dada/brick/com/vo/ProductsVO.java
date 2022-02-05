package dada.brick.com.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ProductsVO extends Paging{
	public static final int STATUS_OPEN = 1;
	public static final int STATUS_CLOSE = -1;
	
	int id;
	int menuId;
	int orderNum;
	int orderNumAfter;
	String name;
	String primaryId;
	String size;
	String packaging;
	String delivery;
	Date wdate;
	Date udate;
	String menuName;
	int parentId;
	int representImage;
	SlidePhotoInfo slideInfo;
	String color;
	String material;
	
	public static ProductsVO newInstance(int id) {
		ProductsVO result = new ProductsVO();
		result.setId(id);
		return result;
	}
}
