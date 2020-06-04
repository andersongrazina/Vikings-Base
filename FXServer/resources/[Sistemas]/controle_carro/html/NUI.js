$(document).ready(function(){

   window.addEventListener('message', function(event) {
		  if (event.data.action == 'open') {
			$('.uk-card').css('display','block');
		} else if (event.data.action == 'close') {
			$('.uk-card').css('display','none');
		}
		
		var elements = document.querySelectorAll("#driver, #seconddoor, #thirddoor, #fourthdoor, #trunk, #hood"), door;  

			  for (var i = 0; i < elements.length; i++) {
				elements[i].addEventListener("click", function() {
			   
				  switch(this.id) {
				case 'driver':
				  door = 0;
				  break;
				case 'trunk':
				  door = 5;
				  break;
				case 'hood': 
				  door = 4;
				  break;
				case 'thirddoor':
				  door = 2;
				  break;
				case 'seconddoor':
				  door = 3;
				  break;
				case 'fourthdoor':
				  door = 1;
			   }
			});

    elements[i].addEventListener("mouseover", function() {
        document.getElementById(this.id).setAttribute("src", './backend/img/arrow_active.png')
    })

    elements[i].addEventListener("mouseout", function() {
        document.getElementById(this.id).setAttribute("src", './backend/img/arrow.png')
    })
  }
		$("#trunk").click(function(){
			$.post('http://controle_carro/MALAS', JSON.stringify({}));
		});
		
		$("#hood").click(function(){
			$.post('http://controle_carro/CAPO', JSON.stringify({}));
		});
		
		$("#driver").click(function(){
			$.post('http://controle_carro/PILOTO', JSON.stringify({}));
		});
		
		$("#fourthdoor").click(function(){
			$.post('http://controle_carro/PASSAGEIRO', JSON.stringify({}));
		});
		
		$("#seconddoor").click(function(){
			$.post('http://controle_carro/P4', JSON.stringify({}));
		});
		
		$("#thirddoor").click(function(){
			$.post('http://controle_carro/P3', JSON.stringify({}));
		});
		
		$("#engine").click(function(){
			$.post('http://controle_carro/MOTOR', JSON.stringify({}));
		});
	
	  $(document).keyup(function(e) {
		if ( e.keyCode == 27 ) {
		   window.location.href = 'index.html';
		  $('.uk-card').css('display','none');
		  $.post('http://controle_carro/escape', JSON.stringify({}));
		}
	  });
  });
});
