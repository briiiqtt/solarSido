package solar.prod.indica.service;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class IndicaVO extends IndRscVO {
	
	//생산지시
	String indicaNo;	//지시번호
	String indicaDt;	//지시일자                                                                                                                                                                     
	String indicaNm;	//지시명
	
	//생산지시상세
	int indicaDetaNo;	//지시상세번호
	int planDetaNo;		//계획상세번호
	String prdtCd;		//제품코드
	String prodFg;		//생산구분
	int indicaQty;		//지시량
	String wkOrd;		//작업순서
	String wkDt;		//작업일자
	String planDt;		//계획일자
	int dayOutput; 		//일생산량 
	String prodDay;		//생산일수
	
	//생산소요자재
	int rscConNo;		//소요자재번호
	String recvDt;		//접수일자
	String orderNo;		//주문번호
	String rscLot;		//자재LotNo
	int rscConQty;		//소요량
	
	//검색
	String startT; 		//기간시작
	String endT;		//기간끝
	String prdtNm; 		//제품명
	String prdtSpec;	//제품규격
	String prdtUnit;	//제품단위
	String coCd;		//업체코드
	String coNm;		//업체명
	String bizno;		//사업자등록번호
	String coFg;		//업체구분
	String nowSt;		//진행상태
	
	//주문
	String paprdDt;		//납기일자
	int orderQty; 		//주문량
	
	//제품BOM, 자재
	String rscCd;		//자재코드
	String rscNm;		//자재명
	int rscUseQty;		//소요량
	int rscQty;			//수량
	int rscStc;			//자재재고
	int totalUseQty;	//총소요량
	
	//계획
	int planQty;		//계획량

}
