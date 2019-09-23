package www.ksee.kr.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import www.ksee.kr.service.BoardService;
import www.ksee.kr.vo.Board;
import www.ksee.kr.vo.FileInfo;
import www.ksee.kr.vo.PhotoInfo;
import www.ksee.kr.vo.UserVO;

@Controller
@RequestMapping(value="/group")
public class GroupController extends KseeController {
	
	/**
	 * 공지사항, 자유게시판, 관련소식 모두 보여주기
	 * 
	 * @param mv
	 * @param board
	 * @return
	 */
	@RequestMapping(value= "/", method = RequestMethod.GET)
	public ModelAndView getGroupView(ModelAndView mv, 
			HttpServletRequest request, Board board) {
		final String currentUrl = "/group/notice";
		mv.addObject("curMenu", getCurMenus(currentUrl, request));
		
		mv.addObject("title", "공지사항");
		
		board.setBoardType(Board.TYPE_GROUP);
		board.setPageSize(10);
		
		int totalCount = boardService.count(board);
		board.setTotalCount(totalCount);
		List<Board> list = boardService.select(board);
		
		mv.addObject("paging", board);
		mv.addObject("list", list);
		mv.setViewName("/group/home");
		return mv;
	}

	/************************************************************************
	 * 	공지사항 관련 메소드
	 * 	1. /notice			: 게시판 리스트
	 *  2. /notice/write	: 게시판 글 쓰기
	 *  3. /notice/view		: 게시판 글 상세보기
	 *  4. /notice/edit		: 게시판 글 수정
	 ************************************************************************/
	/**
	 * 공지사항 리스트 
	 * @param mv
	 * @param board
	 * @return
	 */
	@RequestMapping(value= "/notice")
	public ModelAndView getNoticeView(ModelAndView mv,
			HttpServletRequest request,
			Board board) {
		final String currentUrl = "/group/notice";
		mv.addObject("curMenu", getCurMenus(currentUrl, request));
		mv.addObject("title", "공지사항");
		
		board.setBoardType(Board.TYPE_NOTICE);
		int totalCount = boardService.count(board);
		board.setTotalCount(totalCount);
		List<Board> boardList = boardService.select(board);
		
		mv.addObject("list", boardList);
		mv.addObject("paging", board);
		mv.addObject("listUrl", "/group/notice/");
		mv.addObject("viewUrl", "/group/notice/view/");
		mv.addObject("writeUrl", "/group/notice/write/");
		mv.setViewName("/group/list");
		
		return mv;
	}
	/**
	 * 공지사항 글쓰기 화면
	 * @param mv
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/notice/write")
	public ModelAndView getWriteNoticeView(ModelAndView mv, 
			HttpServletRequest request) {
		final String currentUrl = "/group/notice";
		mv.addObject("curMenu", getCurMenus(currentUrl, request));
		mv.addObject("title", "공지사항");
		
		UserVO user = getUser();
		
		mv.addObject("current", request.getServletPath());
		mv.addObject("listUrl", request.getContextPath() +"/group/notice");
		mv.addObject("authUrl", "/member/isAdmin");
		mv.addObject("user", user);
		mv.addObject("boardType", Board.TYPE_NOTICE);
		mv.setViewName("/board/write");
		return mv;
	}
	/**
	 * 공지사항 상세보기
	 * @param request
	 * @param mv
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/notice/view/{id}")
	public ModelAndView getDetailNoticeView(HttpServletRequest request,
			ModelAndView mv,
			@PathVariable(value="id", required = true)Integer id) {
		final String currentUrl = "/group/notice";
		mv.addObject("curMenu", getCurMenus(currentUrl, request));
		mv.addObject("title", "공지사항");
		
		Board board= boardService.selectOne(Board.newInstance(id));
		board.setViewCount(board.getViewCount() + 1);
		boardService.update(board);
		List<FileInfo> fileList = fileInfoService.select(FileInfo.newInstance(id));
		List<PhotoInfo> photoList = photoInfoService.select(PhotoInfo.newInstance(id));
		
		mv.addObject("listUrl", request.getContextPath() +"/group/notice");
		mv.addObject("edit_url", request.getContextPath()+"/group/notice/edit/");
		mv.addObject("fileList", fileList);
		mv.addObject("photoList", photoList);
		mv.addObject("board", board);
		mv.setViewName("/board/detail");
		return mv;
	}
	
	/**
	 * 공지사항 수정하기 화면
	 * 
	 * @param mv
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/notice/edit/{id}")
	public ModelAndView getNoticeEditView(ModelAndView mv,
			HttpServletRequest request,
			@PathVariable(value="id", required = true)Integer id) {
		final String currentUrl = "/group/notice";
		mv.addObject("curMenu", getCurMenus(currentUrl, request));
		mv.addObject("title", "공지사항");
		
		Board board= boardService.selectOne(Board.newInstance(id));
		List<FileInfo> fileList = fileInfoService.select(FileInfo.newInstance(id));
		List<PhotoInfo> photoList = photoInfoService.select(PhotoInfo.newInstance(id));
		
		mv.addObject("fileList", fileList);
		mv.addObject("photoList", photoList);
		mv.addObject("board", board);
		
		mv.setViewName("/board/edit");
		return mv;
	}
	
	/************************************************************************
	 * 	관련소식 관련 메소드
	 * 	1. /news		: 게시판 리스트
	 *  2. /news/write	: 게시판 글 쓰기
	 *  3. /news/view	: 게시판 글 상세보기
	 *  4. /news/edit	: 게시판 글 수정
	 ************************************************************************/
	
