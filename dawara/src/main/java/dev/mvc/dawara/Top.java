package dev.mvc.dawara;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class Top {
  // http://localhost:9090/dawara/menu/top.do
  @RequestMapping(value = "/menu/top.do", method = RequestMethod.GET)
  public String create() {
    return "/menu/top";
  }
  
}
