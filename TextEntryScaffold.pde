import java.util.Arrays;
import java.util.Collections;

String[] phrases; //contains all of the phrases
int totalTrialNum = 4; //the total number of phrases to be tested - set this low for testing. Might be ~10 for the real bakeoff!
int currTrialNum = 0; // the current trial number (indexes into trials array above)
float startTime = 0; // time starts when the first letter is entered
float finishTime = 0; // records the time of when the final trial ends
float lastTime = 0; //the timestamp of when the last trial was completed
float lettersEnteredTotal = 0; //a running total of the number of letters the user has entered (need this for final WPM computation)
float lettersExpectedTotal = 0; //a running total of the number of letters expected (correct phrases)
float errorsTotal = 0; //a running total of the number of errors (when hitting next)
String currentPhrase = ""; //the current target phrase
String currentTyped = ""; //what the user has typed so far
final int DPIofYourDeviceScreen = 441; //you will need to look up the DPI or PPI of your device to make sure you get the right scale!!
                                      //http://en.wikipedia.org/wiki/List_of_displays_by_pixel_density
final float sizeOfInputArea = DPIofYourDeviceScreen*1; //aka, 1.0 inches square!
int first_select = 0;
int blink = 0;
int blink_grid = 0;
float dragged_dist = 0;
float mouseXdown = -1;
boolean reset_to_main = false;

final float next_button_global_x = 800;
final float next_button_global_y = 0;
final float next_button_width = 200;
final float next_button_height = 200;

final float letter_region_x = 0;
final float letter_region_y = 0;
final float letter_region_width = sizeOfInputArea;
final float letter_region_height = sizeOfInputArea/2;

final float left_adv_x = 0;
final float left_adv_y = sizeOfInputArea/2;
final float left_adv_width = sizeOfInputArea/2;
final float left_adv_height = sizeOfInputArea/2;

final float right_adv_x = sizeOfInputArea/2;
final float right_adv_y = sizeOfInputArea/2;
final float right_adv_width = sizeOfInputArea/2;
final float right_adv_height = sizeOfInputArea/2;
final float[] right_adv_A = new float[]{200+right_adv_x, 200+right_adv_y, right_adv_width, right_adv_height};

// bottom bar
final float a_x = 0;
final float a_y = 6*sizeOfInputArea/7;
final float a_w = sizeOfInputArea;
final float a_h = sizeOfInputArea/7;
final float[] a_A = new float[]{200+a_x, 200+a_y, a_w, a_h};

// backspace
final float b_x = 0;
final float b_y = 6*sizeOfInputArea/7;
final float b_w = sizeOfInputArea/4;
final float b_h = sizeOfInputArea/7;
final float[] b_A = new float[]{200+b_x, 200+b_y, b_w, b_h};

// spacebar
final float s_x = sizeOfInputArea/4;
final float s_y = 6*sizeOfInputArea/7;
final float s_w = sizeOfInputArea/2;
final float s_h = sizeOfInputArea/7;
final float[] s_A = new float[]{200+s_x, 200+s_y, s_w, s_h};

// main button
final float m_x = 3*sizeOfInputArea/4;
final float m_y = 6*sizeOfInputArea/7;
final float m_w = sizeOfInputArea/4;
final float m_h = sizeOfInputArea/7;
final float[] m_A = new float[]{200+m_x, 200+m_y, m_w, m_h};

final float tl_x = 0;
final float tl_y = 0;
final float tl_w = sizeOfInputArea/2;
final float tl_h = 3*sizeOfInputArea/7;
final float[] tl_A = new float[]{200+tl_x, 200+tl_y, tl_w, tl_h};

final float tr_x = sizeOfInputArea/2;
final float tr_y = 0;
final float tr_w = sizeOfInputArea/2;
final float tr_h = 3*sizeOfInputArea/7;
final float[] tr_A = new float[]{200+tr_x, 200+tr_y, tr_w, tr_h};

final float bl_x = 0;
final float bl_y = 3*sizeOfInputArea/7;
final float bl_w = sizeOfInputArea/2;
final float bl_h = 3*sizeOfInputArea/7;
final float[] bl_A = new float[]{200+bl_x, 200+bl_y, bl_w, bl_h};

