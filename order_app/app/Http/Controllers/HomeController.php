<?php

namespace App\Http\Controllers;

use App\Models\Order;
use Illuminate\Http\Request;

class HomeController extends Controller
{
    public function index()
    {

        Order::where([['order_id',session('user_id')],['veryfied',0]])->delete();
        if(session()->missing('user_id')){
            $crypted_data=md5(time());
            $user_id=session()->put('user_id',$crypted_data);
        }else{
            session()->forget('user_id');
            $crypted_data=md5(time());
            $user_id=session()->put('user_id',$crypted_data);
        }
        
        
        //dd(session('user_i'));
        
        return view('home');
    }
}
