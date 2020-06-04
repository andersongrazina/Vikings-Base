$(document).ready(function(){
	
	moment.locale('pt-BR');

   window.addEventListener('message', function(event) {
		if (event.data.action == 'open') {
			$('.jumbotron').css('display','block');
		} else if (event.data.action == 'close') {
			$('.jumbotron').css('display','none');
		}
	
	  $(document).keyup(function(e) {
		if ( e.keyCode == 27 ) {
		   window.location.href = 'NUI.html';
		  $('#pagina').css('display','none');
		  $.post('http://comandohelp/escape', JSON.stringify({}));
		}
	  });
  });
});
