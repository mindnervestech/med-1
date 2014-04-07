package com.mnt.time.controller;

import static play.data.Form.form;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.joda.time.DateTime;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import models.ApplyLeave;
import models.Company;
import models.LeaveBalance;
import models.LeaveLevel;
import models.LeaveX;
import models.RoleLeave;
import models.RoleLevel;
import models.RoleX;
import models.User;
import play.data.DynamicForm;
import play.data.Form;
import play.libs.Json;
//import play.mvc.Controller;
import utils.EmailExceptionHandler;
import utils.ExceptionHandler;

import com.avaje.ebean.Expr;
import com.custom.RoleLeaveBindFromRequest;
import com.custom.domain.LeaveStatus;
import com.custom.domain.RoleDomain;
import com.custom.domain.RoleLevels;
import com.custom.helpers.LeaveApplyContext;
import com.custom.helpers.LeaveBucketSearchContext;
import com.custom.helpers.LeaveSave;
import com.custom.helpers.ProjectSearchContext;
import com.custom.workflow.vacation.VacationWorkflowUtils;
import com.mnt.core.domain.DomainEnum;


//import controllers.routes.Status.userSearch;
import dto.fixtures.MenuBarFixture;

/*@Security.Authenticated(Secured.class)
@BasicAuth*/

@Controller
public class Leaves {
	 @RequestMapping(value="/leaveIndex" , method = RequestMethod.GET)
	public String applyIndex(ModelMap model, @CookieValue("username") String username) {
		 User user = User.findByEmail(username);
		 
		List<LeaveBalance> leavebal=LeaveBalance.find.where().eq("employee_id",user.getId()).findList();
		List<DomainEnum> leaves=new ArrayList<DomainEnum>();
		for(int i=0;i<leavebal.size();i++)
		{
			leaves.add(new RoleDomain(leavebal.get(i).getLeaveLevel().getId()+"", leavebal.get(i).getLeaveLevel().getLeave_type(), false));
		}
		ApplyLeave.leave_domain = leaves;
		
		//leavebal.get(0).getId();
		List<LeaveBalance> leavebal1 = LeaveBalance.find.where().eq("leaveLevel", user.getLevel()).findList();
		System.out.println("hhhh"+leavebal.get(0).getId());
		//leavebal1.getEmployee().getId();
		//LeaveBalance lv=LeaveBalance.findById();
		//User user1=User.findById(leavebal1.getEmployee().getId());
		//System.out.println("User:"+user1.getFirstName()+" "+user1.getLastName());
		model.addAttribute("context",LeaveApplyContext.getInstance().build());
		model.addAttribute("_menuContext", MenuBarFixture.build(username));
    	model.addAttribute("user", user);
    	
    	model.addAttribute("leaves",leavebal);
    	model.addAttribute("leaves1",leavebal1);
    			return "leaveIndex";
		
    }
	 
	 @RequestMapping(value="/leaveEdit" , method = RequestMethod.POST)
	public @ResponseBody String edit(HttpServletRequest request) {
		try {
			LeaveSave saveUtils = new LeaveSave();
			saveUtils.doSave(true,request);
		} catch (Exception e) {
			ExceptionHandler.onError(request.getRequestURI(),e);
		}
		return "Leave Edited Successfully";
    }
	 
	 @RequestMapping(value="/leaveExcelReport" , method = RequestMethod.GET)
	public String excelReport(@CookieValue("username") String username,HttpServletResponse response,HttpServletRequest request ) throws IOException {
		DynamicForm form = DynamicForm.form().bindFromRequest(request);
		form.data().put("email",username);
		response.setContentType("application/vnd.ms-excel");
		HSSFWorkbook hssfWorkbook = LeaveBucketSearchContext.getInstance().build().doExcel(form);
		File f = new File("excelReport.xls");
		FileOutputStream fileOutputStream = new FileOutputStream(f);
		hssfWorkbook.write(fileOutputStream);
		response.setHeader("Content-Disposition", "attachment; filename=excelReport.xls");
		return "";
    }
	 
	 @RequestMapping(value="/leaveApplyExcelReport" , method = RequestMethod.GET)
	public String excelApplyReport(@CookieValue("username") String username, HttpServletRequest request,HttpServletResponse response) throws IOException  {
		DynamicForm form = DynamicForm.form().bindFromRequest(request);
		form.data().put("email", username);
		HSSFWorkbook hssfWorkbook =  LeaveApplyContext.getInstance().build().doExcel(form);
		File f = new File("excelReport.xls");
		FileOutputStream fileOutputStream = new FileOutputStream(f);
		hssfWorkbook.write(fileOutputStream);
		response.setHeader("Content-Disposition", "attachment; filename=excelReport.xls");
		return username;
    }
	 
