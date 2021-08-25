<?php

namespace App\Models\Quiz;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Quiz_Runda extends Model
{
    
    use HasFactory;

    protected $table='quiz__rundas';

    protected $primary='id';
    
    public $slowoDoOdgadniecia='';

    public function __construct($slowoDoOdgadniecia)
    {
        $this->slowoDoOdgadniecia = $slowoDoOdgadniecia;
    }
}
