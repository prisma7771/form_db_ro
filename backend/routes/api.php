<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\api\DataController;
use App\Http\Controllers\api\ImageController;


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

Route::apiResource('/venues', App\Http\Controllers\Api\DataController::class);
Route::apiResource('/images', App\Http\Controllers\Api\ImageController::class);
