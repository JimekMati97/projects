@extends('layouts.app')
@section('content')
    <!--Container-->
    <div class="container d-flex justify-content-center flex-column">

        <div class="header col d-flex justify-content-center">
            <h2 class="h2 text-white">Home</h2>
        </div>

        @if (!auth()->user())
            <!--buttons-->
            <div class="buttons d-flex justify-content-center flex-column">
                <a href="{{route('register')}}" class="btn btn-success w-25 align-self-center">Zarejestruj</a><br/>
                <a href="{{route('login')}}" class="btn btn-primary w-25 align-self-center">Zaloguj</a>
            </div>
            <!--buttons-->
        @endif

    </div>
    <!--Container-->
@endsection    
</html>
