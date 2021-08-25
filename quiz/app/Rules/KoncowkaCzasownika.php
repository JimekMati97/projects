<?php

namespace App\Rules;

use Illuminate\Contracts\Validation\Rule;

class KoncowkaCzasownika implements Rule
{

    /**
     * $kocowki zawiera akcpetowane zakończenia czasownika
     */
    public static array $koncowki=['ar','ir','er'];

    public function __construct()
    {
        
    }

    /**
     * sprawdzenie czy końcówkaWpisanegoCZasownika znajduje się w $koncowki
     *
     * @param  string  $attribute
     * @param  mixed  $value
     * @return bool
     */
    public function passes($attribute, $value)
    {
        $kocowkaWpisanegoCzasownika=substr($value,-2,2);
        return (in_array($kocowkaWpisanegoCzasownika,self::$koncowki))?true:false;
    }

    /**
     * Get the validation error message.
     *
     * @return string
     */
    public function message()
    {
        return 'Czasownik musi być podanny w bezokoliczniku';
    }
}
