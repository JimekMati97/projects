@extends('layouts.app')
@section('content')
    <!--Container-->
    <div class="container d-flex justify-content-center flex-column">

        <div class="header">
            <div class="row ">
                <!--Dzisiejsza data-->
                <div class="currentDate d-flex justify-content-end text-white">
                    <h1>{{date('Y-m-d')}}</h1>
                </div>
                <!--Dzisiejsza data-->
            </div>
        </div>

        <div class="main d-flex justify-content-center">

            <!--Zadania-->

            <div class="tasks w-100 d-flex justify-content-center">
                <!--Sprawdzanie czy istnieją zadania-->
                @if ($noTasks ?? '')
                    <p class="text text-white ">{{$noTasks}}</p>
                @else
                 <ul class="list-group w-100">

                    @foreach ($tasks_for_chosen_day as $task)

                    <li class="list-group-item">{{$task->task}}</li>  

                    @endforeach
                  
                  </ul>
                @endif
                <!--Sprawdzanie czy istnieją zadania-->

            </div>
            <!--Zadania-->
        </div>
    </div>
    <!--Container-->
@endsection    
</html>
