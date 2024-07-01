package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.vo.ResultData;

@Controller
public class UsrHomeController {
	
	@GetMapping("/usr/home/main")
	public String showMain() {
		return "/usr/home/main";
	}

	@GetMapping("/")
	public String root() {
		return "redirect:/usr/home/main";
	}
	
	@GetMapping("/usr/home/test")
	@ResponseBody
	public ResultData<String> test(String key1, String key2) {
		return ResultData.from("코드", key1 + key2);
	}

}