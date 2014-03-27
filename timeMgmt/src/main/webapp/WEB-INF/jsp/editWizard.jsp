<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="wizard" id='${_searchContext.entityName()}${"_edit-wizard"}'>
	<h1></h1>
	<c:forEach var="wizard" items='${_searchContext.getWizards()}'>
		<div class="wizard-card" data-cardname='${wizard.name()}${"_edit"}'
			data-validate='${"form_"}${_searchContext.entityName()}${"_edit_wizard"}'>
			<h3>${wizard.name()}</h3>
			<c:forEach var="fieldType" items="${wizard.card().iterator()}">
				<c:choose>
					<c:when test='${fieldType.ctype().name()=="INPUT"}'>
						<c:choose>
							<c:when test='${!fieldType.hidden()}'>
								<c:choose>
									<c:when
										test='${!fieldType.autocomplete() && !fieldType.multiselect()}'>
										<c:choose>
											<c:when test='${fieldType.order()%2 == 1}'>
												<div class="control-group"
													style="float: left; width: 46%; margin: 0px; height: 75px;">
											</c:when>
											<c:otherwise>
												<div class="control-group" style="height: 75px;">
											</c:otherwise>
										</c:choose>
										<label class="control-label" for="textinput">${fieldType.label()}
											<c:if
												test="${fieldType.validation() !=null && fieldType.validation().required()}">
												<sup style="color: red"> *</sup>
											</c:if>
										</label>
										<div class="controls">
											<c:choose>
												<c:when
													test='${fieldType.validation() !=null && fieldType.validation().required()}'>
													<input
														id='${_searchContext.entityName()}${"edit"}${fieldType.name()}'
														value='${fieldType.value().getO().toString()}'
														${fieldType.htmlAttrib()} name="${fieldType.name()}"
														placeholder="${fieldType.label()}" class="input-large"
														type="text" required rel="popover">
												</c:when>
												<c:otherwise>

													<input
														id='${_searchContext.entityName()}${"edit"}${fieldType.name()}'
														value='${fieldType.value().getO().toString()}'
														${fieldType.htmlAttrib()} name="${fieldType.name()}"
														class="input-large" type="text">
												</c:otherwise>
											</c:choose>
										</div>
		</div>

		</c:when>
		<c:otherwise>
			<c:choose>
				<c:when test='${fieldType.order() % 2 == 1}'>
					<div class="control-group"
						style="float: left; width: 46%; margin: 0px; height: 75px;">
				</c:when>
				<c:otherwise>
					<div class="control-group" style="height: 75px;">
				</c:otherwise>
			</c:choose>
			<label class="control-label" for="textinput">${fieldType.label()}
				<c:if
					test="${fieldType.validation() !=null && fieldType.validation().required()}">
					<sup style="color: red"> *</sup>
				</c:if>
			</label>
			<div class="fuelux controls">
				<c:choose>
					<c:when test='${fieldType.autocomplete()}'>
						<c:choose>
							<c:when test="${fieldType.value().getO()!=null}">
								<c:choose>
									<c:when
										test='${fieldType.validation() !=null && fieldType.validation().required()}'>
										<input
											id='${_searchContext.entityName()}${"edit"}${fieldType.name()}'
											value='${fieldType.value().getO().toString()}'
											${fieldType.htmlAttrib()} required
											placeholder="${fieldType.label()}" type="text">
									</c:when>
									<c:otherwise>
										<input
											id='${_searchContext.entityName()}${"edit"}${fieldType.name()}'
											value='${fieldType.value().getO().toString()}'
											${fieldType.htmlAttrib()} placeholder="${fieldType.label()}"
											type="text">
									</c:otherwise>
								</c:choose>
								<input
									id='${_searchContext.entityName()}${"edit"}${fieldType.name()}${"_hidden"}'
									value='${fieldType.value().id}'
									name='${fieldType.name()}${"_id"}' type="hidden">
							</c:when>
							<c:otherwise>
								<input
									id='${_searchContext.entityName()}${"edit"}${fieldType.name()}'
									placeholder="${fieldType.label()}" autocomplete="off"
									type="text">
								<input
									id='${_searchContext.entityName()}${"edit"}${fieldType.name()}${"_hidden"}'
									name='${fieldType.name()}${"_id"}' type="hidden">
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise>

						<input
							id='${_searchContext.entityName()}${"edit"}${fieldType.name()}'
							${fieldType.htmlAttrib()} placeholder="${fieldType.label()}"
							type="text">
						<input
							id='${_searchContext.entityName()}${"edit"}${fieldType.name()}${"_hidden"}'
							name='${fieldType.name()}${"_ids"}' type="hidden">
					</c:otherwise>
				</c:choose>
			</div>
