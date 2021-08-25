<?php

namespace App\Models;

use App\Models\ExtraFoodDish;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Dish extends Model
{
    protected $table='dish';

    public function extra_food()
    {
        return $this->belongsToMany(ExtraFoodDish::class,'dish_extra_food','dish_id','extra_food_id');
    }
}
