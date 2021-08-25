<?php

use Illuminate\Support\Facades\Route;

use App\Http\Controllers\HomeController;
use App\Http\Controllers\QuizController;
use App\Http\Controllers\CzasownikiController;
use App\Http\Controllers\RzeczownikiController;

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

Route::resource('/quiz', QuizController::class)->name('index','quiz');

Route::resource('/', HomeController::class)->name('index','home');

Route::resource('/czasowniki', CzasownikiController::class)->name('index','czasowniki');

Route::resource('/rzeczowniki', RzeczownikiController::class)->name('index','rzeczowniki');