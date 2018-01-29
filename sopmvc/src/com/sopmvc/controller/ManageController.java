package com.sopmvc.controller;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/welcom")
public class ManageController{

   @RequestMapping(value="/mod_search",method = RequestMethod.GET)
   public String mod_search(HttpServletRequest request,HttpServletResponse response) {
        return "mod_search";
   }
   @RequestMapping(value="/search",method = RequestMethod.GET)
   public String search(HttpServletRequest request,HttpServletResponse response) {
        return "search";
   }
   @RequestMapping(value="/log_search",method = RequestMethod.GET)
   public String log_search(HttpServletRequest request,HttpServletResponse response) {
        return "log_search";
   }
   @RequestMapping(value="/log_find",method = RequestMethod.GET)
   public String log_find(HttpServletRequest request,HttpServletResponse response) {
        return "log_find";
   }
   
}

