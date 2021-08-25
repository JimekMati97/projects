@extends('include.app')
@section('content')
<!--ContainerDishes-->
<div class="containerDishes d-lg-flex">   
<div class="col-12 col-md-8 m-auto">
    @foreach ($dishes as $dish)
    <!--Pojedyncze danie z danej grupy-->
        <div class="single-dish col-12">

            <h1 class="h1"><b>{{$dish->name}}</b></h1>
            

            <p class="text text-justify">{{$dish->describtion}}</p>

            <small>Składniki: {{$dish->ingredients}}</small>

            <div class="d-flex col-12 justify-content-between mt-4">

                <a class="text-decoration-none single_dish_btn rounded-pill p-3 d-flex" href="{{route('dish',[$dish_group,$dish])}}">Zamów</a>
                <p class="text d-flex align-self-center"><b>{{$dish->price}} zł</b></p>

            </div>
            <hr>
        </div>
        
    <!--Pojedyncze danie z danej grupy-->

    @endforeach
        
</div>

 <!--dokonane zamówienie-->
    
 @if (!$orders->isEmpty())
 <!--orders-->
 <div class=" orders col-12 col-lg-4 d-flex justify-content-center">
    <div class="fixed">
     <div class="title mb-4 col-12 d-flex justify-content-center">
         <h1 class="h1"><b>Zamówienia</b></h1>
     </div>
     
     @foreach ($orders as $order)
         <!--order-->
         <div class="ordered col-12 d-flex justify-content-between">
             <div class="ordered_dish col-6">
                 <p class="text">{{$order->dish}}</p>
             </div>
             <div class="price col-4">
                 <p class="text">{{$order->price}}<span> zł</span></p>
             </div>
             <form class="col-2" action="{{route('burger_type_delete',$order)}}" method="post">
                 @csrf
                 @method('DELETE')
                 <button class="btn btn-danger btn-lg" type="submit">Usuń</button>
             </form>
         </div>
         
          <!--order-->
          <hr>
     @endforeach  
         <div class="suma col-12 justify-content-start">

            <p class="text">Suma: {{$totalSum}}<span> zł</span></p>
         </div>
     <!--finalizacja zamówienia-->
     <a class="w-50 m-auto confirm_btn text-decoration-none text-white d-flex justify-content-center btn btn-success" href="{{route('potwierdzenie')}}">Zatwierdź i zapłać</a>
     <!--finalizacja zamówienia-->
    </div>
 </div>
 <!--orders-->
 @else
 {{''}}
 @endif
 
 <!--dokonane zamówienie-->

</div>
<!--ContainerDishes-->
@endsection