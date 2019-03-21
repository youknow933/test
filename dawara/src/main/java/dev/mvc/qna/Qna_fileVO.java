package dev.mvc.qna;

public class Qna_fileVO {
  private String qna_thumbs;
  private String qna_files;
  private String qna_sizes;

  public Qna_fileVO() {

  }

  public Qna_fileVO(String qna_thumbs, String qna_files, String qna_sizes) {
    super();
    this.qna_thumbs = qna_thumbs;
    this.qna_files = qna_files;
    this.qna_sizes = qna_sizes;
  }

  /**
   * @return the thumb
   */
  public String getQna_thumbs() {
    return qna_thumbs;
  }

  /**
   * @param thumb the thumb to set
   */
  public void setQna_thumbs(String qna_thumbs) {
    this.qna_thumbs = qna_thumbs;
  }

  /**
   * @return the file
   */
  public String getQna_files() {
    return qna_files;
  }

  /**
   * @param file the file to set
   */
  public void setQna_files(String qna_files) {
    this.qna_files = qna_files;
  }

  /**
   * @return the size
   */
  public String getQna_sizes() {
    return qna_sizes;
  }

  /**
   * @param size the size to set
   */
  public void setQna_sizes(String qna_sizes) {
    this.qna_sizes = qna_sizes;
  }
  
}

