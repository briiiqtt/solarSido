package solar.prod.plan.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import solar.prod.plan.service.ProdPlanService;
import solar.prod.plan.service.ProdPlanVO;
import solar.sales.order.dao.ModifyVO;

@Service
public class ProdPlanServiceImpl implements ProdPlanService {

	@Autowired ProdPlanMapper ppMapper;

	@Override
	public List<ProdPlanVO> selectPlan(ProdPlanVO ppVo) {
		return ppMapper.selectPlan(ppVo);
	}

	@Override
	public int modifyData(ModifyVO<ProdPlanVO> mvo) {
		if(mvo.getCreatedRows()!=null) {
			for(ProdPlanVO ppVo : mvo.getCreatedRows()) {
				ppMapper.insertPlanD(ppVo);
				System.out.println("ins mvo:" + mvo);
				}
			}
		if(mvo.getDeletedRows()!=null) {
			for(ProdPlanVO ppVo : mvo.getDeletedRows()) {
				ppMapper.deletePlanD(ppVo);
				System.out.println("del mvo:" + mvo);
				System.out.println("del ppvo: " + ppVo);
				System.out.println("del rows:" + mvo.getDeletedRows());
				}
			}
		if(mvo.getUpdatedRows()!=null) {
			for(ProdPlanVO ppVo : mvo.getUpdatedRows()) {
				ppMapper.updatePlanD(ppVo);
				System.out.println("upd mvo:" + mvo);
				}
			}
		return 1;
	}
	
	@Override
	public List<ProdPlanVO> findProdPlan(ProdPlanVO ppVo) {
		return ppMapper.findProdPlan(ppVo);
	}
	
	@Override
	public List<ProdPlanVO> searchPlan(ProdPlanVO ppVo) {
		return ppMapper.searchPlan(ppVo);
	}
	
	@Override
	public List<ProdPlanVO> findOrder(ProdPlanVO ppVo) {
		return ppMapper.findOrder(ppVo);
	}
	
	@Override
	public List<ProdPlanVO> searchOrder(ProdPlanVO ppVo) {
		return ppMapper.searchOrder(ppVo);
	}
	
	@Override
	public List<ProdPlanVO> findCoCd(ProdPlanVO ppVo) {
		return ppMapper.findCoCd(ppVo);
	}

	@Override
	public List<ProdPlanVO> findPrdtCd(ProdPlanVO ppVo) {
		return ppMapper.findPrdtCd(ppVo);
	}

	@Override
	public List<?> selectPstc(ProdPlanVO ppVo) {
		return ppMapper.selectPstc(ppVo);
	}

	@Override
	public List<?> selectRstc(ProdPlanVO ppVo) {
		return ppMapper.selectRstc(ppVo);
	}

}
