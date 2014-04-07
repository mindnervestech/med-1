<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="menuContext.jsp" />
<h4>
	<b style="width: 1051px; margin-left: 20px;"><i>Leaves Settings</i></b>
</h4>
 <%--  <c:set var="pad" value="0" />
<c:set var="b" value="0" />
<c:set var="e" value="0" />
<c:set var="be" value="0" />
<c:set var="en" value="${(AllLeaves.size()/roleLevel.size())-1}" />

<c:forEach var="role" end="${AllLeaves.size()/(AllLeaves.size()/roleLevel.size())-1}" items="${AllLeaves}" varStatus='loopIndex'>
	<c:forEach var="names" begin="${b}" end="${e}" items="${roleLevel}"
		varStatus='loopIndex1'>
		<h1>${names}</h1>
	</c:forEach>
	<c:set var="b" value="${e+1}" />
	<c:set var="e" value="${e+1}" />
	<c:forEach var="r" begin="${0}" end="${(AllLeaves.size()/roleLevel.size())-1}" items="${role.value}"
		varStatus='loopIndex2'>
		<h1>${r}</h1>
		 <c:choose>
			<c:when
				test="${loopIndex2.index % (AllLeaves.size()/roleLevel.size()) == 0.0}">
				<h1>roleLeaves_${role.key+pad-1}__${leave.value}</h1>
			</c:when>
			<c:otherwise>
				<h1>${r} ${role.key+pad+1}</h1>
			</c:otherwise>
		</c:choose> 
	</c:forEach>
	<c:set var="pad" value="${role.key}" />
	<c:set var="be" value="${en+1}" />
	<c:set var="en" value="${en+(AllLeaves.size()/roleLevel.size())}" />

</c:forEach>
  --%>

  <fieldset>
	<div id="Leaves">
		<form:form method="POST"
			action="${pageContext.request.contextPath}/<%=com.mnt.time.controller.routes.Leaves.saveLeaves.url%>"
			id="form">

			    <c:set var="pad" value="0" />
			<c:set var="b" value="0" />
			<c:set var="e" value="0" />
			<c:set var="be" value="0" />
			<c:set var="en" value="${(AllLeaves.size()/roleLevel.size())-1}" />  
 
			<c:forEach var="role"
				end="${AllLeaves.size()/(AllLeaves.size()/roleLevel.size())-1}"
				items="${AllLeaves}" varStatus='loopIndex'>
				<c:forEach var="names" begin="${b}" end="${e}" items="${roleLevel}"
					varStatus='loopIndex1'>
					<div class="span3 clearfix"
						id="roleLeaves1_${loopIndex1.index}__leave_name_field">
						<label for="roleLeaves1_${loopIndex1.index}__leave_name">Role
							Name</label>
						<div class="input">

							<input type="text"
								name="roleLeaves1[${loopIndex1.index}].role_name"
								value="${roleLevel.get(loopIndex1.index)}"
								class=" roleDivs roleDivsInput readonlycls" readonly="readonly">
							<span class="help-inline"></span> <span class="help-block"></span>

						</div>
					</div>

				</c:forEach>






				 <c:set var="b" value="${e+1}" />
				<c:set var="e" value="${e+1}" />

				<div class="container">
				
				<c:forEach var="r" begin="${0}"
					end="${(AllLeaves.size()/roleLevel.size())}"
					items="${role.value}" varStatus='loopIndex2'>
					
					<c:choose>
						<c:when
							test="${loopIndex2.index % (AllLeaves.size()/roleLevel.size()) == 0.0}">
							
								<div class="span2 clearfix"
									id="roleLeaves_${role.key+pad-1}__total_leave">
									<label for="roleLeaves_${role.key+pad-1}__${leave.value}">${r}</label>
									<div class="input">
									
										<input type="text"
											name="roleLeaves[${role.key+pad-1}].total_leave"
											placeholder="0" value="${allTotalValue.get(role.key+pad-1)}"
											id="roleLeaves_${role.key+pad-1}__${leave.value}"
											class="span1 roleDivs roleDivsInput readonlycls"> <span
											class="help-inline"></span> <span class="help-block"></span>

									</div>
									<div class="input">

										<input type="hidden" name="roleLeaves[${role.key+pad-1}].id"
											placeholder="0" value="${role.key+pad}"
											id="roleLeaves_${role.key+pad-1}__${leave.value}"
											class="span1 roleDivs roleDivsInput readonlycls"> <span
											class="help-inline"></span> <span class="help-block"></span>

									</div>

								</div>
							

						</c:when>
					<c:otherwise>
							
								<div class="span2 clearfix"
									id="roleLeaves_${role.key+pad}__total_leave">
									<label for="roleLeaves_${role.key+pad}__${leave.value}">${r}</label>
									<div class="input">
										<input type="text"
											name="roleLeaves[${role.key+pad}].total_leave"
											placeholder="0" value="${allTotalValue.get(role.key+pad)}"
											id="roleLeaves_${role.key+pad}__${leave.value}"
											class="span1 roleDivs roleDivsInput readonlycls"> <span
											class="help-inline"></span> <span class="help-block"></span>

									</div>
									<div class="input">

										<input type="hidden" name="roleLeaves[${role.key+pad}].id"
											placeholder="0" value="${role.key+pad+1}"
											id="roleLeaves_${role.key+pad}__${leave.value}"
											class="span1 roleDivs roleDivsInput readonlycls"> <span
											class="help-inline"></span> <span class="help-block"></span>

									</div>

								</div>
							
						</c:otherwise> 
					</c:choose>
				</c:forEach>   
				
				
				
				
				
				</div>
				<%-- <c:set var="pad" value="${role.key}" />
				<c:set var="be" value="${en+1}" />
				<c:set var="en" value="${en+(AllLeaves.size()/roleLevel.size())}" /> --%>
			</c:forEach>     
			
