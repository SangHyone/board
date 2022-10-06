package com.spring.board.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.board.HomeController;
import com.spring.board.service.boardService;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.CodeVo;
import com.spring.board.vo.PageVo;

@Controller
public class ExcelController {

	@Autowired
	boardService boardService;

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);	
	
	@RequestMapping(value ="/excel.do", method = RequestMethod.GET)
	public void downloadExcel(HttpServletResponse response) throws Exception {

		try (Workbook workbook = new XSSFWorkbook()) {
			Sheet sheet = workbook.createSheet("게시판글들");
			int rowNo = 0;

			Row headerRow = sheet.createRow(rowNo++);
			headerRow.createCell(0).setCellValue("글 번호");
			headerRow.createCell(1).setCellValue("작성자");
			headerRow.createCell(2).setCellValue("제목");
			headerRow.createCell(3).setCellValue("내용");
			headerRow.createCell(4).setCellValue("글 타입");

			List<BoardVo> boardList = new ArrayList<BoardVo>();
			List<CodeVo> codeList = new ArrayList<CodeVo>();
			HashMap<String, Object> map = new HashMap<String, Object>();
			PageVo pageVo = new PageVo();

			int page = 1;

			if (pageVo.getPageNo() == 0) {
				pageVo.setPageNo(page);
			}
			map.put("pageVo", pageVo);
			boardList = boardService.SelectBoardList(map);
			for (CodeVo cv : codeList) {
				for (BoardVo bv : boardList) {
					if (bv.getBoardType().equals(cv.getCodeId())) {
						bv.setBoardType(cv.getCodeName());
					}
				}
			}

			for (BoardVo board : boardList) {
				Row row = sheet.createRow(rowNo++);
				row.createCell(0).setCellValue(board.getBoardNum());
				row.createCell(1).setCellValue(board.getCreator());
				row.createCell(2).setCellValue(board.getBoardTitle());
				row.createCell(3).setCellValue(board.getBoardComment());
				row.createCell(4).setCellValue(board.getBoardType());
			}

			File tmpFile = File.createTempFile("TMP~", ".xlsx");
			try (OutputStream fos = new FileOutputStream(tmpFile);) {
				workbook.write(fos);
			}
			InputStream res = new FileInputStream(tmpFile) {
				@Override
				public void close() throws IOException {
					super.close();
					if (tmpFile.delete()) {
						 logger.info("임시 파일 삭제 완료");
					}
				}
			};
		}
	}
}
