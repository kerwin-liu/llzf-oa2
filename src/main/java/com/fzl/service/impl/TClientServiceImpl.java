package com.fzl.service.impl;

import java.io.InputStream;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.ServletOutputStream;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.formula.functions.T;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.fzl.common.IDUtils;
import com.fzl.common.Pages;
import com.fzl.mapper.TClientLogMapper;
import com.fzl.mapper.TClientMapper;
import com.fzl.pojo.TClient;
import com.fzl.pojo.TClientExample;
import com.fzl.pojo.TClientExample.Criteria;
import com.fzl.pojo.TClientLog;
import com.fzl.pojo.TClientLogExample;
import com.fzl.pojo.Qo.TClientQo;
import com.fzl.service.TClientService;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;

/**
 * Created by kerwin.liu on 2017/10/14.
 */
@Service
public class TClientServiceImpl implements TClientService {
	@Autowired
	private TClientMapper tClientMapper;
	
	@Autowired
	private TClientLogMapper tClientLogMapper;
	

	@Override
	public boolean insertTClient(TClient tClient) {
		return tClientMapper.insert(tClient) > 0;
	}

	@Override
	public boolean updateTClient(TClient tClient) {
		return tClientMapper.updateByPrimaryKey(tClient) > 0;
	}

	@Override
	public List<TClient> findObjects(List<Integer> clientId) {
		TClientExample example = new TClientExample();

		List<TClient> listSelectByExample = tClientMapper
				.selectByExample(example);

		System.out.println("listSelectByExample=====" + listSelectByExample);

		return listSelectByExample;
	}

