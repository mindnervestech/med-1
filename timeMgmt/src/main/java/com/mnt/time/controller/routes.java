package com.mnt.time.controller;

public class routes {
	
public interface Application {
	public interface index {
		public static String url="/index";
	}

	public interface logout {
		public static String url="/logout";
	}

	public interface deployment {
		public static String url="/deploy";
	}

	public interface restrictedPage {
		public static String url="accessDeny";
	}

	public interface setPassword {
		public static String url="set";
	}

	public interface login {
		public static String url="/";
	}

	public interface authenticate {
		public static String url="/login";
	}

	public interface registration {
		public static String url="/registration";
	}

	public interface createAccount {
		public static String url="/registration";
	}

	public interface checkUserEmailAvailability {
		public static String url="/checkUserEmail";
	}

	public interface checkPassword {
		public static String url="/checkPassword";
	}

	public interface checkOldPassword {
		public static String url="/checkOldPassword";
	}

	public interface changePassword {
		public static String url="/changePassword";
	}

	public interface checkCompanyEmailAvailability {
		public static String url="/checkCompanyEmail";
	}

	public interface finduser {
		public static String url="/finduserid";
	}

	public interface forgotpassword {
		public static String url="/forgot";
	}

	public interface companyregistration {
		public static String url="/register";
	}

	public interface companycreateAccount {
		public static String url="/complete";
	}

	public interface companysearch {
		public static String url="/companysearch";
	}

	public interface checkCompanyCodeAvailability {
		public static String url="/checkCompanyCode";
	}
	
	public interface checkCompanyNameAvailability {
		public static String url="/checkCompanyName";
	}
	
	public interface menuContext {
		public static String url="/";
	}

}

public interface Users {
	public interface index {
		public static String url="/userIndex";
	}

	public interface search {
		public static String url="/userSearch";
	}

	public interface delete {
		public static String url="/userDelete";
	}

	public interface create {
		public static String url="/userCreate";
	}

	public interface edit {
		public static String url="/userEdit";
	}

	public interface findHRUser {
		public static String url="/findHRUser";
	}


	public interface getCompanyUser {
		public static String url="/findcompanyuser";
	}

	public interface findManagerUser {
		public static String url="/findManagerUser";
	}

	public interface showEdit {
		public static String url="/userShowEdit";
	}

	public interface findProjectManagers {
		public static String url="/findPM";
	}

	public interface idAvailability	 {
		public static String url="/idAvailability";
	}

	public interface emailAvailability {
		public static String url="/emailAvailability ";
	}

	public interface excelReport {
		public static String url="/userExcelReport";
	}
	
	public interface findDelegateTos {
		public static String url="/findDelegatedTo";
	}

}

public interface userSearch {
	public interface index {
		public static String url="/userGenericSearchIndex";
	}
	public interface search {
		public static String url="/userGenericDoSearch";
	}

}

public interface Clients {
	public interface index {
		public static String url="/clientIndex";
	}

	public interface search {
		public static String url="/clientSearch";
	}

	public interface delete {
		public static String url="/clientDelete";
	}


	public interface create {
		public static String url="/clientCreate";
	}

	public interface edit {
		public static String url="/clientEdit";
	}

	public interface showEdit {
		public static String url="/clientShowEdit ";
	}

	public interface excelReport {
		public static String url="/clientExcelReport";
	}

	public interface findClients {
		public static String url="/findClient";
	}
}

public interface Tasks {
	public interface index {
		public static String url="/taskIndex";
	}

	public interface Search {
		public static String url="/taskSearch";
	}

	public interface delete {
		public static String url="/taskDelete";
	}

	public interface create {
		public static String url="/taskCreate";
	}

	public interface edit {
		public static String url="/taskEdit";
	}

	public interface findProjectByName {
		public static String url="/projectByName";
	}

	public interface showEdit {
		public static String url="/taskShowEdit";
	}

	public interface excelReport {
		public static String url="/taskExcelReport";
	}
}

public interface Projects {
	public interface index {
		public static String url="/projectIndex";
	}

	public interface Search {
		public static String url="/projectSearch";
	}

	public interface create {
		public static String url="/projectCreate";
	}

	public interface edit {
		public static String url="/projectEdit";
	}

	public interface delete {
		public static String url="/projectDelete";
	}

	public interface showEdit {
		public static String url="/projectShowEdit ";
	}

	public interface checkProjectCodeAvailability {
		public static String url="/projectCodeAvailability";
	}

	public interface excelReport{
		public static String url="/projectExcelReport";
	}

}

public interface TimesheetBuckets {
	public interface index {
		public static String url="/timesheet/bucketIndex";
	}
	
	public interface search {
		public static String url="/timesheet/bucketSearch";
	}

	public interface displaySelectedTimesheet {
		public static String url="/timesheet/displayTimesheet";
	}

	public interface approveTimesheets {
		public static String url="/timesheet/approveTimesheets";
	}

	public interface rejectTimesheets {
		public static String url="/timesheet/rejectTimesheets";
	}

	public interface approveTimesheetsOk {
		public static String url="/timesheet/approveTimesheetsOk";
	}

	public interface rejectTimesheetsOk {
		public static String url="/timesheet/rejectTimesheetsOk";
	}
	public interface excelReport {
		public static String url="/timesheetBucketExcelReport";
	}
	public interface timeSheetApprovalViaMail {
		public static String url="/timesheetApprovalViaMail";
	}
}



public interface Leaves {
	public interface defineLeaves{
		public static String url="/defineLeaves";
	}
	
	public interface saveLeaves{
		public static String url="/saveLeaves";
	}
	
	public interface leaveSettings{
		public static String url="/leaveSettings";
	}
	
	public interface applyIndex {
		public static String url="/leaveIndex";
	}

