<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Rules\RzeczownikRule;
use Illuminate\Support\Facades\DB;
use App\Models\Rzeczowniki\RzeczownikiModel;

class RzeczownikiController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $rzeczowniki=RzeczownikiModel::all();

        return view('rzeczowniki/rzeczowniki')->with('rzeczowniki',$rzeczowniki);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $request->validate([
            'rzeczownik'=>[new RzeczownikRule,'required','string','regex:/^[a-zA-Záéíóúüñ ]+$/u','max:25','unique:rzeczowniki_models'],
            'tlumaczenie'=>'required|string|max:25|regex:/^[a-zA-ZćśżźóŻŹĆŚęą]+$/u'
        ]);
        
        $rzeczowniki=RzeczownikiModel::create([
            'rzeczownik'=>$request->input('rzeczownik'),
            'tlumaczenie'=>$request->input('tlumaczenie')
        ]);
        //wkleianie do bazy tabeli ze wszytkimi slowami
        DB::table('quiz_models')->insert([
    
            'slowo'=>$rzeczowniki->rzeczownik,
            'tlumaczenie'=>$rzeczowniki->tlumaczenie
        ]);
        $rzeczowniki=RzeczownikiModel::all();

        return view('rzeczowniki/rzeczowniki')->with('rzeczowniki',$rzeczowniki);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $rzeczownik=RzeczownikiModel::find($id);
        return view('rzeczowniki/show')->with('rzeczownik',$rzeczownik);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }
}


