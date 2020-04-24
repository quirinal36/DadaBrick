package dada.brick.com.vo;

import lombok.ToString;

import lombok.Setter;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import org.json.JSONObject;

import lombok.Getter;

@Getter
@Setter
public class KakaoLogin {
	String access_token;
	String token_type;
	String bearer;
	String refresh_token;
	long expires_in;
	String scope;
	long refresh_token_expires_in;
	
	public static KakaoLogin parse(String input) {
		KakaoLogin result = new KakaoLogin();
		JSONObject json = new JSONObject(input);
		result.setAccess_token(json.getString("access_token"));
		result.setToken_type(json.getString("token_type"));
		result.setBearer(json.getString("bearer"));
		result.setRefresh_token(json.getString("refresh_token"));
		result.setExpires_in(json.getLong("expires_in"));
		result.setScope(json.getString("scope"));
		result.setRefresh_token_expires_in(json.getLong("refresh_token_expires_in"));
		return result;
	}
	
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.JSON_STYLE);
	}
}
