package dev.mvc.notice;

public class No_fileVO {
  private String no_thumbs;
  private String no_files;
  private String no_sizes;

  public No_fileVO() {

  }

  public No_fileVO(String no_thumbs, String no_files, String no_sizes) {
    super();
    this.no_thumbs = no_thumbs;
    this.no_files = no_files;
    this.no_sizes = no_sizes;
  }

  /**
   * @return the thumb
   */
  public String getNo_thumbs() {
    return no_thumbs;
  }

  /**
   * @param thumb the thumb to set
   */
  public void setNo_thumbs(String no_thumbs) {
    this.no_thumbs = no_thumbs;
  }

  /**
   * @return the file
   */
  public String getNo_files() {
    return no_files;
  }

  /**
   * @param file the file to set
   */
  public void setNo_files(String no_files) {
    this.no_files = no_files;
  }

  /**
   * @return the size
   */
  public String getNo_sizes() {
    return no_sizes;
  }

  /**
   * @param size the size to set
   */
  public void setNo_sizes(String no_sizes) {
    this.no_sizes = no_sizes;
  }
  
}

