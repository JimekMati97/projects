<?php
namespace App\Models\Czasowniki;

/**
 *   odmiana czasownika regularnego z uwzględnieniem poszczególnych klas reprezentujących typy 
 *   odmian ze względu na końcówkę czasownika:ar,er,ir
 */
interface KoncowkaI{
    public function odmien($czlon);
}