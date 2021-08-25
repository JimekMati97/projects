<?php

namespace App\Rules;

use Illuminate\Contracts\Validation\Rule;

class Address implements Rule
{
    /**
     * Create a new rule instance.
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
        //address array
        $address_array=explode(',',$value);
        if(count($address_array)!==3){
            return false;
        }else{
            return true;
        }
    }

    /**
     * Get the validation error message.
     *
     * @return string
     */
    public function message()
    {
        return 'Na początku należy podać nazwę miasta, następnie ulicę i numer';
    }
}
