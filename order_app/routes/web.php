<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\DishController;
use App\Http\Controllers\HomeController;
use App\Http\Controllers\MenuController;
use App\Http\Controllers\PastaController;
use App\Http\Controllers\ApprovingController;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

//redirecting to home directory
Route::get('/', function () {
    return redirect(route('home'));
});
//home controller
Route::get('/home',[HomeController::class,'index'])->name('home');
//menu controller
Route::get('/menu',[MenuController::class,'index'])->name('menu');
Route::get('/menu/{dish_group:name}',[MenuController::class,'show'])->name('dish_group');
//dish controller
Route::get('/menu/{dish_group:name}/{dish:name}',[DishController::class,'index'])->name('dish');
Route::post('/menu/{burgers}',[DishController::class,'store'])->name('store');
Route::delete('/burgery/{order}',[DishController::class,'delete'])->name('burger_type_delete');
//approving controller
Route::get('/potwierdzenie',[ApprovingController::class,'index'])->name('potwierdzenie');