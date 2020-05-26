package dada.brick.com.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ProductsVO extends Paging{
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
	
	public static ProductsVO newInstance(int id) {
		ProductsVO result = new ProductsVO();
		result.setId(id);
		return result;
	}
}