	@Override
	public void exportExcel(List<TClient> clientList,
			ServletOutputStream outputStream) {

		/*
		 * 逻辑如下： 1：创建工作簿 1.1创建合并单元格对象 1.2头标题样式 1.3列标题样式 sheet.setColumnWidth(0,
		 * 3766);
		 */
		try {
			// 1 创建工作薄
			HSSFWorkbook workbook = new HSSFWorkbook();

			// 1.1创建合并单元格
			CellRangeAddress rangeAddress = new CellRangeAddress(0, 0, 0, 13);// 起始行号，结束行号，其实列号，结束列号

			// 1.2头标题样式
			HSSFCellStyle styleTitle = createCellStyle(workbook, (short) 16);

			// 1.3 列标题样式
			HSSFCellStyle styleRow = createCellStyle(workbook, (short) 13);

			// 2创建工作表
			HSSFSheet sheet = workbook.createSheet("客户信息");
			// 2.1加载合并单元格对象
			sheet.addMergedRegion(rangeAddress);
			// 设置列宽
			sheet.setDefaultColumnWidth(14); // 设置默认列宽

			// 3 创建行
			HSSFRow rowTitle = sheet.createRow(0); // title（第一行）
			HSSFCell cell = rowTitle.createCell(0);

			// 3.1加载单元格
			cell.setCellStyle(styleTitle);
			cell.setCellValue("客户信息列表");

			// 3.2创建列标题；并设置列标题
			HSSFRow rowHead = sheet.createRow(1); // 第二行

			String[] titles = { "客户编号", "姓名", "身份证", "类型", "性别", "电话", "qq",
					"qq昵称", "微信", "资金", "地址", "描述", "最后修改时间", "隶属员工" };

			for (int i = 0; i < titles.length; i++) {
				HSSFCell cellHead = rowHead.createCell(i);
				// 加载单元格样式 ---------------------------注意改动
				cellHead.setCellStyle(styleRow);
				cellHead.setCellValue(titles[i]);
			}

			// 4操作单元格、将用户列表写入excel
			if (clientList != null) {

				for (int j = 0; j < clientList.size(); j++) {
					HSSFRow row = sheet.createRow(j + 2);// 第一行和第二行已经特殊处理过
					HSSFCell cellObject01 = row.createCell(0);
					cellObject01.setCellValue(clientList.get(j).getClientId());
					HSSFCell cellObject02 = row.createCell(1);
					cellObject02.setCellValue(clientList.get(j).getName());
					HSSFCell cellObject03 = row.createCell(2);
					cellObject03.setCellValue(clientList.get(j).getCard());
					HSSFCell cellObject04 = row.createCell(3);
					cellObject04.setCellValue(clientList.get(j).getType());
					HSSFCell cellObject05 = row.createCell(4);
					cellObject05.setCellValue(clientList.get(j).getSex());
					HSSFCell cellObject06 = row.createCell(5);
					cellObject06.setCellValue(clientList.get(j).getPhone());
					HSSFCell cellObject07 = row.createCell(6);
					cellObject07.setCellValue(clientList.get(j).getQq());
					HSSFCell cellObject08 = row.createCell(7);
					cellObject08.setCellValue(clientList.get(j).getQqqnc());
					HSSFCell cellObject09 = row.createCell(8);
					cellObject09.setCellValue(clientList.get(j).getWeixin());
					HSSFCell cellObject10 = row.createCell(9);
					cellObject10.setCellValue(clientList.get(j).getFunds());
					HSSFCell cellObject11 = row.createCell(10);
					cellObject11.setCellValue(clientList.get(j).getAddress());
					HSSFCell cellObject12 = row.createCell(11);
					cellObject12.setCellValue(clientList.get(j).getRemark());
					HSSFCell cellObject13 = row.createCell(12);

					// 时间
					String string = new SimpleDateFormat("yyyy年mm月dd日-hh时mm分ss")
							.format(new SimpleDateFormat(
									"EEE MMM dd hh:mm:ss z yyyy", Locale.UK)
									.parse(clientList.get(j).getTime()
											.toString()));

					cellObject13.setCellValue(string);

					HSSFCell cellObject14 = row.createCell(13); // 对应客户的员工
					cellObject14.setCellValue(clientList.get(j).getMemberId());

					// 没有下列需求
					// HSSFCell cellObject15 = row.createCell(13);//ip 命名为是否被拉黑
					// cellObject15.setCellValue(clientList.get(j).getIp());

				}

			}

			// 输出
			workbook.write(outputStream);
			workbook.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	/**
	 * 创建单元格样式
	 * 
	 * @param workbook
	 *            工作簿
	 * @param fontSize
	 *            字体大小
	 * @return 单元格样式
	 */
	private HSSFCellStyle createCellStyle(HSSFWorkbook workbook, short fontSize) {
		HSSFCellStyle style = workbook.createCellStyle();
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);// 水平居中

		style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 垂直居中

		style.setBorderBottom(HSSFCellStyle.BORDER_THIN); // 下边框
		style.setBorderLeft(HSSFCellStyle.BORDER_THIN);// 左边框
		style.setBorderTop(HSSFCellStyle.BORDER_THIN);// 上边框
		style.setBorderRight(HSSFCellStyle.BORDER_THIN);// 右边框

		// 设置背景色
		// style.setFillForegroundColor((short) 13);
		// style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);

		// 创建字体
		HSSFFont font = workbook.createFont();
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);// 加粗字体
		font.setFontHeightInPoints(fontSize);

		// 加载字体
		style.setFont(font);
		return style;

	}

