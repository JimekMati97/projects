<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DishGroup extends Model
{
    use HasFactory;

    protected $table='dish_group';

    public function dish()
    {
        return $this->hasMany(Dish::class);
    }
}
