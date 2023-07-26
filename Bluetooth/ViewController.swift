//
//  ViewController.swift
//  Bluetooth
//
//  Created by cubicinc on 2023/07/26.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController {

    private var peripherals: [CBPeripheral] = []
    private var centralManager: CBCentralManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
}

extension ViewController : CBPeripheralDelegate, CBCentralManagerDelegate{
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .unknown:
            print("unknown")
        case .resetting:
            print("restting")
        case .unsupported:
            print("unsupported")
        case .unauthorized:
            print("unauthorized")
        case .poweredOff:
            print("power Off")
        case .poweredOn:
            print("power on")
        @unknown default:
            fatalError()
        }
    }
}
