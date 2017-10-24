package com.fzl.common;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fzl.pojo.Client;
import com.fzl.pojo.ClientExcel;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.beans.PropertyDescriptor;
import java.io.*;
import java.lang.reflect.Method;
import java.text.DecimalFormat;
import java.util.*;

@Component
public class ExcelUtils {

    private static final Logger LOGGER = LoggerFactory.getLogger(ExcelUtils.class);

    private static ExcelUtils excelUtils;

    public static final String REFLECT_CLASS_PATH = "com.fzl.pojo.ClientExcel";

    /**
     * 下载excel文件
     *
     * @param response
     * @param path     文件路径地址
     */
    public static void exportExcel(HttpServletResponse response, String path) throws Exception {
        File file = new File(path);
        String filename = file.getName();
        String ext = filename.substring(filename.lastIndexOf(".") + 1).toUpperCase();
        InputStream fis = new BufferedInputStream(new FileInputStream(path));
        byte[] buffer = new byte[fis.available()];
        fis.read(buffer);
        fis.close();
        response.reset();
        response.setHeader("Content-Disposition", "attachment;filename=" + new String(filename.getBytes("UTF-8"), "ISO8859-1"));
        OutputStream toClient = new BufferedOutputStream(response.getOutputStream());
        response.setContentType("application/vnd.ms-excel;charset=UTF-8");
        toClient.write(buffer);
        toClient.flush();
        toClient.close();
    }

    /**
     * 校验上传excel是否合法
     *
     * @param uploadPath 上传路径
     * @return
     */
//    public static Boolean validExcel(String uploadPath) {
//        Sheet sheetUpload = getSheet(uploadPath);
//        Row rowUpload = sheetUpload.getRow(0);
//        int cellNumUpload = rowUpload.getLastCellNum();
//        int cellNumTemplate = Integer.valueOf(ConfigurerInfo.TEMPLATE_COLUMN_NUM);
//        int rowNumUpload = sheetUpload.getLastRowNum();
//        int rowNumTemplate = Integer.valueOf(ConfigurerInfo.TEMPLATE_ROW_NUM);
//        if (rowNumUpload != rowNumTemplate || cellNumUpload != cellNumTemplate) {
//            LOGGER.error("行数或列数不规范");
//            return false;
//        }
//        StringBuilder sb = new StringBuilder();
//        for (int i = 0; i < cellNumUpload; i++) {
//            Cell cellUpload = rowUpload.getCell(i);
//            String uploadValue = getCellValue(cellUpload);
//            sb.append(uploadValue);
//        }
//        String uploadHeadContent = sb.toString();
//        String templateHeadContent = Base64ConvertUtil.decode(ConfigurerInfo.TEMPLATE_HEAD_CONTENT);
//        if (!uploadHeadContent.equalsIgnoreCase(templateHeadContent)) {
//            LOGGER.error("文件头内容不规范");
//            return false;
//        }
//        if (getDataToBean(getBeanPros(),REFLECT_CLASS_PATH,getSheet(uploadPath)) == null) {
//            LOGGER.error("文件头数据不规范");
//            return false;
//        }
//        return true;
//    }

    /**
     * 将excel封装的对象，解析为对应的发票对象
     *
     * @param filePath excel文件的路径地址
     * @return 发票对象
     */
    public static List<Client> getBatchInvoiceDtoList(String filePath, Long userId) {
        List<ClientExcel> list = getDataToBean(getBeanPros(), REFLECT_CLASS_PATH, getSheet(filePath));
        Iterator<ClientExcel> it = list.iterator();
        while (it.hasNext()) {
            ClientExcel clientExcel = it.next();
            //若名称和电话都为空则去掉此对象
            if (clientExcel.getKhmc().equals("")||clientExcel.getKhsjh().equals("")) {
                it.remove();
            }
        }
        List<Client> clientlist = new ArrayList<>();
        for (ClientExcel clientExcel : list) {
            Client client = new Client();
            client.setKhId(IDUtils.getId());
            client.setKhmc(clientExcel.getKhmc());
            client.setKhsjh(clientExcel.getKhsjh());
            client.setCjrId(userId);
            clientlist.add(client);
        }
        return clientlist;
    }

