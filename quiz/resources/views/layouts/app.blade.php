<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
    
        <title>Laravel</title>

        <!-- Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700&display=swap" rel="stylesheet">
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://code.jquery.com/jquery-3.6.0.slim.min.js">
        <link rel="stylesheet" href="{{asset('css/app.css')}}">

        <style>
            body{
                background-color: #323232;
            }
        </style>
    </head>
    <body class="antialiased">
        <!--Container fluid-->
        <div class="container-fluid col-12 d-flex  m-0 p-0">
            <!--Menu panel-->
            <header class="bg-dark col-2">
                <menu class="p-0">
                    <ul class="navbar-nav">
                        <li class="{{request()->is('quiz')? 'active':'nav-item'}}">
                        <a class="nav-link text-white" aria-current="page" href="{{route('quiz')}}">Quiz</a>
                        </li>
                        <li class="{{request()->is('czasowniki')? 'active':'nav-item'}}">
                        <a class="nav-link text-white" href="{{route('czasowniki')}}">Czasowniki</a>
                        </li>
                        <li class="{{request()->is('rzeczowniki')? 'active':'nav-item'}}">
                            <a class="nav-link text-white" href="{{route('rzeczowniki')}}">Rzeczowniki</a>
                        </li>
                        <li class="{{request()->is('/')? 'active':'nav-item'}}">
                            <a class="nav-link text-white pl-3" href="{{route('home')}}">Home</a>
                        </li>
                    </ul>
                </menu>
            </header>
            <!--Menu panel-->
       @yield('content')

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="{{asset('js/app.js')}}"></script>

    </body>
</html>