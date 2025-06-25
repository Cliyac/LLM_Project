//return todays date formtted as yyy/mm/dd
String todaysDateFormatted(){
  //today
  var dataTimeObject = DateTime.now();
  //year in the format yyyy
  String year = dataTimeObject.year.toString();

  //month in the format mm
  String month = dataTimeObject.month.toString();
  if(month.length == 1){
    month = '0$month';
  }
  // day in format dd
  String day = dataTimeObject.day.toString();
  if(day.length == 1){
    day = '0$day';
  }
  // final format
  String yyyymmdd = year + month + day;
  return yyyymmdd;
}




//convert string yyyymmdd to DateTime object
DateTime createDateTimeObject(String yyyymmdd){
  int yyyy = int.parse(yyyymmdd.substring(0,4));
  int mm = int.parse(yyyymmdd.substring(4,6));
  int dd = int.parse(yyyymmdd.substring(6,8));


  DateTime dateTimeObject = DateTime(yyyy, mm, dd);
  return dateTimeObject;
}



//convert DateTime object to string yyyymmdd
String convertDateTimeToString(DateTime dateTime){
  //year in the format yyyy
  String year = dateTime.year.toString();

  //month in the format mm
  String month = dateTime.month.toString();
  if(month.length == 1){
    month = '0$month';
  }
  String day = dateTime.day.toString();
  if(day.length == 1){
    day = '0$day';
  }
  String yyyymmdd = year + month + day;
  return yyyymmdd;
}


