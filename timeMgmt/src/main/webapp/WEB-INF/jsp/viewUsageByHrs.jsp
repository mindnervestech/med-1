<link rel="stylesheet"  href='<c:url value="resources/stylesheets/BarChart.css"/>' />
<link rel="stylesheet"  href='<c:url value="resources/stylesheets/base.css"/>' />
<link rel="stylesheet"  type="text/css" media="all" href='<c:url value="resources/stylesheets/jquery.pnotify.default.css"/>' />
<script type="text/javascript" src='<c:url value="resources/javascripts/jit.js"/>'></script>
<style>
	#custom-modal-container{
		width: 900px !important;
		left: 38% !important;
		max-height: 600px !important;
		top: 8% !important;
	}

	.formClass{
		padding: 0 30px 40px;
	}
	
	.modal-body{
		max-height: none !important;
	}
	
	.modal-footer{
		padding: 15px 15px 5px !important;
		text-align: left;
		background-color: none !important;
		margin-top: 15px;
	}
	
	table{
		width: 100%;
		text-align: center;
		margin-top: 15px;
	}
	
	table tr th{
		padding: 5px 0 5px;
		border-bottom: 1px solid #333;
	}
	
	table tr td{
		padding: 5px 0;
		border-bottom: 1px solid #d5d5d5;
		border-left: 1px solid #d5d5d5;
		border-right: 1px solid #d5d5d5;
	}
	
	.modal-header .close{
		margin-right: -25px;
	}
	
</style>

<div class="formClass">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal">&times;</button>
		<h4>Graphical Project Details</h4>
	</div>

	<div class="modal-body">	
		<div id="container">
			<div id="left-container">
				<h4>Graph by HRS Spent</h4>
				<div style="display: none;">
					<ul id="id-list" ></ul>
					<a id="update" href="#" class="theme button white">Update Data</a>
				</div>
			</div>
	
			<div id="center-container">
				<div id="infovis"></div>
			</div>
			
			<div id="right-container" style="display: none;">
				<div id="inner-details"></div>
			</div>
			<div id="log"></div>
		</div>
		
		<div id="container2">
			<div id="left-container2" >
				<h4>Graph by Money Spent</h4>
				<div style="display: none;">
					<ul id="id-list2"></ul>
					<a style="display: none;" id="update2" href="#" class="theme button white">Update Data</a>
				</div>	
			</div>
	
			<div id="center-container2">
				<div id="infovis2"></div>
			</div>
			
			<div id="right-container2" style="display: none;">
				<div id="inner-details2"></div>
			</div>
			<div id="log2"></div>
		</div>
	</div>
