import 'package:hive_flutter/hive_flutter.dart';
import 'package:main_project/datetime/date_time.dart';
//reference our box
final _myBox = Hive.box("Habit_Database");

class HabitDatabase{
  List todaysHabitList = [];
  Map<DateTime,int> heatMapDataSet = {};
  //create initial default data
  void createDefaultData(){
    todaysHabitList = [
      ["Run",false],
      ["read",false],
    ];
    _myBox.put("START_DATE",todaysDateFormatted());
}
  //load data if it is already exist
  void loadData(){
  //if it's a new day,get habit list from database
    if(_myBox.get(todaysDateFormatted()) == null){
      todaysHabitList = _myBox.get("CURRENT_HABIT_LIST");
      //set all habit completed to false since it's a new day
      for(int i = 0; i < todaysHabitList.length; i++){
        todaysHabitList[i][1] = false;
      }
    }

    //if it's not a new day,load todays list
    else{
      todaysHabitList = _myBox.get(todaysDateFormatted());
    }
}
  //update database
  void updateDatabase(){
    //update todays entry
    _myBox.put(todaysDateFormatted(),todaysHabitList);
    //update  universal habit list in case it changed(new habit,edit habit.delete habit)
    _myBox.put("CURRENT_HABIT_LIST", todaysHabitList);

    //calculate habit complete percentages for each day
    calculateHabitPercentage();
    //load heat map
    loadHeatMap();
}
void calculateHabitPercentage(){
    int countCompleted = 0;
    for(int i=0;i<todaysHabitList.length;i++){
      if(todaysHabitList[i][1]== true){
        countCompleted++;
      }
    }
    String percent = todaysHabitList.isEmpty
        ? '0.0'
        :(countCompleted/todaysHabitList.length).toStringAsFixed(1);

    //key:"PERCENTAGE_SUMMARY_YYYYMMDD"
    //value :string of 1dp number between 0.0-1.0 incluxive
    _myBox.put("PERCENTAGE_SUMMARY_${todaysDateFormatted()}",percent);
}
void loadHeatMap(){
  DateTime startDate = createDateTimeObject(_myBox.get("START_DATE"));

  //count the no of days to load
  int daysInBetween = DateTime.now().difference(startDate).inDays;

  //go from start date to today and add each percentage to dataset
  //"PERCENTAGE_SUMMARY_yyyymmdd"will be the key in database
  for(int i =0;i < daysInBetween+1;i++){
    String yyyymmdd = convertDateTimeToString(
      startDate.add(Duration(days : i)),
    );
    double strengthAsPercent = double.parse(_myBox.get("PERCENTAGE_SUMMARY_$yyyymmdd")??"0.0",);
    //split the date time up like below so it doesnt worry about hours minute seconds etc

    //year
    int year = startDate.add(Duration(days: i)).year;
    //month
    int month = startDate.add(Duration(days: i)).month;
    //day
    int day = startDate.add(Duration(days: i)).day;
    final percentForEachDay = <DateTime,int>{
      DateTime(year,month,day): (10 * strengthAsPercent).toInt(),
  };
    heatMapDataSet.addEntries(percentForEachDay.entries);
    print(heatMapDataSet);
  }
}

}