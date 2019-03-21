package dev.mvc.mileage;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

@Component("dev.mvc.mileage.MileageProc")
public class MileageProc implements MileageProcInter {
  @Autowired
  @Qualifier("dev.mvc.mileage.MileageDAO")
  private MileageDAOInter MileageDAO;
  
  public MileageProc(){
    System.out.println("--> MileageProc created.");
  }

  @Override
  public int create(MileageVO mileageVO) {
    int count = MileageDAO.create(mileageVO);
    return count;
  }
  
  @Override
  public List<MileageVO> list() {
    List<MileageVO> list = MileageDAO.list();
    
    return list;
  }
  
  
  @Override
  public MileageVO read(int mileage_no) {
    return MileageDAO.read(mileage_no);
  }
 
  @Override
  public int update(MileageVO mileageVO) {
    return MileageDAO.update(mileageVO);
  }
 
  @Override
  public int delete(int mileage_no) {
    return MileageDAO.delete(mileage_no);
  }
  
  @Override
  public List<MileageVO> list_by_mem_no(int mem_no) {
    List<MileageVO> list = MileageDAO.list_by_mem_no(mem_no); 
    Iterator<MileageVO> iter = list.iterator();
    
    return list;
  }
 
  
  @Override
  public List<MileageVO> list_by_mileage_search(HashMap hashMap) {
    List<MileageVO> list = MileageDAO.list_by_mileage_search(hashMap); 
    Iterator<MileageVO> iter = list.iterator();
     
    return list;
  } 
 
  @Override
  public int search_count(HashMap hashMap) { 
    int cnt = MileageDAO.search_count(hashMap);
    
    return cnt;
  }
  
  
  @Override
  public List<MileageVO> list_by_mileage_search_paging(HashMap hashMap) {
    /* 
     ���������� ����� ���� ���ڵ� ��ȣ ��� ���ذ�, nowPage�� 1���� ����
     1 ������: nowPage = 1, (1 - 1) * 10 --> 0 
     2 ������: nowPage = 2, (2 - 1) * 10 --> 10
     3 ������: nowPage = 3, (3 - 1) * 10 --> 20
     */
    int beginOfPage = ((Integer)hashMap.get("nowPage") - 1) * Mileage.RECORD_PER_PAGE;
    
     // ���� rownum, 1 ������: 1 / 2 ������: 11 / 3 ������: 21 
    int startNum = beginOfPage + 1; 
    //  ���� rownum, 1 ������: 10 / 2 ������: 20 / 3 ������: 30
    int endNum = beginOfPage + Mileage.RECORD_PER_PAGE;   
    /*
     1 ������: WHERE r >= 1 AND r <= 10
     2 ������: WHERE r >= 11 AND r <= 20
     3 ������: WHERE r >= 21 AND r <= 30
     */
    hashMap.put("startNum", startNum);
    hashMap.put("endNum", endNum);
    
    List<MileageVO> list = MileageDAO.list_by_mileage_search_paging(hashMap); 
    Iterator<MileageVO> iter = list.iterator();
    
    return list;
  }
 
