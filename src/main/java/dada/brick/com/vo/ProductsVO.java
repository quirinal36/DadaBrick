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
	String name;
	String primaryId;
	String size;
	String packaging;
	String delivery;
	Date wdate;
	Date udate;
	String menuName;
	int parentId;
}
