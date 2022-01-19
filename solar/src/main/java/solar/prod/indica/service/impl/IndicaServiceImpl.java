package solar.prod.indica.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import solar.prod.indica.service.IndicaService;
import solar.prod.indica.service.IndicaVO;

@Service
public class IndicaServiceImpl implements IndicaService {
	
	@Autowired IndicaMapper idcMapper;

	@Override
	public List<?> selectIdc(IndicaVO idcVo) {
		return idcMapper.selectIdc(idcVo);
	}
}