@extends('layouts.app')
@section('content')

     <!--container-->
    <div class="container d-flex justify-content-center flex-column">

        <!--Header-->
        <div class="header col d-flex justify-content-center">
            <h2 class="h2 text-white">Zarejestruj się</h2>
        </div>
         <!--Header-->

         <!--Jumbotron-->
        <div class="jumbotron col d-flex justify-content-center">
            
            <form action="{{route('register')}}" method="post" class="form-group col-5">

                @csrf
                <input class="form-control col my-2" type="text" name="nazwa" value="{{old('nazwa')}}" placeholder="nazwa">

                    @error('nazwa')
                    <p class="text-danger">{{$message}}</p>
                    @enderror

                <input class="form-control col my-2" type="text" name="imie" value="{{old('imie')}}" placeholder="imie">

                    @error('imie')
                    <p class="text-danger">{{$message}}</p>
                    @enderror

                <input class="form-control col my-2" type="text" name="nazwisko" value="{{old('nazwisko')}}" placeholder="nazwisko">

                    @error('nazwisko')
                        <p class="text-danger">{{$message}}</p>
                    @enderror

                <select name="plec" id="plec" class="col-12 my-2">
                    <option value="wybierz płeć" selected>wybierz płeć</option>
                    <option value="1">Mężczyzna</option>
                    <option value="2">Kobieta</option>
                </select>

                    @error('plec')
                    <p class="text-danger">{{$message}}</p>
                    @enderror

                <select name="panstwo" id="panstwo" class="col-12 my-2">

                    <option value="wybierz panstwo" selected>wybierz państwo</option>

                    @foreach ($countries as $country)
                        <option value="{{$country->nazwa}}">{{$country->nazwa}}</option>
                    @endforeach

                </select>

                    @error('panstwo')
                    <p class="text-danger">{{$message}}</p>
                    @enderror

                <input class="form-control col my-2" type="text" name="telefon" value="{{old('telefon')}}" placeholder="telefon">

                    @error('telefon')
                        <p class="text-danger">{{$message}}</p>
                    @enderror
                
                <input class="form-control col my-2" type="email" name="email" value="{{old('email')}}" placeholder="email">

                    @error('email')

                    <p class="text-danger">{{$message}}</p>
                    @enderror

                <input class="form-control col my-2" type="password" name="password" placeholder="haslo">

                    @error('password')
                    <p class="text-danger">{{$message}}</p>
                    @enderror

                <input class="form-control col my-2" type="password" name="password_confirmation" placeholder="powtórz hasło">

                <label for="regulamin">Regulamin</label><input id="regulamin" class="form-check-input ml-2" type="checkbox" name="regulamin" value="1">

                    @error('regulamin')
                        <p class="text-danger">{{$message}}</p>
                    @enderror

                <button class="btn btn-success col" type="submit">Zarejestruj</button>
                
            </form>

        </div>
        <!--Jumbotron-->
    </div>
    <!--container-->
@endsection    
</html>
