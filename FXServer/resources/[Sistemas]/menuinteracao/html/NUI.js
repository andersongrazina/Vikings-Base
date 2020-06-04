$(document).ready(function(){
	
	moment.locale('pt-BR');

   window.addEventListener('message', function(event) {
		if (event.data.action == 'open') {
			$('.circular-menu-container').css('display','block');
		} else if (event.data.action == 'close') {
			$('.circular-menu-container').css('display','none');
		}
	
	  $(document).keyup(function(e) {
		if ( e.keyCode == 27 ) {
		   window.location.href = 'NUI.html';
		  $('#pagina').css('display','none');
		  $.post('http://menuinteracao/escape', JSON.stringify({}));
		}
	  });
  });
  
	$("#emprego").click(function(){
			$.post('http://menuinteracao/EMPREGO', JSON.stringify({}));
	});
	
	$("#banco").click(function(){
			$.post('http://menuinteracao/BANCO', JSON.stringify({}));
	});
});
