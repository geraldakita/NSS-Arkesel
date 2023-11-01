<?php

use App\Http\Controllers\AccountController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::get('/account', [AccountController::class, 'index']);

Route::post('/account', [AccountController::class, 'store']);

Route::put('/account/edit/{id}', [AccountController::class, 'edit'])->middleware('api_auth');

Route::delete('/account/edit/{id}', [AccountController::class, 'delete'])->middleware('api_auth');