package com.mnt.time.controller;

import static com.google.common.collect.Lists.transform;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.persistence.Id;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.Company;
import models.LeaveBalance;
import models.MailSetting;
import models.RoleLevel;
import models.RoleX;
import models.User;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.codehaus.jackson.node.ObjectNode;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import play.data.DynamicForm;
import play.libs.Json;

import com.avaje.ebean.Expr;
import com.custom.domain.RoleDomain;
import com.custom.emails.Email;
import com.custom.helpers.UserSave;
import com.custom.helpers.UserSearchContext;
import com.google.common.base.Function;
import com.mnt.core.domain.DomainEnum;
import com.mnt.core.ui.component.AutoComplete;
import com.mnt.time.controller.Application.Login;
import com.mnt.time.controller.routes.Application.login;
import com.mnt.time.controller.routes.Status.companyIndex;

import dto.fixtures.MenuBarFixture;

/*@Security.Authenticated(Secured.class)
@BasicAuth*/

@Controller
public class Users {
	
	@RequestMapping( value="/userSearch", method= RequestMethod.GET )
	public @ResponseBody String search(HttpServletRequest request,@CookieValue("username") String username) {
		DynamicForm form = DynamicForm.form().bindFromRequest(request);
		form.data().put("email", username);
		return Json.toJson(UserSearchContext.getInstance().build().doSearch(form)).toString();
    }
	
	@RequestMapping( value="/userShowEdit ", method= RequestMethod.GET )
	public String showEdit(ModelMap model, HttpServletRequest request) {
		DynamicForm form = DynamicForm.form().bindFromRequest(request);
		Long id = null;
		try{
			id = Long.valueOf(form.get("query"));
			User user = User.findById(id);
			RoleX role = RoleX.find.where(Expr.eq("company", user.companyobject)).findUnique();
			List<DomainEnum> roleX = new ArrayList<DomainEnum>();
			if(role != null){
				for(int i=0; i<role.roleLevels.size(); i++){
					roleX.add(new RoleDomain(role.roleLevels.get(i).id+"",role.roleLevels.get(i).role_name,false));
				}
			}
			user.rolex = roleX;
			model.addAttribute("_searchContext", new UserSearchContext(user).build());
			return "editWizard";
			/*return ok(editWizard.render(new UserSearchContext(user).build()));*/
		}catch(Exception e){
			//ExceptionHandler.onError(request.getRequestURI(),e);
		}
		return "Not able to show Results, Check Logs";
		
	}
	
	@RequestMapping( value="/userExcelReport", method = RequestMethod.GET)
	public String excelReport(@CookieValue("username") String username, HttpServletRequest request,HttpServletResponse response ) throws IOException {
		DynamicForm form = DynamicForm.form().bindFromRequest(request);
		
		response.setContentType("application/vnd.ms-excel");
		form.data().put("email", username);
		HSSFWorkbook hssfWorkbook =  UserSearchContext.getInstance().build().doExcel(form);
		File f = new File("excelReport.xls");
		FileOutputStream fileOutputStream = new FileOutputStream(f);
		hssfWorkbook.write(fileOutputStream);
		
		response.setHeader("Content-Disposition", "attachment; filename=excelReport.xls");
//		return ok(f).as();
		return "application/vnd.ms-excel";
    }
	
