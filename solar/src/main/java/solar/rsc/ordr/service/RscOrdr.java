package solar.rsc.ordr.service;

import lombok.Data;
  
@Data
public class RscOrdr {
	String ordrDt;
	String rscNm;
	String rscCd;
	String ordrQty;
	String ordrCd;
	String coNm;
	String rscIstQty;
	String rscInferQty;
	String inspCls;
	String rscPassedQty;
	String rtngdResnCd;
	String rtngdDt;
	String coCd;
	String whereParam;
	//자재발주요청
	String dmndNo;
	String dmndQty;
	String lackQty;
}
