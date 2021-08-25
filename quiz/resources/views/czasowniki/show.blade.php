@extends('layouts.app')
@section('content')
    <!--Container-->
    <div class="container showCzasownik text-white">
        
        <!--Tabela-->
        <table>

            <tr>
                <td>1 lp.</td>
                <td>{{$czasownik->czasownikOdmiana['Pierwszalp']}}</td>
                <td>1 lm.</td>
                <td>{{$czasownik->czasownikOdmiana['Pierwszalm']}}</td>
            </tr>
            <tr>
                <td>2 lp.</td>
                <td>{{$czasownik->czasownikOdmiana['Drugalp']}}</td>
                <td>2 lm.</td>
                <td>{{$czasownik->czasownikOdmiana['Drugalm']}}</td>
            </tr>
            <tr>
                <td>3 lp.</td>
                <td>{{$czasownik->czasownikOdmiana['Trzecialp']}}</td>
                <td>3 lm.</td>
                <td>{{$czasownik->czasownikOdmiana['Trzecialm']}}</td>
            </tr>
            <tr>

            </tr>

        </table><br>
        <!--Tabela-->
        <div class="tlumaczenie">
            <p class="text">Tłumaczenie:</p>
            <p class="text">{{$czasownik->czasownik}}-{{$czasownik->tlumaczenie}}</p>
        </div>
        

    </div>
    <!--Container-->
</div>
<!--container-fluid--> 
@endsection
