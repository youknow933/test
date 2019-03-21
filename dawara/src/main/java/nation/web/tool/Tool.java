package nation.web.tool;
// version 0.5

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.awt.image.PixelGrabber;
import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

//
// �����ڰ� ���� �����ϴ� ���� ��� 
public class Tool {
  
  /**
   * �α��ε� ȸ�� �������� �˻��մϴ�.
   * @param request
   * @return true: ������
   */
  public static synchronized boolean isMember(HttpSession session){
    boolean sw = false;
    
    String id = (String)session.getAttribute("id");
    
    if (id != null){
      sw = true;
    }
    return sw; // ���̵� null�̸� false, null�� �ƴϸ� true
  }
  
  /**
   * ������ �Է¹޾� ���� ��θ� �����մϴ�. 
   * ��) getRealPath(request, "/media/storage")
   * 
   * @param request
   * @param dir ���� ��θ� ���� ������
   * @return ���� ��� ���� C:/ai2/sw_images/...
   * @throws IOException
   */
  public static synchronized String getRealPath(HttpServletRequest request, String dir) {
    String path = "";
    
    try{
      path = request.getRealPath(dir) + "/";  
      // System.out.println("Upload path: " + path);
    }catch(Exception e){
      System.out.println(e.toString());
    }
 
    return path;
  }
 
  /**
   * ���� ����
   * @param fname
   * @return
   */
  public static synchronized boolean deleteFile(String fname) {
    File file = new File(fname);
    boolean ret = false;
    
      if (file.exists()){
        ret = file.delete();
      }
    
    return ret;
  }
 
  
  public static synchronized String comma(long no) { // 3�ڸ� ���� �޸�(,)
    String str = "";
    DecimalFormat df = new DecimalFormat("#,###,###");
    str = df.format(no);
    
    return  str;
  }
  
  /**
   * ������ �����մϴ�.
   */
  public static synchronized boolean deleteFile(String folder, String fileName) {
    boolean ret = false;
 
    try {
      if (fileName != null) { // ������ ������ �����ϴ� ��� ����
        File file = new File(folder + "/" + fileName);
        if (file.exists() && file.isFile()) { // �����ϴ� �������� �˻�
          ret = file.delete();
        }
      }
    } catch (Exception e) {
      e.printStackTrace();
    }
 
    return ret;
  }

  /**
   * HTML Ư�� ������ ����, TD �±׵ ���
   * @param str
   * @return
   */
  public static synchronized String convertChar(String str) { // html Ư������
                                                              // entity
    str = str.replaceAll("<", "&lt;"); // &#60;
    str = str.replaceAll(">", "&gt;"); // &#62;
    str = str.replaceAll("'", "&#39");
    str = str.replaceAll("\"", "&quot;"); // &#34;
    str = str.replaceAll("\r\n", "<BR>");

    return str;
  }
  
  /**
   * HTML Ư�� ������ ����, ���� �и����� ����. TEXTAREA �±׵ ���.
   * @param str
   * @return
   */
  public static synchronized String convertChar2(String str) {
    str = str.replaceAll("<", "&lt;"); // &#60;
    str = str.replaceAll(">", "&gt;"); // &#62;
    str = str.replaceAll("'", "&#39");
    str = str.replaceAll("\"", "&quot;"); // &#34;
    
    return str;
  }

  /**
   * ���ڿ��� ���̰� length ���� ũ�� "..." �� ǥ���ϴ� �޼ҵ�
   * 
   * @param str ���ڿ�
   * @param length ������ ���ڿ� ����
   * @return
   */
  public static synchronized String textLength(String str, int length) {

    if (str != null) {
      if (str.length() > length) { // �־��� ���� ������ ũ�ٸ�
        str = str.substring(0, length) + "..."; // ����: 0 ~ length - 1 ����
      }
    } else {
      str = "";
    }

    return str;
  }

  /**
   * null Ư�� ���ڳ� "null" ���ڿ��� ���� ""���� �����մϴ�.
   * 
   * @param str ���� ���ڿ�
   * @return ����� ���ڿ�
   */
  public static synchronized String checkNull(String str) {
    if (str == null) {
      return "";
    } else if (str.equals("null")) {
      return "";
    } else {
      return str;
    }
  }

  /**
   * �̹������� �˻�
   * @param file
   * @return
   */
  public static synchronized boolean isImage(String file) {
    boolean sw = false;

    if (file != null) {
      file = file.toLowerCase(); // �ҹ���
      if (file.endsWith(".jpg") || file.endsWith(".jpeg") || file.endsWith(".png") || file.endsWith(".gif")) {
        sw = true;
      }
    }
    return sw;
  }

