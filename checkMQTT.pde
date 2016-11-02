import mqtt.*;

MQTTClient client;

String[]  receivedMQTT = new String[6];

int tripodNumberReceived; 
int tubeModulusReceived;
int tubeNumberReceived;
int sideTouchedReceived;
int payLoadReceived;

void checkMQTT() {
  for (int i = 0; i < numTripods; i++) {
    for (int j = 0; j < 3; j++) {
      for (int k = 0; k < 2; k++) {
        //println(
        client.subscribe("tripods/" + i + "/tube/" + j + "/side/" + k);
      }
    }
  }
  //tripods/0/tube/0/side/0
}

void messageReceived(String topic, byte[] payload) {
  
  println("new message: " + topic + " - " + new String(payload));
  
  //Send direct to tube with tubenumber
  
  String[] receivedMQTT = split(topic, '/');
  
  payLoadReceived = int(payload[0]);
  
  tripodNumberReceived = Integer.parseInt(receivedMQTT[1]);
  
  tubeModulusReceived = Integer.parseInt(receivedMQTT[3]);
  
  sideTouchedReceived = Integer.parseInt(receivedMQTT[5]);
  
  tubeNumberReceived = tripodNumberReceived*3 + tubeModulusReceived;
  
  if (payLoadReceived == 1){
  tubes[tubeNumberReceived].isTouched(sideTouchedReceived);
  }
  
  if (payLoadReceived == 0){
    tubes[tubeNumberReceived].isUnTouched(sideTouchedReceived);
  }
  
}