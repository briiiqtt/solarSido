package solar.co.cmmn.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import solar.co.cmmn.service.Co;
import solar.co.cmmn.service.CoService;

@Service
public class CoServiceImpl implements CoService{

	@Autowired
	CoMapper coMapper;
	
	@Override
	public List<Co> selectAll() {
		return coMapper.selectAll();
	}

}