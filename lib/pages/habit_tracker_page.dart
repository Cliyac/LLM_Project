import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:main_project/component/month_summary.dart';
import 'package:main_project/component/my_fab.dart';
import 'package:main_project/component/my_alert_box.dart';
import 'package:main_project/component/habit_tile.dart';
import 'package:main_project/data/habit_database.dart';

class HabitTrackerPage extends StatefulWidget {
  const HabitTrackerPage({super.key});

  @override
  State<HabitTrackerPage> createState() => _HabitTrackerPageState();
}

class _HabitTrackerPageState extends State<HabitTrackerPage> {
  //data structure for todays list
 HabitDatabase db = HabitDatabase();
 final _myBox = Hive.box("Habit_Database");

 @override
  void initState() {
   //if there is no current habit list,then it is the first time ever opening the app
   //then create default  data
   if (_myBox.get("CURRENT_HABIT_LIST")==null){
     db.createDefaultData();
   }
   // there already exist data,this is not the first time
   else{
     db.loadData();
   }
   //update the database
   db.updateDatabase();

    super.initState();

  }

//bool to control habit completed
  //bool habitCompleted= false;

  //checkbox was tapped
  void checkBoxTapped(bool? value,int index){
    setState(() {

      db.todaysHabitList[index][1] = value;
    });
    db.updateDatabase();
  }

  //create a new habit
  final _newHabitNameController =TextEditingController();
  void createNewHabit(){
    //show alert dialog for user to enter the new habit details
    showDialog(
      context: context,
      builder: (context) {
      return MyAlertBox(
        controller: _newHabitNameController,
        onSave: saveNewHabit,
        onCancel: cancelDialogBox,
        hintText: "Enter Habit...."
      );
      },
    );
  }
  //save new habit
  void saveNewHabit(){
    //add new habit to todays habit list
    setState(() {
      db.todaysHabitList.add([_newHabitNameController.text,false]);
    });

    //clear textfield
    _newHabitNameController.clear();
    //pop dailogbox
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  //cancel new habit
  void cancelDialogBox(){
    //clear textfield
    _newHabitNameController.clear();
    //pop dailogbox
    Navigator.of(context).pop();
  }
  //openhabitsettings to edit
  void openHabitSettings(int index){
    showDialog(context: context, builder: (context){
      return MyAlertBox(
          controller: _newHabitNameController,
          onSave: () => saveExistingHabit(index),
          onCancel: cancelDialogBox,
          hintText: db.todaysHabitList[index][0],
      );
    },
    );
  }
  //save existing habit with a new name
  void saveExistingHabit(int index){
    setState(() {
      db.todaysHabitList[index][0] = _newHabitNameController.text;
    });
    _newHabitNameController.clear();
    Navigator.pop(context);
    db.updateDatabase();

  }
  //delete habit
  void deleteHabit(int index){
    setState(() {
      db.todaysHabitList.removeAt(index);
    });
    db.updateDatabase();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[300],
      floatingActionButton: MyFloatingActionButton(
        onPressed:createNewHabit),
      body: ListView(
        children: [
          //monthly summary heatmap
          MonthlySummary(datasets: db.heatMapDataSet, startDate: _myBox.get("START_DATE")),
          //list of habits
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: db.todaysHabitList.length,
            itemBuilder: (context, index){
              return HabitTile(
                habitName: db.todaysHabitList[index][0],
                habitCompleted: db.todaysHabitList[index][1],
                onChanged: (value) => checkBoxTapped(value,index),
                settingsTapped: (context) => openHabitSettings(index),
                deleteTapped: (context) => deleteHabit(index),
              );
            },

          ),
        ],
      )

    );
  }
}

