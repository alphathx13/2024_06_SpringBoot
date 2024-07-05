package com.example.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Festival {
	private int id;
	private String regDate;
	private String updateDate;
	private String loginId;
	private String loginPw;
	private String name;
	private String nickname;
	private String cellphone;
	private String email;
	
	private int eventSeq;
	private String contents;
	private String placeCdNm;
	private String targetCdNm;
	private String managementCdNm;
	private String themeCdNm;
	private String title;
	private String beginDt;
	private String endDt;
	private String themeCd;
	private String placeCd;
	private String imageLink;
	private String recommendationYn;
	private String hotYn;
	private String useYn;
	private int hit;
	private String beginTm;
	private String endTm;
	private int recommendationPoint;
	private int notRecommandationPoint;
	private int targetCd;
	private int managementCd;
	private String placeDetail;
	private String dataStnDt;
	private String opmtnInstt;
	private String chargeInfo;
	private String eventTm;
	private String prpleHoldYn;
	private String homepageAdd;

}