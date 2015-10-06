
public float haversine(float lon1, float lon2, float lat1, float lat2) {  //haversine code from sketch by Steven Kay
  // works out the distance between two latitude/longitude pairs
  float dlon=lon1-lon2;
  float dlat=lat1-lat2; 
  float a = sq(sin(dlat/2.0)) + cos(lat1) * cos(lat2) * sq(sin(dlon/2));
  float c = 2.0 * asin(min(1.0, sqrt(a)));
  return  256.0 * c;
} 

public float calcAngle(float myLon, float hisLon, float myLat, float hisLat) { 
  float objectAngle = atan2(hisLon-myLon, hisLat-myLat);
  objectAngle *= 180/PI;
  float angle = objectAngle - myAngleReal;
  angle = (angle + 360) % 360;
  return angle;
}
