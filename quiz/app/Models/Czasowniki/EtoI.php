<?php
namespace App\Models\Czasowniki;

use App\Models\Czasowniki\NieregularI;

/**
 * Wymiana oboczności ei na i
 */
class EtoI implements NieregularI{

    //liczba wystąpień litery e  w $czlon
    private static int $eCount=0;

    /**
     * odmiana czasownika nieregularnego, w którym wystepowała wymiana E na I
     *
     * @param string $czlon
     * @return array
     */
    public function odmienNiereg($czlon){
        
        //obliczanie wystąpień litery e w $czlon
        $arrayCzlon=str_split($czlon);    
        for ($i=0; $i < count($arrayCzlon); $i++) { 
            ($arrayCzlon[$i]=='e')?(self::$eCount+=1):'noE';
        }

        //inicjalizacja łańcucha $odmianyCzasownika
        $odmianyCzasownika=[];
        
        // jeżeli litera e wystapiła w $arrayCzlon tylko jeden raz, zostaje ona zastapiona literą i w każdej osobie 
        //za wyjątkiem pierwszej i drugiej osoby liczby mnogiej
        if(self::$eCount==1){
            
            //wymiana litery e na i
            $formaNieregularna=str_replace('e','i',$czlon);

            //przypisanie poszczególnym osobom odpowiedniej odmiany
            $PierwszaOs=$formaNieregularna;
            $DrugaOs=$formaNieregularna;
            $TrzeciaOs=$formaNieregularna;
            $Pierwszalm=$czlon;
            $Drugalm=$czlon;
            $Trzecialm=$formaNieregularna;

            //Odmiany czasownika w każdej osobie
            $odmiany=[$PierwszaOs,$DrugaOs,$TrzeciaOs,$Pierwszalm,$Drugalm,$Trzecialm];
            
            //Umieszczenie każdej z odmian w łańcuchu $odmianyCzasownika
            for ($i=0; $i < count($odmiany); $i++){ 
                $odmianyCzasownika[$i]=$odmiany[$i];
            }
    
            return $odmianyCzasownika;

        // jeżeli litera e wystapiła w $arrayCzlon dwa razy, ostatnia litera e w $arrayCzlon
        //zostaje ona zastapiona literą i w każdej osobie za wyjątkiem pierwszej i drugiej osoby liczby mnogiej
        }else if(self::$eCount==2){

            
            $miesjceE=strripos($czlon,'e');
            //wymiana ostaniej w $arrayCzlon litery e na literę i
            $formaNieregularna=substr_replace($czlon,'i',$miesjceE,1);
            //przypisanie poszczególnym osobom odpowiedniej odmiany
            $PierwszaOs=$formaNieregularna;
            $DrugaOs=$formaNieregularna;
            $TrzeciaOs=$formaNieregularna;
            $Pierwszalm=$czlon;
            $Drugalm=$czlon;
            $Trzecialm=$formaNieregularna;

            $odmiany=[$PierwszaOs,$DrugaOs,$TrzeciaOs,$Pierwszalm,$Drugalm,$Trzecialm];
            //Umieszczenie każdej z odmian w łańcuchu $odmianyCzasownika
            for ($i=0; $i < count($odmiany); $i++){ 
                $odmianyCzasownika[$i]=$odmiany[$i];
            }
            
            return $odmianyCzasownika;

        //w przypadku błędnego wybrania typu nieregularności czasownika
        }else{
            die('Ten czasownik nie odmienia się w taki sposób');
        }
    }
}