	/**
	 * 관련소식 리스트
	 * @param mv
	 * @param board
	 * @return
	 */
	@RequestMapping(value="/news")
	public ModelAndView getNewsView(ModelAndView mv,
			HttpServletRequest request,
			Board board) {
		final String currentUrl = "/group/news";
		mv.addObject("curMenu", getCurMenus(currentUrl, request));
		mv.addObject("title", "관련소식");
		
		board.setBoardType(Board.TYPE_NEWS);
		int totalCount = boardService.count(board);
		board.setTotalCount(totalCount);
		List<Board> boardList = boardService.select(board);
		
		mv.addObject("list", boardList);
		mv.addObject("paging", board);
		mv.addObject("listUrl", "/group/news/");
		mv.addObject("viewUrl", "/group/news/view/");
		mv.addObject("writeUrl", "/group/news/write/");
		mv.setViewName("/group/list");
		
		return mv;
	}
	/**
	 * 관련소식 글작성 화면
	 * 
	 * @param mv
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/news/write")
	public ModelAndView getWriteNewsView(ModelAndView mv, HttpServletRequest request) {
		final String currentUrl = "/group/news";
		mv.addObject("curMenu", getCurMenus(currentUrl, request));
		mv.addObject("title", "관련소식");
		UserVO user = getUser();
		
		mv.addObject("current", request.getServletPath());
		mv.addObject("listUrl", request.getContextPath() +"/group/news");
		mv.addObject("authUrl", "/member/isLogin");
		mv.addObject("boardType", Board.TYPE_NEWS);
		mv.addObject("user", user);
		mv.setViewName("/board/write");
		return mv;
	}
	
	/**
	 * 관련소식 상세보기 화면
	 * 
	 * @param request
	 * @param mv
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/news/view/{id}")
	public ModelAndView getDetailNewsView(HttpServletRequest request, ModelAndView mv,
			@PathVariable(value="id", required = true)Integer id) {
		final String currentUrl = "/group/news";
		mv.addObject("curMenu", getCurMenus(currentUrl, request));
		mv.addObject("title", "관련소식");
		
		Board board= boardService.selectOne(Board.newInstance(id));
		board.setViewCount(board.getViewCount() + 1);
		boardService.update(board);
		List<FileInfo> fileList = fileInfoService.select(FileInfo.newInstance(id));
		List<PhotoInfo> photoList = photoInfoService.select(PhotoInfo.newInstance(id));
		
		mv.addObject("listUrl", request.getContextPath() +"/group/news");
		mv.addObject("edit_url", request.getContextPath()+"/group/news/edit/");
		mv.addObject("fileList", fileList);
		mv.addObject("photoList", photoList);
		mv.addObject("board", board);
		mv.setViewName("/board/detail");
		return mv;
	}
	/**
	 * 관련소식 수정하기 화면
	 * 
	 * @param mv
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/news/edit/{id}")
	public ModelAndView getNewsEditView(ModelAndView mv,
			HttpServletRequest request,
			@PathVariable(value="id", required = true)Integer id) {
		final String currentUrl = "/group/news";
		mv.addObject("curMenu", getCurMenus(currentUrl, request));
		mv.addObject("title", "관련소식");
		
		Board board= boardService.selectOne(Board.newInstance(id));
		List<FileInfo> fileList = fileInfoService.select(FileInfo.newInstance(id));
		List<PhotoInfo> photoList = photoInfoService.select(PhotoInfo.newInstance(id));
		
		mv.addObject("title", "관련소식");
		mv.addObject("fileList", fileList);
		mv.addObject("photoList", photoList);
		mv.addObject("board", board);
		
		mv.setViewName("/board/edit");
		return mv;
	}
	
	/************************************************************************
	 * 	회원동정 관련 메소드
	 * 	1. /member			: 게시판 리스트
	 *  2. /member/write	: 게시판 글 쓰기
	 *  3. /member/view		: 게시판 글 상세보기
	 *  4. /member/edit		: 게시판 글 수정
	 ************************************************************************/
	/**
	 * 회원동정 리스트 
	 * @param mv
	 * @param board
	 * @return
	 */
	@RequestMapping(value= "/member")
	public ModelAndView getMemberView(ModelAndView mv,
			HttpServletRequest request,
			Board board) {
		final String currentUrl = "/group/member";
		mv.addObject("curMenu", getCurMenus(currentUrl, request));
		mv.addObject("title", "회원동정");
		
		board.setBoardType(Board.TYPE_MEMBER);
		int totalCount = boardService.count(board);
		board.setTotalCount(totalCount);
		List<Board> boardList = boardService.select(board);
		
		mv.addObject("list", boardList);
		mv.addObject("paging", board);
		mv.addObject("listUrl", "/group/member/");
		mv.addObject("viewUrl", "/group/member/view/");
		mv.addObject("writeUrl", "/group/member/write/");
		mv.setViewName("/group/list");
		return mv;
	}
	/**
	 * 회원동정 글쓰기 화면
	 * @param mv
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/member/write")
	public ModelAndView getWriteMemberView(ModelAndView mv, 
			HttpServletRequest request) {
		final String currentUrl = "/group/member";
		mv.addObject("curMenu", getCurMenus(currentUrl, request));
		mv.addObject("title", "회원동정");
		
		UserVO user = getUser();
		
		mv.addObject("current", request.getServletPath());
		mv.addObject("listUrl", request.getContextPath() +"/group/member");
		mv.addObject("authUrl", "/member/isLogin");
		mv.addObject("user", user);
		mv.addObject("boardType", Board.TYPE_MEMBER);
		mv.setViewName("/board/write");
		return mv;
	}
	/**
	 * 회원동정 상세보기
	 * @param request
	 * @param mv
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/member/view/{id}")
	public ModelAndView getDetailMemberView(HttpServletRequest request,
			ModelAndView mv,
			@PathVariable(value="id", required = true)Integer id) {
		final String currentUrl = "/group/member";
		mv.addObject("curMenu", getCurMenus(currentUrl, request));
		mv.addObject("title", "회원동정");
		
		Board board= boardService.selectOne(Board.newInstance(id));
		board.setViewCount(board.getViewCount() + 1);
		boardService.update(board);
		List<FileInfo> fileList = fileInfoService.select(FileInfo.newInstance(id));
		List<PhotoInfo> photoList = photoInfoService.select(PhotoInfo.newInstance(id));
		
		mv.addObject("listUrl", request.getContextPath() +"/group/member");
		mv.addObject("edit_url", request.getContextPath()+"/group/member/edit/");
		mv.addObject("fileList", fileList);
		mv.addObject("photoList", photoList);
		mv.addObject("board", board);
		mv.setViewName("/board/detail");
		return mv;
	}
	
	/**
	 * 회원동정 수정하기 화면
	 * 
	 * @param mv
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/member/edit/{id}")
	public ModelAndView getMemberEditView(ModelAndView mv,
			HttpServletRequest request, 
			@PathVariable(value="id", required = true)Integer id) {
		final String currentUrl = "/group/member";
		mv.addObject("curMenu", getCurMenus(currentUrl, request));
		mv.addObject("title", "회원동정");
		
		Board board= boardService.selectOne(Board.newInstance(id));
		List<FileInfo> fileList = fileInfoService.select(FileInfo.newInstance(id));
		List<PhotoInfo> photoList = photoInfoService.select(PhotoInfo.newInstance(id));
		
		mv.addObject("fileList", fileList);
		mv.addObject("photoList", photoList);
		mv.addObject("board", board);
		
		mv.setViewName("/board/edit");
		return mv;
	}
}