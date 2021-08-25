<?php

namespace App\Rules;

use Illuminate\Support\Facades\DB;
use Illuminate\Contracts\Validation\Rule;

class QuizRule implements Rule
{

    private $slowoDoPrzetlumaczenia;
    public function __construct($slowoDoPrzetlumaczenia)
    {
        $this->slowoDoPrzetlumaczenia=$slowoDoPrzetlumaczenia;
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
        
        $tlumaczenie=DB::select('select tlumaczenie from quiz_models where slowo = :value', ['value'=>$value]);
        //jeżeli wystepuje chociaż jedno tlumaczenie, nastepuje sprawdzenie czy jesto ono takie same jak $slowoDoPrzetlumaczenia w tabeli quiz_rundas
        if(count($tlumaczenie)>0){
           
            if($tlumaczenie[0]->tlumaczenie==$this->slowoDoPrzetlumaczenia[0]->slowoDoTlumaczenia){

                //jeżeli slowo zostało odgadnięte, to zostaje ono usunięte z puli słów do tłumaczenia
                DB::table('quiz_gras')->where('slowoDoTlumaczenia','=',$this->slowoDoPrzetlumaczenia[0]->slowoDoTlumaczenia)->delete();
                $slowaDoOdgadniecia=DB::table('quiz_models')->get('tlumaczenie');

                return true;
            }else{
                //niepoprawna odpowwiedż w quizie
                $_SESSION['niezeruj']='niezeruj';
                return false;
            }

        }else{
            //niepoprawna odpowwiedż w quizie
            $_SESSION['niezeruj']='niezeruj';
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
        return 'Niepoprawne tlumaczenie';
    }
}
