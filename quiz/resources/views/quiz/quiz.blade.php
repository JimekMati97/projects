@extends('layouts.app')
@section('content')

<!--ContainerQuiz-->
<div class="container-fluid containerQuiz col-10">
    <!--Container Błędy-->
    <div class="container BledyQuiz col-10 errors ml-5 d-flex justify-content-center align-items-center" >
        <!--Errors-->
        @if ($errors->any())
        
                <?php $_SESSION['niezeruj']='niezeruj';?>
                @foreach ($errors->all() as $error)
                    <div class="alert alert-danger m-2 d-flex align-items-center">{{$error}}</div>
                @endforeach
            
        @endif
        <!--Errors-->
    </div>
    <!--Container Błędy-->


    <!--Container-->

    <div class="container d-flex flex-row col-12 justify-content-center">
        

        <!--Row-->
        <div class="row col-12 col-md-6">

            <div class="row top d-flex justify-content-end">

                <p class="text slowoDoPrzetlumaczenia d-flex justify-content-center">{{$slowa[0]}}</p>
                
            </div>
            <!--Wybrane słowo do przetłumaczenia-->

            <!--Panel-->
            <div class="panel d-flex justify-content-center flex-column">


                <!--Form-->
                <form class="d-flex justify-content-center flex-column m-auto" action="" method="POST">

                    @csrf

                    <input class="inputDoWpisywaniaLiter" type="text" name="odpowiedz" value="">

                    <button class="OkBtn btn btn-primary mt-5" type="submit">Ok</button>

                </form>
                <!--Form-->

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
            <!--Panel-->
         </div>
         <!--Row-->

    </div>
    <!--Container-->
  </div>
  <!--ContainerQuiz-->
</div>
<!--Container fluid-->
@endsection
