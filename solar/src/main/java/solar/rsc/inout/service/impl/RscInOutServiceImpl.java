package solar.rsc.inout.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import solar.rsc.inout.service.RscInOut;
import solar.rsc.inout.service.RscInOutService;

@Service
public class RscInOutServiceImpl implements RscInOutService {

	@Autowired RscInOutMapper rscInOutMapper;
	
	@Override
	public List<RscInOut> selectAll() {
		return rscInOutMapper.selectAll();
	}

	@Override
	public int insert(RscInOut rscInOut) {
		return rscInOutMapper.insert(rscInOut);
	}

	@Override
	public int stcInc(RscInOut rscInOut) {
		return rscInOutMapper.stcInc(rscInOut);
	}

}