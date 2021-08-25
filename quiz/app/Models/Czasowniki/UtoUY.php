<?php
namespace App\Models\Czasowniki;

use App\Models\Czasowniki\NieregularI;

/**
 * Wymiana oboczności u na uy
 */

class UtoUY implements NieregularI{

    //liczba wystąpień litery u  w $czlon
    private static int $iCount=0;
    /**
     * odmiana czasownika nieregularnego, w którym wystepowała wymiana u na uy
     *
     * @param string $czlon
     * @return array
     */
    public function odmienNiereg($czlon){

        //obliczanie wystąpień litery u w $czlon
        $arrayCzlon=str_split($czlon);

        for ($i=0; $i < count($arrayCzlon); $i++) { 
            ($arrayCzlon[$i]=='u')?(self::$iCount+=1):'noI';
        }
        //inicjalizacja łańcucha $odmianyCzasownika
        $odmianyCzasownika=[];

        // jeżeli litera u wystapiła w $arrayCzlon tylko jeden raz, zostaje ona zastapiona literami uy w każdej osobie 
        //za wyjątkiem pierwszej i drugiej osoby liczby mnogiej
        if(self::$iCount==1){

            //wymiana litery u na uy
            $formaNieregularna=str_replace('u','uy',$czlon);
            
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

        }
        // jeżeli litera u wystapiła w $arrayCzlon dwa razy, ostatnia litera u w $arrayCzlon
        //zostaje ona zastapiona literami uy w każdej osobie za wyjątkiem pierwszej i drugiej osoby liczby mnogiej
        else if(self::$iCount==2){
            //szukanie pozycji ostatniej litery u w $czlon
            $miesjceE=strripos($czlon,'u');

            $formaNieregularna=substr_replace($czlon,'uy',$miesjceE,1);
            
            $PierwszaOs=$formaNieregularna;
            $DrugaOs=$formaNieregularna;
            $TrzeciaOs=$formaNieregularna;
            $Pierwszalm=$czlon;
            $Drugalm=$czlon;
            $Trzecialm=$formaNieregularna;

            //Umieszczenie każdej z odmian w łańcuchu $odmianyCzasownika
            $odmiany=[$PierwszaOs,$DrugaOs,$TrzeciaOs,$Pierwszalm,$Drugalm,$Trzecialm];
            
            for ($i=0; $i < count($odmiany); $i++){ 
                $odmianyCzasownika[$i]=$odmiany[$i];
            }
    
            return $odmianyCzasownika;
            
        }else{
            die('Ten czasownik nie odmienia się w taki sposób');
        }
        

    }
}