<?php

namespace App\Http\Controllers;

use App\Models\Month;
use Illuminate\Http\Request;

class MonthController extends Controller
{
    public function index($user,Month $month)
    {
        return view('panel.index',[auth()->user(),$month]);
    }
}
