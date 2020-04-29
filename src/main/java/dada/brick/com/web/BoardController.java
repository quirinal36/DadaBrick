package dada.brick.com.web;

import java.util.List;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dada.brick.com.service.BoardService;
import dada.brick.com.vo.Board;

@RequestMapping(value="/board")
@Controller
public class BoardController extends DadaController{
	@Autowired
	private BoardService boardService;
	
	@RequestMapping(value= {"/notice/"}, method = RequestMethod.GET)
	public ModelAndView getNoticeView(ModelAndView mv,
			Board board) {
		if(board.getPageNo() == 0) {
			board.setPageNo(1);
		}
		board.setBoardType(16);
		List<Board> list = boardService.select(board);
		
		mv.addObject("writeUrl", "/board/write/"+board.getBoardType());
		mv.addObject("list", list);
		mv.addObject("paging", board);
		mv.addObject("boardName", "공지사항");
		mv.setViewName("/board/list");
		return mv;
	}
	
	@RequestMapping(value= {"/faq/"}, method = RequestMethod.GET)
	public ModelAndView getFaqView(ModelAndView mv,
			Board board) {
		if(board.getPageNo() == 0) {
			board.setPageNo(1);
		}
		board.setBoardType(17);
		List<Board> list = boardService.select(board);
		mv.addObject("writeUrl", "/board/write/"+board.getBoardType());
		mv.addObject("list", list);
		mv.addObject("paging", board);
		mv.addObject("boardName", "질문과답변");
		mv.setViewName("/board/list");
		return mv;
	}
	
	@RequestMapping(value= {"/data/"}, method = RequestMethod.GET)
	public ModelAndView getDataView(ModelAndView mv,
			Board board) {
		if(board.getPageNo() == 0) {
			board.setPageNo(1);
		}
		board.setBoardType(18);
		List<Board> list = boardService.select(board);
		mv.addObject("writeUrl", "/board/write/"+board.getBoardType());
		mv.addObject("list", list);
		mv.addObject("paging", board);
		mv.addObject("boardName", "자료실");
		mv.setViewName("/board/list");
		return mv;
	}
	

	@RequestMapping(value= {"/detail/", "/detail/{id}"}, method=RequestMethod.GET)
	public ModelAndView getDetailView(ModelAndView mv) {
		mv.setViewName("/board/detail");
		return mv;
	}
	
	@RequestMapping(value= {"/write/", "/write/{type}"}, method=RequestMethod.GET)
	public ModelAndView getWriteView(ModelAndView mv) {
		mv.setViewName("/board/write");
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value= {"/write"}, method=RequestMethod.POST, produces = "application/json; charset=utf8")
	public String write(ModelAndView mv, Board board) {
		JSONObject json = new JSONObject();
		return json.toString();
	}
	
	@RequestMapping(value= {"/edit/", "/edit/{type}"}, method=RequestMethod.GET)
	public ModelAndView getEditView(ModelAndView mv) {
		mv.setViewName("/board/edit");
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value= {"/edit"}, method=RequestMethod.POST, produces = "application/json; charset=utf8")
	public String edit(ModelAndView mv, Board board) {
		JSONObject json = new JSONObject();
		return json.toString();
	}
}
