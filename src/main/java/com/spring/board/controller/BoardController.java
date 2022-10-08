package com.spring.board.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.board.HomeController;
import com.spring.board.service.boardService;
import com.spring.board.service.codeService;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.CodeVo;
import com.spring.board.vo.PageVo;
import com.spring.common.CommonUtil;

@Controller
public class BoardController {

	@Autowired
	boardService boardService;

	@Autowired
	codeService codeService;

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@RequestMapping(value = "/board/boardList.do", method = RequestMethod.GET)
	public String boardList(Locale locale, PageVo pageVo, Model model) throws Exception {

		List<BoardVo> boardList = new ArrayList<BoardVo>();
		List<CodeVo> codeList = new ArrayList<CodeVo>();
		HashMap<String, Object> map = new HashMap<String, Object>();

		int page = 1;
		int totalCnt = 0;

		if (pageVo.getPageNo() == 0) {
			pageVo.setPageNo(page);
		}
		map.put("pageVo", pageVo);
		boardList = boardService.SelectBoardList(map);
		codeList = codeService.selectMenuList();
		totalCnt = boardService.selectBoardCnt();
		for(CodeVo cv : codeList) {
			for(BoardVo bv : boardList) {
				if(bv.getBoardType().equals(cv.getCodeId())) {
					bv.setBoardType(cv.getCodeName());
				}
			}
		}
		model.addAttribute("boardList", boardList);
		model.addAttribute("codeList", codeList);
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("pageNo", page);

		return "board/boardList";
	}

	@RequestMapping(value = "/board/sortBoardList.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> sortBoardList(Locale locale, PageVo pageVo,
			@RequestParam(value="checkedList[]") List<String> checkedList,
			Model model) throws Exception {

		List<BoardVo> boardList = new ArrayList<BoardVo>();
		List<CodeVo> codeList = new ArrayList<CodeVo>();
		HashMap<String, Object> map = new HashMap<String, Object>();
		HashMap<String, Object> result = new HashMap<String, Object>();

		codeList = codeService.selectMenuList();

		for(CodeVo cv : codeList) {
			for(String value : checkedList) {
				if(value.equals(cv.getCodeName())) {
					value = cv.getCodeId();
				}
			}
		}

		checkedList.removeAll(Collections.singletonList(null));
		System.out.println(checkedList);
		int page = 1;
		int totalCnt = 0;

		if (pageVo.getPageNo() == 0) {
			pageVo.setPageNo(page);
		}
		map.put("pageVo", pageVo);
		map.put("checkedList", checkedList);

		boardList = boardService.SelectBoardList(map);
		totalCnt = boardList.size();

		for(CodeVo cv : codeList) {
			for(BoardVo bv : boardList) {
				if(bv.getBoardType().equals(cv.getCodeId())) {
					bv.setBoardType(cv.getCodeName());
				}
			}
		}

		model.addAttribute("boardList", boardList);
		model.addAttribute("codeList", codeList);
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("pageNo", page);

		result.put("success", (boardList!=null) ? "Y" : "N");
		result.put("boardList", boardList);
		result.put("codeList", codeList);
		result.put("totalCnt", totalCnt);
		result.put("pageNo", page);
		String callbackMsg = CommonUtil.getJsonCallBackString(" ", result);

		System.out.println("callbackMsg::" + callbackMsg);

		return result;
	}

	@RequestMapping(value = "/board/{boardType}/{boardNum}/boardView.do", method = RequestMethod.GET)
	public String boardView(Locale locale, Model model, @PathVariable("boardType") String boardType,
			@PathVariable("boardNum") int boardNum) throws Exception {

		BoardVo boardVo = new BoardVo();
		List<CodeVo> codeList = codeService.selectMenuList();

		String str = "";
		for(CodeVo vo : codeList) {
			if(boardType.equals(vo.getCodeName())) {
				str = vo.getCodeId();
			}
		}

		boardVo = boardService.selectBoard(str, boardNum);

		model.addAttribute("boardType", boardType);
		model.addAttribute("boardNum", boardNum);
		model.addAttribute("board", boardVo);

		return "board/boardView";
	}

	@RequestMapping(value = "/board/boardWrite.do", method = RequestMethod.GET)
	public String boardWrite(Locale locale, Model model) throws Exception {
		List<CodeVo> list = codeService.selectMenuList();
		model.addAttribute("codeList",list);
		return "board/boardWrite";
	}

	@RequestMapping(value = "/board/boardWriteAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardWriteAction(
			Locale locale,
			@RequestBody List<BoardVo> list) throws Exception {
		HashMap<String, String> result = new HashMap<String, String>();

		int resultCnt = 0;
		for(BoardVo vo : list) {
			boardService.boardInsert(vo);
			resultCnt++;
		}

		result.put("success", (resultCnt>=list.size()) ? "Y" : "N" );
		String callbackMsg = CommonUtil.getJsonCallBackString(" ", result);

		System.out.println("callbackMsg::" + callbackMsg);

		return callbackMsg;
	}

	@RequestMapping(value = "/board/boardUpdateAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardUpdateAction(Locale locale, BoardVo boardVo) throws Exception {

		HashMap<String, String> result = new HashMap<String, String>();

		int resultCnt = boardService.boardUpdate(boardVo);

		result.put("success", (resultCnt > 0) ? "Y" : "N");
		String callbackMsg = CommonUtil.getJsonCallBackString(" ", result);

		System.out.println("callbackMsg::" + callbackMsg);

		return callbackMsg;
	}

	@RequestMapping(value = "/board/boardViewChangeAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardViewChangeAction(Locale locale, BoardVo boardVo) throws Exception {

		HashMap<String, Object> result = new HashMap<String, Object>();

		BoardVo dbVo = boardService.selectBoard(boardVo.getBoardType(), boardVo.getBoardNum());
		result.put("board", dbVo);
		String callbackMsg = CommonUtil.getJsonCallBackString(" ", result);

		System.out.println("callbackMsg::" + callbackMsg);

		return callbackMsg;
	}

	@RequestMapping(value = "/board/boardDeleteAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardDeleteAction(Locale locale, int boardNum) throws Exception {

		HashMap<String, Object> result = new HashMap<String, Object>();

		int resultCnt = boardService.boardDelete(boardNum);

		result.put("success", (resultCnt > 0) ? "Y" : "N");
		String callbackMsg = CommonUtil.getJsonCallBackString(" ", result);

		System.out.println("callbackMsg::" + callbackMsg);

		return callbackMsg;
	}

}
