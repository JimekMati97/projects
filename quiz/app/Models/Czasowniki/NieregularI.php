<?php
namespace App\Models\Czasowniki;

/**
 * odmiana czasownika Nieregularnego z uwzględnieniem poszczególnych klas reprezentujących typy odmian:
 * E->i,E->IE,O->UE,I->Y
 */
interface NieregularI{
    public function odmienNiereg($czlon);
}