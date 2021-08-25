<?php

namespace App\Http\Controllers;

use App\Models\Dish;
use App\Models\DishGroup;
use App\Models\Order;
use App\Rules\Address;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class DishController extends Controller
{
    public function index($dishGroup,Dish $dish)
    {

        $orders=Order::where('order_id',session('user_id'))->get();
        $dish=Dish::find($dish->id);
        $totalSum=0;
        foreach ($orders as $order) {
            $totalSum+=$order->price;
        }
        return view('dishes/dish',['dish'=>$dish,'orders'=>$orders,'dishGroup'=>$dishGroup,'totalSum'=>$totalSum]);
    }

    public function store(Dish $burgers,Request $request)
    {
        //sprawdzanie czy istnieje już identyfiaktor w bazie danych
        $check_user_id=Order::where('order_id',session('user_id'))->get('address','phone_nr');
        //dd($check_user_id);
        if($check_user_id->isEmpty()){
            
            $validator=Validator::make($request->all(),[
                'address'=>['required','string',new Address],
                'phone'=>['required','string','digits:9']
            ],$messages=[
                'address.required'=>"Należy wypełnić pole adres",
                'phone.required'=>"Należy wypełnić pole Nr. telefonu",
                'phone.digits'=>"Należy wypełnić pole Nr. telefonu 9 cyframi"
            ]);

            if($validator->fails()){
                return back()
                ->withErrors($validator)
                ->withInput();
            }
            session()->put('filled_data','set');
        }

        $extra_food_names=$this->getDodatki($request['dodatek']);
        $extra_food_prices=$this->getPrices($request['dodatek']);
        
        $session_id=session('user_id');
        //dd($request['quantity']);

        Order::create([
            'dish'=>$burgers->name,
            'quantity'=>$request['quantity'],
            'extra_food'=>$extra_food_names,
            'address'=>$request['address'],
            'phone_nr'=>$request['phone'],
            'price'=>(array_sum($extra_food_prices)+$burgers->price)*$request['quantity'],
            'order_id'=>$session_id
        ]);
     
        return redirect(route('menu'));


   
    }
    public function delete(Order $order)
    {
        $order->where('id',$order->id)->delete();
        return back();
    }


    public function getDodatki($dodatki)
    {
        $extra_food='';
        if(is_array($dodatki)){
            foreach ($dodatki as $key => $value) {
                $position=strpos($value,',');
                $value=substr($value,$position+1,-1);
                $extra_food.=$value.', ';
            }
        }

        return $extra_food;
    }
    public function getPrices($dodatki) 
    {
        $extra_food_prices=[];
        if(is_array($dodatki)){
            foreach ($dodatki as $key => $value) {
                $position=strpos($value,',');
                //wycinanie ceny 
                $value=substr($value,1,$position-1);
                $extra_food_prices[$key]=$value;
            }
        }   
        return $extra_food_prices;
    }
}
