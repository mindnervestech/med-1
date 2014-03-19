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
import models.LeaveLevel;
import models.LeaveX;
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
import com.custom.domain.LeaveStatus;
import com.custom.helpers.LeaveApplyContext;
import com.custom.helpers.LeaveBucketSearchContext;
import com.custom.helpers.LeaveSave;
import com.custom.helpers.ProjectSearchContext;
import com.custom.workflow.vacation.VacationWorkflowUtils;


//import controllers.routes.Status.userSearch;
import dto.fixtures.MenuBarFixture;

/*@Security.Authenticated(Secured.class)
@BasicAuth*/

@Controller
public class Leaves {
	 @RequestMapping(value="/leaveIndex" , method = RequestMethod.GET)
	public String applyIndex(ModelMap model, @CookieValue("username") String username) {
		User user = User.findByEmail(username);
		model.addAttribute("context",LeaveApplyContext.getInstance().build());
		model.addAttribute("_menuContext", MenuBarFixture.build(username));
    	model.addAttribute("user", user);
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
			if(status.status == LeaveStatus.Approved)
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
		leaveForm.get().user = user;
		leaveForm.get().pendingWith = user;
		leaveForm.get().leaveGuid = UUID.randomUUID().toString();
		leaveForm.get().status = LeaveStatus.Submitted;
		leaveForm.get().save();
		
		if(leaveForm.get().status == LeaveStatus.Submitted){
			leaveForm.get().pendingWith = user.manager;
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
			String pid = applyLeave.processInstanceId;
			VacationWorkflowUtils.setVariableToTask(pid, isApproved,applyLeave.leaveGuid);
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
			String pid = leave.processInstanceId;
			VacationWorkflowUtils.setVariableToTask(pid, true,leave.leaveGuid);
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
			String pid = leave.processInstanceId;
			VacationWorkflowUtils.setVariableToTask(pid, false,leave.leaveGuid);
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
			model.addAttribute("user",user);
			model.addAttribute("_menuContext",MenuBarFixture.build(username));
			model.addAttribute("leavexForm",leaveXForm);
			model.addAttribute("leaveLevels",new ArrayList<LeaveLevel>());
	//		model.addAttribute("levels",getAllRoles(username));

	/*	 User user=User.findByEmail(username);
		 model.addAttribute("user",user);
		 model.addAttribute("_menuContext", MenuBarFixture.build(username));
	*/	 return "defineLeaves";
	 }
	 
	 @RequestMapping(value="/leaveSettings",method = RequestMethod.GET)
	 public String showLeaves(ModelMap model,@CookieValue("username") String username){
		 User user=User.findByEmail(username);
		 model.addAttribute("user",user);
		 model.addAttribute("roleLevels",Roles.getAllRoles(username));
		 model.addAttribute("_menuContext", MenuBarFixture.build(username));
		 return"leaveSettings";
	 } 

	 @RequestMapping(value="/saveLeaves " ,method=RequestMethod.POST)		
		public @ResponseBody String saveLeaves(@CookieValue("username")String username,HttpServletRequest request){
				
			User user = User.findByEmail(username);
			Form<LeaveX> leaveXForm = form(LeaveX.class).bindFromRequest(request);
			LeaveX leaveX = LeaveX.find.where(Expr.eq("company", user.getCompanyobject())).findUnique();
	//		Form<LeaveX> l1 = form(LeaveX.class).bindFromRequest(request);
			if(leaveX != null){
				for(LeaveLevel _rl : leaveXForm.get().getLeaveLevels()){
						_rl.leaveX = leaveX;
						_rl.save();
				}
			}else{
				leaveXForm.get().setCompany(user.getCompanyobject());
		//		leaveXForm.get().setId(1L);
			
				leaveXForm.get().save();
			}

			return "Defined Leaves has been saved";
	 
	 }

}
