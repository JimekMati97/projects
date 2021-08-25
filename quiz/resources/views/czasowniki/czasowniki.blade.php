@extends('layouts.app')
@section('content')
    <!--containerCzasowniki-->
    <div class="container-fluid containerCzasowniki">

        <!--dodajCzasownik-->
        <div class="dodajCzasownik container col-12 d-flex flex-column justify-content-center">

            <!--Errors-->
            <div class="row errors col-6 ml-5 d-flex align-items-center m-auto">
                @if ($errors->any())
                    
                        @foreach ($errors->all() as $error)
                            <div class="alert alert-danger m-2 d-flex justify-content-center">{{$error}}</div>
                        @endforeach
                    
                @endif
            </div>
            <!--Errors-->

            <form class="d-flex flex-row col-12 justify-content-center mt-4" action="/czasowniki" method="POST">
                @csrf
                <!--inputs-->
                <div class="row inputs col-6 d-flex justify-content-center flex-column">
                    <!--Row inside Input-->
                    <div class="row col-8 d-flex justify-content-center align-self-center">

                        <input type="text" class="input-control czasownikInput inputDoWpisywaniaLiter" placeholder="Wpisz czasownik" name="czasownik">
                        <input type="text" class="input-control czasownikInput mt-3" placeholder="Wpisz tlumaczenie (pl)" name="tlumaczenie">

                        <!--Button-->
                        <div class="button d-flex justify-content-center">
                            <button class="btn btn-primary mt-5 col-4" type="submit">Dodaj</button>
                        </div>
                        <!--Button-->

                    </div>
                    <!--Row inside Input-->
                </div>
                <!--inputs-->

                <!--Brak wyjątku-->
                <div class="radios row col-6">

                     <!--Napis-->
                    <div class="row"> 
                        <h3>Wymiana liter</h3>
                    </div>  
                    <!--Napis-->

                    <!--Options-->
                    <div class="row d-flex options">

                        <div class="form-check m-2">
                            <input class="form-check-input" type="radio" name="option[]" value="Brak" id="flexCheckDefault" checked>
                            <label class="form-check-label" for="flexCheckDefault">
                            Brak
                            </label>
                        </div>
                        <!--E-EI-->
                        {{-- <div class="form-check m-2">
                            <input class="form-check-input" type="radio" name="option[]" value="E->IE" id="checkEEI">
                            <label class="form-check-label" for="checkEEI">
                            E->IE
                            </label>
                        </div>
    
                        <!--E->I-->
                        <div class="form-check m-2">
                            <input class="form-check-input" type="radio" name="option[]" value="E->I" id="checkEI" >
                            <label class="form-check-label" for="checkEI">
                                E->I
                            </label>
                        </div>
                        <!--O->UE-->
                        <div class="form-check m-2">
                            <input class="form-check-input" type="radio" name="option[]" value="O->UE" id="checkOUE">
                            <label class="form-check-label" for="checkOUE">
                                O->UE
                            </label>
                        </div>
    
                        <!--1 os.-->
                        <div class="form-check m-2">
                            <input class="form-check-input" type="radio" name="option[]" value="ItoY" id="check1os">
                            <label class="form-check-label" for="check1os">
                                I->Y
                            </label>
                        </div> --}}
                    </div>
                    <!--Options-->

            </form>

        </div>
        <!--dodajCzasownik-->
        <div class="row">
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
        <!--Czasowniki z bazy danych-->
        <div class="row tabelaCzaswoniki d-flex justify-content-center mt-5">
            <div class="table">
                <div class="table_row d-flex flex-wrap">
                @foreach ($czasowniki as $czasownik)
                    <a href="/czasowniki/{{$czasownik->id}}" class="cell col-1 justify-content-center align-items-center d-flex">{{$czasownik->czasownik}}</a>
                @endforeach
            </div>
            </div>
        </div>
        <!--Czasowniki z bazy danych-->

    </div>
    <!--containerCzsowniki-->
</div>
<!--Container-fluid-->
@endsection