</div>		
	<script type="text/javascript">
		$(document).ready(function(){
			ProjectsaddviewGraph_onReady();			
		});	
	
		function ProjectsaddviewGraph_onReady(){
			setTimeout(function(){
				$.ajax({
					type: "GET",
					dataType: "json",
					url:"${pageContext.request.contextPath}/projViewGraphHrs",
					data:{id:${proID}},
					success: function(data){
						$("#infovis").empty();
						$("#infovis2").empty();
						init(data[0]);
						init2(data[1]);
					}
				}); 
			},100);
		}
		
		function init(data) {
			var labelType, useGradients, nativeTextSupport, animate;
			(function() {
				var ua = navigator.userAgent, iStuff = ua.match(/iPhone/i)
						|| ua.match(/iPad/i), typeOfCanvas = typeof HTMLCanvasElement, nativeCanvasSupport = (typeOfCanvas == 'object' || typeOfCanvas == 'function'), textSupport = nativeCanvasSupport
						&& (typeof document.createElement('canvas')
								.getContext('2d').fillText == 'function');
				//I'm setting this based on the fact that ExCanvas provides text support for IE
				//and that as of today iPhone/iPad current text support is lame
				labelType = (!nativeCanvasSupport || (textSupport && !iStuff)) ? 'Native'
						: 'HTML';
				nativeTextSupport = labelType == 'Native';
				useGradients = true;
				animate = !(iStuff || !nativeCanvasSupport);
			})();
			
			var Log = {
				elem : false,
				write : function(text) {
					if (!this.elem)
						this.elem = document.getElementById('log');
					this.elem.innerHTML = text;
					this.elem.style.left = (500 - this.elem.offsetWidth / 2) + 'px';
				}
			};
			//init data
			var json = data;
			console.log(json);
			//init BarChart
			var barChart = null;
			barChart = new $jit.BarChart({
				//id of the visualization container
				injectInto : 'infovis',
				//whether to add animations
				animate : true,
				//horizontal or vertical barcharts
				orientation : 'vertical',
				//bars separation
				barsOffset : 20,
				//visualization offset
				Margin : {
					top : 5,
					left : 5,
					right : 5,
					bottom : 5
				},
				//labels offset position
				labelOffset : 5,
				//bars style
				type : useGradients ? 'stacked:gradient' : 'stacked',
				//whether to show the aggregation of the values
				showAggregates : true,
				//whether to show the labels for the bars
				showLabels : true,
				//labels style
				Label : {
					type : labelType, //Native or HTML
					size : 13,
					family : 'Arial',
					color : 'white'
				},
				//add tooltips
				Tips : {
					enable : true,
					onShow : function(tip, elem) {
						tip.innerHTML = "<b>" + elem.name + "</b>: " + elem.value;
					}
				}
			});
			//load JSON data.
			barChart.loadJSON(json);
			//end
			var list = null;
			list = $jit.id('id-list'), button = $jit.id('update'), orn = $jit
					.id('switch-orientation');
			
			//update json on click 'Update Data'
			$jit.util.addEvent(button, 'click', function() {
				var util = $jit.util;
				if (util.hasClass(button, 'gray'))
					return;
				util.removeClass(button, 'white');
				util.addClass(button, 'gray');
				barChart.updateJSON(json2);
			});
			//dynamically add legend to list
			var legend = barChart.getLegend(), listItems = [];
			for ( var name in legend) {
				listItems
						.push('<div class=\'query-color\' style=\'background-color:'
	          + legend[name] +'\'>&nbsp;</div>'
								+ name);
			}
			list.innerHTML = '<li>' + listItems.join('</li><li>') + '</li>';
		}
		
		function init2(data) {
			var labelType, useGradients, nativeTextSupport, animate;
	
			(function() {
				var ua = navigator.userAgent, iStuff = ua.match(/iPhone/i)
						|| ua.match(/iPad/i), typeOfCanvas = typeof HTMLCanvasElement, nativeCanvasSupport = (typeOfCanvas == 'object' || typeOfCanvas == 'function'), textSupport = nativeCanvasSupport
						&& (typeof document.createElement('canvas')
								.getContext('2d').fillText == 'function');
				//I'm setting this based on the fact that ExCanvas provides text support for IE
				//and that as of today iPhone/iPad current text support is lame
				labelType = (!nativeCanvasSupport || (textSupport && !iStuff)) ? 'Native'
						: 'HTML';
				nativeTextSupport = labelType == 'Native';
				useGradients = true;
				animate = !(iStuff || !nativeCanvasSupport);
			})();
	
			var Log = {
				elem : false,
				write : function(text) {
					if (!this.elem)
						this.elem = document.getElementById('log2');
					this.elem.innerHTML = text;
					this.elem.style.left = (500 - this.elem.offsetWidth / 2) + 'px';
				}
			};
	
			//init data
			var json = data;
			
			//init BarChart
			var barChart = new $jit.BarChart({
				//id of the visualization container
				injectInto : 'infovis2',
				//whether to add animations
				animate : true,
				//horizontal or vertical barcharts
				orientation : 'vertical',
				//bars separation
				barsOffset : 20,
				//visualization offset
				Margin : {
					top : 5,
					left : 5,
					right : 5,
					bottom : 5
				},
				//labels offset position
				labelOffset : 5,
				//bars style
				type : useGradients ? 'stacked:gradient' : 'stacked',
				//whether to show the aggregation of the values
				showAggregates : true,
				//whether to show the labels for the bars
				showLabels : true,
				//labels style
				Label : {
					type : labelType, //Native or HTML
					size : 13,
					family : 'Arial',
					color : 'white'
				},
				//add tooltips
				Tips : {
					enable : true,
					onShow : function(tip, elem) {
						tip.innerHTML = "<b>" + elem.name + "</b>: " + elem.value;
					}
				}
			});
			//load JSON data.
			barChart.loadJSON(json);
			//end
			var list = $jit.id('id-list2'), button = $jit.id('update2'), orn = $jit
					.id('switch-orientation');
			//update json on click 'Update Data'
			$jit.util.addEvent(button, 'click', function() {
				var util = $jit.util;
				if (util.hasClass(button, 'gray'))
					return;
				util.removeClass(button, 'white');
				util.addClass(button, 'gray');
				barChart.updateJSON(json2);
			});
			//dynamically add legend to list
			var legend = barChart.getLegend(), listItems = [];
			for ( var name in legend) {
				listItems
						.push('<div class=\'query-color\' style=\'background-color:'
	          + legend[name] +'\'>&nbsp;</div>'
								+ name);
			}
			list.innerHTML = '<li>' + listItems.join('</li><li>') + '</li>';
		}
		
	</script>