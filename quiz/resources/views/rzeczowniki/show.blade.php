@extends('layouts.app')
@section('content')
    <!--Container-->
    <div class="container text-white showRzeczownik">
        
        <!--Tabela-->
        <table>
            <tr>
                <td>Rzeczownik</td>
                <td>Tłumaczenie</td>
            </tr>

            <tr>

                <td>{{$rzeczownik->rzeczownik}}</td>

                <td>{{$rzeczownik->tlumaczenie}}</td>
            </tr>



        </table>
        <!--Tabela-->
    </div>
    <!--Container-->
</div>
<!--container-fluid-->
@endsection