final float br_x = sizeOfInputArea/2;
final float br_y = 3*sizeOfInputArea/7;
final float br_w = sizeOfInputArea/2;
final float br_h = 3*sizeOfInputArea/7;
final float[] br_A = new float[]{200+br_x, 200+br_y, br_w, br_h};

final float[] grid_6_x_A = new float[]{0, sizeOfInputArea/3, 2*sizeOfInputArea/3};
final float[] grid_6_y_A = new float[]{0, 3*sizeOfInputArea/7};
final float grid_6_w = sizeOfInputArea/3;
final float grid_6_h = 3*sizeOfInputArea/7;
final String[] input_ABCDEF = new String[]{"A", "B", "C", "D", "E", "F"};
final String[] input_GHIJKL = new String[]{"G", "H", "I", "J", "K", "L"};
final String[] input_MNOPQR = new String[]{"M", "N", "O", "P", "Q", "R"};
final String[] input_STUVWXYZ = new String[]{"S", "T", "U", "V", "W", "XYZ"};
final String[] input_XYZ = new String[]{"X", "Y", "Z", ""};
// lower case strings
final String[] input_ABCDEF_lower = new String[]{"a", "b", "c", "d", "e", "f"};
final String[] input_GHIJKL_lower = new String[]{"g", "h", "i", "j", "k", "l"};
final String[] input_MNOPQR_lower = new String[]{"m", "n", "o", "p", "q", "r"};
final String[] input_STUVWXYZ_lower = new String[]{"s", "t", "u", "v", "w", "xyz"};
final String[] input_XYZ_lower = new String[]{"x", "y", "z", ""};

final float[] grid_4_x_A = new float[]{0, sizeOfInputArea/2};
final float[] grid_4_y_A = new float[]{0, 3*sizeOfInputArea/7};
final float grid_4_w = sizeOfInputArea/2;
final float grid_4_h = 3*sizeOfInputArea/7;
final String[] input_initial = new String[]{"ABCDEF", "GHIJKL", "MNOPQR", "STUVWXYZ"};

//draw grid of equal rectanlges
void draw_grid(float[] start_x_A, float[] start_y_A, float w, float h, String[] text_A){
  int text_i = 0;
  for (float y : start_y_A){
    for (float x : start_x_A){
      fill(0, 0, 255);
      if (blink_grid != -1 && blink_grid == text_i){
        fill(0, 255, 0);
      }
      float[] new_A = new float[]{200+x, 200+y, w, h};
      array_to_rect(new_A);
      fill(255);
      textAlign(CENTER);
      textSize(120); 
      if (text_A[text_i].length() > 1){
        textSize(50); 
      }
      text(text_A[text_i], 200 + x + w/2, 200 + y + h/2 + 20);
      textSize(26); 
      text_i += 1;
    }
  }
}

//draw grid of 6 rectanlges
void draw_grid_6(String[] text_A){
  draw_grid(grid_6_x_A, grid_6_y_A, grid_6_w, grid_6_h, text_A);
}

void draw_grid_4(String[] text_A){
  draw_grid(grid_4_x_A, grid_4_y_A, grid_4_w, grid_4_h, text_A);
}

//draw grid of equal rectanlges
int mouse_click_grid(float[] start_x_A, float[] start_y_A, float w, float h){
  int text_i = 0;
  for (float y : start_y_A){
    for (float x : start_x_A){
      if(didMouseClick(200 + x, 200 + y, w, h)){
        return text_i;
      }
      text_i += 1;
    }
  }
  return -1;
}

int mouse_click_grid_6(){
  return mouse_click_grid(grid_6_x_A, grid_6_y_A, grid_6_w, grid_6_h);
}

int mouse_click_grid_4(){
  return mouse_click_grid(grid_4_x_A, grid_4_y_A, grid_4_w, grid_4_h);
}

//Variables for my silly implementation. You can delete this:
char currentLetter = 'a';

//You can modify anything in here. This is just a basic implementation.
void setup()
{
  phrases = loadStrings("phrases2.txt"); //load the phrase set into memory
  Collections.shuffle(Arrays.asList(phrases)); //randomize the order of the phrases
    
  orientation(PORTRAIT); //can also be LANDSCAPE -- sets orientation on android device
  size(1000, 1000, OPENGL); //Sets the size of the app. You may want to modify this to your device. Many phones today are 1080 wide by 1920 tall.
  textFont(createFont("Arial", 24)); //set the font to arial 24
  noStroke(); //my code doesn't use any strokes.
}

