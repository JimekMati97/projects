<?php

namespace App\Http\Controllers;

use App\Models\Order;
use Illuminate\Http\Request;
use App\Models\Dish;
use App\Models\DishGroup;

class MenuController extends Controller
{

    public function index()
    {    
        $dish_groups=DishGroup::all();
        $orders=Order::where('order_id',session('user_id'))->get();
        $totalSum=0;
        foreach ($orders as $order) {
            $totalSum+=$order->price;
        }
        //dd($totalSum);
        return view('menu',['orders'=>$orders,'dish_groups'=>$dish_groups,'totalSum'=>$totalSum]);
    }

    public function show(DishGroup $dish_group) 
    {    
        $orders=Order::where('order_id',session('user_id'))->get();
        $dishes=Dish::where('dish_group_id',$dish_group->id)->get();
        $totalSum=0;
        foreach ($orders as $order) {
            $totalSum+=$order->price;
        }
        return view('dishes/dishes',['dishes'=>$dishes,'orders'=>$orders,'dish_group'=>$dish_group,'totalSum'=>$totalSum]);
    }
}
