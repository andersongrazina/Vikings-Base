$(document).ready(function(){
		
		moment.locale('pt-BR');
		
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
			$.post('http://esx_caminhoneirojob/escape', JSON.stringify({}));
		});
	
	$("#leite-carga").click(function(){
			$.post('http://esx_caminhoneirojob/LEITE', JSON.stringify({}));
	});
	
	$("#carne-carga").click(function(){
			$.post('http://esx_caminhoneirojob/CARNE', JSON.stringify({}));
	});
	
	$("#petroleo-carga").click(function(){
			$.post('http://esx_caminhoneirojob/PETROLEO', JSON.stringify({}));
	});
	
	$("#vinho-carga").click(function(){
			$.post('http://esx_caminhoneirojob/VINHO', JSON.stringify({}));
	});
	
	$("#quimicos-carga").click(function(){
			$.post('http://esx_caminhoneirojob/QUIMICOS', JSON.stringify({}));
	});
	
	$("#carros-carga").click(function(){
			$.post('http://esx_caminhoneirojob/CARROS', JSON.stringify({}));
	});
	
	$("#roupas-carga").click(function(){
			$.post('http://esx_caminhoneirojob/ROUPAS', JSON.stringify({}));
	});
	
	$("#madeira-carga").click(function(){
			$.post('http://esx_caminhoneirojob/MADEIRA', JSON.stringify({}));
	});
	
	$("#tanque-carga").click(function(){
			$.post('http://esx_caminhoneirojob/MILITAR', JSON.stringify({}));
	});
	
	$("#frango-carga").click(function(){
			$.post('http://esx_caminhoneirojob/FRANGO', JSON.stringify({}));
	});
	
	$("#cameras-carga").click(function(){
			$.post('http://esx_caminhoneirojob/CAMERAS', JSON.stringify({}));
	});
	
	$("#documentos-carga").click(function(){
			$.post('http://esx_caminhoneirojob/DOCUMENTOS', JSON.stringify({}));
	});
	
	
	$(document).keyup(function(e) {
     if ( e.keyCode == 27 ) {
       window.location.href = 'NUI.html';
      $('#pagina').css('display','none');
      $.post('http://esx_caminhoneirojob/escape', JSON.stringify({}));
    }
  });
});
