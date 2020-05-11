package dada.brick.com.vo;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SlidePhotoInfo {
	int id;
	int display;
	int photoId;
	String linkUrl;
	String url;
	String title;
	
	public static SlidePhotoInfo newInstance(int display) {
		SlidePhotoInfo result = new SlidePhotoInfo();
		result.setDisplay(display);
		return result;				
	}
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.JSON_STYLE);
	}
}
