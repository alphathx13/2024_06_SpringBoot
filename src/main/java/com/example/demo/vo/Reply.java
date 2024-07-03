package com.example.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Reply {
	private int id;
	private int memberNumber;
	private String relTypeCode;
	private int relId;
	private String body;
	private String regDate;
	private String updateDate;
	private String nickname;
	
	public String getBody() {
		return this.body.replaceAll("\n", "<br />");
	}
}