@extends('layouts.app')
@section('content')
    <!--containerRzeczowniki-->
    <div class="container-fluid containerRzeczowniki">
        <!--dodajRzeczownik-->
        <div class="dodajRzeczownik container col-12 d-flex flex-column justify-content-center">
            <!--Errors-->
            <div class="row errors col-6 ml-5 d-flex align-items-center m-auto">
                @if ($errors->any())
                    
                        @foreach ($errors->all() as $error)
                            <div class="alert alert-danger m-2">{{$error}}</div>
                        @endforeach
                    
                @endif
            </div>
            <!--Errors-->
            <form class="d-flex flex-row col-12 justify-content-center align-items-center flex-column mt-4" action="/rzeczowniki" method="POST">
                @csrf
                <div class="inputs col-4 d-flex justify-content-center flex-column m-0">
                    <input type="text" class="input-control rzeczwonikInput inputDoWpisywaniaLiter" value="" placeholder="Wpisz rzeczownik" name="rzeczownik">
                    <input type="text" class="input-control rzeczownikInput mt-3" placeholder="Wpisz tlumaczenie (pl)" value="" name="tlumaczenie">
                </div>

                <button class="btn btn-primary col-3 mt-5" type="submit">Dodaj</button>
            </form>

            <!--Klawiatura-->
            <div class="klawiatura d-flex justify-content-center">
                <!--Litery-->
                <div class="litery d-flex justify-content-center mt-5">
                    <!--Litera-->
                    <div class="litera d-flex justify-content-center align-items-center"><button type="button" class="d-flex justify-content-center align-items-center">á</button></div>
                    <!--Litera-->
                    <div class="litera d-flex justify-content-center align-items-center"><button type="button" class="d-flex justify-content-center align-items-center">é</button></div>
                    <div class="litera d-flex justify-content-center align-items-center"><button type="button" class="d-flex justify-content-center align-items-center">í</button></div>
                    <div class="litera d-flex justify-content-center align-items-center"><button type="button" class="d-flex justify-content-center align-items-center">ó</button></div>
                    <div class="litera d-flex justify-content-center align-items-center"><button type="button" class="d-flex justify-content-center align-items-center">ú</button></div>
                    <div class="litera d-flex justify-content-center align-items-center"><button type="button" class="d-flex justify-content-center align-items-center">ü</button></div>
                    <div class="litera d-flex justify-content-center align-items-center"><button type="button" class="d-flex justify-content-center align-items-center">ñ</button></div>

                </div>
                <!--Litery-->
            </div>
            <!--Klawiatura-->

        </div>
        <!--dodajRzeczownik-->

        <!--Czasowniki z bazy danych-->
        <div class="row tabelaCzaswoniki d-flex justify-content-center mt-5">
            <div class="table">

                <div class="table_row d-flex flex-wrap">
                    @foreach ($rzeczowniki as $rzeczownik)
                        <a href="/rzeczowniki/{{$rzeczownik->id}}" class="cell col-1 justify-content-center align-items-center d-flex">{{$rzeczownik->rzeczownik}}</a>
                    @endforeach 

                </div>
            </div>
        </div>
        <!--Czasowniki z bazy danych-->
    </div>
    <!--containerRzeczowniki-->
</div> 
<!--container-fluid-->
@endsection