	 @RequestMapping(value="/leavesShowEdit" , method = RequestMethod.GET)
	public String showEdit(ModelMap model, @CookieValue("username") String username,HttpServletRequest request) {
		DynamicForm form = DynamicForm.form().bindFromRequest(request);
		Long id = null;
		try{
			id = Long.valueOf(form.get("query"));
			ApplyLeave status = ApplyLeave.findById(id);
			if(status.getStatus() == LeaveStatus.Approved)
			{
				return "Approved Leave cannot be Edited";
			}
			else
			model.addAttribute("_searchContext",new LeaveApplyContext(ApplyLeave.findById(id)).build());	
			return "editWizard";
		}catch(NumberFormatException nfe){
			ExceptionHandler.onError(request.getRequestURI(),nfe);
		}
		return "Not able to show Results, Check Logs";
	}
    
	 @RequestMapping(value="/leaveCreate" , method = RequestMethod.POST)
	public @ResponseBody String create(@CookieValue("username") String username,HttpServletRequest request) {
		Form<ApplyLeave> leaveForm = form(ApplyLeave.class).bindFromRequest(request);
		User user = User.findByEmail(username);
		leaveForm.get().setUser(user);
		leaveForm.get().setPendingWith(user);
		leaveForm.get().setLeaveGuid(UUID.randomUUID().toString());
		leaveForm.get().setStatus (LeaveStatus.Submitted);
		leaveForm.get().save();
		
		if(leaveForm.get().getStatus() == LeaveStatus.Submitted){
			leaveForm.get().setPendingWith(user.getManager());
			leaveForm.get().update();
		}
		
		try{
			VacationWorkflowUtils.startVacationWF(leaveForm.get().leaveGuid);
		}
		catch (Exception e) {
			//ExceptionHandler.onError(request().uri(),e);
		}
		return "Leave Created Successfully";
    }
	 
	 @RequestMapping(value="/leaveDelete" , method = RequestMethod.GET)
	public String delete() {
		return "";
    }
	 
	 @RequestMapping(value="/leaveSearch" , method = RequestMethod.GET)
	public @ResponseBody String search(@CookieValue("username") String username,HttpServletRequest request) {
		DynamicForm form = DynamicForm.form().bindFromRequest(request);
		form.data().put("email",username);
		return Json.toJson(LeaveApplyContext.getInstance().build().doSearch(form)).toString();
    }
	 
	 @RequestMapping(value="/leaveApprovalViaMail" , method = RequestMethod.GET)
	public String leaveApprovalViaMail(HttpServletRequest request){
		DynamicForm dynamicForm =DynamicForm .form().bindFromRequest(request);
		String query = dynamicForm.get("q");
		String leaveGUID = dynamicForm.get("id");
		
		ApplyLeave applyLeave = ApplyLeave.find.where().eq("leaveGuid", leaveGUID).findUnique();
		
		boolean isApproved;
		if(query.equals("yes")){
			isApproved = true;
		}
		else{
			isApproved = false;
		}
		
		
		if(applyLeave != null){
			String pid = applyLeave.getProcessInstanceId();
			VacationWorkflowUtils.setVariableToTask(pid, isApproved,applyLeave.getLeaveGuid());
		}else{
		}
		
		return "index";
	}
	
	
	 @RequestMapping(value="/leave/bucketIndex" , method = RequestMethod.GET)
	public String bucketIndex(ModelMap model,@CookieValue("username") String username){
		User user = User.findByEmail(username);
		model.addAttribute("context",LeaveBucketSearchContext.getInstance().build());
		model.addAttribute("_menuContext", MenuBarFixture.build(username));
    	model.addAttribute("user", user);
		return "leaveBucket";
	}
	
	 @RequestMapping(value="/leave/bucketSearch" , method = RequestMethod.GET)
	public @ResponseBody String leaveSearch(@CookieValue("username") String username,HttpServletRequest request) {
		User user = User.findByEmail(username);
		DynamicForm form = DynamicForm.form().bindFromRequest(request);
		form.data().put("userEmail", user.getEmail());
		return Json.toJson(LeaveBucketSearchContext.getInstance().build().doSearch(form)).toString();
    }
	 
