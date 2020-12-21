//
//  ViewController.swift
//  CrossStreetAPP
//
//  Created by Edward Jimenez on 20/12/2020.
//  Copyright © 2020 Edward Jimenez. All rights reserved.
//

import UIKit
import AudioToolbox
import CocoaMQTT

class ViewController: UIViewController {
    
    // set MQTT Client Configuration
    let clientID = "CocoaMQTT-" + String(ProcessInfo().processIdentifier)
    let mqtt: CocoaMQTT
    
    required init?(coder aDecoder: NSCoder){
        print(clientID);
        mqtt = CocoaMQTT(clientID: clientID, host: "localhost", port: 1883)
        mqtt.willMessage = CocoaMQTTWill(topic: "INICIO_CRUCE_CALLE", message: "");
        mqtt.keepAlive = 60
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        mqtt.delegate = self
        mqtt.connect()
        //mqtt.subscribe("INICIO_CRUCE_CALLE");
        
        mqtt.didReceiveMessage = { mqtt, message, id in
            
            print("Message received in topic \(message.topic) with payload \(message.string!)")
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
        
    }

    @IBAction func IniciarCruceCalle(_ sender: UIButton) {
        print("Message published in topic SOLICITAR_CRUCE_CALLE with payload ")
        
        mqtt.publish("SOLICITAR_CRUCE_CALLE", withString: "")
        
    }
    
}

extension ViewController: CocoaMQTTDelegate{
    func mqttDidPing(_ mqtt: CocoaMQTT) {
        
    }
    
    func mqttDidReceivePong(_ mqtt: CocoaMQTT) {
        
    }
    
    func mqttDidDisconnect(_ mqtt: CocoaMQTT, withError err: Error?) {
        
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didConnectAck ack: CocoaMQTTConnAck) {
        if ack == .accept {
            mqtt.subscribe("INICIO_CRUCE_CALLE", qos: CocoaMQTTQOS.qos1)
        }
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishMessage message: CocoaMQTTMessage, id: UInt16) {
        
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishAck id: UInt16) {
        
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didReceiveMessage message: CocoaMQTTMessage, id: UInt16) {
        
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didSubscribeTopic topics: [String]) {
        
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didUnsubscribeTopic topic: String) {
        
    }

}
