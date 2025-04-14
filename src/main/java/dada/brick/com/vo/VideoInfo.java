/**
 * 
 */
package dada.brick.com.vo;

import java.sql.Date;

import org.hibernate.internal.util.Cloneable;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * @author LeeHG
 * date 2025-04-09
 */
@Getter
@Setter
@ToString
public class VideoInfo extends Cloneable {
	public static VideoInfo newInstance(int productId) {
		VideoInfo result = new VideoInfo();
		result.setProductId(productId);
		return result;
	}
	public static VideoInfo newInstance(int productId, int userId) {
		VideoInfo result = new VideoInfo();
		result.setUserId(userId);
		result.setProductId(productId);
		return result;
	}
	int id;
	String videoId;
	Date created;
	Date updated;
	int userId;
	int productId;
	
	@Override
	protected Object clone() throws CloneNotSupportedException {
		return super.clone();
	}
}
