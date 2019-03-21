package dev.mvc.dawara;

import java.util.Locale;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HomeController {
  // "/" : http://localhost:9090/dawara/
  //"/index.do" : http://localhost:9090/dawara/index.do
	@RequestMapping(value = {"/", "/index.do"}, method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
	  
	  
	  
	  
		return "/index";
	}
	
	@RequestMapping(value = {"/", "/top.do"}, method = RequestMethod.GET)
	public ModelAndView top() {
	  ModelAndView mav = new ModelAndView();
	  mav.setViewName("/menu/top");
	  
	  return mav; 
	}
	
	@RequestMapping(value = {"/", "/bottom.do"}, method = RequestMethod.GET)
	public ModelAndView bottom() {
	  ModelAndView mav = new ModelAndView();
	  mav.setViewName("/menu/bottom");
	  
	  return mav;
	}
	
}
