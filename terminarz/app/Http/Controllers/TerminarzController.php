<?php

namespace App\Http\Controllers;

use DateTime;
use App\Models\Task;
use App\Models\User;
use App\Models\Month;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use phpDocumentor\Reflection\Types\Integer;

class TerminarzController extends Controller
{
    /**
     * wyświetlanie terminarza
     *
     * @param User $user
     * @param Month $month
     * @return array
     */
    public function index($user,Month $month)
    {
        //dzisiejsza data
        $dateToday=new DateTime('now');
        $dateToday=$dateToday->format('Y-m-d H:i:s');
        $dateToday=date_parse($dateToday);

        //wszystkie miesiące
        $months=Month::get();

        //id obecnego miesiąca
        $cur_month=$month->id;

        //sprawdzanie nazwy i numeru dnia tygodnia
        function nazwa_dnia($cur_month){

            //dzisiejsza data
            $dateToday=new DateTime('now');
            $date_converted=$dateToday->format('Y-m-d');


            $dateToday=date_parse($date_converted);
            $year=$dateToday['year'];
            
            //miesiąc z parametru


            //sprawdzanie którym dniem tygodnia jest pierwszy dzień obecnego miesiąca
            $check_day=date_create_from_format('Y-m-j',$year.'-'.$cur_month.'-1');
            $check_day=$check_day->format('Y-m-w');
            $check_day=date_parse($check_day);

            //jeżeli dzień tygodnia jest różny od niedzieli
            if($check_day['day']!==0){
                $days_to_skip=$check_day['day']-1;

            //jeżeli dniem tygodnia jest jest niedziela    
            }else{
                $days_to_skip=6;
            }

            //zwracanie skórconej nazwy dnia oraz liczby dni do przeskoczenia w terminarzu (skipped days)
            switch ($check_day['day']) {
           
                case 0:
                    return ["Nd",$days_to_skip];
                    break;
                case 1:
                    return ["Pon",$days_to_skip];
                    break;
                case 2:
                    return ["Wt",$days_to_skip];
                    break;
                case 3:
                    return ["Śr",$days_to_skip];
                    break;
                case 4:
                    return ["Czw",$days_to_skip];
                    break;
                case 5:
                    return ["Pt",$days_to_skip];
                    break;
                                    
                case 6:
                    return ["Sob",$days_to_skip];
                    break;
            }         
        }
        //pobieranie zadań na cały miesiąc
        $tasksForWholeMonth=$this->getParticularMonthTasks($cur_month,$dateToday['year'],auth()->user());

        //pobieranie zadań na poszczególny dzień

        $taskForParticularDay=$this->getParticularDayTasks($dateToday['day'],auth()->user());

        $nazwa_dniai_skip_days=nazwa_dnia($cur_month);

        //liczba dni w obecnym miesiącu
        $days_in_month=cal_days_in_month(CAL_GREGORIAN,$cur_month,$dateToday['year']);

        return view('panel.index',['dateToday'=>$dateToday,'days_in_month'=>$days_in_month,'skipdays'=>$nazwa_dniai_skip_days,
        'months'=>$months,'tasksForWholeMonth'=>$tasksForWholeMonth,'cur_month'=>$cur_month]);
    }
    /**
     * liczba zadań na dany dzień
     *
     * @param  int $chosenDay
     * @param User $user
     * @return int
     */
    public function getParticularDayTasks($chosenDay,User $user) 
    {
        return $user->id;
    }
    /**
     * liczba zadań na dany miesiąc
     *
     * @param int $chosenMonth
     * @param int $chosenYear
     * @param User $user
     * @return array $task_counts
     */
    public function getParticularMonthTasks($chosenMonth,$chosenYear,User $user) 
    {
        //pobieranie zadań do wykonania w wybranym miesiącu
        $tasksForWholeMonth=DB::table('tasks')
                ->where([['user_id','=',$user->id],['month','=',$chosenMonth]])->get(); 

        //jeżeli brak zadań na cały wybrany miesiąc        
        if($tasksForWholeMonth->isEmpty()){        

            return $tasksForWholeMonth=array_fill(1,31,0);
            
        }
        //jeżeli wystapiło przynajmniej jedno zadanie do wykonania w danym misiącu
        else{

            $task_counts=[];
            //wykonanie pętli tyle razy ile jest dni w wybranym miesiącu
            for ($i=1; $i <= cal_days_in_month(CAL_GREGORIAN, intval($chosenMonth),$chosenYear); $i++) { 
                
                $wystapienie=0;
                //dla każdego zadania, sprawdzany jest dzień do którego zostało ono przydzielone 
                foreach ($tasksForWholeMonth as $task) {

                    //jeżeli dzień miesiąca pokrywa się z dniem, na który zostało przydzielone zadanie następuje, zaliczenie wystąpienia
                    if($task->day==$i){
                        $wystapienie+=1;

                        $task_counts[$i]=$wystapienie;
                       
                    }
                    else{

                        $task_counts[$i]??$task_counts[$i]=0;
                    }                
                }
            }
                   
             return $task_counts;   
        }
 
    }
    /**
     * walidacja i wkleianie zadania do tabeli
     *
     * @param Request $request
     * @param User $user
     * @param string $month
     * @return void
     */
    public function store(Request $request,$user, $month)
    {
        //validation
        $validator=Validator::make($request->all(),[
            'task'=>'required|string|max:300'
        ],$messages=[
            'task.required'=>'Pole zadanie musi być wypełnione',
            'task.max'=>'Zadanie nie może przekroczyć 300 znaków'
        ]);
        if($validator->fails()){
            return back()
                ->withErrors($validator)
                ->withInput();
        }

        //creating task
        Task::create([
            'user_id'=>auth()->user()->id,
            'year'=>$request['year'],
            'month'=>$request['month'],
            'day'=>$request['day'],
            'task'=>$request['task']
        ]);
            
        return back();
    }

    /**
     * pokazywanie zadań z wybranego dnia
     *
     * @param User $user
     * @param Month $month
     * @param int $id
     * @return array
     */
    public function show($user,Month $month,$id)
    {   
        //zadania na wybrany dzień
        $tasks_for_chosen_day=DB::table('tasks')->where([['day','=',$id],['month','=',$month->id],['user_id','=',auth()->user()->id]])->get('task');
        
        if($tasks_for_chosen_day->isEmpty()){
            return view('panel.task')->with('noTasks','Brak zadań');
        }else{
            return view('panel.task',['tasks_for_chosen_day'=>$tasks_for_chosen_day]);
        }
     
    }




}