	 @RequestMapping(value="/leave/approveLeave" , method = RequestMethod.GET)
	public @ResponseBody String approveLeave(@CookieValue("username") String username,HttpServletRequest request){
		DynamicForm form = DynamicForm.form().bindFromRequest(request);
		String query = form.data().get("query");
		if(query == null){
			query = form.data().get("leaveID");
		}
		for(String ids : query.split(",")){
			ApplyLeave leave = ApplyLeave.find.byId(Long.parseLong(ids));
			leave.setStatus(LeaveStatus.Approved);
			leave.update(Long.parseLong(ids));
			String pid = leave.getProcessInstanceId();
			VacationWorkflowUtils.setVariableToTask(pid, true,leave.getLeaveGuid());
		}
		Integer count = Application.count(username);
		String notification = count.toString(); 
		String message = "Selected Leave have been Approved";
		Map<String,String> jsonMap = new HashMap<String,String>();
		jsonMap.put("count", notification);
		jsonMap.put("message", message);
		return Json.toJson(jsonMap).toString();
	}
	 
	 @RequestMapping(value="/leave/rejectLeave" , method = RequestMethod.GET)
	public @ResponseBody String rejectLeave(@CookieValue ("username") String username,HttpServletRequest request){
		DynamicForm form = DynamicForm.form().bindFromRequest(request);
		String query = form.data().get("query");
		if(query == null){
			query = form.data().get("leaveID");
		}
		for(String ids : query.split(",")){
			ApplyLeave leave = ApplyLeave.find.byId(Long.parseLong(ids));
			leave.setStatus(LeaveStatus.Rejected);
			leave.update(Long.parseLong(ids));
			String pid = leave.getProcessInstanceId();
			VacationWorkflowUtils.setVariableToTask(pid, false,leave.getLeaveGuid());
		}
		Integer count = Application.count(username);
		String notification = count.toString(); 
		String message = "Selected Leave have been Rejected";
		Map<String,String> jsonMap = new HashMap<String,String>();
		jsonMap.put("count", notification);
		jsonMap.put("message", message);
		return Json.toJson(jsonMap).toString();
	}
	 
	 @RequestMapping(value="/leave/retractLeave" , method = RequestMethod.GET)
	public @ResponseBody String retractLeave(HttpServletRequest request){
		DynamicForm form = DynamicForm.form().bindFromRequest(request);
		String query = form.data().get("query");
		ApplyLeave leave = ApplyLeave.find.byId(Long.parseLong(query));
		DateTime today = new DateTime();
		String message = "";
		Map<String,String> jsonMap = new HashMap<String,String>();
		if(today.isBefore(leave.getStartDate().getTime()))
		{
			if(leave.getStatus() == LeaveStatus.Submitted || leave.getStatus() == LeaveStatus.Approved)
			{
				leave.setStatus(LeaveStatus.Withdrawn);
				leave.update();
				message = "Leave has been WithDrawn Successfully";
				jsonMap.put("message", message);
					return Json.toJson(jsonMap).toString();
			}
			else if(leave.status == LeaveStatus.Rejected)
			{
				message = "Leave is Rejected it cannot be Retracted";
				jsonMap.put("message", message);
				return Json.toJson(jsonMap).toString();
			}
			else{
				message = "Leave is Already WithDrawn";
				jsonMap.put("message", message);
				return Json.toJson(jsonMap).toString();
			}
		}
		else{
				message = "Leave Period has Started it cannot be Withdrawn now";
				jsonMap.put("message", message);
				return Json.toJson(jsonMap).toString();
		}
	}
	 @RequestMapping(value="/defineLeaves" , method = RequestMethod.GET)
	 public String defineLeaves(ModelMap model, @CookieValue("username") String username)
	 {	
			User user = User.findByEmail(username);
			LeaveX leaveX = LeaveX.find.where(Expr.eq("company", user.companyobject)).findUnique();
			Form<LeaveX> leaveXForm;
			if(leaveX != null){
				leaveXForm = form(LeaveX.class).fill(leaveX);
			}else{
				LeaveX object = new LeaveX();
				List<LeaveLevel> leaveLevels = new ArrayList<LeaveLevel>();
				leaveLevels.add(new LeaveLevel());
				object.setLeaveLevels(leaveLevels);
				leaveXForm = form(LeaveX.class).fill(object);
					
			}
			List<LeaveLevel>leaveLevels=LeaveLevel.findListByCompany(user.getCompanyobject().getId()); 
			model.addAttribute("user",user);
			model.addAttribute("_menuContext",MenuBarFixture.build(username));
			model.addAttribute("leavexForm",leaveXForm);
			model.addAttribute("leaveLevels",leaveLevels);
			return "defineLeaves";
	 }
	 
