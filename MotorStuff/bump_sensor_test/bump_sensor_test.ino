int bump;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);           // set up Serial library at 9600 bps

  pinMode(2, INPUT);
  pinMode(3,OUTPUT);
  digitalWrite(2, HIGH);
}


void loop() {
  // put your main code here, to run repeatedly:
  bump=digitalRead(3);
  
  Serial.println(bump +" "+ digitalRead(2));
 
  
}
