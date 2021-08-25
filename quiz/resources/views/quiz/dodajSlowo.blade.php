@extends('layouts.app')
@section('content')

    <!--containerBrakSlow-->
    <div class="container m-0 containerBrakSlow d-flex flex-row col-12">
        
        <!--Row lewy-->
        <div class="row col-12 d-flex justify-content-start mt-3 align-items-start flex-column">

            <h2 class="text d-flex text-white">W bazie danych nie znaleziono żadnych słów do tłumaczenia.</h2>
            <!--Buttons-->
                <div class="buttons mt-4">
                    <a href="{{'czasowniki'}}"class="btn btn-secondary">Dodaj Czasownik</a>
                    <a href="{{'rzeczowniki'}}" class="btn btn-dark">Dodaj rzeczownik</a>
                </div>
            <!--Buttons-->
        </div>
        <!--Row lewy-->
    </div>
    <!--containerBrakSlow-->
</div>  
<!--container-fluid-->
@endsection
