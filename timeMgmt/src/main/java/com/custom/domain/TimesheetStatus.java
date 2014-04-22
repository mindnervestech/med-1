package com.custom.domain;

import com.mnt.core.domain.DomainEnum;

public enum TimesheetStatus implements DomainEnum{
	Submitted("Submitted"),
	Draft("Draft"),
	Approved("Approved"),
	Rejected("Rejected");
	
	private boolean uiHidden = false;
	@Override
	public boolean uiHidden() {
		return uiHidden;
	}
	private String forName;
	
	private TimesheetStatus(String forName){
		this.forName=forName;
	}
	
	public String getName(){
		return forName;
	}
}