</div>
<script>
											<c:if test='${fieldType.value().li !=null}'>
												idss = [];
												<c:forEach var='mo' items="${fieldType.value().li}">
													idss.push(${mo.id});
												</c:forEach>
												$('#${_searchContext.entityName()}${"edit"}${fieldType.name()}${"_hidden"}').val(idss);
												$('#${_searchContext.entityName()}${"edit"}${fieldType.name()}').val(idss);
											</c:if>
											$('#${_searchContext.entityName()}${"edit"}${fieldType.name()}').select2({
												minimumInputLength: 1,
												multiple:${fieldType.multiselect()},
											    ajax: { // instead of writing the function to execute the request we use Select2's convenient helper
											        url: "${pageContext.request.contextPath}${_searchContext.autoCompleteUrls().get(fieldType.label())}",
											        dataType: 'json',
											        data: function (term, page) {
											            return {
											                query: term, // search term
											                param: function(){
											                	if(typeof(${_searchContext.entityName()}${"edit"}${fieldType.name()}${"_customParameterBuilder"}) == "function"){
											                			return ${_searchContext.entityName()}${"edit"}${fieldType.name()}${"_customParameterBuilder()"};
											                }else{
                                                                     return "";
											                }
                                                            },
											                page_limit: 10
											            };
											        },
											        results: function (data, page) { // parse the results into the format expected by Select2.
											            return {results: data.results};
											        }
											    },
											    formatResult: function(exercise) { 
											    	return "<div class='select2-user-result'>" + exercise._1 + "</div>"; 
											    },
											    formatSelection: function(exercise) { 
											    	return exercise._1; 
											    },
											   
											    
											    initSelection: function(element, callback) {
											    	var _id=$(element).val();
											    	var data = [];
											    	<c:choose>
											    		<c:when test="${fieldType.multiselect()}">
											    			<c:if test='${fieldType.value().li!=null}'>
												    			<c:forEach var='mo' items='${fieldType.value().li}'>
												    				data.push({id: ${mo.id}, _1:'${mo.getO()}' });	
												    			</c:forEach>
											    			</c:if>
											    	</c:when>
											    	<c:otherwise>
											    		 data = {_1:_id,id:$('#${_searchContext.entityName()}${"edit"}${fieldType.name()}${"_hidden"}').val()};
											    	</c:otherwise>
											    	</c:choose>
											    	callback(data);
											    }
											}).on('change',function(ev){
											//	console.log(ev.val);
												$('#'+'${_searchContext.entityName()}${"edit"}${fieldType.name()}${"_hidden"}').val(ev.val);
											});
											</script>
</c:otherwise>
</c:choose>
</c:when>
<c:otherwise>
	<input id='${_searchContext.entityName()}${"edit"}${fieldType.name()}'
		name='${fieldType.name()}' value='${fieldType.value().getO()}'
		type="hidden">
</c:otherwise>
</c:choose>
</c:when>

<c:when test='${fieldType.ctype().name()=="SELECT_OPTION"}'>
	<c:choose>
		<c:when test='${fieldType.order() % 2 == 1}'>
			<div class="control-group"
				style="float: left; width: 46%; margin: 0px; height: 75px;">
		</c:when>
		<c:otherwise>
			<div class="control-group" style="height: 75px;">
		</c:otherwise>
	</c:choose>

	<label class="control-label" for="selectbasic">${fieldType.label()}</label>
	<div class="controls">
		<select
			id='${_searchContext.entityName()}${"edit"}${fieldType.name()}'
			name="${fieldType.name()}" class="input-large">
			<c:forEach var="option" items="${fieldType.options()}">

				<c:choose>
					<c:when test='${option.name().equals(fieldType.value().display)}'>
						<option value='${option}' selected>${option.getName()}</option>
					</c:when>
					<c:otherwise>
						<c:if test="${option.uiHidden()== false}">
							<option value='${option}'>${option.getName()}</option>
						</c:if>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</select>
	</div>
	</div>
</c:when>
<c:when test='${fieldType.ctype().name()=="SEARCH"}'>

	<div class="control-group">
		<label class="control-label" for="selectbasic">${fieldType.label()}</label>
		<div class="controls">
			<!-- @searchContext(_searchContext.getSearchContexts.get(fieldType.name),(_searchContext.entityName),"edit") -->
			<c:set var="_searchContext"
				value="${_searchContext.getSearchContexts().get(fieldType.name())}"
				scope="request" />
			<c:set var="_parentSearchCtx" value="${_searchContext.entityName()}"
				scope="request" />
			<c:set var="mode" value="edit" scope="request" />
			<jsp:include page="searchContext.jsp"></jsp:include>
		</div>
		<input class="OneToMany" entity='${_searchContext.entityName()}'
			id='${_searchContext.entityName()}${"edit"}${fieldType.name()}${"_hidden"}'
			name='${fieldType.name()${"_ids"}' type="hidden">
	</div>
	<script type="text/javascript">
	<c:if test='${fieldType.value().li!= null}'>
			idss = [];
			<c:forEach var='mo' items='${fieldType.value().li}'>
				idss.push('${mo.id}');
				$('#${_searchContext.getSearchContexts().get(fieldType.name()).entityName()${"edit"}${"_Pillbox ul"}').append("<li data-id='${mo.id()}' class='status-info'>${mo.getO()}</li>");
			</c:forEach>
			$('#${_searchContext.entityName()${"edit"}${fieldType.name()}${"_hidden"}').val(idss);
		</c:if>
	</script>
	</div>
