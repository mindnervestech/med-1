<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="menuContext.jsp" />
<h4>
	<b style="width: 1051px; margin-left: 20px;"><i>Manage Tasks</i></b>
</h4>
<c:set var="_searchContext" value="${context}" scope="request" />
<c:set var="_parentSearchCtx" value="${null}" scope="request" />
<c:set var="mode" value="add" scope="request" />
<jsp:include page="searchContext.jsp" />

<script type="text/javascript">
 $(document).ready(function(){
	 $("#Taskeffort").click(function(){
			 var startdt = $("#startDate input").val();
			 var enddt = $("#endDate input").val();
			 
			 var bits1=startdt.split('-');
		     var date1 = new Date(bits1[2],bits1[1],bits1[0],0,0,0,0);
		     
   			 var bits2=enddt.split('-');
			 var date2 = new Date(bits2[2],bits2[1],bits2[0],0,0,0,0);
			 
			 if(date1.getTime() > date2.getTime())
				{
					  
				 $.pnotify({
				        title: 'Alert!',
				        addclass: 'cpnotify',
				        delay:2500,
				        text: "Invalid Date Selection"
				    });
				} 
	 });
	 
	 $("#s2id_Taskproject").after("<a style='margin-left: 2%;' href='routes.Projects.index.url'>New Project</a>");
 });
 function Taskedit_onCardReady(_wizard){
	 if((_wizard).index==0){
		 $("#Taskediteffort").click(function(){
			 var startdt = $("#TaskeditstartDate input").val();
			 var enddt = $("#TaskeditendDate input").val();
			 
			 var bits1=startdt.split('-');
		     var date1 = new Date(bits1[2],bits1[1],bits1[0],0,0,0,0);
		     
   			 var bits2=enddt.split('-');
			 var date2 = new Date(bits2[2],bits2[1],bits2[0],0,0,0,0);
			 
			 if(date1.getTime() > date2.getTime())
				{
					  
				 $.pnotify({
				        title: 'Alert!',
				        addclass: 'cpnotify',
				        delay:2500,
				        text: "Invalid Date Selection"
				    });
				} 
	 
	 
	 });
	 }
	 
 }
 
 function Taskadd_onCardReady(_wizard){
	 if((_wizard).index==1){
		 Taskadd_SearchGrid.resizeGrid();  
	 }
 }
 

 
 
 function Taskedit_onCardReady(_wizard){
	 
	 if((_wizard).index==1){
		 Taskadd_SearchGrid.resizeGrid();  
	 } 
 }	 
 </script>