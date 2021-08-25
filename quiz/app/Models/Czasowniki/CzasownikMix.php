<?php

namespace App\Models\Czasowniki;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
/**
 * odmiana czasownika który odmienia się w sposób nieregularny, łącząc typy oboczności 
 * dla nieregularności dla pierwszej osoby i jednej z 4 tpyów wymian e->i itd. Klasa posiada gotowe odmiany. 
 */
class CzasownikMix extends Model
{
    use HasFactory;

    /**
     * zawiera wszytkie odmiany czasownika nieregurlanego typ Mix
     *
     * @var array
     */
    protected $odmianyCzasownikaMix=[];
    
    /**
     * odmiana czasownika o niergularnej formie odmiany typu Mix
     *
     * @param String $czasownikMix
     * @return void
     */
    public function odmien($czasownikMix)
    {
        /**
         * @param String $czasownikMix
         */
        switch ($czasownikMix) {

            case 'decir':
                
                $PierwszaOs='digo';
                $DrugaOs='dices';
                $TrzeciaOs='dice';
                $Pierwszalm='decimos';
                $Drugalm='decis';
                $Trzecialm='dicen';
        
                $odmiany=[$PierwszaOs,$DrugaOs,$TrzeciaOs,$Pierwszalm,$Drugalm,$Trzecialm];
        
                    for ($i=0; $i < count($odmiany); $i++){ 
                        $this->odmianyCzasownikaMix[$i]=$odmiany[$i];
                    }
        
                    return $this->odmianyCzasownikaMix;
                
                break;
            
            case 'elegir':
            
                $PierwszaOs='elijo';
                $DrugaOs='eliges';
                $TrzeciaOs='elige';
                $Pierwszalm='elegimos';
                $Drugalm='elegís';
                $Trzecialm='eligen';
        
                $odmiany=[$PierwszaOs,$DrugaOs,$TrzeciaOs,$Pierwszalm,$Drugalm,$Trzecialm];
        
                    for ($i=0; $i < count($odmiany); $i++){ 
                        $this->odmianyCzasownikaMix[$i]=$odmiany[$i];
                    }
                    
                    return $this->odmianyCzasownikaMix;
                
                break;
            case 'oir':
            
                $PierwszaOs='oigo';
                $DrugaOs='dices';
                $TrzeciaOs='oyes';
                $Pierwszalm='oye';
                $Drugalm='oís';
                $Trzecialm='oyen';
        
                $odmiany=[$PierwszaOs,$DrugaOs,$TrzeciaOs,$Pierwszalm,$Drugalm,$Trzecialm];
        
                    for ($i=0; $i < count($odmiany); $i++){ 
                        $this->odmianyCzasownikaMix[$i]=$odmiany[$i];
                    }
        
                    return $this->odmianyCzasownikaMix;
                
                break;
                
            case 'tener':
            
                $PierwszaOs='tengo';
                $DrugaOs='tienes';
                $TrzeciaOs='tiene';
                $Pierwszalm='tenemos';
                $Drugalm='tenéis';
                $Trzecialm='tienen';
        
                $odmiany=[$PierwszaOs,$DrugaOs,$TrzeciaOs,$Pierwszalm,$Drugalm,$Trzecialm];
        
                    for ($i=0; $i < count($odmiany); $i++){ 
                        $this->odmianyCzasownikaMix[$i]=$odmiany[$i];
                    }
        
                    return $this->odmianyCzasownikaMix;
                
                break;

            case 'venir':
            
                $PierwszaOs='vengo';
                $DrugaOs='vienes';
                $TrzeciaOs='viene';
                $Pierwszalm='venimos';
                $Drugalm='venís';
                $Trzecialm='vienen';
        
                $odmiany=[$PierwszaOs,$DrugaOs,$TrzeciaOs,$Pierwszalm,$Drugalm,$Trzecialm];
        
                    for ($i=0; $i < count($odmiany); $i++){ 
                        $this->odmianyCzasownikaMix[$i]=$odmiany[$i];
                    }
        
                    return $this->odmianyCzasownikaMix;
                
                break;

            case 'jugar':
        
                $PierwszaOs='jeuego';
                $DrugaOs='juegas';
                $TrzeciaOs='juega';
                $Pierwszalm='jugamos';
                $Drugalm='jugáis';
                $Trzecialm='juegan';
        
                $odmiany=[$PierwszaOs,$DrugaOs,$TrzeciaOs,$Pierwszalm,$Drugalm,$Trzecialm];
        
                    for ($i=0; $i < count($odmiany); $i++){ 
                        $this->odmianyCzasownikaMix[$i]=$odmiany[$i];
                    }
        
                    return $this->odmianyCzasownikaMix;
                
                break;
        }
    }


}
