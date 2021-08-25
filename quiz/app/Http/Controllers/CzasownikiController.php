<?php

namespace App\Http\Controllers;


use Illuminate\Http\Request;
use App\Models\Czasowniki\Ar;
use App\Models\Czasowniki\Er;
use App\Models\Czasowniki\Ir;
use App\Models\Czasowniki\Brak;
use App\Models\Czasowniki\EtoI;
use App\Models\Czasowniki\EtoIE;
use App\Models\Czasowniki\OtoUE;
use App\Models\Czasowniki\UtoUY;
use App\Rules\KoncowkaCzasownika;
use Illuminate\Support\Facades\DB;
use App\Models\Czasowniki\CzasownikMix;
use App\Models\Czasowniki\CzasownikModel;
use App\Models\Czasowniki\CzasownikBudowa;

class CzasownikiController extends Controller
{
    /**
     * inicjalizacja opisu Czasownika. opisCzasownika składa się z typu nieregularności oraz typu końcówki czasownika
     *
     * @var array
     */
    public static $opisCzasownika=[];

    /**
     * czasownikiMix, odmiana każdego z nich została przedstawiona w klasie CzasownikMix
     *
     * @var array
     */
    protected static $czasownikiMix=['decir','elegir','oir','tener','venir','jugar'];

    /**
     * czasowniki nieregularne tylko w pierwszej osobie liczby pojedynczej
     *
     * @var array
     */
    protected static $czasownikiNiereg1Os=['caer'=>'caigo','coger'=>'cojo','conducir'=>'conduzo','conocer'=>'conozco','dar'=>'doy','hacer'=>'hago','ofrecer'=>'ofrezco'
    ,'pertenecer'=>'pertenezco','poner'=>'pongo','producir'=>'produzco','saber'=>'sé','salir'=>'salgo','traer'=>'traigo'];
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //wszystkie czasowniki
        $czasowniki=CzasownikModel::all();

        return view('czasowniki/czasowniki',['czasowniki'=>$czasowniki]);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //walidacja pola czasownik, tłumaczenie, option
        $request->validate([
            'czasownik'=>[new KoncowkaCzasownika,'required','regex:/^[a-zA-Z,áéíóúüñ]+$/u','max:20','unique:czasownik_models'],
            'tlumaczenie'=>'required|regex:/^[a-zA-Z,ćśżźóŻŹĆŚęą]+$/u|max:50',
            'option'=>'required'
        ]);

        //wkleienie czasownika, tłumaczenia i wybranej opcji do tabeli czasowniki_models
        $czasowniki=CzasownikModel::create([
            
            'czasownik'=>$request->input('czasownik'),
            'tlumaczenie'=>$request->input('tlumaczenie'),
            'nieregularnosc'=>$request->input('option')[0]
        ]);

        //Sprawdzanie czy czasownik znajduje się w łańcuchu czasowników Nieregeluranych typu mix
        if(in_array($czasowniki->czasownik,self::$czasownikiMix)){

            $czasownikMix=new CzasownikMix();
            $odmianaKoncowki=$czasownikMix->odmien($czasowniki->czasownik);
        
        }
        else{

            //Sprawdzenie czy czasownik jest nieregularny, lub jakiego typu posiada nieregularność
            switch ($czasowniki->nieregularnosc) {
                case 'Brak':
                    
                    $brak=new Brak();
                    self::$opisCzasownika[0]=$brak;
                    break;
                case 'E->I':
                    $EtoI=new EtoI();
                    self::$opisCzasownika[0]=$EtoI;
                    
                    break;
                case 'E->IE':
                    $EtoIE=new EtoIE();
                    self::$opisCzasownika[0]=$EtoIE;
                    
                    break;
                case 'O->UE':
                    $OtoIU=new OtoUE();
                    self::$opisCzasownika[0]=$OtoIU;
                    
                    break;
                case 'ItoY':
                    $ItoY=new UtoUY();
                    
                    self::$opisCzasownika[0]=$ItoY;
                    
                    break;
                default:
                    $brak=new Brak();
                    self::$opisCzasownika[0]=$brak;
                    break;
    
            }

            //odcięcie końcówki czasownika (ar,ir,er)
            $czlon=substr($czasowniki->czasownik,0,-2); 
            
            //wyodrebnienie końcówki czasownika (ar,er,ir)
            $koncowka=substr($czasowniki->czasownik,-2,2);
            
            /**
             * wybór klasy reprezentującej dany styl odmiany dla wyodrębnionej koncówki czasownika
             */
            switch ($koncowka) {
                case 'ar':
                    $ar=new Ar($czlon);
                self::$opisCzasownika[1]=$ar;
                break;
                case 'ir':
                    $ir=new Ir($czlon);
                self::$opisCzasownika[1]=$ir;
                break;
                case 'er':
                    $er=new Er($czlon);
                self::$opisCzasownika[1]=$er;
                break;
            }
            //odmiana czasownika według wybranej nieregularności oraz jego odmiana według końcówki
            $czasownikModel=new CzasownikBudowa(self::$opisCzasownika[0],self::$opisCzasownika[1]);

            $odmianaNieregularna=$czasownikModel->odmienNiereg($czlon);

            $odmianaKoncowki=$czasownikModel->odmien($odmianaNieregularna);


        }
        //Jeżeli czasownik wpisany w polu czasowniki znajduje się w $czasownikiNiereg1Os, 1 osobie liczby pojedynczej zostaje przyporządkowana odmiana
        //o odpowiednim indeksie
        if(in_array($czasowniki->czasownik,array_keys(self::$czasownikiNiereg1Os))){
            $val=self::$czasownikiNiereg1Os[$czasowniki->czasownik];
            $odmianaKoncowki[0]=$val;
        };

        //wkleienie odmian do tabeli czasowniki_odmianas
    
        DB::table('czasownik_odmianas')->insert([
            'czasownik_model_id'=>$czasowniki->id,
            'Pierwszalp'=>$odmianaKoncowki[0],
            'Drugalp'=>$odmianaKoncowki[1],
            'Trzecialp'=>$odmianaKoncowki[2],
            'Pierwszalm'=>$odmianaKoncowki[3],
            'Drugalm'=>$odmianaKoncowki[4],
            'Trzecialm'=>$odmianaKoncowki[5]
        ]);

        //wkleianie do tabeli quiz_models czasownika i jego tłumaczenia
        DB::table('quiz_models')->insert([
    
            'slowo'=>$czasowniki->czasownik,
            'tlumaczenie'=>$czasowniki->tlumaczenie
        ]);

        //Wyświetlanie wyników z bazy danych
        $czasowniki=CzasownikModel::all();
        
        return view('czasowniki/czasowniki',['czasowniki'=>$czasowniki]);
    }

    /**
     * wyswietlanie klikniętego czasownika na osobnej stronie
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //wyświetlanie czasownika, którego id = $id
        $czasownik=CzasownikModel::find($id);

        return view('czasowniki/show')->with('czasownik',$czasownik);
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
