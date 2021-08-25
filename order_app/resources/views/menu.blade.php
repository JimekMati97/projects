@extends('include.app')
@section('content')

<div class="containerMenu">

    <!--menu-->
    <ul class="menu-list col-12 d-flex justify-content-center">
        
        @foreach ($dish_groups as $dish_group)

        <!--pojdedyncza karta grupy dania-->
        <div class="card mr-2" style="width: 18rem;">

            <img class="card-img-top h-75" src="{{asset('images/'.$dish_group->img)}}" alt="Card image cap">

            <div class="card-body">

              <h5 class="card-title d-flex justify-content-center align-items-center"><a href="{{route('dish_group',$dish_group)}}">
                <a href="{{route('dish_group',$dish_group)}}" class="dish_group_btn w-100 text-decoration-none rounded-pill px-4 py-3
                 text-white d-flex justify-content-center">{{$dish_group->name}}</a>
              </h5>
              
            </div>

        </div>
        <!--pojedyncza karta grupy dania-->
        @endforeach
        
    </ul>
    <!--menu-->

<!--dokonane zamówienia-->
<div class="container">   

        @if (!$orders->isEmpty())

        <!--orders-->
        <div class="orders col-12 d-flex flex-column align-items-center">

            <div class="title mb-4 col-12 d-flex justify-content-center">
                <h1 class="h1">Zamówienia</h1>
            </div>
        

            @foreach ($orders as $order)

                <!--zamówienie-->
                <div class="ordered col-12 d-flex justify-content-between">

                    <div class="ordered_dish col-7 mr-3">
                        <p class="text pl-3">{{$order->dish}}</p>
                    </div>

                    <div class="price col-3 mr-3">
                        <p class="text d-flex justify-content-center">{{$order->price}}<span> zł</span></p>
                    </div>

                    <form class="col-2 d-flex justify-content-end" action="{{route('burger_type_delete',$order)}}" method="post">
                        @csrf
                        @method('DELETE')
                        <button class="btn btn-danger" type="submit">Usuń</button>
                    </form>
                
                </div>
                <hr class="w-100">
                <!--zamówienie-->
                
            @endforeach  
            <!--całość do zapłaty-->
            <div class="suma col-12 justify-content-start">

                <p class="text">Suma: {{$totalSum}}<span> zł</span></p>

            </div>
            <!--całość do zapłaty-->

            <!--finalizacja zamówienia-->
            <a class="text-decoration-none rounded-pill p-3 d-flex justify-content-center btn btn-success btn-lg" href="{{route('potwierdzenie')}}">Zatwierdź i zapłać</a>
            <!--finalizacja zamówienia-->

        </div>
        <!--orders-->

        <!--ContainerDish-->
        @else
        {{''}}
        @endif
        
    </div>
</div>
<!--dokonane zamówienie-->
@endsection