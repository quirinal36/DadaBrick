package dada.brick.com.util;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.logging.Logger;

import org.apache.poi.EncryptedDocumentException;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor.HSSFColorPredefined;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;

import dada.brick.com.vo.ApplyVO;
import dada.brick.com.vo.ProductsVO;
import dada.brick.com.vo.UserVO;
import lombok.Getter;

@Getter
public class ExcelMaker {
	Workbook wb;
	Sheet sheet;
	final static Logger logger = Logger.getLogger(ExcelMaker.class.getSimpleName());
	public ExcelMaker() {
		
	}
	public List<ProductsVO> getExcelFileToProductsVO() {
		String filePath = "D:\\dada.xlsx"; 
		List<ProductsVO> list = new ArrayList<ProductsVO>();
		try {
			InputStream inputStream = new FileInputStream(filePath);
			Workbook workbook = WorkbookFactory.create(inputStream); // 시트 로드 0, 첫번째 시트 로드 
			Sheet sheet = workbook.getSheetAt(0); 
			Iterator<Row> rowItr = sheet.iterator(); // 행만큼 반복
			
			while(rowItr.hasNext()) {
				Row row = rowItr.next();
				if(row.getRowNum() == 0)continue;
				Iterator<Cell> cellItr = row.cellIterator(); // 한행이 한열씩 읽기 (셀 읽기)
				ProductsVO product = new ProductsVO();
				while(cellItr.hasNext()) {
					Cell cell = cellItr.next();
					
					
					int index = cell.getColumnIndex();
					switch(index) {
					case 1:
						product.setMenuId(((Double)getValueFromCell(cell)).intValue());
						break;
					case 2:
						product.setOrderNum(((Double)getValueFromCell(cell)).intValue());
						break;
					case 3:
						product.setName((String)getValueFromCell(cell));
						break;
					case 4:
						product.setPrimaryId((String)getValueFromCell(cell));
						break;
					case 5:
						product.setSize((String)getValueFromCell(cell));
						break;
					case 6:
						product.setPackaging((String)getValueFromCell(cell));
						break;
					case 7:
						product.setDelivery((String)getValueFromCell(cell));
						break;
					}
				}
				list.add(product);
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (EncryptedDocumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InvalidFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}
	private Object getValueFromCell(Cell cell) { 
		switch(cell.getCellTypeEnum()) { 
		case STRING: 
			return cell.getStringCellValue(); 
		case BOOLEAN: 
			return cell.getBooleanCellValue(); 
		case NUMERIC: 
			return cell.getNumericCellValue(); 
		case FORMULA: 
			return cell.getCellFormula(); 
		case BLANK: 
			return ""; 
		default: 
			return ""; 
		} 
	}
	public void makeSheet(final String title) {
		this.wb = new HSSFWorkbook();
		this.sheet = this.wb.createSheet(title);		
	}
	private CellStyle getBodyStyle() {
		// 데이터용 경계 스타일 테두리
		CellStyle bodyStyle = this.wb.createCellStyle();
		bodyStyle.setBorderTop(BorderStyle.THIN);
		bodyStyle.setBorderBottom(BorderStyle.THIN);
		bodyStyle.setBorderLeft(BorderStyle.THIN);
		bodyStyle.setBorderRight(BorderStyle.THIN);
		return bodyStyle;
	}
	private CellStyle getHeadStyle() {		
		// table header style
		CellStyle headStyle = this.wb.createCellStyle();
		// 가는 경계선
		headStyle.setBorderTop(BorderStyle.THIN);
		headStyle.setBorderBottom(BorderStyle.THICK);
		headStyle.setBorderLeft(BorderStyle.THIN);
		headStyle.setBorderRight(BorderStyle.THIN);
		
		// 베경색
		headStyle.setFillForegroundColor(HSSFColorPredefined.GREY_25_PERCENT.getIndex());
		headStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
		
		// 데이터 가운데정렬
		headStyle.setAlignment(HorizontalAlignment.CENTER);
		
		return headStyle;
	}
	
	public void makeHead(final String[] headers) {
		CellStyle headStyle = getHeadStyle();
		int rowNo = this.sheet.getLastRowNum();
		Row row = this.sheet.createRow(++rowNo);
		for(int i = 0; i<headers.length; i++) {
			Cell cell = row.createCell(i);
			cell.setCellStyle(headStyle);
			cell.setCellValue(headers[i]);
		}
	}
	
	public void makeApplicationBody(List<ApplyVO> applyList, final String[] headers) {
		CellStyle bodyStyle = getBodyStyle();
		Iterator<ApplyVO> iter = applyList.iterator();
		while(iter.hasNext()) {
			ApplyVO item = iter.next();
			int rowNo = this.sheet.getLastRowNum();
			Row row = this.sheet.createRow(++rowNo);
			
			for(int i = 0; i<headers.length; i++) {
				Cell cell = row.createCell(i);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(getApplyItem(item, i));
			}
		}
	}
	
	public void makeUserBody(List<UserVO> userList, final String[] headers) {
		CellStyle bodyStyle = getBodyStyle();
		Iterator<UserVO> iter = userList.iterator();
		while(iter.hasNext()) {
			UserVO item = iter.next();
			int rowNo = this.sheet.getLastRowNum();
			Row row = this.sheet.createRow(++rowNo);
			
			for(int i = 0; i<headers.length; i++) {
				Cell cell = row.createCell(i);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(getUserItem(item, i));
			}
		}
	}
	
	private String getUserItem(UserVO user, int i) {
		switch(i) {
		case 0:
			return String.valueOf(user.getId());
		case 1:
			return user.getRole_name_kr();
		case 2:
			return user.getUsername();
		case 3:
			return user.getClassification();
		case 4:
			return user.getLevel();
		case 5:
			if(user.getEmail() != null && user.getEmail().length()>0) {
				return user.getEmail() +"@" + user.getDomain();
			}
		case 6:
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");  
			return dateFormat.format(user.getMdate());
		}
		return null;
	}
	private String getApplyItem(ApplyVO item, int i) {
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");  

		switch(i) {
		case 0:
			return dateFormat.format(item.getMdate());
		case 1:
			if(item.getMemberType() == 2) {
				return "일반";	
			}else if(item.getMemberType() == 3) {
				return "기업";
			}else if(item.getMemberType() == 4) {
				return "학생";
			}
			break;
		case 2:
			if(item.getIsSpeaker() == 1) {
				return "O";
			}else if(item.getIsSpeaker() == 2){
				return "X";
			}
			break;
		case 3:
			if(item.getNational() == 1) {
				return "대한민국";
			}else if(item.getNational() == 2) {
				return "중국";
			}else if(item.getNational() == 3) {
				return "일본";
			}
			break;
		case 4:
			return item.getUsername();
		case 5:
			return item.getClassification();
		case 6:
			return item.getLevel();
		case 7:
			return item.getTelephone();
		case 8:
			if(item.getEmail() != null && item.getEmail().length()>0) {
				return item.getEmail() +"@" + item.getDomain();
			}
		}
		return null;
	}
}
