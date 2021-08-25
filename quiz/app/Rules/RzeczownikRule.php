<?php

namespace App\Rules;

use Illuminate\Contracts\Validation\Rule;

class RzeczownikRule implements Rule
{
    /**
     * Sprawdzenie czy przed rzeczownikiem znajduje się rodzajnik el, lub la
     *
     * @return void
     */
    public function __construct()
    {
        //
    }

    /**
     * Determine if the validation rule passes.
     *
     * @param  string  $attribute
     * @param  mixed  $value
     * @return bool
     */
    public function passes($attribute, $value)
    {
        
        $pierwszeDwieLitery=substr($value,0,2);
        //$pierwszeTrzyLitery=substr($value,0,2);

        //sprawdzanie czy przed rzeczownikiem jest rodzajnik el
        if($pierwszeDwieLitery=='el'){
            return true;

        //sprawdzanie czy przed rzeczownikiem jest rodzajnik la
        }else if($pierwszeDwieLitery=='la'){
            return true;
        }else{
            return false;
        }
        
        
    }

    /**
     * Get the validation error message.
     *
     * @return string
     */
    public function message()
    {
        return 'Przed rzeczownikiem musi być wpisany rodzajnik el, lub la';
    }
}
