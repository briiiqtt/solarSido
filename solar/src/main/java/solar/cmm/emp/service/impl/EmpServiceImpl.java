package solar.cmm.emp.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import solar.cmm.emp.dao.EmpVO;
import solar.cmm.emp.service.EmpService;
import solar.sales.order.dao.ModifyVO;

@Service
public class EmpServiceImpl implements EmpService{

	@Autowired EmpMapper empMapper;
	
	@Override
	public List<EmpVO> empList(EmpVO empVO) {
		// TODO Auto-generated method stub
		return empMapper.empList(empVO);
	}

	@Override
	public EmpVO findById(String no) {
		// TODO Auto-generated method stub
		return empMapper.findById(no);
	}

	@Override
	public int empInsert(EmpVO empVO) {
		// TODO Auto-generated method stub
		return empMapper.empInsert(empVO);
	}

	@Override
	public int empUpdate(EmpVO empVO) {
		// TODO Auto-generated method stub
		return empMapper.empUpdate(empVO);
	}

	@Override
	public int empDelete(EmpVO empVO) {
		// TODO Auto-generated method stub
		return empMapper.empDelete(empVO);
	}

	@Override
	public int modifyData(ModifyVO<EmpVO> modifyVO) {
		if(modifyVO.getCreatedRows()!=null) {
		for(EmpVO empVO : modifyVO.getCreatedRows()) {
			empMapper.empInsert(empVO);
			}
		if(modifyVO.getDeletedRows()!=null) {
			for(EmpVO empVO : modifyVO.getDeletedRows()) {
				empMapper.empDelete(empVO);
				}
			}
		if(modifyVO.getUpdatedRows()!=null) {
			for(EmpVO empVO : modifyVO.getUpdatedRows()) {
				empMapper.empUpdate(empVO);
				}
			}
		}
		return 1;
	}

	@Override
	public List<EmpVO> empdataFind(EmpVO empVO) {
		// TODO Auto-generated method stub
		return empMapper.empdataFind(empVO);
	}

}