//You can modify anything in here. This is just a basic implementation.
void draw()
{
  background(0); //clear background

 // image(watch,-200,200);
  fill(100);
  rect(200, 200, sizeOfInputArea, sizeOfInputArea); //input area should be 2" by 2"

  if (finishTime!=0)
  {
    fill(255);
    textAlign(CENTER);
    text("Finished", 280, 150);
    float wpm = (lettersEnteredTotal/5.0f)/((finishTime - startTime)/60000f); //FYI - 60K is number of milliseconds in minute
    text("Raw WPM: " + wpm, 280, 190);
    float freebieErrors = lettersExpectedTotal*.05; //no penalty if errors are under 5% of chars
    text("Freebie errors: " + freebieErrors, 280, 240);
    float penalty = max(errorsTotal-freebieErrors,0) * .5f;
    text("Penalty: " + penalty, 280, 280);
    text("WPM w/ penalty: " + (wpm-penalty), 280, 320);
    return;
  }

  if (startTime==0 & !mousePressed)
  {
    fill(255);
    textAlign(CENTER);
    text("Click to start time!", 280, 150); //display this messsage until the user clicks!
  }

  if (startTime!=0)
  {
    //you will need something like the next 10 lines in your code. Output does not have to be within the 2 inch area!
    textAlign(LEFT); //align the text left
    fill(128);
    text("Phrase " + (currTrialNum+1) + " of " + totalTrialNum, 70, 50); //draw the trial count
    fill(255);
    text("Target:   " + currentPhrase, 70, 100); //draw the target string
    String currentTyped_underscore = currentTyped.replaceAll(" ", "_");
    text("Entered:  " + currentTyped_underscore, 70, 140); //draw what the user has entered thus far 
    text("Distance Dragged:  " + dragged_dist, 70, 190); //draw what the user has entered thus far 
    fill(255, 0, 0);
    rect(next_button_global_x, next_button_global_y, next_button_width, next_button_height); //drag next button
    fill(255);
    text("NEXT > ", 850, 100); //draw next label
    //text("first_select:   " + first_select, 270, 200); //draw the target string  

    //my draw code
    stroke(0);
    draw_nav_buttons();
    if (first_select == 0){
      draw_top();
      draw_bottom();
    }else if (first_select == 1){
      draw_grid_6(input_ABCDEF);
    }else if (first_select == 2){
      draw_grid_6(input_GHIJKL);
    }else if (first_select == 3){
      draw_grid_6(input_MNOPQR);
    }else if (first_select == 4){
      draw_grid_6(input_STUVWXYZ);
    }else if (first_select == 99){
      // special case for XYZ
      draw_grid_4(input_XYZ);
    }
    if (blink != 0){
      fill(0, 255, 0);
      if (blink == 1){
        array_to_rect(tl_A);
      }else if (blink == 2){
        array_to_rect(tr_A);
      }else if (blink == 3){
        array_to_rect(bl_A);
      }else if (blink == 4){
        array_to_rect(br_A);
      }
      blink = 0;
    }
    
    if (blink_grid != -1){
      draw_grid_6(input_ABCDEF);
      blink_grid = -1;
    }
   
    noStroke();    
  }
  
}

void array_to_rect(float[] A){
  rect(A[0], A[1], A[2], A[3]); //draw right green button
}

void draw_six(){
  fill(125, 125, 125);
  array_to_rect(tl_A);
  fill(0, 125, 125);
  array_to_rect(tr_A);
  fill(125, 0, 125);
  array_to_rect(bl_A);
  fill(125, 125, 0);
  array_to_rect(br_A);
}

void draw_nav_buttons(){
  fill(0, 0, 255);
  //array_to_rect(a_A);
  array_to_rect(b_A);
  array_to_rect(s_A);
  array_to_rect(m_A);
  fill(255);
  textAlign(CENTER);
  textSize(25); 
  text("⇐", 200 + b_x + b_w/2, 200 + b_y + b_h/2);
  text("space", 200 + s_x + s_w/2, 200 + s_y + s_h/2);
  text("Menu", 200 + m_x + m_w/2, 200 + m_y + m_h/2);
  textSize(26); 
}