</c:when>

<c:when test='${fieldType.ctype().name()=="DATE"}'>
	<c:choose>
		<c:when test='${fieldType.order() % 2 == 1}'>
			<div class="control-group"
				style="float: left; width: 46%; margin: 0px; height: 75px;">
		</c:when>
		<c:otherwise>
			<div class="control-group" style="height: 75px;">
		</c:otherwise>
	</c:choose>

	<label class="control-label" for="selectbasic">${fieldType.label()}
		<c:if
			test="${fieldType.validation() !=null && fieldType.validation().required()}">
			<sup style="color: red"> *</sup>
		</c:if>
	</label>
	<div id='${_searchContext.entityName()}${"edit"}${fieldType.name()}'
		data-provide="datepicker" class="input-prepend date datepicker"
		data-date="" data-date-format="dd-mm-yyyy">
		<span class="add-on"><i class="icon-calendar"></i></span>
		<c:choose>
			<c:when test='${fieldType.value().dt!=null}'>
				<fmt:formatDate var="fmtDate" pattern="dd-MM-YYYY"
					value='${fieldType.value().dt}' />
				<input size="16" type="text" value="${fmtDate}"
					<%-- value='${fieldType.value().dt.format("dd-MM-yyyy")}' --%>
					name='${fieldType.name()}'
					placeholder="dd-MM-YYYY" class="add-on">
			</c:when>
			<c:otherwise>
				<fmt:formatDate var="fmtDate" pattern="dd-MM-YYYY"
					value='${fieldType.value().dt}' />
				<input size="16" type="text" value='${fmtDate}'
					name='${fieldType.name()}' placeholder="dd-MM-YYYY" class="add-on">
			</c:otherwise>
		</c:choose>
	</div>
	</div>
</c:when>
</c:choose>
</c:forEach>
</div>
</c:forEach>
<div class="wizard-success">${_searchContext.entityName()}${" Edited Successfully"}
</div>

<div class="wizard-error">submission had an error</div>

<div class="wizard-failure">submission failed</div>
</div>
<script>
function ${"form_"}${_searchContext.entityName()}${"_edit_wizard"}(){
	$('#${"form_"}${_searchContext.entityName()}${"_edit-wizard"}').validate({
		//errorElement:"", 
		rules: {
		     <c:forEach var='wizard' items='${_searchContext.getWizards()}'>
		    		<c:forEach var='fieldType' items='${wizard.card().iterator()}'>
		    			 <c:if test='${fieldType.validation() !=null}'>
			    			 	 ${fieldType.name()}:{
				    				 minlength: ${fieldType.validation().minlength()},
				    				 required : ${fieldType.validation().required()},
				    				 email: ${fieldType.validation().email()},
				    				 maxlength: ${fieldType.validation().maxlength()},
				    				 date: ${fieldType.validation().date()},
				    				 digits: ${fieldType.validation().digits()},
									 number: ${fieldType.validation().number()}			    				 
				    			 },
		    		 	</c:if>
		    		</c:forEach>
		    		</c:forEach>
	    	 },
	    	 messages: {
	    	  <c:forEach var='wizard' items='${_searchContext.getWizards()}'>
	    		 <c:forEach var='fieldType' items='${wizard.card().iterator()}'>
	    			 <c:if test='${fieldType.validation() !=null}'>
	    				 <c:if test='${!fieldType.validation().messages().equals("")}'>
		    				 ${fieldType.name()} :'${fieldType.validation().messages()}',
	    				</c:if>
		    		 </c:if>
	    		 </c:forEach>
	    		 </c:forEach>
	    	 },
	    	
	    highlight: function (element) {
	        $(element).closest('.control-group').removeClass('success').addClass('error');
	    },
	    success: function(element) {
	        element
	        .addClass('valid')
	        .closest('.control-group').removeClass('error').addClass('success');
	      }
	});
	return $('#${"form_"}${_searchContext.entityName()}${"_edit-wizard"}').valid();
}
</script>
