volatile int IRQcount; // value may change between different accesses, even if it does not appear to be modified
int pin_irq = 3; //pin for the interupt
int angle = 360;
int anglespaces = 12;
int delayer = 25;
float rads;

void setup() {
  // put your setup code here, to run once:
  Serial.begin (9600);
  attachInterrupt(digitalPinToInterrupt(pin_irq), IRQcounter, RISING);
}

void IRQcounter() {
  IRQcount++;
}

void loop() {
  // put your main code here, to run repeatedly:

  cli();//flag to disable interrupts
  IRQcount = 0;//reset timer
  sei();//flag to enable interrupts

  delay(delayer);

  cli();
  int result = IRQcount;//take number of tick
  sei();

  Serial.print(F("velocity = "));//print the velocity
  rads=angle/anglespaces*result/delayer*1000;
  Serial.println(rads);
}