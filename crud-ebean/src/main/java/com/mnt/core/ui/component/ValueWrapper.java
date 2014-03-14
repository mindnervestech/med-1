package com.mnt.core.ui.component;

import java.util.Date;
import java.util.List;

public class ValueWrapper {
	
	public Object id;
	
	public Object o;
	
	public String display;
	
	public Enum option;
	
	public Date dt;
	
	public List<ValueWrapper> li;

	public Object getId() {
		return id;
	}

	public void setId(Object id) {
		this.id = id;
	}

	public Object getO() {
		return o;
	}

	public void setO(Object o) {
		this.o = o;
	}

	public String getDisplay() {
		return display;
	}

	public void setDisplay(String display) {
		this.display = display;
	}

	public Enum getOption() {
		return option;
	}

	public void setOption(Enum option) {
		this.option = option;
	}

	public Date getDt() {
		return dt;
	}

	public void setDt(Date dt) {
		this.dt = dt;
	}

	public List<ValueWrapper> getLi() {
		return li;
	}

	public void setLi(List<ValueWrapper> li) {
		this.li = li;
	}

}
