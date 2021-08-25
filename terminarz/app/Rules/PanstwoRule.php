<?php

namespace App\Rules;

use Illuminate\Contracts\Validation\Rule;
use App\Http\Controllers\RegisterController;

class PanstwoRule implements Rule
{
    /**
     * Create a new rule instance.
     *
     * @return void
     */
    private array $countries;

    public function __construct(array $countries)
    {
        $this->countries=$countries;
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
        $country_names=[];

            for ($i=0; $i < count($this->countries[0]); $i++) { 

                $country_names[$i]=$this->countries[0][$i]['nazwa'];

            }
  
        if(in_array($value,$country_names)){
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
        
        return 'Nie wybrano państwa';
    }
}
