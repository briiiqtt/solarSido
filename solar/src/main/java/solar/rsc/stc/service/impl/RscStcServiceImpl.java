package solar.rsc.stc.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import solar.rsc.stc.service.RscStc;
import solar.rsc.stc.service.RscStcService;

@Service
public class RscStcServiceImpl implements RscStcService {

	@Autowired RscStcMapper rscStcMapper;
	
	@Override
	public List<RscStc> selectAll() {
		return rscStcMapper.selectAll();
	}

}
