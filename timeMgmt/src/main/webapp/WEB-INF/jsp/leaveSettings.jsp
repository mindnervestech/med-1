<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="menuContext.jsp" />
<h4>
	<b style="width: 1051px; margin-left: 20px;"><i>Leaves Settings</i></b>
</h4>

<fieldset>
	<div id="Leaves">
		<form:form >
			<c:forEach var="role" items="${roleLevels}" varStatus='loopIndex'>

				<div class="span3 clearfix"
					id="roleLevels_${loopIndex.index}__role_name_field">
					<label for="roleLevels_${loopIndex.index}__role_name">Role
						Name</label>
					<div class="input">

						<input type="text" name="roleLevels[${loopIndex.index}].role_name"
							value="${roleLevels.get(loopIndex.index)}"
							id="roleLevels_${loopIndex.index}__role_name"
							class=" roleDivs roleDivsInput readonlycls" readonly="readonly">
						<span class="help-inline"></span> <span class="help-block"></span>

					</div>
				</div>
				<div class="container">
					<div class="span2 clearfix"
						id="roleLevels_${loopIndex.index}__Casual_Leave">
						<label for="roleLevels_${loopIndex.index}__Casual_Leave">Casual Leave </label>
						<div class="input">
							<input type="text" name="roleLevels[${loopIndex.index}].Casual_Leave"placeholder="0"
								value="" id="roleLevels_${loopIndex.index}__Casual_Leave"
								class="span1 roleDivs roleDivsInput readonlycls"> <span
								class="help-inline"></span> <span class="help-block"></span>

						</div>
					</div>

					<div class="span2 clearfix"
						id="roleLevels_${loopIndex.index}__Sick_Leave">
						<label for="roleLevels_${loopIndex.index}__Sick_Leave">Sick
							Leave </label>
						<div class="input">
							<input type="text" name="roleLevels[${loopIndex.index}].Sick_Leave"
								value="" id="roleLevels_${loopIndex.index}__Sick_Leave"placeholder="0"
								class="span1 roleDivs roleDivsInput readonlycls"> <span
								class="help-inline"></span> <span class="help-block"></span>

						</div>
					</div>

					<div class="span2 clearfix"
						id="roleLevels_${loopIndex.index}__Maternity_Leave">
						<label for="roleLevels_${loopIndex.index}__Maternity_3">Maternity
							Leave </label>
						<div class="input">
							<input type="text" name="roleLevels[${loopIndex.index}].Maternity_Leave"
								value="" id="roleLevels_${loopIndex.index}__Maternity_Leave"placeholder="0"
								class="span1 roleDivs roleDivsInput readonlycls"> <span
								class="help-inline"></span> <span class="help-block"></span>

						</div>
					</div>
				</div>
			</c:forEach>


			<div class="actions" style="margin-top: 1%;">
				<input type="button" class="btn btn-info" id="submitButton"
					value="Submit" style="margin: 1% 2%; width: 8%;">
			</div>
		</form:form>
	</div>
</fieldset>