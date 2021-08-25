@extends('include.app')
@section('content')
<div class="container containerHome">

    <div class="row col-12 d-flex align-items-center">
        <div class="welcome_text d-flex justify-content-center ">
            <h1 class="h1 text-dark  font-weight-bold">Zamów śniadanie, obiad, kolację</h1>
        </div>
    </div>

    <div class="row col-12 m-0 d-flex align-items-top">
        <div class="d-flex justify-content-center col-12 align-self-end ">
            <a class="make_order text-decoration-none text-white rounded-pill p-4 mb-5" href="{{route('menu')}}">Złóż zamówienie</a>
        </div>
    </div>

</div>

@if (session()->has('status'))
   <div class="container">
    <div class="row-padding bg-success rounded-pill d-flex justify-content-center align-items-center col-12">
        <p class="text-white col-6 m-0">Dziękujemy. Twoje zamówienie jest w trakcie realizacji</p>
    </div>
</div> 
@endif

@endsection