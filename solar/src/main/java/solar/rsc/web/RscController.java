package solar.rsc.web;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import solar.cmm.code.service.CmmnCdService;
import solar.rsc.cmmn.service.RscService;
import solar.rsc.infer.service.RscInferService;
import solar.rsc.inout.service.RscInOut;
import solar.rsc.inout.service.RscInOutService;
import solar.rsc.ordr.service.RscOrdr;
import solar.rsc.ordr.service.RscOrdrService;
import solar.rsc.stc.service.RscStc;
import solar.rsc.stc.service.RscStcService;
import solar.sales.order.dao.ModifyVO;

@Controller
public class RscController {

	@Autowired
	RscOrdrService rscOrdrService;
	@Autowired
	RscService rscService;
	@Autowired
	RscInferService rscInferService;
	@Autowired
	CmmnCdService cmmnCdService;
	@Autowired
	RscInOutService rscInOutService;
	@Autowired
	RscStcService rscStcService;
	
	//발주페이지
	@GetMapping("rsc/ordr")
	public String rscOrdr() {
		return "rsc/ordr";
	}
	
	//발주데이터
	@GetMapping("rsc/ordrData")
	public String rscOrdrData(@RequestParam Map<String,String> map, Model model) {
		Map<String,Object> data = new HashMap<String, Object>();
		Map<String,Object> page = new HashMap<String, Object>();
		List<?> list = rscOrdrService.search(map);
		
		model.addAttribute("result",true);
		
		page.put("page", 1);
		page.put("totalCount", list.size());
		
		data.put("contents", list);
		data.put("pagination", page);
		
		model.addAttribute("data", data);
		System.out.println("model  "+model);
		System.out.println("map  "+map);
		return "jsonView";
	}

	//업체목록 모달
	@GetMapping("co")
	public String getCo() {
		return "modal/searchCo";
	}
	
	//자재목록 모달
	@GetMapping("rsc")
	public String rsc() {
		return "modal/searchRsc";
	}
	
	//자재목록 데이터요청
	@GetMapping("rsc/rscData")
	public String rscData(Model model) {
		model.addAttribute("rsc",rscService.selectAll());
		return "jsonView";
	}
	
	//공통코드 목록 요청
	@GetMapping("cmmn/codes")
	public String cmmnCodes(Model model) {
		model.addAttribute("codes", cmmnCdService.select(Arrays.asList("rscst","rscinfer","rsc")));
		return "jsonView";
	}
	
	//검수관리페이지 이동
	@GetMapping("rsc/insp")
	public String rscInsp() {
		return "rsc/insp";
	}
	
	//검수 목록 요청
	@GetMapping("rsc/inspData")
	public String rscInspData(/*@RequestParam Map<String,String> map, */Model model) {
		Map<String,Object> data = new HashMap<String, Object>();
		Map<String,Object> page = new HashMap<String, Object>();
		List<?> list = rscInferService.selectAll();
		
		model.addAttribute("result",true);
		
		page.put("page", 1);
		page.put("totalCount", list.size());
		
		data.put("contents", list);
		data.put("pagination", page);
		
		model.addAttribute("data", data);
		return "jsonView";
	}
	
	//검수 모달
	@GetMapping("rsc/inspModal")
	public String rscInspModal() {
		return "modal/searchInsp";
	}
	
	//발주데이터 dataSource modify
	@ResponseBody
	@PutMapping("rsc/ordrData")
	public int rscOrdrData(@RequestBody ModifyVO<RscOrdr> mvo) {
		rscOrdrService.modify(mvo);
		return 201;
	}
	
	//입고페이지
	@GetMapping("rsc/in")
	public String rscIn() {
		return "rsc/in";
	}
	
	//입고 처리 요청
	@ResponseBody
	@PostMapping("rsc/in/rscin")
	public int rscIn(@RequestBody RscInOut rscInOut, Model model) {
		System.out.println(rscInOut);
		rscInOutService.insert(rscInOut);
		rscInOutService.stcInc(rscInOut);
		return 202;
	}
	
	//출고페이지
	@GetMapping("rsc/out")
	public String rscOut() {
		return "rsc/out";
	}
	
	//자재재고페이지
	@GetMapping("rsc/stc")
	public String rscStc() {
		return "rsc/stc";
	}
	
	//재고 데이터 요청
	@GetMapping("rsc/stcData")
	public String rscStcData(@RequestBody RscStc rscStc, Model model) {
		model.addAttribute("stc", rscStcService.selectAll());
		return "jsonView"; 
	}
	
}