package solar.prcs2.service;

import java.util.List;

import solar.prcs2.dao.EqmAble;
import solar.prcs2.dao.Prcs2;
import solar.prcs2.dao.PrcsIng;
import solar.sales.order.dao.ModifyVO;

public interface Prcs2Service {
	List<Prcs2> searchPlanList(Prcs2 vo);
	List<Prcs2> findTemp();
	int insertData(Prcs2 vo);
	//int insertDetail(ModifyVO<Prcs2> mvo);
	int insertDetailO(ModifyVO<Prcs2> mvo);
	List<PrcsIng> prIng(Prcs2 vo);
	List<Prcs2> repeat(Prcs2 vo);
	List<EqmAble> allYEqm();
}
