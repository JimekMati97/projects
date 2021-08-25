<?php
namespace App\Models\Czasowniki;

use App\Models\Czasowniki\NieregularI;

/**
 * Wymiana oboczności o na ue
 */
class OtoUE implements NieregularI{

    //liczba wystąpień litery o  w $czlon
    private static int $oCount=0;

    /**
     * odmiana czasownika nieregularnego, w którym wystepowała wymiana o na ue
     *
     * @param string $czlon
     * @return array
     */
    public function odmienNiereg($czlon){

        //obliczanie wystąpień litery o w $czlon
        $arrayCzlon=str_split($czlon);
    
        for ($i=0; $i < count($arrayCzlon); $i++) { 
            ($arrayCzlon[$i]=='o')?(self::$oCount+=1):'noE';
        }

        //inicjalizacja łańcucha $odmianyCzasownika
        $odmianyCzasownika=[];
        
        // jeżeli litera o wystapiła w $arrayCzlon tylko jeden raz, zostaje ona zastapiona literami ue w każdej osobie 
        //za wyjątkiem pierwszej i drugiej osoby liczby mnogiej
        if(self::$oCount==1){
      
            //wymiana litery o na ue
            $newArray=array_map(function($val){return ($val=='o')?'ue':$val;},$arrayCzlon);
            
            //przypisanie poszczególnym osobom odpowiedniej odmiany
            $formaNieregularna=implode($newArray);
            
            $PierwszaOs=$formaNieregularna;
            $DrugaOs=$formaNieregularna;
            $TrzeciaOs=$formaNieregularna;
            $Pierwszalm=$czlon;
            $Drugalm=$czlon;
            $Trzecialm=$formaNieregularna;

            //Odmiany czasownika w każdej osobie
            $odmiany=[$PierwszaOs,$DrugaOs,$TrzeciaOs,$Pierwszalm,$Drugalm,$Trzecialm];
            
            for ($i=0; $i < count($odmiany); $i++){ 
                $odmianyCzasownika[$i]=$odmiany[$i];
            }
    
            return $odmianyCzasownika;
            
        }
        // jeżeli litera o wystapiła w $arrayCzlon dwa razy, ostatnia litera o w $arrayCzlon
        //zostaje ona zastapiona literami ue w każdej osobie za wyjątkiem pierwszej i drugiej osoby liczby mnogiej
        else if(self::$oCount==2){

            //wymiana litery o na ue
            $miesjceO=strripos($czlon,'o');

            //wymiana litery o na ue
            $formaNieregularna=substr_replace($czlon,'ue',$miesjceO,1);
            
            $PierwszaOs=$formaNieregularna;
            $DrugaOs=$formaNieregularna;
            $TrzeciaOs=$formaNieregularna;
            $Pierwszalm=$czlon;
            $Drugalm=$czlon;
            $Trzecialm=$formaNieregularna;

            //Odmiany czasownika w każdej osobie
            $odmiany=[$PierwszaOs,$DrugaOs,$TrzeciaOs,$Pierwszalm,$Drugalm,$Trzecialm];
            
            for ($i=0; $i < count($odmiany); $i++){ 
                $odmianyCzasownika[$i]=$odmiany[$i];
            }
    
            return $odmianyCzasownika;
            
        }else{
            die('Ten czasownik nie odmienia się w tak sposób');
        }
        

    }
}