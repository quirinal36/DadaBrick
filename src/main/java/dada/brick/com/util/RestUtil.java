package dada.brick.com.util;

import java.util.ArrayList;
import java.util.List;

import org.apache.http.Header;
import org.apache.http.client.HttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicHeader;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

public class RestUtil {
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	public JSONObject post(String api, String auth) {
		StringBuilder url = new StringBuilder()
							.append("https://kapi.kakao.com/")
							.append(api);
		Header jsonHeader = new BasicHeader(HttpHeaders.CONTENT_TYPE, "application/json");
		Header authHeader = new BasicHeader(HttpHeaders.AUTHORIZATION, "Bearer "+ auth);
		List<Header> headers = new ArrayList<>();
		headers.add(jsonHeader);
		headers.add(authHeader);
		
		HttpClient httpClient = HttpClientBuilder.create()					
				.setMaxConnTotal(100) // connection pool 적용
				.setMaxConnPerRoute(5) // connection pool 적용
				.setDefaultHeaders(headers)
				.build();
		
		HttpComponentsClientHttpRequestFactory factory = new HttpComponentsClientHttpRequestFactory(); 
		factory.setReadTimeout(5000); // 읽기시간초과, ms 
		factory.setConnectTimeout(3000); // 연결시간초과, ms 
		factory.setHttpClient(httpClient); // 동기실행에 사용될 HttpClient 세팅
		
		RestTemplate restTemplate = new RestTemplate(factory); 
		logger.info(url.toString());
		
		JSONObject json = new JSONObject();
		try {
			String result = restTemplate.postForObject(url.toString(), null, String.class);
			json = new JSONObject(result);
		}catch(RestClientException e) {
			e.printStackTrace();
			return null;
		}
		return json;
	}
	
}