    /**
     * 解析excel表中数据并封装成list集合
     *
     * @param beanpros      bean对应字段的map
     * @param classPathName 进行封装数据的对象全路径
     * @param sheet         解析的sheet
     * @return
     */
    public static List<ClientExcel> getDataToBean(Map<Integer, String> beanpros, String classPathName, Sheet sheet) {
        List<ClientExcel> beanList = new ArrayList<>();
        try {
            Class clazz = Class.forName(classPathName);
            Set<Integer> set = beanpros.keySet();
            int beginRow = 1;
            Row row = sheet.getRow(beginRow);
            while (row != null) {
                Object obj = clazz.newInstance();
                for (Integer key : set) {
                    String value = "";
                    if (row != null) {
                        Cell cell = row.getCell(key);
                        value = getCellValue(cell);
                    }
                    PropertyDescriptor pd = new PropertyDescriptor(beanpros.get(key), clazz);
                    Method wM = pd.getWriteMethod();
                    wM.invoke(obj, value);
                }
                beanList.add((ClientExcel) obj);
                row = sheet.getRow(++beginRow);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return beanList;
    }

    /**
     * BatchInvoice对象中的字段
     *
     * @return map
     */
    public static Map<Integer, String> getBeanPros() {
        Map<Integer, String> beanpros = new HashMap<Integer, String>();
        beanpros.put(0, "khmc");
        beanpros.put(1, "khsjh");
        return beanpros;
    }

    /**
     * 获取excel中的sheet表
     *
     * @param filePath excel文件路径地址
     * @return
     */
    public static Sheet getSheet(String filePath) {
        Sheet sheet = null;
        boolean isE2007 = false;
        if (filePath.endsWith("xlsx")) {
            isE2007 = true;
        }
        try {
            InputStream input = new FileInputStream(filePath);
            Workbook wb = null;
            if (isE2007) {
                wb = new XSSFWorkbook(input);
            } else {
                wb = new HSSFWorkbook(input);
            }
            sheet = wb.getSheetAt(0);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return sheet;
    }

    /**
     * 获取excel单元格内容
     *
     * @param cell
     * @return
     */
    public static String getCellValue(Cell cell) {
        String value = "";
        if (cell != null) {
            int type = cell.getCellType();
            if (type == Cell.CELL_TYPE_STRING) {
                value = String.valueOf(cell.getStringCellValue());
            } else if (type == Cell.CELL_TYPE_NUMERIC) {
                value = String.valueOf(cell.getNumericCellValue());
            } else if (type == Cell.CELL_TYPE_BOOLEAN) {
                value = String.valueOf(cell.getBooleanCellValue());
            } else if (type == Cell.CELL_TYPE_FORMULA) {
                try {
                    DecimalFormat df = new DecimalFormat("0.00");
                    value = df.format(cell.getNumericCellValue());
                } catch (IllegalStateException e) {
                    value = String.valueOf(cell.getRichStringCellValue());
                }
            }
        }
        return value;
    }

    @SuppressWarnings("unchecked")
    public static void export(String[][] columnNames,
                              Pages<?> listData, String fileName, HttpServletResponse response) {

        JSONObject json = (JSONObject) JSON.toJSON(listData);
        JSONArray arr = (JSONArray) json.get("result");

        List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
        Map<String, Object> map0 = new HashMap<String, Object>();
        map0.put("sheetName", "sheet1");
        list.add(map0);
        for (int i = 0; i < arr.size(); i++) {
            JSONObject obj = arr.getJSONObject(i);
            Map<String, Object> map = (Map<String, Object>) JSON.parseObject(JSON.toJSONString(JSON.parseObject(JSON.toJSONString(obj), listData.getResult().get(0).getClass())), Map.class);
            list.add(map);
        }

        try {
            fileName = fileName + ".xls";
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            ExportToExcelUtil.createWorkBook(list, columnNames).write(baos);
            byte[] content = baos.toByteArray();
            InputStream is = new ByteArrayInputStream(content);
            response.reset();
            response.setContentType("application/vnd.ms-excel;charset=UTF-8");
            response.setHeader("Content-Disposition", "attachment;filename=" + new String(fileName.getBytes("UTF-8"), "ISO8859-1"));
            ServletOutputStream sos = response.getOutputStream();
            BufferedInputStream bis = null;
            BufferedOutputStream bos = null;
            try {
                bis = new BufferedInputStream(is);
                bos = new BufferedOutputStream(sos);
                byte[] buff = new byte[2048];
                int bytesRead;
                while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
                    bos.write(buff, 0, bytesRead);
                }
            } catch (Exception e) {
                throw e;
            } finally {
                if (bis != null) {
                    bis.close();
                }
                if (bos != null) {
                    bos.close();
                }
            }
        } catch (Exception e) {
            LOGGER.error("导出excel异常:{}", e.getMessage());
        }
    }


}