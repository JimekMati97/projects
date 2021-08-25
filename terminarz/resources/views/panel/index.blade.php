@extends('layouts.app')
@section('content')
    <div class="container d-flex justify-content-center flex-column">
        <div class="header col d-flex justify-content-center">
            <h2 class="h2 text-white">Terminarz</h2>
        </div>

        <div class="main">
            <!--terminarz-->
            <div class="container terminarz d-flex">
                <div class="row">
                    <ul>
                        @foreach ($months as $month)
                        
                        <li class="list-group-item text-dark">
                            <a href="{{route('kalendarz.user.month',[auth()->user(),$month])}}">{{$month->miesiac}}</a>
                        </li>

                         @endforeach
                    </ul>
                </div>         
                <div class="row col-6 bg-white">


                    <!--ile dni w miesiącu-->

                    <div class="plansza d-flex flex-wrap align-items-start">


                        <!--Wszystkie pola dni oraz puste pola-->
                        <div class="days d-flex flex-wrap m-auto col"> 

                            <!--Nazwy dni tygodnia-->

                                                        
                            <div class="dzien d-flex flex-column">                           
                                <div class="dzien_tyg col d-flex justify-content-center align-items-center h-25"><p><small>Pon</small></p></div>
                            </div>

                            <div class="dzien d-flex flex-column">                           
                                <div class="dzien_tyg col d-flex justify-content-center align-items-center h-25"><p><small>Wt</small></p></div>
                            </div>

                            <div class="dzien d-flex flex-column">                           
                                <div class="dzien_tyg col d-flex justify-content-center align-items-center h-25"><p><small>Śr</small></p></div>
                            </div>

                            <div class="dzien d-flex flex-column">                           
                                <div class="dzien_tyg col d-flex justify-content-center align-items-center h-25"><p><small>Czw</small></p></div>
                            </div>

                            <div class="dzien d-flex flex-column">                           
                                <div class="dzien_tyg col d-flex justify-content-center align-items-center h-25"><p><small>Pt</small></p></div>
                            </div>

                            <div class="dzien d-flex flex-column">                           
                                <div class="dzien_tyg col d-flex justify-content-center align-items-center h-25"><p><small>Sob</small></p></div>
                            </div>

                            <div class="dzien d-flex flex-column">                           
                                <div class="dzien_tyg col d-flex justify-content-center align-items-center h-25"><p><small>Nd</small></p></div>
                            </div>

                      
                            <!--Nazwy dni tygodnia-->
                     

                            <!--Skipped days-->
                            @for ($i=1;$i<=$skipdays[1];$i++)
                                <a class="dzien" href="#">

                                        <div class="dzien d-flex flex-column">                           
                                            <div class="dzien_tyg col d-flex justify-content-end h-25"></div>
                                        </div>
                                </a>
                            @endfor
                            <!--Skipped days-->

                            <!--dni danego miesiąca-->
                            
                            @for ($i=1;$i<=$days_in_month;$i++)
                               
                                <a class="dzien" href="{{route('kalendarz.user.month.day',[auth()->user(),$months[$cur_month-1],$i])}}"><div class="dzien d-flex flex-column @if ($i==$dateToday['day']&&$dateToday['month']==$cur_month) today @endif">
                                    <!--rozważyć progresbar-->
                                    <div class="nr_dnia col d-flex justify-content-center align-items-center h-75"><p class="d-flex align-items-center mt-4">{{$i}}</p></div>
                                    <div class="zadania col d-flex justify-content-end h-25 p-0"><span class=" d-flex justify-content-center align-items-center">
                                        {{$tasksForWholeMonth[$i]}}
                                    </span></div>

                                </div></a>

                            @endfor

                            <!--dni danego miesiąca-->
                        </div>
                        <!--Wszystkie pola dni oraz puste pola-->

                    </div>

                </div>
                
            <!--formularz dodawania zadań-->
                <div class="row col-6 bg-secondary">
                    
                    <form action="{{route('kalendarz.user.month',[auth()->user()->id,$month])}}" method="post" class="d-flex flex-column">
                        @csrf
                        <!--Wybór roku-->
                        <select name="year" id="year">
                            <option selected value="{{$dateToday['year']}}">{{$dateToday['year']}}</option>
                            <option value="2022">2022</option>
                            <option value="2023">2023</option>
                            <option value="2024">2024</option>
                        </select>
                        <!--Wybór roku-->

                        <!--Wybór miesiąca-->
                        <select name="month" id="month">

                            <option selected value="{{$months[$dateToday['month']-1]->id}}">{{$months[$dateToday['month']-1]->miesiac}}</option>
                            @foreach ($months as $month)
                                
                                <option value="{{$month->id}}">{{$month->miesiac}}</option>
                                
                            @endforeach
                            

                        </select>
                        <!--Wybór miesiąca-->

                        <!--Wybór dnia-->
                        <select name="day" id="day">
                            
                            <option selected value="{{$dateToday['day']}}">{{$dateToday['day']}}</option>
                            @for ($i=1;$i<=$days_in_month;$i++)
                                
                                             
                                <option value="{{$i}}">{{$i}}</option>
                                
                            @endfor
                            

                        </select>
                        <!--Wybór dnia-->

                        <!--Treść zadania-->
                        <textarea name="task" id="task" cols="30" rows="10" placeholder="wpisz swoje zadanie"></textarea>
                        <!--Treść zadania-->

                        <button class="btn btn-success">Dodaj</button>

                        <!--Błąd - brak wypełnienia pola zadanie-->
                        @if ($errors->any())
                        @foreach ($errors->all() as $error)
                            <div class="alert alert-danger mt-4">{{$error}}</div>
                        @endforeach
                        
                        @endif
                        <!--Błąd - brak wypełnienia pola zadanie-->
                    </form>


                </div>

            </div>

        </div>
    </div>
@endsection    
</html>