  /**
   * ���� ���޹޾� �ڷ��� ������ �����մϴ�.
   * 
   * @param size
   * @return 1000 > 1000 Byte
   */
  // static�޼ҵ�� ����ȭ���� ���� �� �ٿ�� �� ����
  public static synchronized String unit(long size) {
    String str = "";

    if (size < 1024) { // 1 KB ����
      str = size + " Byte";
    } else if (size < 1024 * 1024) { // 1 MB ����
      str = (int) (Math.ceil(size / 1024.0)) + " KB"; // 1048576 ���� ������ KB
    } else if (size < 1024 * 1024 * 1024) { // 1 GB ����
      str = (int) (Math.ceil(size / 1024.0 / 1024.0)) + " MB";
    } else if (size < 1024L * 1024 * 1024 * 1024) { // 1 TB ����
      // 1024L: long�� ���
      str = (int) (Math.ceil(size / 1024.0 / 1024.0 / 1024.0)) + " GB";
    } else if (size < 1024L * 1024 * 1024 * 1024 * 1024) { // 1 PT ����
      str = (int) (Math.ceil(size / 1024.0 / 1024.0 / 1024.0 / 1024.0)) + " TB";
    } else if (size < 1024L * 1024 * 1024 * 1024 * 1024 * 1024) { // 1 EX ����
      str = (int) (Math.ceil(size / 1024.0 / 1024.0 / 1024.0 / 1024.0 / 1024.0)) + " PT";
    }

    return str;
  }

  /**
   * �̹��� ����� �����Ͽ� ���ο� Preview(�����) �̹����� �����մϴ�.
   * 
   * <pre>
   *  ���� �״�θ� ���, synchronized: Thead���
   ��뿹): Too.preview(folder ��, ���� ���ϸ�, 200, 150)
   * </pre>
   * 
   * @param upDir ���� �̹��� ����
   * @param _src ���� ���ϸ�
   * @param width ������ �̹��� �ʺ�
   * @param height ������ �̹��� ����, ImageUtil.RATIO�� �ڵ� ��� ����
   * @return src.jpg ������ �̿��Ͽ� src_t.jpg ������ �����Ͽ� ���ϸ� ����
   */
  public static synchronized String preview(String upDir, String _src, int width, int height) {
    int RATIO = 0;
    int SAME = -1;

    File src = new File(upDir + "/" + _src); // ���� ���� ��ü ���� // java.io.File
    String srcname = src.getName(); // ���� ���ϸ� ����

    // ���� ���ϸ� ����, mt.jpg -> mt �� ����
    String _dest = srcname.substring(0, srcname.indexOf("."));

    // ��� �̹��� ���� /upDir/mt_t.jpg
    File dest = new File(upDir + "/" + _dest + "_t.jpg");

    Image srcImg = null; // java.awt ��Ű��, ��ü ������ �ʾ���
    // ������ Ȯ���� ����
    String name = src.getName().toLowerCase(); // ���ϸ� ����, �ҹ��ڷ� ����

    // �̹��� �������� �˻�
    if (name.endsWith("jpg") || name.endsWith("bmp") || name.endsWith("png") || name.endsWith("gif")) {
      try {
        srcImg = ImageIO.read(src); // �޸𸮿� ���� �̹��� ����, src: Call by Reference
        int srcWidth = srcImg.getWidth(null); // ���� �̹��� �ʺ� ����
        int srcHeight = srcImg.getHeight(null); // ���� �̹��� ���� ����
        int destWidth = -1, destHeight = -1; // ��� �̹��� ũ�� �ʱ�ȭ

        if (width == SAME) { // width�� ���� ���
          destWidth = srcWidth;
        } else if (width > 0) {
          destWidth = width; // ���ο� width�� �Ҵ�
        }

        if (height == SAME) { // ���̰� ���� ���
          destHeight = srcHeight;
        } else if (height > 0) {
          destHeight = height; // ���ο� ���̷� �Ҵ�
        }

        // ������ ���� ũ�� ���
        if (width == RATIO && height == RATIO) {
          destWidth = srcWidth;
          destHeight = srcHeight;
        } else if (width == RATIO) {
          double ratio = ((double) destHeight) / ((double) srcHeight);
          destWidth = (int) ((double) srcWidth * ratio);
        } else if (height == RATIO) {
          double ratio = ((double) destWidth) / ((double) srcWidth);
          destHeight = (int) ((double) srcHeight * ratio);
        }

        // �޸𸮿� ��� �̹��� ���� Call by reference
        Image imgTarget = srcImg.getScaledInstance(destWidth, destHeight, Image.SCALE_SMOOTH);
        int pixels[] = new int[destWidth * destHeight];
        PixelGrabber pg = new PixelGrabber(imgTarget, 0, 0, destWidth, destHeight, pixels, 0, destWidth); // �̹�����

        pg.grabPixels();

        BufferedImage destImg = new BufferedImage(destWidth, destHeight, BufferedImage.TYPE_INT_RGB); // �޸𸮿�
                                                                                                      // �׸�
        destImg.setRGB(0, 0, destWidth, destHeight, pixels, 0, destWidth);

        // ���Ͽ� ���
        ImageIO.write(destImg, "jpg", dest);

        System.out.println(dest.getName() + " �̹����� �����߽��ϴ�.");
      } catch (Exception e) {
        e.printStackTrace();
      }
    }

    return dest.getName();
  }

}
