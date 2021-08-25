<?php

namespace App\Models\Czasowniki;

use App\Models\Czasowniki\Ar;
use App\Models\Czasowniki\KoncowkaI;
use App\Models\Czasowniki\NieregularI;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use App\Models\Czasowniki\CzasownikOdmiana;

class CzasownikBudowa extends Model implements KoncowkaI, NieregularI
{
    use HasFactory;

    protected KoncowkaI $czasownik_koncowka;
    protected NieregularI $czasownik_typ_niereg;
    /**
     * Constructor
     *
     * @param NieregularI $czasownik_typ_niereg
     * @param KoncowkaI $czasownik_koncowka
     */
    public function __construct(NieregularI $czasownik_typ_niereg, KoncowkaI $czasownik_koncowka)
    {
        $this->czasownik_typ_niereg=$czasownik_typ_niereg;
        $this->czasownik_koncowka = $czasownik_koncowka;
    }
    /**
     * odmiana według końcówki czasownika: 3 możliwości
     *
     * @param $czlon
     * @return array
     */
    public function odmien($czlon)
    {
       return $this->czasownik_koncowka->odmien($czlon);
    }
    /**
     * odmiana według wybranego typu nieregularności
     *
     * @param string $czlon
     * @return array
     */
    public function odmienNiereg($czlon)
    {
       return $this->czasownik_typ_niereg->odmienNiereg($czlon);
    }
}
