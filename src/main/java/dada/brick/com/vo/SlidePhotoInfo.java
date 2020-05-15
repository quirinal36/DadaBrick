package dada.brick.com.vo;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SlidePhotoInfo {
	public static final int INDEX_MAIN = 1;
	public static final int INDEX_MENU = 2;
	public static final int MENUS_TITLE = 3;
	
	int id;
	int display;
	int photoId;
	String linkUrl;
	String url;
	String title;
	int menuId;
	
	public static SlidePhotoInfo newInstance(int display) {
		SlidePhotoInfo result = new SlidePhotoInfo();
		result.setDisplay(display);
		return result;				
	}
	public static SlidePhotoInfo newInstance(int display, int menuId) {
		SlidePhotoInfo result = new SlidePhotoInfo();
		result.setDisplay(display);
		result.setMenuId(menuId);
		return result;				
	}
	
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.JSON_STYLE);
	}
}