	@RequestMapping( value="/userEdit", method = RequestMethod.POST)
	public @ResponseBody String edit(@CookieValue("username")String username,HttpServletRequest request) {
		boolean userStatus = false;
		
		try {
			DynamicForm form = DynamicForm.form().bindFromRequest(request);
			Map<String, Object> extra = new HashMap<String, Object>();
			RoleLevel rl = RoleLevel.find.byId(Long.parseLong(form.get("rolex")));
			extra.put("role", rl);
			
			if(User.findById(Long.parseLong(form.data().get("id"))).userStatus == com.custom.domain.Status.Approved){
				userStatus = true;
			}
			
			if(User.findById(Long.parseLong(form.data().get("id"))).permissions != null){
				String permissions = User.findById(Long.parseLong(form.data().get("id"))).permissions;
				permissions = permissions+"|"+rl.getPermissions();
				List<String> blackListedPerm = Arrays.asList(permissions.split("[|]"));
				Set<String> set = new HashSet<String>(blackListedPerm);
				String permission = "";
				for(String temp : set){
					permission = temp + "|" +permission;
				}
				extra.put("permissions",permission);
			}else{
				extra.put("permissions",rl.getPermissions());
			}
	    	
			
			extra.put("designation",rl.role_name);
	    	
	    	UserSave saveUtils = new UserSave(extra);
	    	
	    	//Not completed
			Object o = saveUtils.doSave(true, request);
			User user = User.findById((Long)o);
			if(user.userStatus == com.custom.domain.Status.PendingApproval){
				user.setUserStatus(com.custom.domain.Status.Approved);
				user.update();
				try{
				MailSetting smtpSetting = MailSetting.find.where().eq("companyObject", user.companyobject).findUnique();
				String recipients = "";
				String subject = "";
				String body = "";
				
				recipients = user.email;
				subject = "Approval By Admin";
				body = "Congratulation !!! You are Approved By Admin..." +
						"\nNow You can Login the TimeTrotter System!!";
				Email.sendOnlyMail(smtpSetting,recipients, subject, body);
				}catch (Exception e){
					//ExceptionHandler.onError(request.getRequestURI(),e);
				}
				
			}
			
		} catch (Exception e) {
			//ExceptionHandler.onError(request.getRequestURI(),e);
			//return badRequest();
			e.printStackTrace();
			return new ResponseEntity<String>(HttpStatus.BAD_REQUEST).toString();
		}
		Integer count = Application.count(username);
		String notification = count.toString(); 
		String message="";
		if(userStatus){
			message = "User have been Edited Successfully";
		}else{
			message = "The Selected User have been Approved and Edited Successfully";
		}
		 
		Map<String,String> jsonMap = new HashMap<String,String>();
		jsonMap.put("count", notification);
		jsonMap.put("message", message);
		return Json.toJson(jsonMap).toString();
    }
	
	@RequestMapping(value="/userIndex", method = RequestMethod.GET)
	public String index(ModelMap model,@CookieValue("username") String username) {
		User user = User.findByEmail(username);
		RoleX role = RoleX.find.where(Expr.eq("company", user.companyobject)).findUnique();
		List<DomainEnum> roleX = new ArrayList<DomainEnum>();
		if(role != null){
			for(int i=0; i<role.roleLevels.size(); i++){
				roleX.add(new RoleDomain(role.roleLevels.get(i).id+"",role.roleLevels.get(i).role_name,false));
			}
		}
		user.rolex = roleX;
		
		model.addAttribute("context", UserSearchContext.getInstance().build());
		model.addAttribute("_menuContext", MenuBarFixture.build(username));
		model.addAttribute("user", user);
		
		return "userIndex";
		/*return ok(userIndex.render(UserSearchContext.getInstance().build(),MenuBarFixture.build(request().username()),user));*/
    }
	
	@RequestMapping(value="/userDelete", method=RequestMethod.GET)
	public String delete() {
		return "";
    }
	
	@RequestMapping(value="/findPM", method=RequestMethod.GET)
	public @ResponseBody String findProjectManagers(@CookieValue("username") String username,HttpServletRequest requset){
		DynamicForm form = DynamicForm.form().bindFromRequest(requset);
		String designation = form.get("param");
		String query = form.get("query");
		ObjectNode result = Json.newObject();
		List<AutoComplete> results = transform(findUpperLevelUser(username, query, designation, true), toAutoCompleteFormatForPM());
		result.put("results", Json.toJson(results));
		return Json.toJson(result).toString();
	}
	
	@RequestMapping(value="/findHRUser", method=RequestMethod.GET)
	public @ResponseBody String findHRUser(@CookieValue("username") String username,HttpServletRequest requset){
		DynamicForm form = DynamicForm.form().bindFromRequest(requset);
		String designation = form.get("param");
		String query = form.get("query");
		ObjectNode result = Json.newObject();
		List<AutoComplete> results = transform(findHRManagers(username, query,designation), toAutoCompleteFormatForHR());
		result.put("results", Json.toJson(results));
		return Json.toJson(result).toString();
	}
	