	@Override
	public void importExcel(MultipartFile importFile, String name,Long role,Long id) {
		try {
//			FileInputStream fileInputStream = new FileInputStream(
//					importFile.toString());
			InputStream fileInputStream = importFile.getInputStream();
			

//			boolean is03Excel = name.matches("^.+\\.(?i)(xls)$");

			// 1读取工作薄
//			Workbook workbook = is03Excel ? new HSSFWorkbook(fileInputStream)
//					: new XSSFWorkbook(fileInputStream);
			Workbook workbook = new  HSSFWorkbook(fileInputStream);

			// 2读取工作表
			Sheet sheet = workbook.getSheetAt(0);

			// 3读取行
			if (sheet.getPhysicalNumberOfRows() > 2) {
				TClient client = null;

				for (int k = 2; k < sheet.getPhysicalNumberOfRows(); k++) {
					// 4读取单元格
					Row row = sheet.getRow(k);
					// 创建客户
					client = new TClient();

					// 姓名
					Cell cell02 = row.getCell(0);
					client.setName(cell02.getStringCellValue());
					// 身份证
					String card = "";
					Cell cell03 = row.getCell(1);

					try {
						card = cell03.getStringCellValue();
					} catch (Exception e) {
						double dCard = cell03.getNumericCellValue();
						card = BigDecimal.valueOf(dCard).toString();
					}
					client.setPhone(card);

					// 类型
					String typeNumber = "";
					Cell cell04 = row.getCell(2);

					try {
						typeNumber = cell04.getStringCellValue();
					} catch (Exception e) {
						double dtypeNumber = cell04.getNumericCellValue();
						typeNumber = BigDecimal.valueOf(dtypeNumber).toString();
					}
					client.setType(Integer.valueOf(typeNumber.substring(0, 1)));
					
					
					
					
					// 性别
					Cell cell05 = row.getCell(3);
					client.setSex(cell05.getStringCellValue());
					// 电话
					String phoneNumber = "";
					Cell cell06 = row.getCell(4);

					try {
						phoneNumber = cell06.getStringCellValue();
					} catch (Exception e) {
						double dPhoneNumber = cell06.getNumericCellValue();
						phoneNumber = BigDecimal.valueOf(dPhoneNumber)
								.toString();
					}
					client.setPhone(phoneNumber);

					
//					qq
					String qqNumber = "";
					Cell cell07 = row.getCell(5);

					try {
						qqNumber = cell07.getStringCellValue();
					} catch (Exception e) {
						double dqqNumber = cell07.getNumericCellValue();
						qqNumber = BigDecimal.valueOf(dqqNumber)
								.toString();
					}
					client.setPhone(qqNumber);

					
					
					
					// qq昵称
					Cell cell08 = row.getCell(6);
					client.setQqqnc(cell08.getStringCellValue());
					// 微信
					Cell cell09 = row.getCell(7);
					client.setWeixin(cell09.getStringCellValue());
					// 资金
					Cell cell10 = row.getCell(8);
					client.setFunds(cell10.getStringCellValue());
					// 地址
					Cell cell11 = row.getCell(9);
					client.setAddress(cell11.getStringCellValue());
					// 描述
					Cell cell12 = row.getCell(10);
					client.setRemark(cell12.getStringCellValue());
					// 最后修改时间
					client.setTime(new Date());

					// 剩余的选项添加
					// 客户id
					client.setClientId(IDUtils.getId());
					// 隶属员工
					if(role.compareTo(1L)== 0 ){
						client.setMemberId(id);
					}
					else if(role.compareTo(2L)== 0){
						client.setMemberId(id);
					}
					else if(role.compareTo(3L)== 0){
						client.setMemberId(000000l);
					}

					tClientMapper.insert(client);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	@Override
	public List<TClient> findObjects() {

		return null;

	}

	@Override
	public Pages<TClient> queryTClientByMemberId(TClientQo tClientQo, long id) {
		PageHelper.startPage(tClientQo.getPageIndex(), tClientQo.getPageSize());
		tClientQo.setMemberId(null);
		List<TClient> list = tClientMapper.selectClientById(id);
		Page<TClient> page = (Page<TClient>) list;
		return new Pages<>(page.getStartRow(), page.getTotal(),
				page.getPageSize(), list);
	}

	@Override
	public Pages<TClient> queryTClientByDepartment(TClientQo tClientQo, Long id) {
		PageHelper.startPage(tClientQo.getPageIndex(), tClientQo.getPageSize());
		tClientQo.setMemberId(null);
		List<TClient> list = tClientMapper.selectClientByDepartment(id);
		Page<TClient> page = (Page<TClient>) list;
		return new Pages<>(page.getStartRow(), page.getTotal(),
				page.getPageSize(), list);
	}

	@Override
	public Pages<TClient> queryTClientByAdmin(TClientQo tClientQo) {
		PageHelper.startPage(tClientQo.getPageIndex(), tClientQo.getPageSize());
		tClientQo.setMemberId(null);
		TClientExample example = new TClientExample();
		List<TClient> list = tClientMapper.selectByExample(example);
		Page<TClient> page = (Page<TClient>) list;
		return new Pages<>(page.getStartRow(), page.getTotal(),
				page.getPageSize(), list);
	}

	@Override
	public List<TClient> queryTClientByClientCard(String card) {

		TClientExample example = new TClientExample();
		Criteria criteria = example.createCriteria();
		criteria.andCardEqualTo(card);
		List<TClient> list = tClientMapper.selectByExample(example);
		return list;
	}

	@Override
	public boolean saveTClient(TClient client, Long id) {

		client.setMemberId(id);
		client.setClientId(IDUtils.getId());
		return tClientMapper.insert(client) == 1 ? true : false;
	}

	@Override
	public boolean update(TClient client) {

				int a = tClientMapper.updateByPrimaryKey(client) ;
				boolean flag = a == 1 ? true : false;
	return flag;
	}
	
	

	// excel
	@Override
	public List<TClient> findClientListByMemberId(Long id) {
		return tClientMapper.selectClientById(id);
	}

	// excel
	@Override
	public List<TClient> findClientListByDepartmentId(Long id) {
		return tClientMapper.selectClientByDepartment(id);
	}

	// excel
	@Override
	public List<TClient> findClientListAll() {
		TClientExample example = new TClientExample();
		List<TClient> list = tClientMapper.selectByExample(example);
		return list;
	}

	@Override
	public boolean deleteByid(Long clientId) {
		
		boolean flag = tClientMapper.deleteByPrimaryKey(clientId) == 1 ? true : false ;
		
		return flag;
	}

	@Override
	public boolean deleteByids(List<Long> clientIdList) {

	
		TClientExample example = new TClientExample();
		Criteria criteria = example.createCriteria();
		criteria.andClientIdIn(clientIdList);
		int example2 = tClientMapper.deleteByExample(example);
		
		System.out.println("example2===="+example2);
		return example2>0?true:false;
	}

	@Override
	public List<TClientLog> selectClientInfoByClientId(Long id) {

TClientLogExample example = new TClientLogExample();
 
TClientLogExample.Criteria criteria = example.createCriteria();
criteria.andClientIdEqualTo(id);

		List<TClientLog> list = tClientLogMapper.selectByExample(example);
		
		return list;
	}

	@Override
	public boolean saveClientLog(TClientLog tLog) {
		
		return tClientLogMapper.insert(tLog) == 1 ? true : false ;
	
		
	}


	@Override
	public boolean  updatByClientId(Long ids){

		TClient  client = tClientMapper.selectByPrimaryKey(ids);
		client.setIp("2");//2表示成交  1表示未成交

		return tClientMapper.updateByPrimaryKey(client) == 1 ? true :false;
	}

	@Override
	public boolean  updatByClientIds(List<Long> ids){


		for(int i = 0 ; i <ids.size() ; i ++){
			TClient  client = tClientMapper.selectByPrimaryKey(ids.get(i));
			client.setIp("2");//2表示成交  1表示未成交

			tClientMapper.updateByPrimaryKey(client) ;

		}


		return true;
	}



	@Override
	public  List<TClient>  queryByIp(){

		TClientExample example = new TClientExample();
		example.createCriteria().andIpEqualTo("2");
		return   tClientMapper.selectByExample(example);

	}






}
