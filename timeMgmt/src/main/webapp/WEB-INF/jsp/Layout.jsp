
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html >
    <head>
        <title><tiles:insertAttribute name="title" ignore="true" /></title>
        <link rel="stylesheet" media="screen" href='<c:url value="/resources/stylesheets/main.css"/>'>
        <link rel="shortcut icon" type="image/png" href='<c:url value="/resources/images/clock.png"/>'>
        <link rel="stylesheet" href='<c:url value="/resources/stylesheets/bootstrap.css"/>'>
        <link rel="stylesheet" href='<c:url value="/resources/stylesheets/bootstrap-responsive.css"/>'>
         <link rel="stylesheet" href='<c:url value="/resources/stylesheets/ui.jqgrid.css"/>'>
         <link rel="stylesheet" href='<c:url value="/resources/stylesheets/jquery-ui-custom.css"/>'>
         <link rel="stylesheet"  href='<c:url value="/resources/stylesheets/bootstrap-wizard.css"/>'>
          <link rel="stylesheet" href='<c:url value="/resources/stylesheets/fuelux.css"/>'>
         <link rel="stylesheet"  href='<c:url value="/resources/stylesheets/fuelux-responsive.min.css"/>'>
         <link rel="stylesheet"  href='<c:url value="/resources/stylesheets/datepicker.css"/>'>
		<link rel="stylesheet"  href='<c:url value="/resources/customCSS/timeTrotter.css"/>'>        
         <link rel="stylesheet"  href='<c:url value="/resources/stylesheets/select2.css"/>'>
         <link rel="stylesheet"  href='<c:url value="/resources/stylesheets/BarChart.css"/>'>
         <link rel="stylesheet"  href='<c:url value="/resources/stylesheets/base.css"/>'>
         <link rel="stylesheet"  type="text/css" media="all" href='<c:url value="/resources/stylesheets/jquery.pnotify.default.css"/>'>

        <script src='<c:url value="/resources/javascripts/jquery-1.9.0.min.js"/>' type="text/javascript"></script>
        <script src='<c:url value="/resources/javascripts/jquery-ui-1.9.2.custom.min.js"/>' type="text/javascript"></script>
        <script src='<c:url value="/resources/javascripts/require.js"/>' type="text/javascript"></script>
        <script src='<c:url value="/resources/javascripts/loader.js"/>' type="text/javascript"></script>
        <script src='<c:url value="/resources/javascripts/pillbox.js"/>' type="text/javascript"></script>
        <script type="text/javascript" src='<c:url value="/resources/javascripts/select2.js"/>'></script>
		<script type="text/javascript" src='<c:url value="/resources/javascripts/select2_locale_en.js.template"/>'></script>
		    
        <!-- IMP: If you want to use bootstrap-wizard put it after loader -->
        <script src='<c:url value="/resources/javascripts/bootstrap-wizard.js"/>' type="text/javascript"></script>
        <!-- IMP: Do not add  bootstrap.js , as loader.js is doing your job -->
        <!-- <script src='<c:url value="/resources/javascripts/bootstrap.min.js"/>' type="text/javascript"></script> -->
        <script src='<c:url value="/resources/javascripts/bootstrap-datepicker.js"/>' type="text/javascript"></script>
         <script src='<c:url value="/resources/javascripts/grid.locale-en.js"/>' type="text/javascript"></script>
         <script src='<c:url value="/resources/javascripts/jquery.jqGrid.min.js"/>' type="text/javascript"></script>
         <script src='<c:url value="/resources/javascripts/jquery.validate.min.js"/>' type="text/javascript"></script>
    	 <script src='<c:url value="/resources/javascripts/jquery.pnotify.min.js"/>' type="text/javascript"></script>
    	 <script type="text/javascript" src='<c:url value="/resources/javascripts/jit.js"/>'></script>
    	 <script type="text/javascript" src='<c:url value="/resources/javascripts/bootstrap-datetimepicker.min.js"/>'></script>
    	 <script type="text/javascript" src='<c:url value="/resources/javascripts/moment.js"/>'></script>
    	 <script type="text/javascript" src='<c:url value="/resources/javascripts/bootbox.min.js"/>'></script>
    </head>
    <body style="background-color: rgba(245, 245, 245, 0.71);box-shadow: 0 1px 30px #CCC;
border-radius: 36px;">
    	<div id="loading" style='position:fixed;
    							top:50%;
    							left:50%;
    							z-index:1;'>
    		<img alt="loading" src='<c:url value="/resources/images/loading.gif"/>'>
    	</div>
    
    	<tiles:insertAttribute name="header" />
		
		<div class="container" style="box-shadow: 0 5px 118px #CCC;">
			<tiles:insertAttribute name="content" />
		</div>
		
		<%-- <tiles:insertAttribute name="footer" /> --%>
    </body>
    <script src='<c:url value="/resources/javascripts/bootstrap-dropdown.js"/>' type="text/javascript"></script>
    <script type="text/javascript">
    	$("#loading").hide();
    	$(document).bind("ajaxSend", function(){
    	   		$("#loading").show();
    	 }).bind("ajaxComplete", function(){
    	   		$("#loading").hide();
    	 });
    	$(document).ready(function(){
    	if(localStorage.getItem("notification_mesg")){
	    	$.pnotify({
		        title: '',
		        text: localStorage.getItem("notification_mesg")
		    });
    	}
    	});
    </script>     
</html>

<style>
.cpnotify{
	position: fixed;
	top: 50% !important;
	left: 50% !important;
	z-index:1060;
 }

</style>



