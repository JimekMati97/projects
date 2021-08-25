@extends('layouts.app')
@section('content')
    <!--container-->
    <div class="container d-flex justify-content-center flex-column">
        
        <!--Header-->
        <div class="header col d-flex justify-content-center">
            <h2 class="h2 text-white">Zaloguj się</h2>
        </div>
        <!--Header-->

        <!--Jumbotron-->
        <div class="jumbotron col d-flex justify-content-center">

            <form action="{{route('login')}}" method="post" class="form-group col-5">       
                @csrf
                
                <input class="form-control col my-2" type="email" name="email" value="{{old('email')}}" placeholder="email">
                <input class="form-control col my-2" type="password" name="password" placeholder="haslo">

                <button class="btn btn-success col" type="submit">Zaloguj</button>
                @if (session()->has('status'))
                <div class="alert alert-danger mt-4">{{session('status')}}</div>
           @endif
            </form>

        </div>
        <!--Jumbotron-->
    </div>
    <!--container-->
@endsection    
</html>