	 @RequestMapping(value="/leaveSettings",method = RequestMethod.GET)
	 public String showLeaves(ModelMap model,@CookieValue("username") String username){
		 User user=User.findByEmail(username);
		 List<RoleLeave>leaves= RoleLeave.find.all();
		 List<Long>allTotalValue=new ArrayList<Long>();
		 for(int i=0;i<leaves.size();i++)
			allTotalValue.add(leaves.get(i).getTotal_leave()); 
		 model.addAttribute("user",user);
		 model.addAttribute("allTotalValue",allTotalValue);
		 model.addAttribute("roleLevel",Roles.getAllRoles(username));
		 model.addAttribute("AllLeaves", getAllLeaves(username));
		 model.addAttribute("_menuContext", MenuBarFixture.build(username));
		 return "leaveSettings";
	 } 

	 @RequestMapping(value="/saveLeaves " ,method=RequestMethod.POST)		
		public @ResponseBody String saveLeaves(@CookieValue("username")String username,HttpServletRequest request){
				
			User user = User.findByEmail(username);
			Form<LeaveX> leaveXForm = form(LeaveX.class).bindFromRequest(request);
			LeaveX leaveX = LeaveX.find.where(Expr.eq("company", user.getCompanyobject())).findUnique();
			List<RoleLevel> rolelevel=RoleLevel.findListByCompany(user.getCompanyobject().getId());
	
			if(leaveX != null){
				for(LeaveLevel _rl : leaveXForm.get().getLeaveLevels()){
					if(_rl.getId()!=null)
					{
						_rl.update();
					}
					_rl.setLeaveX(leaveX);
						_rl.save();
				}
			}else{
				leaveXForm.get().setCompany(user.getCompanyobject());
		//		leaveXForm.get().setId(1L);
			
				leaveXForm.get().save();
			}

			List<LeaveLevel> ll=LeaveLevel.findListByCompany(user.getCompanyobject().getId());
			for(RoleLevel r:rolelevel){
		/*	{
				RoleLeave rl=new RoleLeave();
				rl.setRoleLevel(r);
				rl.setCompany(user.getCompanyobject());
				rl.setLeaveLevels(ll);
				rl.save();
		*/		
				for(LeaveLevel l:ll) {
					RoleLeave rl=new RoleLeave();
					rl.setRoleLevel(r);
					rl.setCompany(user.getCompanyobject());
//					rl.setLeaveLevels(l);
					rl.setLeaveLevel(l);
					rl.save();
				}
			}
			return "Defined Leaves has been saved";	 
	 }
	 
	@RequestMapping(value="/saveLeaveValue " ,method=RequestMethod.POST)		
	public @ResponseBody String saveLeaveValue(@CookieValue("username")String username,HttpServletRequest request)
	{
		Form<RoleLeaveBindFromRequest>leaveForm=form(RoleLeaveBindFromRequest.class).bindFromRequest(request);	
		RoleLeave rl=new RoleLeave();
		for(int i=0;i<leaveForm.get().getRoleLeaves().size();i++)
		{
			rl.setId(leaveForm.get().getRoleLeaves().get(i).getId());
			rl.setTotal_leave(leaveForm.get().getRoleLeaves().get(i).getTotal_leave());
			rl.update();
		}
		return "leave value saved";
	}			

