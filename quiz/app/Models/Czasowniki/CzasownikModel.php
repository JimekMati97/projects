<?php

namespace App\Models\Czasowniki;


use Illuminate\Database\Eloquent\Model;
use App\Models\Czasowniki\CzasownikOdmiana;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class CzasownikModel extends Model 
{

    use HasFactory;

    protected $table='czasownik_models';

    public $timestamps='true';

    protected $primaryKey='id';

    protected $dateFormat='Y-m-d H:i-s';

    protected $fillable=['czasownik','tlumaczenie','nieregularnosc'];

    public function czasownikOdmiana()
    {
        return $this->hasOne(CzasownikOdmiana::class);
    }


}
