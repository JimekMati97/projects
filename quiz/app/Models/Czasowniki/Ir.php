<?php

namespace App\Models\Czasowniki;

use App\Models\Czasowniki\KoncowkaI;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Ir extends Model implements KoncowkaI
{
    use HasFactory;
    
    protected $czlon;
    /**
     * constructor
     *
     * @param string $czlon
     */
    public function __construct($czlon)
    {
        $this->czlon = $czlon;
    }
    /**
     * odmien
     *Funkcja odmienia czasownik z końcówką -ar
     * @param $czlon
     * @return void
     */
    public function odmien($czlon){

        //Jeżeli czlon jest napisem
        if(is_string($czlon)){

            /**
             * Przechowuje odmianę czasownika w każdej osobie
             * @param array $odmianyCzasownika
             */
            $odmianyCzasownika=[];

            /**
             * @param string $PierwszaOs
             * @param string $DrugaOs
             * @param string $TrzeciaOs
             * @param string $Pierwszalm
             * @param string $Drugalm
             * @param string $Trzecialm
             */
            $odmianyCzasownika=[];
            $PierwszaOs=$czlon.'o';
            $DrugaOs=$czlon.'es';
            $TrzeciaOs=$czlon.'e';
            $Pierwszalm=$czlon.'imos';
            $Drugalm=$czlon.'ís';
            $Trzecialm=$czlon.'en';

                //Przechowuje odmiany czasownika
                $odmiany=[$PierwszaOs,$DrugaOs,$TrzeciaOs,$Pierwszalm,$Drugalm,$Trzecialm];

                for ($i=0; $i < count($odmiany); $i++){ 
                    $odmianyCzasownika[$i]=$odmiany[$i];
                }

            return $odmianyCzasownika;
    }
        //Jeżeli czlon jest łańcuchem
        else if(is_array($czlon)){

            $odmianyCzasownika=[];
            
            $odmianyCzasownika=[];
            $PierwszaOs=$czlon[0].'o';
            $DrugaOs=$czlon[1].'es';
            $TrzeciaOs=$czlon[2].'e';
            $Pierwszalm=$czlon[3].'imos';
            $Drugalm=$czlon[4].'ís';
            $Trzecialm=$czlon[5].'en';

                $odmiany=[$PierwszaOs,$DrugaOs,$TrzeciaOs,$Pierwszalm,$Drugalm,$Trzecialm];

                for ($i=0; $i < count($odmiany); $i++){ 
                    $odmianyCzasownika[$i]=$odmiany[$i];
                }

            return $odmianyCzasownika;
       }
    }

}

       