	public interface search {
		public static String url="/leaveSearch";
	}

	public interface delete {
		public static String url="/leaveDelete";
	}

	public interface create {
		public static String url="/leaveCreate";
	}

	public interface edit {
		public static String url="/leaveEdit";
	}

	public interface showEdit {
		public static String url="/leavesShowEdit";
	}

	public interface leaveApprovalViaMail {
		public static String url="/leaveApprovalViaMail";
	}

	public interface excelReport {
		public static String url="/leaveExcelReport";
	}

	public interface excelApplyReport {
		public static String url="/leaveApplyExcelReport";
	}
	
	public interface bucketIndex {
		public static String url="/leave/bucketIndex";
	}

	public interface leaveSearch {
		public static String url="/leave/bucketSearch";
	}

	public interface approveLeave {
		public static String url="/leave/approveLeave";
	}

	public interface rejectLeave {
		public static String url="/leave/rejectLeave";
	}

	public interface retractLeave {
		public static String url="/leave/retractLeave";
	}
}

public interface Timesheets {
	public interface index {
		public static String url="/timesheetIndex";
	}

	public interface searchIndex {
		public static String url="/timesheetSearchIndex";
	}

	public interface create {
		public static String url="/timesheetCreate";
	}

	public interface cancel {
		public static String url="/timesheetCancel";
	}

	public interface getTaskCodes {
		public static String url="/timesheet/getTaskCode";
	}

	public interface getTimesheetTable {
		public static String url="/timesheet/getTimesheetTable";
	}

	public interface getLastWeekTimesheet {
		public static String url="/timesheet/getLastWeekTimesheet";
	}

	public interface search {
		public static String url="/TimesheetSearch";
	}

	public interface editTimesheet {
		public static String url="/timesheetEdit/{id} ";
	}

	public interface excelReport {
		public static String url="/timesheetExcelReport";
	}
	
	public interface retractTimesheet {
		public static String url="/retractTimesheet";
	}
}

public interface Delegate {
	public interface index {
		public static String url="/delegateIndex";
	}
	public interface save {
		public static String url="/delagationSave";
	}
}

public interface UserPermissions {
	public interface index {
		public static String url="/permissionIndex";
	}
	public interface getUserList {
		public static String url="/permissionsearch";
	}
	public interface update {
		public static String url="/permission/update";
	}
	public interface save {
		public static String url="/permission/save";
	}
}

public interface RolePermissions {
	public interface index {
		public static String url="/rolepermissionIndex";
	}

	public interface getRoleList {
		public static String url="/rolepermissionsearch";
	}

	public interface update {
		public static String url="/rolepermission/update";
	}

	public interface save {
		public static String url="/rolepermission/save";
	}
}

public interface Status {
	public interface userIndex {
		public static String url="/userStatusIndex";
	}
	
	public interface companyIndex {
		public static String url="/companyStatusIndex	";
	}

	public interface userSearch {
		public static String url="/userStatusSearch";
	}

	public interface approveUserStatus {
		public static String url="/userStatusApprove";
	}

	public interface disapproveUserStatus {
		public static String url="/userStatusdisapprove";
	}

	public interface excelReportUser {
		public static String url="/userStatusExcelReport";
	}

	public interface companySearch {
		public static String url="/companyStatusSearch";
	}
	public interface approveCompanyStatus {
		public static String url="/companyStatusApprove";
	}

	public interface disapproveCompanyStatus {
		public static String url="/companyStatusDisapprove";
	}

	public interface excelReportCompany {
		public static String url="/companyStatusExcelReport";
	}

}

public interface Reports {
	public interface teamRateIndex {
		public static String url="/reportIndex";
	}
	public interface teamRateSearch {
		public static String url="/reportSearch";
	}

}

public interface ProjectReports {
	public interface projectReportIndex {
		public static String url="/projReportIndex";
	}

	public interface projectReportSearch {
		public static String url="/projReportSearch";
	}

	public interface viewProjectDetails {
		public static String url="/projViewDetails";
	}

	public interface viewGraph {
		public static String url="/viewGraph";
	}

	public interface viewUsageByHrs {
		public static String url="/projViewGraphHrs";
	}
}

public interface Mail {
	public interface index {
		public static String url="/mailIndex";
	}
	public interface settingSave {
		public static String url="/mailSave";
	}

}

public interface Notifications {
	public interface index {
		public static String url="/notificationIndex";
	}
	public interface save {
		public static String url="/notificationSave";
	}
}

public interface Roles {
	public interface defineRoles {
		public static String url="/defineRoles";
	}

	public interface showRoles {
		public static String url="/showRoles";
	}

	public interface index {
		public static String url="/roleIndex";
	}

	public interface search {
		public static String url="/roleSearch";
	}

	public interface delete {
		public static String url="/roleDelete";
	}

	public interface create {
		public static String url="/roleCreate";
	}
	
	public interface showEdit {
		public static String url="/roleShowEdit";
	}

	public interface edit {
		public static String url="/roleEdit";
	}

	public interface saveRole {
		public static String url="saveRole";
	}

}

public interface Feedbacks {
	public interface index {
		public static String url="/feedback/view";
	}
	
	public interface customIndex {
		public static String url="/feedback/create";
	}

	public interface customSearchIndex {
		public static String url="/feedback/customSearchIndex";
	}

	public interface submit {
		public static String url="/submitFeedback";
	}	
	public interface create {
		public static String url="/feedbackCreate";
	}

	public interface searchIndex {
		public static String url="/feedback/searchIndex";
	}

	public interface display {
		public static String url="/feedbackDisplay";
	}

}
public interface ProjectSearch {
	public interface index {
		public static String url="/projDetailsIndex";
	}

	public interface search {
		public static String url="/projDetailsSearch";
	}

}
}
