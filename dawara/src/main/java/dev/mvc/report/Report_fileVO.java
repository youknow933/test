package dev.mvc.report;

public class Report_fileVO {
  private String report_thumbs;
  private String report_files;
  private String report_sizes;

  public Report_fileVO() {

  }

  public Report_fileVO(String report_thumbs, String report_files, String report_sizes) {
    super();
    this.report_thumbs = report_thumbs;
    this.report_files = report_files;
    this.report_sizes = report_sizes;
  }

  /**
   * @return the thumb
   */
  public String getReport_thumbs() {
    return report_thumbs;
  }

  /**
   * @param thumb the thumb to set
   */
  public void setReport_thumbs(String report_thumbs) {
    this.report_thumbs = report_thumbs;
  }

  /**
   * @return the file
   */
  public String getReport_files() {
    return report_files;
  }

  /**
   * @param file the file to set
   */
  public void setReport_files(String report_files) {
    this.report_files = report_files;
  }

  /**
   * @return the size
   */
  public String getReport_sizes() {
    return report_sizes;
  }

  /**
   * @param size the size to set
   */
  public void setReport_sizes(String report_sizes) {
    this.report_sizes = report_sizes;
  }
  
}

