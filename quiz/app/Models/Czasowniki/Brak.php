<?php

namespace App\Models\Czasowniki;


use App\Models\Czasowniki\NieregularI;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Brak extends Model implements NieregularI
{
    use HasFactory;

        //inicajlizaja klasy Brak
        protected $czlon='';

        /**
         * Odmiana standardowa według instrukacji odmiany dla końcówek -ar, -er, -ir
         *
         * @param string $czlon
         * @return string
         */
        public function odmienNiereg($czlon){
            return $czlon;
        }   
}
