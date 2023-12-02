#include <ArduinoJson.h>
#include <ArduinoJson.hpp>

#include <WebSocketsServer.h>
#include <WiFi.h>

#define PIN_GPIO35 35

WebSocketsServer webSocket = WebSocketsServer(81);
const char* wifiName = "GratisJR";
const char* wifiPassword = "soypobre";

void setup() {
  Serial.begin(9600);
  delay(10);

  pinMode(19, OUTPUT);
  Serial.println();
  Serial.println();
  Serial.print("Contectado al wiffi");
  WiFi.begin(wifiName, wifiPassword);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
    if (WiFi.status() == WL_CONNECT_FAILED || WiFi.status() == WL_NO_SSID_AVAIL) {
      Serial.println("Error al conectar a la red Wi-Fi. Verifica la configuración.");
    }
  }

  Serial.println("Connexion Exitosa!!!");
  Serial.println(WiFi.localIP());

  webSocket.begin();
  webSocket.onEvent(onEvent);
}

void onBeatDetected()
{
  Serial.println("Beat Detected!");
}

uint8_t idChannel = 255;
void onEvent(uint8_t num, WStype_t type, uint8_t* payload, size_t length) {
  Serial.printf("[%u] Tipo!!!", type);
  switch (type) {
    case WStype_DISCONNECTED:
      Serial.printf("[%u] Disconnected!\n", num);
      idChannel = 255;
      break;
    case WStype_CONNECTED:
      {
        IPAddress ip = webSocket.remoteIP(num);
        Serial.printf("[%u] Connected from %d url: %s\n", num, ip, payload);
        idChannel = num;
        DynamicJsonDocument jsonDoc(200);
        jsonDoc["event"] = "Connected";

        String jsonString;
        serializeJson(jsonDoc, jsonString);
        webSocket.sendTXT(num, jsonString);
      }
      break;
    case WStype_TEXT:
      Serial.printf("[%u] get Text: %s\n", num, payload);
      break;
    case WStype_BIN:
      Serial.printf("[%u] get binary length: %u\n", num, length);
      break;
    case WStype_ERROR:
    case WStype_FRAGMENT_TEXT_START:
    case WStype_FRAGMENT_BIN_START:
    case WStype_FRAGMENT:
    case WStype_FRAGMENT_FIN:
      break;
  }
}

uint32_t tsLastReport = 0;
#define REPORTING_PERIOD_MS 1000

void loop() {
  webSocket.loop();
  int lectura = analogRead(PIN_GPIO35);

  static unsigned long startTime = millis(); // Guarda el tiempo de inicio
  unsigned long currentTime = millis(); // Obtiene el tiempo actual

  if (idChannel == 255) {
    if(currentTime - startTime >= 3000) {
      Serial.println("Required Conexion of Client");
      startTime = currentTime;
    }
  } else {
    bool status = webSocket.clientIsConnected(idChannel);
    if (!status) {
      Serial.println("Client not connected");
    } else {
      Serial.println(lectura);
      sendValue(lectura);
    }
  }
  
  delay(40);
}

void sendValue(int value) {
  DynamicJsonDocument jsonDoc(200);
  jsonDoc["event"] = "Pulser";
  jsonDoc["value"] = value;

  // Serialize the JSON object to a string
  String jsonString;
  serializeJson(jsonDoc, jsonString);
  webSocket.sendTXT(idChannel, jsonString);
}