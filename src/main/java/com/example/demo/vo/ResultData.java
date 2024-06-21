package com.example.demo.vo;

import lombok.Data;

@Data
public class ResultData {
	private String resultCode;
	private String resultMsg;
	private Object data;

	public static ResultData from(String resultCode, String resultMsg) {
		return from(resultCode, resultMsg, null);
	}

	public static ResultData from(String resultCode, String resultMsg, Object data) {
		
		ResultData result = new ResultData();
		
		result.resultCode = resultCode;
		result.resultMsg = resultMsg;
		result.data = data;
		
		return result;
	}
	
	public boolean isSuccess() {
		return this.resultCode.startsWith("S-");
	}
	
	public boolean isFail() {
		return isSuccess() == false;
	}
	
}