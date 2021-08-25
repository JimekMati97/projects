<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCzasownikOdmianasTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('czasownik_odmianas', function (Blueprint $table) {
           
            $table->increments('id');
            $table->unsignedInteger('czasownik_model_id');
            $table->string('Pierwszalp');
            $table->string('Drugalp');
            $table->string('Trzecialp');
            $table->string('Pierwszalm');
            $table->string('Drugalm');
            $table->string('Trzecialm');
            $table->foreign('czasownik_model_id')
            ->references('id')
            ->on('czasownik_models')
            ->onDelete('cascade');

        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('czasownik_odmianas');
    }
}
