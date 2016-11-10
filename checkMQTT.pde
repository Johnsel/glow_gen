import mqtt.*;

MQTTClient client;

String[]  receivedMQTT = new String[6];

int tripodNumberReceived; 
int tubeModulusReceived;
int tubeNumberReceived;
int sideTouchedReceived;
int payLoadReceived;

void checkMQTT() {

  //tripods/0/tube/0/side/0
}

void messageReceived(String topic, byte[] payload) {

  //println("new message: " + topic + " - " + new String(payload));

  //Send direct to tube with tubenumber

  String[] receivedMQTT = split(topic, '/');

  tripodNumberReceived = Integer.parseInt(receivedMQTT[1]);

  tubeModulusReceived = Integer.parseInt(receivedMQTT[3]);

  sideTouchedReceived = Integer.parseInt(receivedMQTT[5]);
  
  //println(tripodNumberReceived + "," + tubeModulusReceived + "," + sideTouchedReceived);

  payLoadReceived = int(payload[0]) - 48;

  tubeNumberReceived = tripodNumberReceived*3 + tubeModulusReceived;

  if (payLoadReceived == 1) {
    tubes[tubeNumberReceived].isTouched(sideTouchedReceived);
  }

  if (payLoadReceived == 0) {
    tubes[tubeNumberReceived].isUnTouched(sideTouchedReceived);
  }
}