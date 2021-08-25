<?php

namespace App\Models\Quiz;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class QuizModel extends Model
{
    use HasFactory;
    protected $table='quiz_models';
    protected $primaryKey='id';
    public $timestamps=true;
    protected $fillable=['slowo','tlumaczenie'];
}
