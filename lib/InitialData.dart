class InitialData {
  static double initial_Lat = 0;
  static double initial_Lng = 0;

  ///The number of updates location data
  static int update = 0;

  static void initializeLocationData(double lat, double lng) {
    initial_Lat = lat;
    initial_Lng = lng;
    update = 1;
  }

  ///Reserve Function, Might be deleted later
  ///The location data some time will be delayed,
  ///So it should have second chance to update it again.
  static void reinitializeLocationData(double lat, double lng) {
    if (update == 0 || update == 1) {
      initial_Lat = lat;
      initial_Lng = lng;
      print('： Lat:${lat},Lng:${lng}');
      update++;
    }
  }
}
