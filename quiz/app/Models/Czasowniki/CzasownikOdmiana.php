<?php

namespace App\Models\Czasowniki;


use Illuminate\Database\Eloquent\Model;
use App\Models\Czasowniki\CzasownikModel;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class CzasownikOdmiana extends Model
{
    use HasFactory;

    public function czasownikModel()
    {
        return $this->belongsTo(CzasownikModel::class);
    }
}
