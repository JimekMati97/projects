<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Order extends Model
{
    use HasFactory;

    protected $table='order';
    protected $fillable=['dish','extra_food','price','order_id','quantity','address','phone_nr'];
}