	@RequestMapping(value="/findDelegatedTo", method=RequestMethod.GET)
	public @ResponseBody String findDelegateTos(@CookieValue("username") String username,HttpServletRequest requset){
		
		DynamicForm form = DynamicForm.form().bindFromRequest(requset);
		String query = form.get("query");
		ObjectNode result = Json.newObject();
		List<AutoComplete> results = transform(findDelegateTos(username, query), toAutoCompleteFormatForDelegate());
		result.put("results", Json.toJson(results));
		return Json.toJson(result).toString();
	}

	private static Function<models.User,AutoComplete> toAutoCompleteFormatForHR() {
		return new Function<models.User, AutoComplete>() {
			@Override
			public AutoComplete apply(models.User user) {
					return new AutoComplete(user.firstName,user.lastName,user.email,user.id);
			}
		};
	}
	
	private static Function<models.User,AutoComplete> toAutoCompleteFormatForPM() {
		return new Function<models.User, AutoComplete>() {
			@Override
			public AutoComplete apply(models.User user) {
					return new AutoComplete(user.firstName,user.lastName,user.email,user.id);
			}
		};
	}
	
	public static List<User> findHRManagers(String username, String query, String param) {
		RoleX roleX = RoleX.find.where(Expr.eq("company", 
										User.findByEmail(username).companyobject)).findUnique();
		
		List<String> upperRoleLevels = new ArrayList<String>();
		for(RoleLevel level : roleX.roleLevels){
			if(Integer.parseInt(level.role_level.name().split("[_]")[1]) > Integer.parseInt(param)){
				upperRoleLevels.add(level.role_level.name());
			}
		}
		
	    return User.find.where().and(Expr.in("designation", upperRoleLevels),
	    		   Expr.or(Expr.ilike("firstName", query+"%"), 
	    				   Expr.or(Expr.ilike("lastName", query+"%"),
	    						   Expr.ilike("middleName", query+"%")))).findList();
	}
	
	public static List<User> findProjectManagers(String username, String query, String param) {
		return findUpperLevelUser(username, query, param, false);
	}
	
	public static List<User> findUpperLevelUser(String username, String query, String param, boolean check){

		User _thisUser = User.findByEmail(username);
		RoleX roleX = RoleX.find.where(Expr.eq("company", 
				_thisUser.getCompanyobject())).findUnique();
		List<User> usersAfterFilter = new ArrayList<User>(); 
		
		if(param.length() != 0) {
			RoleLevel thisLevel = RoleLevel.findById(Long.parseLong(param));
			
			List<User> users = User.find.where().
			and(Expr.eq("role.roleX",roleX),
			Expr.or(Expr.ilike("firstName", query+"%"), 
				Expr.or(Expr.ilike("lastName", query+"%"),
						Expr.ilike("middleName", query+"%")))).findList();
			
			for(User _u : users){
				if(_u.getRole().getRole_level().ordinal() >= thisLevel.getRole_level().ordinal()){
					usersAfterFilter.add(_u);
				}
			}
		} else {
			List<User> users = User.find.where().add(Expr.eq("role.roleX",roleX)).findList();
			for(User _u : users){
				usersAfterFilter.add(_u);
			}
		}
		if (usersAfterFilter.size() == 0 ){
			usersAfterFilter.add(User.find.where().and(Expr.eq("companyobject", 
					_thisUser.getCompanyobject()), Expr.eq("designation", "Admin")).findUnique());
		}
		
		return usersAfterFilter;
	}
	
	
	public static List<User> findDelegateTos(String username, String query) {
		User user = User.findByEmail(username);
		RoleX role1 = RoleX.find.where().eq("company", user.getCompanyobject()).findUnique();
		RoleLevel level = RoleLevel.find.where().eq("role_name",user.getDesignation()).eq("roleX",role1).findUnique();
		
		return findUpperLevelUser(username, query, level.id.toString(), true);
	}
	
	private static Function<models.User,AutoComplete> toAutoCompleteFormatForDelegate() {
		return new Function<models.User, AutoComplete>() {
			@Override
			public AutoComplete apply(models.User user) {
					return new AutoComplete(user.firstName,user.lastName,user.email,user.id);
			}
		};
	}
	
	@RequestMapping(value="/findManagerUser", method=RequestMethod.GET)
	public String findManagerUser(){
		return "";
	}
	
