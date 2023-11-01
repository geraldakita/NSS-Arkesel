<?php

use App\Http\Controllers\ToDoController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

Route::get('/', [ToDoController::class, 'index']);
Route::get('/create', [ToDoController::class, 'create']);
Route::get('/{id}', [ToDoController::class, 'show']);
Route::post('/', [ToDoController::class, 'store']);
Route::delete('/{id}', [ToDoController::class, 'destroy'])->name('todo.destroy');