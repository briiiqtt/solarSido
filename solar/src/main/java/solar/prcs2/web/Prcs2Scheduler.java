package solar.prcs2.web;

import org.springframework.stereotype.Component;
@Component
public class Prcs2Scheduler {
	/*
	 * @Autowired Prcs2Mapper pmapper; //무한루프 그려서 화면에 표기
	 * 
	 * @Scheduled(fixedDelay=2000) public void sch() { List<Prcs2> plist =
	 * pmapper.findTemp(); List<EqmAble> elist= new ArrayList<EqmAble>();
	 * List<EqmAble> elist2= new ArrayList<EqmAble>(); List<EqmAble> elist3= new
	 * ArrayList<EqmAble>(); List<EqmAble> elist4= new ArrayList<EqmAble>(); EqmAble
	 * eqmNo = new EqmAble(); DateTimeFormatter dtf =
	 * DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss"); if(plist.isEmpty())
	 * {}else {
	 * 
	 * eqmNo.setLiNo(Integer.toString(1)); elist.addAll( pmapper.ableEqm(eqmNo));
	 * System.out.println(elist); eqmNo.setLiNo(Integer.toString(2)); elist2.addAll(
	 * pmapper.ableEqm(eqmNo));
	 * 
	 * eqmNo.setLiNo(Integer.toString(3)); elist3.addAll( pmapper.ableEqm(eqmNo));
	 * 
	 * eqmNo.setLiNo(Integer.toString(4)); elist4.addAll( pmapper.ableEqm(eqmNo));
	 * 
	 * for(int i =0; i<plist.size();i++) {
	 * 
	 * 
	 * // System.out.println("start"); System.out.println(plist.get(i).getPrdtFg());
	 * // System.out.println(plist.get(i).getPrdtFg().equals("P") &&
	 * plist.get(i).getPrcsFrTm()==null);
	 * 
	 * if(plist.get(i).getPrdtFg().equals("P") && plist.get(i).getPrcsFrTm()==null
	 * && elist.size()!=0) { EqmAble eq = new EqmAble();
	 * plist.get(i).setPrcsFrTm(java.sql.Timestamp.valueOf(LocalDateTime.now()));
	 * System.out.println(elist.get(0)); pmapper.updatePEqm(elist.get(0)); String
	 * selected = new String(elist.get(0).getEqmCd());
	 * plist.get(i).setEqmCd(selected); pmapper.updateFr(plist.get(i));
	 * elist.remove(0);
	 * 
	 * 
	 * }else if(plist.get(i).getPrdtFg().equals("P") &&
	 * plist.get(i).getPrcsFrTm()!=null) { EqmAble eq = new EqmAble();
	 * eq.setEqmCd(plist.get(i).getEqmCd()); eq.setLiNo("1");
	 * pmapper.updateYEqm(eq); elist.add(eq);
	 * 
	 * plist.get(i).setPrcsToTm(java.sql.Timestamp.valueOf(LocalDateTime.now()));
	 * pmapper.insertMid(plist.get(i)); plist.get(i).setPrdtFg("P1");
	 * pmapper.updateTo(plist.get(i)); pmapper.updateFg(plist.get(i));
	 * 
	 * }
	 * 
	 * }
	 * 
	 * 
	 * System.out.println(pmapper.findTemp()); }
	 * 
	 * }
	 */
	
}
