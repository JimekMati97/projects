<?php

namespace App\Http\Controllers;

use App\Models\Month;
use DateTime;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class LoginController extends Controller
{
    public function index()
    {
        return view('account.login');
    }

    public function store(Request $request)
    {
        $validator=Validator::make($request->all(),[
            'email'=>'required|same:email',
            'password'=>['required']
        ]);
        
        if(!auth()->attempt($request->only('email','password'),$request->remember)){
            
            return back()->with('status','Niepoprawne dane logowania');
        }

        //dzisiejsza data
        $dateToday=new DateTime('now');
        $date_converted=$dateToday->format('Y-m-d');


        $dateToday=date_parse($date_converted);
        
        //model obecnego miesiąca
        $month=$dateToday['month']; 
        $month=Month::find($month);

        //wkleianie parametrów:user,month
        return redirect()->route('kalendarz.user.month',[auth()->user(),$month]);
    }
}