void draw_top(){
  fill(255, 0, 0);
  array_to_rect(tl_A);
  array_to_rect(tr_A);
  fill(255);
  textAlign(CENTER);
  textSize(50); 
  text("ABCDEF", 200 + tl_x + tl_w/2, 200 + tl_y + tl_h/2);
  text("GHIJKL", 200 + tr_x + tr_w/2, 200 + tr_y + tr_h/2);
  textSize(26); 
}

void draw_bottom(){
  fill(255, 0, 0);
  array_to_rect(bl_A);
  array_to_rect(br_A);
  fill(255);
  textAlign(CENTER);
  textSize(45); 
  text("MNOPQR", 200 + bl_x + bl_w/2, 200 + bl_y + bl_h/2);
  text("STUV-Z", 200 + br_x + br_w/2, 200 + br_y + br_h/2);
  textSize(26); 
}

boolean didMouseClick(float x, float y, float w, float h) //simple function to do hit testing
{
  return (mouseX > x && mouseX<x+w && mouseY>y && mouseY<y+h); //check to see if it is in button bounds
}

boolean didMouseClick2(float[] A) //simple function to do hit testing
{
  return didMouseClick(A[0], A[1], A[2], A[3]);
}

void mouseReleased(){
  if (mouseXdown >= 0){
    // swipe left
    if ((mouseX - mouseXdown) < -200){
      dragged_dist = abs(mouseX - mouseXdown);
      if (currentTyped.length()>0){
        currentTyped = currentTyped.substring(0, currentTyped.length()-1);
      }  
    }
    // swipe right
    if ((mouseX - mouseXdown) > 200){
      dragged_dist = abs(mouseX - mouseXdown);
      currentTyped+=" ";  
    }
  }
}

void mousePressed()
{
  mouseXdown = mouseX;
  if (startTime==0 & mousePressed)
  {
    nextTrial(); //start the trials!
    first_select = 0;
    return;
  }
  
  // backspace button
  if (didMouseClick2(b_A))
  {
    if (currentTyped.length()>0){
      currentTyped = currentTyped.substring(0, currentTyped.length()-1);
    }
  }
  
  // spacebar button
  if (didMouseClick2(s_A))
  {
    currentTyped+=" ";
  }
  
  // main button
  if (didMouseClick2(m_A)) 
  {
   reset_to_main = true;
  }
  
  if (first_select == 1){
    int grid_region_clicked = mouse_click_grid_6();
    if (grid_region_clicked != -1){
      currentTyped+= input_ABCDEF_lower[grid_region_clicked];
      reset_to_main = true;
      blink_grid = grid_region_clicked;
    }
  }
  
  if (first_select == 2){
    int grid_region_clicked = mouse_click_grid_6();
    if (grid_region_clicked != -1){
      currentTyped+= input_GHIJKL_lower[grid_region_clicked];
      reset_to_main = true;
      blink_grid = grid_region_clicked;
    }
  }
  
  if (first_select == 3){
    int grid_region_clicked = mouse_click_grid_6();
    if (grid_region_clicked != -1){
      currentTyped+= input_MNOPQR_lower[grid_region_clicked];
      reset_to_main = true;
      blink_grid = grid_region_clicked;
    }
  }
  
  // special case for XYZ
  if (first_select == 99){
    int grid_region_clicked = mouse_click_grid_4();
    if (grid_region_clicked != -1){
      currentTyped+= input_XYZ_lower[grid_region_clicked];
      reset_to_main = true;
      blink_grid = grid_region_clicked;
    }
  }
  
  if (first_select == 4){
    int grid_region_clicked = mouse_click_grid_6();
    if (grid_region_clicked == 5){
      first_select = 99;
      blink_grid = grid_region_clicked;
    }
    else if (grid_region_clicked != -1){
      currentTyped+= input_STUVWXYZ_lower[grid_region_clicked];
      reset_to_main = true;
      blink_grid = grid_region_clicked;
    } 
  }
  
  
  if (first_select == 0){
    // ABCDEF
    if (didMouseClick2(tl_A))
    {
      first_select = 1;
      blink = 1;
    }
    // GHIJKL
    if (didMouseClick2(tr_A)) 
    {
      first_select = 2;
      blink = 2;
    }
    // MNOPQR
    if (didMouseClick2(bl_A))
    {
      first_select = 3;
      blink = 3;
    }
    // STUVWXYZ
    if (didMouseClick2(br_A)) 
    {
      first_select = 4;
      blink = 4;
    }
  }
 


  //You are allowed to have a next button outside the 2" area
  if (didMouseClick(next_button_global_x, next_button_global_y, next_button_width, next_button_height)) //check if click is in next button
  {
    nextTrial(); //if so, advance to next trial
    reset_to_main = true;
  }
  
  // return back to main menu
  if (reset_to_main){
    first_select = 0;
    reset_to_main = false;
  }
}


