package com.mnt.core.helper;

import static play.data.Form.form;

import java.lang.reflect.Field;
import java.lang.reflect.ParameterizedType;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import play.data.Form;
import play.db.ebean.Model;

import com.mnt.core.ui.annotation.UIFields;

public abstract class SaveModel<model extends Model> {
	
	protected Class<model> ctx; 
	
	public SaveModel(Class<model> ctx){
		this.ctx=ctx;
	}
	
	public SaveModel() {
	}

	public final <T extends Model>Object doSave(boolean isUpdate,HttpServletRequest request) throws Exception{
		Form<? extends Model> form = form(ctx).bindFromRequest(request);
		preSave(form);
		if(!isUpdate){
			form.get().save();
		}else{
			form.get().update();
		}
		
		postSave();
		return form.get().getClass().getField("id").get(form.get());
	}
	
	protected void preSave(Form<? extends Model> form) throws Exception{
		for(Field f :ctx.getFields()){
			if(f.isAnnotationPresent(UIFields.class)){
				if(((UIFields)f.getAnnotation(UIFields.class)).autocomplete()){
					String _idAsStr = form.data().get(f.getName()+"_id");
					if(_idAsStr!=null && _idAsStr.length()>0){
						Object o =f.getType().getDeclaredMethod("findById", Long.class).invoke(null, Long.valueOf(_idAsStr));
						form.get().getClass().getField(f.getName()).set(form.get(), o);
					}
				}
				
				
				
				if(((UIFields)f.getAnnotation(UIFields.class)).searchable() || ((UIFields)f.getAnnotation(UIFields.class)).multiselect()){
					String _idAsStr = form.data().get(f.getName()+"_ids");
					List<Long> _idAsLong = new ArrayList<Long>();
					for(String _id:_idAsStr.split(",")){
						if(_id.length()>0)
							_idAsLong.add(Long.valueOf(_id));
					}
					if(!_idAsLong.isEmpty()){
						ParameterizedType listType = (ParameterizedType)f.getGenericType();
						 Class<?> listClass = (Class<?>) listType.getActualTypeArguments()[0];
						Object o =listClass.getDeclaredMethod("findByIds", List.class).invoke(null, _idAsLong);
						form.get().getClass().getField(f.getName()).set(form.get(), o);
					}
				}
				
			}
		}
	}
	
	protected void postSave(){}
}
