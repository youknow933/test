package dev.mvc.product;

public class Pr_fileVO {
  private String pr_thumb;
  private String pr_file;
  private String pr_size;

  public Pr_fileVO() {

  }

  public Pr_fileVO(String pr_thumb, String pr_file, String pr_size) {
    super();
    this.pr_thumb = pr_thumb;
    this.pr_file = pr_file;
    this.pr_size = pr_size;
  }

  /**
   * @return the pr_thumb
   */
  public String getPr_thumb() {
    return pr_thumb;
  }

  /**
   * @param pr_thumb the pr_thumb to set
   */
  public void setPr_thumb(String pr_thumb) {
    this.pr_thumb = pr_thumb;
  }

  /**
   * @return the pr_file
   */
  public String getPr_file() {
    return pr_file;
  }

  /**
   * @param pr_file the pr_file to set
   */
  public void setPr_file(String pr_file) {
    this.pr_file = pr_file;
  }

  /**
   * @return the pr_size
   */
  public String getPr_size() {
    return pr_size;
  }

  /**
   * @param pr_size the pr_size to set
   */
  public void setPr_size(String pr_size) {
    this.pr_size = pr_size;
  }
  
  
  
}