<!--  <_________________________________> -->
 
 
		<%-- 	<c:set var="b" value="0"/>
			<c:set var="e" value="${AllLeaves.size()/roleLevel.size()-1}"/>				
			<c:set var="leaves" value="${AllLeaves}"/>
			<c:forEach var="role" items="${roleLevel}" varStatus='loopIndex'>
			
				<div class="span3 clearfix"
					id="roleLeaves_${loopIndex.index}__leave_name_field">
					<label for="roleLeaves_${loopIndex.index}__leave_name">Role
						Name</label>
					<div class="input">

						<input type="text" name="roleLeaves1[${loopIndex.index}].role_name"
							value="${roleLevels.get(loopIndex.index)}"
							class=" roleDivs roleDivsInput readonlycls" readonly="readonly">
						<span class="help-inline"></span>
						<span class="help-block"></span>

					</div>
				</div>
				<c:forEach var="leave" begin="${b}" end="${e}" items="${leaves}" varStatus='loopIndex2'>
					<div class="container">
						<div class="span2 clearfix"
							id="roleLeaves_${loopIndex2.index}__total_leave">
							<label for="roleLeaves_${loopIndex2.index}__${leave.value}">${leave.value}</label>
							<div class="input">
								<input type="text"
									name="roleLeaves[${loopIndex2.index}].total_leave"
									placeholder="0" value=""
									id="roleLeaves_${loopIndex2.index}__${leave.value}"
									class="span1 roleDivs roleDivsInput readonlycls">  
									<span class="help-inline"></span> 
									<span class="help-block"></span>
									
							</div>
							<div class="input">
							
							<input type="hidden" name="roleLeaves[${loopIndex2.index}].id"
									placeholder="0" value="${leave.key}"
									id="roleLeaves_${loopIndex2.index}__${leave.value}"
									class="span1 roleDivs roleDivsInput readonlycls">  
									<span class="help-inline"></span> 
									<span class="help-block"></span>
									
							</div>
							
						</div>
					</div>
				</c:forEach> 
  
			<c:set var="leave" value="${leaves}"/>
			<c:set var="b" value="${e+1}"/>
			<c:set var="e" value="${e+AllLeaves.size()/roleLevel.size()}"/>
			</c:forEach>		  
 --%>

			<div class="actions" style="margin-top: 1%;">
				<input type="button" class="btn btn-info" id="submitButton"
					value="Submit" style="margin: 1% 2%; width: 8%;">
			</div>
		</form:form>
	</div>
</fieldset>  


  <script>
	$(document).ready(function() {

		$("#submitButton").click(function() {
			$.ajax({
				type : "POST",
				data : $("#form").serialize(),
				url : "${pageContext.request.contextPath}/saveLeaveValue",
				success : function(data) {
					$.pnotify({
						history : false,
						text : data
					});
				}
			});
		});
	});
</script> 
