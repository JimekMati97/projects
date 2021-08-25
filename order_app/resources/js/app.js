require('./bootstrap');
$(function() {


const doc=document.querySelector('.make_order');
//sprawdzanie czy na stronie znajduje się przycisk złóż zamówienie
if(doc){

    //przeładowywanie strony home, w celu zmiany user_id
    CheackingSeassion()
    function CheackingSeassion() {
        const xmlhttp = new XMLHttpRequest();
        xmlhttp.onload = function() {
            const docc = this.responseXML;
        }
        xmlhttp.open("GET", "home");
        xmlhttp.send();
    }
}

//dostępne dodatki dla wszystkich dań
const extra_food=['pikle','czerwona cebula','ser cheddar','sałata lodowa','podwójna warstwa mięsa',
'ser pleśniowy','jalapeno','awokado','guacamole','ostryga morska','kawior','sos pomidorowy ostry',
'podwójny ser','ogórek konserwowy','oliwki czarne','oliwki zielone','pieczarki'];
//cena bazowa dania
const $cena=$('.cena').text();
//pole ceny
const $field_cena=$('.cena');
//przyciski zwiększania i zmniejszania liczby produktu
document.getElementById('plus_btn').addEventListener('click',increaseQuantity);
document.getElementById('minus_btn').addEventListener('click',reduceQuantity);

//ustawienia domyślne liczby i sumy
localStorage.setItem('liczba',1);
localStorage.setItem("suma",$cena)
//$field_cena.text(parseInt(localStorage.getItem('cena')));
//only one chebox checked
// $("input:checkbox").on('click', function() {
//     var $box = $(this);
//     if ($box.is(":checked")) { 
//       var group = "input:checkbox[name='" + $box.attr("name") + "']";
//       $(group).prop("checked", false);    
//       $box.prop("checked", true);    
//     } else {
//       $box.prop("checked", false);  
//     }
// });

//creating click event

$('.dodatki').each(function(){
   
    $(this).on('click',function(){
       
        updateQuantity($(this));
    })
})

//update sumy do zapłaty
function updateQuantity(element){
 
    var value=getExtraFoodPrice(element);
    
    const element_id=element.attr('id');
    
    //jeżeli checbox jest zaznaczony
    if(element.is(':checked')){
        
        //ustawienie ceny bazowej produktu
        localStorage.setItem("cena_bazowa",$cena)
        //ustawienie dodatku do dania jako item, nadanie mu jako wartość jego cenę    
        localStorage.setItem(element_id,value);
        //sprawdzanie jakie dodatki są zanznaczone
        settedItems=checksetItems();
        //ustawianie ceny bazowej jako sumę początkową
        var suma=parseFloat(localStorage.getItem("cena_bazowa"))
        for (let index = 0; index < settedItems.length; index++) {
            
            const element = settedItems[index];
            //powiekszenie ceny bazowej o dodatki
            suma+=parseFloat(localStorage.getItem(element))
            localStorage.setItem("suma",suma)
            //kwota jest wielokrotnością sumy wybranego produktu
            localStorage.setItem("kwota",suma*parseInt(localStorage.getItem('liczba')));
            //update pola sumy
            $field_cena.text(parseFloat(localStorage.getItem('kwota')));

        }
    }
    //jeżeli checkbox został odznaczony
    else{
        //zredukowanie sumy o cenę odhaczonego cheboxa    
        let suma=parseFloat(localStorage.getItem("suma"))-parseFloat(localStorage.getItem(element_id));
        localStorage.removeItem(element_id);
        //update item'u suma
        localStorage.setItem("suma",suma)
        //kwota jest wielokrotnością sumy wybranego produktu
        localStorage.setItem("kwota",suma*parseInt(localStorage.getItem('liczba')));
        //update pola sumy
        $field_cena.text(parseFloat(localStorage.getItem('kwota')));
        
    }
}

//sprawdzanie ile jest ustawionych item'ów w localstorage
function checksetItems(){
    var setted=[];
    
    extra_food.forEach(element => {
        if(localStorage.getItem(element)){
            setted.push(element)
        }
    });

    return setted;
}




    //zmniejszanie liczby produktu
    function reduceQuantity(){
        if(localStorage.getItem('liczba')>1){
            
            quantity=parseInt(localStorage.getItem('liczba'))-1;

            localStorage.setItem('liczba',quantity);
            localStorage.setItem("kwota",(localStorage.getItem('suma'))*quantity);
            document.getElementById('quantity').value=quantity
            $field_cena.text(parseFloat(localStorage.getItem('kwota')));

        }
    } 
    //zwiększanie liczby produktu
    function increaseQuantity(){
                //ustawienie item - 'suma', który równa sie bazowej cenie dania
        
        quantity=parseInt(localStorage.getItem('liczba'))+1;   
        localStorage.setItem('liczba',quantity);
        localStorage.setItem("kwota",localStorage.getItem('suma')*quantity);
        document.getElementById('quantity').value=quantity  
        $field_cena.text(parseFloat(localStorage.getItem('kwota')));
    }
});

//pobranie cen dodatków do jedzenia
function getExtraFoodPrice(element){
    var elemnt_value=element.attr('value');
    var position=elemnt_value.indexOf(',');
    var extra_food_prices=elemnt_value.substr(1,position-1)

    return extra_food_prices;
}

window.onload=function(){
    
    localStorage.clear()
}

//ustawianie liczby sztuk zamówionego produktu









