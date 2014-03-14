package com.custom.domain;

public class BlackListedPermissions {

	public static String BLACKLISTED_PERMISSIONS_FOR_SUPERADMIN = 
			"ManageUser|ManageProject|ManageTask|ManageClient|Delegate|FeedBackCreate|FeedBackView|" +
				"UserPermissions|UserRequest|MyBucket|LeaveBucket|TeamRate|ProjectReport|Mail|Notification|" +
					"DefineRoles|OrgHierarchy|ApplyLeave|Leaves|Timesheet|CreateTimesheet|SearchTimesheet|RolePermissions";
	
	
	
	public static String BLACKLISTED_PERMISSIONS_FOR_ADMIN = 
			"Delegate|FeedBackCreate|FeedBackView|TeamRate|ProjectReport|Notification|" +
					"ApplyLeave|Leaves|Timesheet|CreateTimesheet|SearchTimesheet|CompanyRequest";
	
	

	public static String BLACKLISTED_PERMISSIONS_FOR_USERS = 
			"ManageUser|ManageProject|ManageTask|ManageClient|Delegate|FeedBackCreate|FeedBackView|" +
				"UserPermissions|UserRequest|MyBucket|LeaveBucket|TeamRate|ProjectReport|Mail|Notification|" +
					"DefineRoles|OrgHierarchy|ApplyLeave|Leaves|Timesheet|CreateTimesheet|SearchTimesheet|" +
						"CompanyRequest|RolePermissions";


}
