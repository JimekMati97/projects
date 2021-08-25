<?php

namespace App\Http\Controllers;

use App\Models\Order;
use Illuminate\Http\Request;

class ApprovingController extends Controller
{
    public function index()
    {
        //email sending

        //checking orders as veryfied
        
        Order::where('order_id',session('user_id'))->update([
            'veryfied'=>1
        ]);
        session()->forget('filled_data');
        session()->flash('status','Dziękujemy. Twoje zamówienie jest w trakcie realizacji');
        
        //dd(session('filled_data'));
        return view('approve');
    }
}
