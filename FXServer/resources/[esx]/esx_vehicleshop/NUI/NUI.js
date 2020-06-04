$(document).ready(function(){
		
		window.addEventListener('message', function(event) {
			if (event.data.action == 'open') {
				$('#pagina').css('display','block');
				$('body').css('background-color','grey');
				
			}
			else if (event.data.action == 'close') {
				$('#pagina').css('display','none');
				$('body').css('background-color','transparent');
			}
			});
		
		$("#closebtn").click(function(){
			$.post('http://esx_vehicleshop/closeButton', JSON.stringify({}));
		});
		
		$("#golf-car").click(function(){
			$.post('http://esx_vehicleshop/GOLF', JSON.stringify({}));
		});
		
		$("#fusca-car").click(function(){
			$.post('http://esx_vehicleshop/FUSCA', JSON.stringify({}));
		});
		
		$("#civic-car").click(function(){
			$.post('http://esx_vehicleshop/CIVICEK9', JSON.stringify({}));
		});
		
		$("#206-car").click(function(){
			$.post('http://esx_vehicleshop/206', JSON.stringify({}));
		});
		
		$("#up-car").click(function(){
			$.post('http://esx_vehicleshop/UP', JSON.stringify({}));
		});
		
		$("#punto-car").click(function(){
			$.post('http://esx_vehicleshop/PUNTO', JSON.stringify({}));
		});
		
		$("#crx-car").click(function(){
			$.post('http://esx_vehicleshop/CRX', JSON.stringify({}));
		});
		
		$("#ds3-car").click(function(){
			$.post('http://esx_vehicleshop/DS3', JSON.stringify({}));
		});
		
		$("#forte-car").click(function(){
			$.post('http://esx_vehicleshop/FORTE', JSON.stringify({}));
		});
		
		$("#civic99-car").click(function(){
			$.post('http://esx_vehicleshop/CIVIC99', JSON.stringify({}));
		});
		
		$("#logan-car").click(function(){
			$.post('http://esx_vehicleshop/LOGAN', JSON.stringify({}));
		});
		
		$("#gtr-car").click(function(){
			$.post('http://esx_vehicleshop/GTR', JSON.stringify({}));
		});
		
		$("#charger69-car").click(function(){
			$.post('http://esx_vehicleshop/CHARGER69', JSON.stringify({}));
		});
		
		$("#silverado-car").click(function(){
			$.post('http://esx_vehicleshop/SILVERADO', JSON.stringify({}));
		});
		
		$("#amarok-car").click(function(){
			$.post('http://esx_vehicleshop/AMAROK', JSON.stringify({}));
		});
		
		$("#s10-car").click(function(){
			$.post('http://esx_vehicleshop/S10', JSON.stringify({}));
		});
		
		$("#trailblazer-car").click(function(){
			$.post('http://esx_vehicleshop/TRAILBLAZER', JSON.stringify({}));
		});
		
		$("#faggio-car").click(function(){
			$.post('http://esx_vehicleshop/FAGGIO', JSON.stringify({}));
		});
		
		$("#pcj-car").click(function(){
			$.post('http://esx_vehicleshop/PCJ', JSON.stringify({}));
		});
		
		$("#akuma-car").click(function(){
			$.post('http://esx_vehicleshop/AKUMA', JSON.stringify({}));
		});
		
		$("#avarus-car").click(function(){
			$.post('http://esx_vehicleshop/AVARUS', JSON.stringify({}));
		});
		
		$("#hexer-car").click(function(){
			$.post('http://esx_vehicleshop/HEXER', JSON.stringify({}));
		});
		
		$("#wolfsbane-car").click(function(){
			$.post('http://esx_vehicleshop/WOLFSBANE', JSON.stringify({}));
		});
		
		$("#bati801-car").click(function(){
			$.post('http://esx_vehicleshop/BATI801', JSON.stringify({}));
		});
		
		$("#bmx-car").click(function(){
			$.post('http://esx_vehicleshop/BMX', JSON.stringify({}));
		});
		
		$("#cruiser-car").click(function(){
			$.post('http://esx_vehicleshop/CRUISER', JSON.stringify({}));
		});
		
		$("#fixter-car").click(function(){
			$.post('http://esx_vehicleshop/FIXTER', JSON.stringify({}));
		});
		
		$("#scorcher-car").click(function(){
			$.post('http://esx_vehicleshop/SCORCHER', JSON.stringify({}));
		});
		
		$("#tribike-car").click(function(){
			$.post('http://esx_vehicleshop/TRIBIKE', JSON.stringify({}));
		});
	
	$(document).keyup(function(e) {
     if ( e.keyCode == 27 ) {
       window.location.href = 'NUI.html';
      $('#pagina').css('display','none');
      $.post('http://esx_vehicleshop/escape', JSON.stringify({}));
    }
  });
});