	 public static HashMap<Long, List<String>>getAllLeaves(String username)
	 {
		 User user = User.findByEmail(username);
		 HashMap<Long,List<String>> map = new HashMap<Long,List<String>>();
		 List<RoleLeave>roleLeaves=RoleLeave.find.where().add(Expr.eq("company_id",user.getCompanyobject().getId())).findList();
		 List<LeaveLevel>leaveLevels=LeaveLevel.findListByCompany(user.getCompanyobject().getId());
		 List<String> leaves=new ArrayList<String>();
		 for(int i=0;i<leaveLevels.size();i++)
		 {
			 leaves.add(leaveLevels.get(i).getLeave_type());
		 }
		 for(int i=0;i<roleLeaves.size();i++)
		 {			 
			 map.put(roleLeaves.get(i).getId(),leaves);
		 }
		 return map;
	 }
	 
	 
	 @RequestMapping(value="/testupdate " ,method=RequestMethod.GET)		
	 public void testupdate() {
		 // Datastructure to hold mapping 
		 //<CompanyID,<RoleID,<LeaveType,Float>>>
		 Map<Long,Map<Long,Map<Long,Float>>> map = new HashMap<Long, Map<Long,Map<Long,Float>>>();
			
		 List<LeaveBalance> leaveBalances ;
		 List<Company> companies = Company.find.all();
		 Map<Long,  Float> value1=null;
		 Map<Long, Map<Long,  Float>> value = null;
		 for(Company company : companies) {
			 RoleX role = RoleX.find.where(Expr.eq("company", company)).findUnique();
			 value = new HashMap<Long, Map<Long,Float>>();
			 for(RoleLevel rl: role.roleLevels) {
				 List<RoleLeave> leaves =  RoleLeave.find.where().eq("company", company).eq("roleLevel", rl).findList();
				 
				 
				 value1 = new HashMap<Long, Float>();
				 
				 for(RoleLeave roleLeave : leaves) {
					 value1.put(roleLeave.leaveLevel.getId(), new Float(roleLeave.total_leave/12.0 ));
				 }
				 
				 value.put(rl.getId(), value1 );
			 }
			 map.put(company.getId(), value );
		 }
		 
		 List<User> users = User.find.all();
		 
		 for(User user :users) {
			 leaveBalances = LeaveBalance.find.where().eq("employee", user).findList();
			 for(LeaveBalance leaveBalance : leaveBalances) {
				 if(user.companyobject == null || user.role == null) break;
				 Float toBeAccrued ;
				 toBeAccrued =map.get(user.companyobject.getId()).get(user.role.getId()).get(leaveBalance.getLeaveLevel().getId());
				 System.out.println("chk val "+toBeAccrued);
				 leaveBalance.setBalance(leaveBalance.balance + toBeAccrued);
				 leaveBalance.update();
			 }
		 }
			 
	}
			 
	
	
	 
	 @RequestMapping(value="/testupdate1 " ,method=RequestMethod.GET)		
	 public void testupdate1() {	 
	 
		 Map<Long,Map<Long,Map<Long,Float>>> map = new HashMap<Long, Map<Long,Map<Long,Float>>>();
			
		 List<LeaveBalance> leaveBalances ;
		 List<Company> companies = Company.find.all();
		 Map<Long,  Float> value1=null;
		 Map<Long, Map<Long,  Float>> value = null;
		 for(Company company : companies) {
			 RoleX role = RoleX.find.where(Expr.eq("company", company)).findUnique();
			 value = new HashMap<Long, Map<Long,Float>>();
			 for(RoleLevel rl: role.roleLevels) {
				 List<RoleLeave> leaves =  RoleLeave.find.where().eq("company", company).eq("roleLevel", rl).findList();
				 
				 
				 value1 = new HashMap<Long, Float>();
				 
				 for(RoleLeave roleLeave : leaves) {
					 value1.put(roleLeave.leaveLevel.getId(), new Float(roleLeave.total_leave/12.0 ));
				 }
				 
				 value.put(rl.getId(), value1 );
			 }
			 map.put(company.getId(), value );
		 }
		// List<LeaveLevel>ll = LeaveLevel.find.all();
		 
		 List<User> users = User.find.all();
		 
		 for(User user :users) {
			 leaveBalances = LeaveBalance.find.where().eq("employee", user).findList();
			 for(LeaveBalance leaveBalance : leaveBalances) {
				 //float b=0;
				// if(user.companyobject == null || user.role == null) break;
				  LeaveLevel lv = LeaveLevel.find.where().eq("id", leaveBalance.getLeaveLevel().getId()).findUnique() ;
                  
				  System.out.println("chk :"+lv.getCarry_forward(). equals("NO"));
				  
				 if(lv.getCarry_forward(). equals("NO"))
                  {
                	  leaveBalance.setBalance(0.0f);
                	  leaveBalance.update();
                  }else{
				  /*Float toBeAccrued ;
				 toBeAccrued =map.get(user.companyobject.getId()).get(user.role.getId()).get(leaveBalance.getLeaveLevel().getId());
				 System.out.println("chk val "+toBeAccrued);
				 leaveBalance.setBalance(leaveBalance.balance + toBeAccrued);
				 leaveBalance.update();*/
                  }
			 }
		 }
		 
		 
		 
	 }
	 
	 
	 
	 
	 
	 
}