  /** 
   * SPAN�±׸� �̿��� �ڽ� ���� ����, 1 ���������� ���� 
   * ���� ������: 11 / 22   [����] 11 12 13 14 15 16 17 18 19 20 [����] 
   *
   * @param categoryno ī�װ���ȣ 
   * @param search_count �˻�(��ü) ���ڵ�� 
   * @param nowPage     ���� ������
   * @param word �˻���
   * @return ����¡ ���� ���ڿ�
   */ 
  public String paging(int mem_no, int search_count, int nowPage, String word){ 
    int totalPage = (int)(Math.ceil((double)search_count/Mileage.RECORD_PER_PAGE)); // ��ü ������  
    int totalGrp = (int)(Math.ceil((double)totalPage/Mileage.PAGE_PER_BLOCK));// ��ü �׷� 
    int nowGrp = (int)(Math.ceil((double)nowPage/Mileage.PAGE_PER_BLOCK));    // ���� �׷� 
    int startPage = ((nowGrp - 1) * Mileage.PAGE_PER_BLOCK) + 1; // Ư�� �׷��� ������ ��� ����  
    int endPage = (nowGrp * Mileage.PAGE_PER_BLOCK);             // Ư�� �׷��� ������ ��� ����   
     
    StringBuffer str = new StringBuffer();  
     
    str.append("<style type='text/css'>"); 
    str.append("  #paging {text-align: center; margin-top: 5px; font-size: 1em;}"); 
    str.append("  #paging A:link {text-decoration:none; color:black; font-size: 1em;}"); 
    str.append("  #paging A:hover{text-decoration:none; background-color: #FFFFFF; color:black; font-size: 1em;}"); 
    str.append("  #paging A:visited {text-decoration:none;color:black; font-size: 1em;}"); 
    str.append("  .span_box_1{"); 
    str.append("    text-align: center;");    
    str.append("    font-size: 1em;"); 
    str.append("    border: 1px;"); 
    str.append("    border-style: solid;"); 
    str.append("    border-color: #cccccc;"); 
    str.append("    padding:1px 6px 1px 6px; /*��, ������, �Ʒ�, ����*/"); 
    str.append("    margin:1px 2px 1px 2px; /*��, ������, �Ʒ�, ����*/"); 
    str.append("  }"); 
    str.append("  .span_box_2{"); 
    str.append("    text-align: center;");    
    str.append("    background-color: #668db4;"); 
    str.append("    color: #FFFFFF;"); 
    str.append("    font-size: 1em;"); 
    str.append("    border: 1px;"); 
    str.append("    border-style: solid;"); 
    str.append("    border-color: #cccccc;"); 
    str.append("    padding:1px 6px 1px 6px; /*��, ������, �Ʒ�, ����*/"); 
    str.append("    margin:1px 2px 1px 2px; /*��, ������, �Ʒ�, ����*/"); 
    str.append("  }"); 
    str.append("</style>"); 
    str.append("<DIV id='paging'>"); 
//    str.append("���� ������: " + nowPage + " / " + totalPage + "  "); 
 
    // ���� 10�� �������� �̵�
    // nowGrp: 1 (1 ~ 10 page),  nowGrp: 2 (11 ~ 20 page),  nowGrp: 3 (21 ~ 30 page) 
    // ���� 2�׷��� ���: (2 - 1) * 10 = 1�׷��� 10
    // ���� 3�׷��� ���: (3 - 1) * 10 = 2�׷��� 20
    int _nowPage = (nowGrp-1) * Mileage.PAGE_PER_BLOCK;  
    if (nowGrp >= 2){ 
      str.append("<span class='span_box_1'><A href='./list_by_mileage_search_paging.do?&word="+word+"&nowPage="+_nowPage+"&mem_no="+mem_no+"'>����</A></span>"); 
    } 
 
    for(int i=startPage; i<=endPage; i++){ 
      if (i > totalPage){ 
        break; 
      } 
  
      if (nowPage == i){ 
        str.append("<span class='span_box_2'>"+i+"</span>"); // ���� ������, ���� 
      }else{
        // ���� �������� �ƴ� ������
        str.append("<span class='span_box_1'><A href='./list_by_mileage_search_paging.do?word="+word+"&nowPage="+i+"&mem_no="+mem_no+"'>"+i+"</A></span>");   
      } 
    } 
 
    // 10�� ���� �������� �̵�
    // nowGrp: 1 (1 ~ 10 page),  nowGrp: 2 (11 ~ 20 page),  nowGrp: 3 (21 ~ 30 page) 
    // ���� 1�׷��� ���: (1 * 10) + 1 = 2�׷��� 11
    // ���� 2�׷��� ���: (2 * 10) + 1 = 3�׷��� 21
    _nowPage = (nowGrp * Mileage.PAGE_PER_BLOCK)+1;  
    if (nowGrp < totalGrp){ 
      str.append("<span class='span_box_1'><A href='./list_by_mileage_search_paging.do?&word="+word+"&nowPage="+_nowPage+"&mem_no="+mem_no+"'>����</A></span>"); 
    } 
    str.append("</DIV>"); 
     
    return str.toString(); 
  }
 
 
}