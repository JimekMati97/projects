<?php

namespace Database\Factories;

use App\Models\Quiz\Quiz_Runda;
use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Str;
class Quiz_Factory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = App\Models\Quiz\Quiz_Runda::class;

    /**
     * Define the model's default state.
     *
     * @return array
     */
    public function definition()
    {
        return [
            'slowoDoTlumaczenia' => Quiz_Runda::$slowoDoOdgadniecia,
            'dobre_odpowiedzi' => 0,
            'zle_odpowiedzi' => 0
        ];
        
    }
}
