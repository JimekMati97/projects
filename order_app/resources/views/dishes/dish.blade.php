@extends('include.app')
@section('content')
<!--ContainerDish-->
<div class="container containerDish justify-content-center">
    <!--Card-->
    <div class="one_card col-12">

        <div class="col-12 d-flex justify-content-end">
            <div class="name col-11"><p>{{$dish->name}}</p> </div>
            <div class="cena">{{$dish->price}}</div>
            <div class="curency">zł</div>
        </div>
        <hr>
        <h2 class="h2">Dodatki:</h2>
        <form action="{{route('store',$dish)}}" method="post">
            @csrf
            <!--Extra Food checboxes--> 
            <div class="extra_food_checkboxes d-flex flex-column">

                @forelse ($dish->extra_food as $each_extra_food)
                <!--extra_food_checbox-->
                    <div class="extra_food_checkbox">   
                        <label class="ml-2" for="{{$each_extra_food->name}}">{{$each_extra_food->name}}</label>
                        <input type="checkbox" class="dodatki" name="dodatek[]" 
                        id="{{$each_extra_food->name}}" value="[{{$each_extra_food->price}},{{$each_extra_food->name}}]" {{(is_array(old('dodatek')) && in_array($each_extra_food->price, 
                        old('dodatek'))) ? 'checked' :''}}>
                        @empty
                        {{''}}
                    </div> 
                <!--extra_food_checbox-->
                @endforelse
            </div>
            <!--Extra Food checboxes--> 
            <hr>
           
            @if (!session()->has('filled_data'))
             <!--adres,nr. telefonu-->
            <div class="contact_details mb-5 col-12 col-sm-10 col-md-8 col-lg-6 col-xl-4 p-0">
                <label for="address">Adres</label><input id="address" class="form-control" type="text" name="address" placeholder="Tarnowskie Góry, Bytomska, 7">
                <label for="phone">Nr. telefonu</label><input id="phone" class="form-control" type="text" name="phone" placeholder="642 444 232">

                <!--Errors-->
                @foreach ($errors->all() as $error)
                    <div class="alert alert-danger mt-5 mb-3">{{$error}}</div> 
                @endforeach
                <!--Errors-->
            </div>
            <!--adres,nr. telefonu-->
            @endif




            <!--wybieranie liczby dań-->
            <div class="confirm col-12 d-flex justify-content-between align-items-center">

                <div class="quantity d-flex">
                    <div class="minus"><button id="minus_btn" type="button">-</button></div>
                    <div class="count d-flex justify-content-center align-items-center">
                        <input class="pl-3" id="quantity" name="quantity" type="text" value="1">
                    </div>
                    <div class="plus"><button id="plus_btn" type="button">+</button></div>
                </div>
                
                <button type="submit" class="confirm_dish_btn rounded-pill p-3 btn btn-success btn-lg">Zatwierdź</button>

            </div> 
            <!--wybieranie liczby dań-->  
        </form>
    </div>
    <!--Card-->

    <!--dokonane zamówienie-->
        
    @if (!$orders->isEmpty())
    <div class="container">
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
        <a class="confirm_btn text-decoration-none rounded-pill p-3 text-white d-flex justify-content-center btn btn-success btn-lg" href="{{route('potwierdzenie')}}">Zatwierdź i zapłać</a>
        <!--finalizacja zamówienia-->

    </div>
    <!--orders-->

    <!--ContainerDish-->
    @else
    {{''}}
    @endif
    </div>
    <!--container-->
</div>
<!--containerDish-->

@endsection