package dada.brick.com.web;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import dada.brick.com.service.ReplyService;
import dada.brick.com.vo.Reply;

@Controller
@RequestMapping(value="/reply")
public class ReplyController extends DadaController{
	@Autowired
	ReplyService replyService;
	
	@ResponseBody
	@RequestMapping(value="/insert", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	public String replyInsert(Reply input, HttpServletRequest request) {
		JSONObject json = new JSONObject();
		if(isLoginedUser(request)) {
			json.put("result", replyService.insert(input));
		}else {
			json.put("msg", "로그인이 필요합니다.");
			json.put("result", -1);
		}
		return json.toString();
	}
	
	@ResponseBody
	@RequestMapping(value="/update", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	public String replyUpdate(Reply input, HttpServletRequest request) {
		JSONObject json = new JSONObject();
		if(isLoginedUser(request)) {
			json.put("result", replyService.update(input));
		}else {
			json.put("result", -1);
			json.put("msg", "로그인이 필요합니다.");
		}
		return json.toString();
	}
	
	@ResponseBody
	@RequestMapping(value="/delete", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	public String delete(Reply reply) {
		JSONObject json = new JSONObject();
		
		json.put("result", replyService.delete(reply));
		
		return json.toString();
	}
}
