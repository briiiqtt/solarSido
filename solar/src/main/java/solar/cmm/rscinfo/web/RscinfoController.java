package solar.cmm.rscinfo.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import solar.cmm.cmmndata.dao.CmmndataVO;
import solar.cmm.cmmndata.service.impl.CmmndataMapper;
import solar.cmm.rscinfer.dao.RscinferVO;
import solar.cmm.rscinfo.dao.RscinfoVO;
import solar.cmm.rscinfo.service.RscinfoService;
import solar.cmm.rscinfo.service.impl.RscinfoMapper;
import solar.rsc.stc.service.RscStc;
import solar.sales.order.dao.ModifyVO;

@Controller
public class RscinfoController {

	@Autowired RscinfoService rscinfoService;
	@Autowired RscinfoMapper rscinfoMapper;
	@Autowired CmmndataMapper cmmndataMapper;
	
	@RequestMapping("common/mng/rscinfo")
	public String rscinfoList() {
		return "common/mng/rscinfo";
	}
	
	@RequestMapping("/modal/prcsinfoList2")
	public String prscmodal() {
		return "modal/prcsinfoList2";
	}
	
	@GetMapping("/grid/rscinfoList.do")
	public String rscinfoList(Model model, RscinfoVO rscinfoVO) throws Exception{
		
		List<?> rscinfoList = rscinfoService.rscinfoList(rscinfoVO);		
		Map<String,Object> data = new HashMap<>();
		Map<String,Object> map = new HashMap<>();
		data.put("contents", rscinfoList);		
		model.addAttribute("result", true);
		model.addAttribute("data", data);
		return "jsonView";
	}
	
	@GetMapping("/grid/rscinfoFind")
	public String rscinfoFind(Model model, RscinfoVO rscinfoVO) throws Exception{
		
		List<?> rscinfoList = rscinfoService.rscinfofind(rscinfoVO);
		model.addAttribute("result", true);
		Map<String, Object>map = new HashMap();
		Map<String, Object>map2 = new HashMap();
		map.put("contents", rscinfoList);
		map2.put("page", 1);
		map2.put("totalCount", rscinfoList.size());
		model.addAttribute("data", map);
		
		return "jsonView";
	}
	
	@RequestMapping("/rscinfo.do")
	@ResponseBody
	public Map<String, Object> rscinfo(@RequestParam("rscCd") String rscCd) {
		RscinfoVO rscinfoVO = new RscinfoVO();
		rscinfoVO.setRscCd(rscCd);
		rscinfoVO = rscinfoService.rscinfo(rscinfoVO);
		
		Map<String, Object> data = new HashMap<>();
		data.put("result", rscinfoVO);
		
		return data;
	}
	
	@PostMapping("/rscinfoUpdate.do")
	public String rscinfoUpdate( RscinfoVO rscinfoVO) {
		rscinfoService.rscinfoUpdate(rscinfoVO);
		CmmndataVO cmmndataVO = new CmmndataVO();
		cmmndataVO.setCmmnCdDetaId(rscinfoVO.getRscCd());
		cmmndataVO.setCmmnCdId("rsc");
		cmmndataVO.setCmmnCdNm(rscinfoVO.getRscNm());
		cmmndataMapper.cmmnDetailUpdate(cmmndataVO);
		return "common/mng/rscinfo";
	}
	
	@PostMapping("/rscinfoInsert.do")
	public String rscinfoInsert(RscinfoVO rscinfoVO) {
		rscinfoService.rscinfoInsert(rscinfoVO);
		rscinfoService.rscinfoStc(rscinfoVO);
		CmmndataVO cmmndataVO = new CmmndataVO();
		cmmndataVO.setCmmnCdDetaId(rscinfoVO.getRscCd());
		cmmndataVO.setCmmnCdId("rsc");
		cmmndataVO.setCmmnCdNm(rscinfoVO.getRscNm());
		cmmndataMapper.cmmnDetailInsert(cmmndataVO);
		return "common/mng/rscinfo";
	}
	@PostMapping("/rscinfoDelete.do")
	public String rscDelete(RscinfoVO rscinfoVO) {
		rscinfoService.rscinfoDelete(rscinfoVO);
		rscinfoService.rscstcDelete(rscinfoVO);
		CmmndataVO cmmndataVO = new CmmndataVO();
		cmmndataVO.setCmmnCdDetaId(rscinfoVO.getRscCd());
		cmmndataMapper.cmmnDetailDelete(cmmndataVO);
		
		return "common/mng/rscinfo";
	}
	
	@RequestMapping("/grid/rscinfoUpdateIn.do")
	public String rscinfoUpdateIn(Model model, RscinfoVO rscinfoVO, @RequestBody ModifyVO<RscinfoVO> modifyVO) throws Exception
	{
		rscinfoService.modifyData(modifyVO);
		model.addAttribute("mode","upd");
		return "jsonView";
	}
}
