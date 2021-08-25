<?php

namespace Database\Seeders;

use App\Models\Panstwo;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
       return Panstwo::factory()->count(100)->create();
    }
}
