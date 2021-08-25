require('./bootstrap');


  $(function(){
      //input focus
      $('input').focus();

      //wybór litery
      const input=document.querySelector('.inputDoWpisywaniaLiter')
      
      $('.litera').on('click',function(event){

        //wartość wpisana do inputa
        const wpisaneLitery=document.querySelector('.inputDoWpisywaniaLiter').value;

        const litera=event.target.innerText;
        wprowadzLitere(litera,wpisaneLitery);
        
      });

      function wprowadzLitere(litera,wpisaneLitery){
        console.log(wpisaneLitery);
        input.value=wpisaneLitery+litera;
      }

  })