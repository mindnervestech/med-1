<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="menuContext.jsp" />

<h4>
	<b style="width: 1051px; margin-left: 20px;"><i>Define Leaves</i></b>
</h4>
<script src="resources/customScripts/defineLeave.js" type="text/javascript"></script>
<form:form method="POST" commandName="leavexForm" action="<%=com.mnt.time.controller.routes.Leaves.saveLeaves.url%>" id="form">
	<fieldset>
		<div id="leavex">
			<div class=" twipsies well leaveLevel" style="width: 96%; ">
				<div class="clearfix" style="margin-right: 4%;float: left;">
					<label for="leaveLevels_0__leave">Leaves Type</label> <input
						type="text" name="leaveLevels[0].leave_type"
						id="leaveLevels_0__leave_type" class="input-small"
						placeholder="Leave Type">
				</div>
				<div class="clearfix" style="width: 52%;">
					<label for="leaveLevels_0__leave">Carried Forward</label> <select
						id="leaveLevels_0__carry_forward"
						name="leaveLevels[0].carry_forward" class="input-small">
						<option class="largeInput largeInputFirst required" value="">-select-</option>
						<option class="largeInput largeInputFirst required" value="YES">YES</option>
						<option class="largeInput largeInputFirst required" value="NO">NO</option>
					</select> <a class="removeLeave btn danger pull-right">Remove</a>
				</div>
			</div>



			<div class="twipsies well leaveLevel_template hidden" >
				<div class="clearfix" style="margin-right: 4%;float: left;">
					<label for="leaveLevels_x__leave">Leaves Type</label> <input
						type="text" name="leaveLevels[x].leave_type"
						id="leaveLevels_x__leave_type" class="input-small"
						placeholder="Leave Type">
				</div>
				<div style="width: 52%;">
					<label for="leaveLevels_x__leave">Carried Forward</label> <select
						id="leaveLevels_x__carry_forward"
						name="leaveLevels[x].carry_forward" class="input-small">
						<option class="largeInput largeInputFirst required" value="">-select-</option>
						<option class="largeInput largeInputFirst required" value="YES">YES</option>
						<option class="largeInput largeInputFirst required" value="NO">NO</option>
					</select> <a class="removeLeave btn danger pull-right">Remove</a>
				</div>
			</div>
		</div>


	</fieldset>
	<div class=" actions buttonPosition">
		<a class="addMore btn btn-success">Add More</a> 
	<input type="button"
			class="btn btn-info" id="submitButton" value="Submit"
			style="width: 9%;">
	</div>

</form:form>

<script>
	$(document).ready(function() {

		$("#submitButton").click(function() {
			$('.leaveLevel_template').remove()
			$.ajax({
				type : "POST",
				data : $("#form").serialize(),
				url : "/saveLeaves",
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

<style>
/* .well{
 	background-color: #ffffff; 
 	border: 0px solid #e3e3e3;
} */
 .input-small {
	width: 159px !important;
}
 

</style>
