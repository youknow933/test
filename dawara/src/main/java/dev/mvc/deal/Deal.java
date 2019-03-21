package dev.mvc.deal;

//상수 클래스
public class Deal {
  
  /** 페이지당 출력할 레코드 갯수 */
  public static int RECORD_PER_PAGE = 5; // final이 없으므로 값이 바뀔 수 있음
  
  /** 블럭당 페이지 수, 하나의 블럭은 1개 이상의 페이지로 구성됨 */
  public static int PAGE_PER_BLOCK = 10; // final이 없으므로 값이 바뀔 수 있음
}
