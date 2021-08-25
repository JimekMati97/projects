<?php

namespace App\Models\Rzeczowniki;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class RzeczownikiModel extends Model
{
    use HasFactory;
    protected $table='rzeczowniki_models';
    protected $primaryKey='id';
    protected $fillable=['rzeczownik','tlumaczenie'];
}
