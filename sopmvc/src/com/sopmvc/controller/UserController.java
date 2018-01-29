package com.sopmvc.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sopmvc.dao.UserDao;

@Controller
@RequestMapping("/login.do")
public class UserController{

   @RequestMapping(method = RequestMethod.POST)
   public String loginControl(HttpServletRequest request,HttpServletResponse response) {
        String username = request.getParameter("username");
		String password = request.getParameter("password");
		String psw =new UserDao().findUsername(username);
		if(psw.equals(password)){
			request.getSession().setAttribute("username", username);
			return "welcom";
		}else {
			return "errUser";
		}
   }
   
}