	@RequestMapping(value="/userCreate", method = RequestMethod.POST)
	public @ResponseBody String create(HttpServletRequest request,@CookieValue("username") String username) {
		String email,code,userEmail;
		int a,b;
		
			DynamicForm form = DynamicForm.form().bindFromRequest(request);
			String userName = form.get("email");
			User user = User.findByEmail(username);
			
			email = user.email;
			b = email.length();
			a = email.lastIndexOf("@");
			code = email.substring(a,b);
			userEmail = userName.concat(code);
			
			User companyAdmin = User.findByEmail(username);
			form.data().put("email", userEmail);
			String password = Application.generatePassword();
			RoleLevel roleLevel = RoleLevel.findById(Long.parseLong(form.get("rolex")));
	    	Map<String, Object> extra = new HashMap<String, Object>();
	    	extra.put("email", userEmail);
			extra.put("companyobject", User.findByEmail(username).companyobject);
			extra.put("userStatus", com.custom.domain.Status.Approved);
			extra.put("password", password);
			extra.put("tempPassword", 1);
			extra.put("role", roleLevel);
			extra.put("designation", roleLevel.role_name);
			extra.put("permissions",roleLevel.getPermissions());
			
			UserSave saveUtils = new UserSave(extra);
			
			try {
				saveUtils.doSave(false, request);
			}catch (Exception e) {
				//ExceptionHandler.onError(request.getRequestURI(),e);
				//	return badRequest();
				e.printStackTrace();
				return new ResponseEntity<String>(HttpStatus.BAD_REQUEST).toString();

			}
			
			try {
				MailSetting smtpSetting = MailSetting.find.where().eq("companyObject", user.companyobject).findUnique();
				String recipients = "";
		    	String subject = "";
		    	String body = "";
		    	recipients = userEmail;
		    	subject = "Account Creation By" + companyAdmin.firstName;
		    	body = "Your Login Details :";
		    	body += "\nUser Name :" + userEmail;
		    	body += "\nPassword  :" + password;
		    	Email.sendOnlyMail(smtpSetting,recipients, subject, body);
			}catch (Exception e) {
				//ExceptionHandler.onError(request.getRequestURI(),e);
			}
			return "User Created Successfully";
    }
	
	@RequestMapping(value="/emailAvailability", method=RequestMethod.POST)
	public @ResponseBody String emailAvailability(HttpServletRequest request,@CookieValue("username") String username)
	{
		String email,code,userEmail;
		int a,b;
		
		DynamicForm form = DynamicForm.form().bindFromRequest(request);
		String q = form.get("q");
		User user = User.findByEmail(username);
		
		email = user.email;
		b = email.length();
		a = email.lastIndexOf("@");
		code = email.substring(a,b);
		userEmail = q.concat(code);
		
		User userNew = User.find.where().eq("email", userEmail).findUnique();
		if(userNew==null){
			return Json.toJson(true).toString();
		}
		return Json.toJson(false).toString();
		
	}
	
	@RequestMapping(value="/findcompanyuser", method=RequestMethod.GET)
	public @ResponseBody String getCompanyUser(HttpServletRequest request,@CookieValue("username") String username)
	{
		DynamicForm form = DynamicForm.form().bindFromRequest(request);
		String designation = form.get("param");
		String query = form.get("query");
		ObjectNode result = Json.newObject();
		List<AutoComplete> results = transform(findCompanyUser(username, query, designation), toAutoCompleteFormatForCU());
		result.put("results", Json.toJson(results));
		return Json.toJson(result).toString();
	}
	
	public static List<User> findCompanyUser(String username, String query, String param) {
		User user = User.findByEmail(username);
	    return User.find.where().eq("companyobject", user.companyobject).ilike("firstName", query+"%").findList();
	}
	
	private static Function<models.User,AutoComplete> toAutoCompleteFormatForCU() {
		return new Function<models.User, AutoComplete>() {
			@Override
			public AutoComplete apply(models.User user) {
					return new AutoComplete(user.firstName,user.lastName,user.email,user.id);
				
			}
		};
	}
	
	@RequestMapping(value="/idAvailability", method=RequestMethod.POST)
	public String idAvailability(HttpServletRequest request)
	{
		DynamicForm form = DynamicForm.form().bindFromRequest(request);
		String q = form.get("q");
		User user = User.find.where().eq("employeeId", q).findUnique();
		if(user == null){
			return Json.toJson(true).toString();
		}
		return Json.toJson(false).toString();
	}
}
