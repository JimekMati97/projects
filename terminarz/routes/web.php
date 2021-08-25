<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\HomeController;
use App\Http\Controllers\LoginController;
use App\Http\Controllers\MonthController;
use App\Http\Controllers\Logoutcontroller;
use App\Http\Controllers\RegisterController;
use App\Http\Controllers\TerminarzController;

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
//home
Route::get('/', [HomeController::class,'index'])->name('home');

//register
Route::get('/kalendarz/register', [RegisterController::class,'index'])->name('register');
Route::post('/kalendarz/register', [RegisterController::class,'store']);

//login
Route::get('/kalendarz/login', [LoginController::class,'index'])->name('login');
Route::post('/kalendarz/login', [LoginController::class,'store']);

//logout
Route::get('/logout', [Logoutcontroller::class,'logout'])->name('logout');

//terminarz
Route::get('/kalendarz/{user:imie}/{month:miesiac}', [TerminarzController::class,'index'])->name('kalendarz.user.month');
Route::post('/kalendarz/{user:imie}/{month:miesiac}', [TerminarzController::class,'store']);
Route::get('/kalendarz/{user:imie}/{month:miesiac}/{day}',[TerminarzController::class,'show'])->name('kalendarz.user.month.day');