void nextTrial()
{
  if (currTrialNum >= totalTrialNum) //check to see if experiment is done
    return; //if so, just return

    if (startTime!=0 && finishTime==0) //in the middle of trials
  {
    System.out.println("==================");
    System.out.println("Phrase " + (currTrialNum+1) + " of " + totalTrialNum); //output
    System.out.println("Target phrase: " + currentPhrase); //output
    System.out.println("Phrase length: " + currentPhrase.length()); //output
    System.out.println("User typed: " + currentTyped); //output
    System.out.println("User typed length: " + currentTyped.length()); //output
    System.out.println("Number of errors: " + computeLevenshteinDistance(currentTyped.trim(), currentPhrase.trim())); //trim whitespace and compute errors
    System.out.println("Time taken on this trial: " + (millis()-lastTime)); //output
    System.out.println("Time taken since beginning: " + (millis()-startTime)); //output
    System.out.println("==================");
    lettersExpectedTotal+=currentPhrase.length();
    lettersEnteredTotal+=currentTyped.length();
    errorsTotal+=computeLevenshteinDistance(currentTyped.trim(), currentPhrase.trim());
  }

  //probably shouldn't need to modify any of this output / penalty code.
  if (currTrialNum == totalTrialNum-1) //check to see if experiment just finished
  {
    finishTime = millis();
    System.out.println("==================");
    System.out.println("Trials complete!"); //output
    System.out.println("Total time taken: " + (finishTime - startTime)); //output
    System.out.println("Total letters entered: " + lettersEnteredTotal); //output
    System.out.println("Total letters expected: " + lettersExpectedTotal); //output
    System.out.println("Total errors entered: " + errorsTotal); //output
    
    float wpm = (lettersEnteredTotal/5.0f)/((finishTime - startTime)/60000f); //FYI - 60K is number of milliseconds in minute
    System.out.println("Raw WPM: " + wpm); //output
    
    float freebieErrors = lettersExpectedTotal*.05; //no penalty if errors are under 5% of chars
    
    System.out.println("Freebie errors: " + freebieErrors); //output
    float penalty = max(errorsTotal-freebieErrors,0) * .5f;
    
    System.out.println("Penalty: " + penalty);
    System.out.println("WPM w/ penalty: " + (wpm-penalty)); //yes, minus, becuase higher WPM is better
    System.out.println("==================");
    
    currTrialNum++; //increment by one so this mesage only appears once when all trials are done
    return;
  }

  if (startTime==0) //first trial starting now
  {
    System.out.println("Trials beginning! Starting timer..."); //output we're done
    startTime = millis(); //start the timer!
  }
  else
  {
    currTrialNum++; //increment trial number
  }

  lastTime = millis(); //record the time of when this trial ended
  currentTyped = ""; //clear what is currently typed preparing for next trial
  currentPhrase = phrases[currTrialNum]; // load the next phrase!
  //currentPhrase = "abc"; // uncomment this to override the test phrase (useful for debugging)
}



//=========SHOULD NOT NEED TO TOUCH THIS METHOD AT ALL!==============
int computeLevenshteinDistance(String phrase1, String phrase2) //this computers error between two strings
{
  int[][] distance = new int[phrase1.length() + 1][phrase2.length() + 1];

  for (int i = 0; i <= phrase1.length(); i++)
    distance[i][0] = i;
  for (int j = 1; j <= phrase2.length(); j++)
    distance[0][j] = j;

  for (int i = 1; i <= phrase1.length(); i++)
    for (int j = 1; j <= phrase2.length(); j++)
      distance[i][j] = min(min(distance[i - 1][j] + 1, distance[i][j - 1] + 1), distance[i - 1][j - 1] + ((phrase1.charAt(i - 1) == phrase2.charAt(j - 1)) ? 0 : 1));

  return distance[phrase1.length()][phrase2.length()];
}