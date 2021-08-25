<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\Panstwo;
use App\Rules\PanstwoRule;
use App\Rules\UserNameRule;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Auth\Events\Validated;
use App\Http\Requests\StoreUerRequest;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rules\Password;

class RegisterController extends Controller
{

    /**
     * zwraca listę państw
     *
     * @return array
     */
    public function index()
    {   
        $countries=DB::table('panstwos')->orderBy('nazwa','ASC')->get();
        
        return view('account.register',['countries'=>$countries]);
       
    }

    /**
     * walidacja i wkleianie danych
     *
     * @param Request $request
     * @return void
     */
    public function store(Request $request)
    {
        $countries=Panstwo::get();
        
        //form validation
        $validator=Validator::make($request->all(),[
            'nazwa'=>'required|unique:users,nazwa|alpha_num|min:2|max:18',
            'imie'=>'required|string|min:2|max:18',
            'nazwisko'=>'required|string|min:2|max:18',
            'plec'=>'required|digits_between:0,3',
            'panstwo'=>[new PanstwoRule([$countries])],
            'telefon'=>'required|integer',
            'email'=>'required|unique:users,email|email',
            'password'=>['required','confirmed',Password::min(1)->numbers()],
            'regulamin'=>'accepted'
        ],$messages=[
            'nazwa.required'=>'Pole :attribute musi być wypełnione',
            'imie.required'=>'Pole :attribute musi być wypełnione',
            'nazwisko.required'=>'Pole :attribute musi być wypełnione',
            'telefon.required'=>'Pole :attribute musi być wypełnione',
            'telefon.integer'=>'Niepoprawny numer telefonu',
            'email.required'=>'Pole :attribute musi być wypełnione',
            'plec.digits_between'=>"Nie wybrano płci",
            'regulamin.accepted'=>'Musisz zaakceptować regulamin, aby się zarejestrować',
            'password.required'=>'Pole :attribute musi być wypełnione',
            'password.confirmed'=>'Hasła nie są tożsame'
        ]);

        if($validator->fails()){
            return redirect(route('register'))
                    ->withErrors($validator)
                    ->withInput();
        }

        //inserting new user
        User::create([
            'nazwa'=>$request['nazwa'],
            'imie'=>$request['imie'],
            'nazwisko'=>$request['nazwisko'],
            'plec'=>$request['plec'],
            'panstwo'=>$request['panstwo'],
            'telefon'=>$request['telefon'],
            'email'=>$request['email'],
            'password'=>Hash::make($request['password']),
            'profile_image'=>($request['plec']==1)?'profile_man.jpg':'profile_girl.jpg'
        ]);

        return redirect(route('login'));
    }
}
