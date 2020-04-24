package dada.brick.com.vo;

import java.util.ArrayList;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Menus {
	int id;
	String name;
	int parentId;
	String url;
	int menuNum;
	
	Menus prev;
	Menus next;
	List<Menus> children;
	int total;
	
	public static Menus newInstance(int id) {
		Menus menu = new Menus();
		menu.setChildren(new ArrayList<Menus>());
		menu.setId(id);
		return menu;
	}
}
