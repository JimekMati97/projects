<?php

namespace App\Http\Controllers;

use App\Rules\QuizRule;
use Illuminate\Http\Request;
use App\Models\CzasownikModel;
use App\Models\Quiz\Quiz_Runda;
use Illuminate\Support\Facades\DB;
use App\Models\Rzeczowniki\RzeczownikiModel;
use Mockery\Undefined;

use function PHPUnit\Framework\isEmpty;
session_start();
class QuizController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    
    public function index()
    {
        
        $slowaDoOdgadniecia=DB::table('quiz_models')->get('tlumaczenie');
        //sprawdzenie czy zostały dodane jakiekolwiek czasowniki i rzeczowniki
        if($slowaDoOdgadniecia->isEmpty()){
            return view('quiz/dodajSlowo');
        }else{
             //slowo aktualnie wyświetlane w quizie
             $quiz__rundas=DB::table('quiz__rundas')->get('slowoDoTlumaczenia');
            
             //jeżeli brak rekordu w tabeli quiz_rundas, nastąpi wkleienie słowa początkowego do quizu
             if($quiz__rundas->isEmpty()){

                 DB::table('quiz__rundas')->insert([
                     'slowoDoTlumaczenia'=>'starter'
               ]);
                    
            }
            
            //sprawwdzanie czy quiz_gras jest puste
            $slowa_quiz_gras=DB::table('quiz_gras')->get('slowoDoTlumaczenia');

            if($slowa_quiz_gras->isEmpty()){
                //usunięcie zmiennej sesyjnej o zakazie usuwania zawartości tabeli quiz_gras
               unset($_SESSION['niezeruj']);

            }
            //jeżeli nie ma zakazu usuwania zawartości tabeli quiz_gras

            if(!isset($_SESSION['niezeruj'])){
                
                //usuwanie rekordów tabeli
                DB::table('quiz_gras')->truncate();
            
                //tworzenie puli slow
                foreach ($slowaDoOdgadniecia as $slowo){
                    DB::table('quiz_gras')->insert([
                        'slowoDoTlumaczenia'=>$slowo->tlumaczenie
                    ]);
                }
                unset($_SESSION['niezeruj']);
             
            }
                //pula słów do zgadnięcia
                $slowaDoOdgadniecia=DB::table('quiz_gras')->get('slowoDoTlumaczenia');

                $slowa=[];
                foreach($slowaDoOdgadniecia as $slowo){
                    $slowa[$slowo->slowoDoTlumaczenia]=$slowo->slowoDoTlumaczenia;
                }
                //wymieszanie puli słów
                shuffle($slowa);
                
                //aktulaizacja wyświetlanego słowa do zgadnięcia
                DB::table('quiz__rundas')->where('id',1)->update([
                    'slowoDoTlumaczenia'=>$slowa[0]
                ]);
        
                return view('quiz/quiz',['slowa'=>$slowa]);
                    
        }

        
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {   

        $slowoDoOdgadniecia=DB::table('quiz__rundas')->where('id',1)->get('slowoDoTlumaczenia');
        
        //sprawdzenie poprawnosci odpowiedzi w bazie danych
        $request->validate([
            'odpowiedz'=>[new QuizRule($slowoDoOdgadniecia),'required','string']
        ]);

        $slowaDoOdgadniecia=DB::table('quiz_models')->get('tlumaczenie');

        //jeżeli brak rekordu w tabeli quiz_rundas, nastąpi wkleienie słowa początkowego do quizu
        if($slowaDoOdgadniecia->isEmpty()){

            DB::table('quiz__rundas')->insert([
                'slowoDoTlumaczenia'=>'starter'
            ]);

        }

        $slowaDoOdgadniecia=DB::table('quiz_gras')->get('slowoDoTlumaczenia');
        //pula słów do zgadnięcia
        $slowa=[];
        foreach($slowaDoOdgadniecia as $slowo){
            $slowa[$slowo->slowoDoTlumaczenia]=$slowo->slowoDoTlumaczenia;
        }

        //wymieszanie puli słów
        shuffle($slowa);

        //jeżeli nie ma słów do przetłumaczenia, nastepuje przekierowanie do koniecGry.php
        if(array_keys($slowa)==false){
            return view('quiz/koniecGry');
        }

        //aktulaizacja wyświetlanego słowa do zgadnięcia
        DB::table('quiz__rundas')->where('id',1)->update([
            'slowoDoTlumaczenia'=>$slowa[0]
        ]);
      
        return view('quiz/quiz',['slowa'=>$slowa,]);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }
}
