$(document).ready(function(){

   window.addEventListener('message', function(event) {
		  if (event.data.action == 'open') {
			$('.circular-menu-container').css('display','block');
		} else if (event.data.action == 'close') {
			$('.circular-menu-container').css('display','none');
		}
		
		$("#inventario").click(function(){
			$.post('http://2KN_UI/INVENTARIO', JSON.stringify({}));
		});
	
	  $(document).keyup(function(e) {
		if ( e.keyCode == 27 ) {
		   window.location.href = 'NUI.html';
		  $('.circular-menu-container').css('display','none');
		  $.post('http://2KN_UI/escape', JSON.stringify({}));
		}
	  });
  });
});
