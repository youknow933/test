package yoonho.member.exeption;

public class MemberException  extends RuntimeException{
  private static final long serialVersionUID = 1L;
  
  public MemberException(){
    super("MemberDAOException Occurs");
  }
  
  public MemberException(String msg) {
    super(msg);
  }


  
  
      

}
