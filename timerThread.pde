//written after http://processing.org/discourse/beta/num_1213599231.html  forum answer

class TimerThread extends Thread {

  boolean running = false;

  long previousTime;

  boolean isActive = true;

  double interval;
  double total_time_passed_real;
  double total_time_passed_ideal;
  double timing_error;
  double bpm = 0;
  int task = 0;

  boolean finishedJob = false;

  TimerThread(double new_bpm)
  {
    bpm = new_bpm;
    interval = (1000.0 / (bpm /240)) / 96;
    previousTime = System.nanoTime();
  }

  void set_bpm(double new_bpm)
  {
    bpm = new_bpm;
    interval = (1000.0 / (bpm / 240)) / 96;
    total_time_passed_real = 0; 
    total_time_passed_ideal = 0;
  }

  void run() 
  {

    long rest_period = 0;

    while (this.isActive)
    {
      if (this.running)
      {
        // put the task here

        if (!finishedJob) {
         // in here
         
        if (task == 1){ getData(); 
            if (sendDataToMax){ sendLine();}
        }
        else if (task == 2) greetingManager();
        else if (task == 3) { 
                for (int i = 0; i<trainLines.length; i++){
                   for (int j = 0; j<myTrain[i].length;j++){
                     myTrain[i][j].update();  
                   /*  if (myTrain[i][j].triggerCounter-- <= 0)
                         {
                        myTrain[i][j].trigger(); 
                        myTrain[i][j].triggerReset();
                       }*/
                    }
                }
        } 
         
         finishedJob = true;
        }


        // calculate time difference since last beat & wait 
        double timePassed = (System.nanoTime()-previousTime)*1.0e-6;

        // sleep for a while 
        rest_period = (long) (interval *.75);
        try 
        {
          if ((rest_period > 1) && (timePassed < rest_period)) 
            finishedJob = false;            
          Thread.sleep(rest_period);
        }
        catch(InterruptedException e)
        {
          println("force quit....");
        }

        // wake up a little early and watch the alarm clock 
        while (timePassed < (interval - timing_error))
        {   
          timePassed = (System.nanoTime()-previousTime)*1.0e-6;
        }
        previousTime = System.nanoTime();

        total_time_passed_real += timePassed;
        total_time_passed_ideal += interval;

        // if more time has passed between notes than should have passed, then slow things down a little 
        timing_error = total_time_passed_real - total_time_passed_ideal;
      }
      else {
        try { 
          Thread.sleep(100);
        }
        catch(InterruptedException e) {
        }
      }
    }
  }

  void do_stop()
  {
    this.running = false;
  }

  void do_start()
  {
    total_time_passed_real = 0;
    total_time_passed_ideal = 0;
    previousTime = System.nanoTime();
    this.running = true;
  }
}           

