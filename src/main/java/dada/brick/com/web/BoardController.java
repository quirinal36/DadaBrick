package dada.brick.com.web;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dada.brick.com.Config;
import dada.brick.com.service.BoardService;
import dada.brick.com.service.ReplyService;
import dada.brick.com.util.FileUtil;
import dada.brick.com.vo.Board;
import dada.brick.com.vo.FileInfo;
import dada.brick.com.vo.PhotoInfo;
import dada.brick.com.vo.Reply;

@RequestMapping(value="/board")
@Controller
public class BoardController extends DadaController{
	@Autowired
	private BoardService boardService;
	@Autowired
	ReplyService replyService;
	
	@RequestMapping(value= {"/{boardName}/"}, method = RequestMethod.GET)
	public ModelAndView getNoticeView(ModelAndView mv,
			Board board, @PathVariable(value="boardName", required = true)String boardName) {
		if(board.getPageNo() == 0) {
			board.setPageNo(1);
		}
		if(boardName.equals("notice")) {
			board.setBoardType(16);
			mv.addObject("boardName", "공지사항");
		}else if(boardName.equals("faq")) {
			board.setBoardType(17);
			mv.addObject("boardName", "질문과답변");
		}else if(boardName.equals("data")) {
			board.setBoardType(18);
			mv.addObject("boardName", "자료실");
		}
		
		int total = boardService.count(board);
		board.setTotalCount(total);
		List<Board> list = boardService.select(board);
		
		mv.addObject("writeUrl", "/board/write/"+board.getBoardType());
		mv.addObject("list", list);
		mv.addObject("paging", board);
		
		mv.setViewName("/board/list");
		return mv;
	}
	@RequestMapping(value= {"/{boardName}/{id}"}, method = RequestMethod.GET)
	public ModelAndView getBoardDetailView(ModelAndView mv,
			@PathVariable(value="id")Optional<Integer>boardId) throws IOException {
		Board board;
		if(boardId.isPresent()) {
			board = Board.newInstance(boardId.get());
			board = boardService.selectOne(board);

			boardService.updateCount(Board.newInstance(board.getId()));
			
			List<FileInfo> fileList = fileInfoService.select(FileInfo.newInstance(board.getId()));
			List<PhotoInfo> photoList = photoInfoService.select(PhotoInfo.newInstance(board.getId()));
			
			Reply reply = Reply.newInstance(board.getId());
			List<Reply> replyList = replyService.select(reply);
			
			File file = ResourceUtils.getFile("classpath:kakao.env");
			String apiKey = FileUtils.readFileToString(file, Config.ENCODING);
			
			mv.addObject("del_url", "/board/delete/");
			mv.addObject("replyList", replyList);
			mv.addObject("loginRedirect", "/board/notice/"+boardId.get());
			mv.addObject("apiKey", apiKey);
			mv.addObject("user", getUser());
			mv.addObject("board", board);
			mv.addObject("fileList", fileList);
			mv.addObject("photoList", photoList);
			
			switch(board.getBoardType()) {
			case 16:
				mv.addObject("listUrl", "/board/notice/");
				break;
			case 17:
				mv.addObject("listUrl", "/board/faq/");
				break;
			case 18:
				mv.addObject("listUrl", "/board/data/");
				break;
			}
			mv.setViewName("/board/detail");
		}
		
		return mv;
	}
	
	@RequestMapping(value= {"/write/", "/write/{type}"}, method=RequestMethod.GET)
	public ModelAndView getWriteView(ModelAndView mv, 
			@PathVariable(value="type")Optional<Integer> boardType) {
		StringBuilder listUrl = new StringBuilder();
		listUrl.append("/board/");
		if(boardType.isPresent()) {
			mv.addObject("boardType", boardType.get());
			switch(boardType.get()) {
			case 16:
				mv.addObject("boardName", "공지사항");
				listUrl.append("notice/");
				break;
			case 17:
				mv.addObject("boardName", "질문과답변");
				listUrl.append("faq/");
				break;
			case 18:
				mv.addObject("boardName", "자료실");
				listUrl.append("data/");
				break;
			}
			
		}
		
		mv.addObject("user", getUser());
		mv.addObject("listUrl", listUrl.toString());
		mv.setViewName("/board/write");
		return mv;
	}
	
	/**
	 * 새글 작성
	 * 
	 * @param mv
	 * @param board
	 * @param pictures
	 * @param files
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value= {"/write"}, method=RequestMethod.POST, produces = "application/json; charset=utf8")
	public String write(ModelAndView mv, Board board,
			@RequestParam(value="pictures")String pictures,
			@RequestParam(value="files")String files) {
		JSONObject json = new JSONObject();
		int result = boardService.insert(board);
		
		FileUtil fileUtil = new FileUtil();
		if(result > 0 && board.getId()>0) {
			if(pictures.length() > 0) {
				photoInfoService.update(fileUtil.parsePhotoInfo(pictures.split(","), board.getId()));
			}
			if(files.length() > 0) {
				fileInfoService.update(fileUtil.parseFileInfo(files.split(","), board.getId()));
			}
		}
		json.put("result", result);
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
	
	/**
	 * 게시글 삭제
	 * 
	 * @param id
	 * @param response
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/delete/{id}", method= {RequestMethod.GET, RequestMethod.POST})
	public String editBoard (@PathVariable(value="id", required = true)Integer id, HttpServletResponse response) {
		List<PhotoInfo> photoList = photoInfoService.select(PhotoInfo.newInstance(id));
		List<FileInfo> fileList = fileInfoService.select(FileInfo.newInstance(id));
		
		int result = boardService.delete(Board.newInstance(id));
		if(result > 0) {
			List<File> files = new ArrayList<File>();
			String srcPath = new FileUtil().makeUserPath();
			if(photoList.size() > 0) {
				Iterator<PhotoInfo> iter = photoList.iterator();
				while(iter.hasNext()) {
					PhotoInfo photo = iter.next();
					File file = new File(srcPath + File.separator + photo.getNewFilename());
					files.add(file);
				}
			}
			if(fileList.size() > 0) {
				Iterator<FileInfo> iter = fileList.iterator();
				while(iter.hasNext()) {
					FileInfo info = iter.next();
					File file = new File(srcPath + File.separator + info.getNewFilename());
					files.add(file);
				}
			}
			if(files.size() > 0) {
				Iterator<File> iter = files.iterator();
				while(iter.hasNext()) {
					File file = iter.next();
					if(file.exists()) {
						file.delete();
					}
				}
			}
		}
		JSONObject json = new JSONObject();
		json.put("result", result);
		return json.toString();
	}
}
