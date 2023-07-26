//
//  ViewController.swift
//  Bluetooth
//
//  Created by cubicinc on 2023/07/26.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController {

    lazy var baseView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    lazy var topStackView: UIStackView = {
        var view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fillEqually
        view.alignment = .fill
        view.spacing = 8
        return view
    }()
    
    lazy var stateLb1: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "블루투스 상태"
        return label
    }()
    
    lazy var stateLb2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ":"
        return label
    }()
    
    lazy var buttonStackView: UIStackView = {
        var view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.alignment = .fill
        view.spacing = 14
        return view
    }()
    
    lazy var startBtn: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("검색 시작", for: .normal)
        return button
    }()
    
    lazy var stopBtn: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("검색 중단", for: .normal)
        return button
    }()
    
    lazy var searchLb: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "검색된 블루투스 기기"
        return label
    }()

    lazy var bottomBaseView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var scrollView: UIScrollView = {
        var view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsVerticalScrollIndicator = false
        view.keyboardDismissMode = .onDrag
        return view
    }()
    
    lazy var bottomStackView: UIStackView = {
        var view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fillEqually
        view.alignment = .fill
        view.spacing = 8
        return view
    }()

    private var peripherals: [CBPeripheral] = []
    private var centralManager: CBCentralManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        addViews()
        applyConstraints()
        addTarget()
        
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    fileprivate func addViews() {
        view.addSubview(baseView)
        baseView.addSubview(topStackView)
        baseView.addSubview(bottomBaseView)
        bottomBaseView.addSubview(scrollView)
        scrollView.addSubview(bottomStackView)
        topStackView.addArrangedSubview(stateLb1)
        topStackView.addArrangedSubview(stateLb2)
        topStackView.addArrangedSubview(buttonStackView)
        topStackView.addArrangedSubview(searchLb)
        buttonStackView.addArrangedSubview(startBtn)
        buttonStackView.addArrangedSubview(stopBtn)
    }
    
    fileprivate func applyConstraints() {
        let baseViewConstraints = [
            baseView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            baseView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            baseView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            baseView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        
        let topStackViewConstraints = [
            topStackView.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 30),
            topStackView.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -30),
            topStackView.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 30),
        ]
        
        let bottomBaseViewConstraints = [
            bottomBaseView.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 30),
            bottomBaseView.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -30),
            bottomBaseView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 30),
            bottomBaseView.bottomAnchor.constraint(equalTo: baseView.bottomAnchor, constant: -30),
        ]
        
        let scrollViewConstraints = [
            scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: bottomBaseView.leadingAnchor),
            scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: bottomBaseView.trailingAnchor),
            scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: bottomBaseView.topAnchor),
            scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: bottomBaseView.bottomAnchor)
        ]
        
        let bottomStackViewConstraints = [
            bottomStackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            bottomStackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            bottomStackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            bottomStackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            bottomStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ]
        
        NSLayoutConstraint.activate(baseViewConstraints)
        NSLayoutConstraint.activate(topStackViewConstraints)
        NSLayoutConstraint.activate(bottomBaseViewConstraints)
        NSLayoutConstraint.activate(scrollViewConstraints)
        NSLayoutConstraint.activate(bottomStackViewConstraints)

    }
    
    fileprivate func addTarget() {
        startBtn.addTarget(self, action: #selector(didTapStartButton(_:)), for: .touchUpInside)
        stopBtn.addTarget(self, action: #selector(didTapStopButton(_:)), for: .touchUpInside)
    }

    @objc func didTapStartButton(_ sender: UIButton) {
        print("검색 시작")
        if(!centralManager.isScanning){
            centralManager?.scanForPeripherals(withServices: nil, options: nil)
        }
    }
    
    @objc func didTapStopButton(_ sender: UIButton) {
        print("검색 종료")
        centralManager.stopScan()
    }
    
    fileprivate func addPeripheral(serial: String) {
        lazy var serialLb: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = serial
            return label
        }()
        
        bottomStackView.addArrangedSubview(serialLb)
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
            stateLb2.text = ": 블루투스 OFF"
        case .poweredOn:
            print("power on")
            stateLb2.text = ": 블루투스 ON"
        @unknown default:
            fatalError()
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        let check: Bool = false
        if !check {
            peripherals.append(peripheral)
            addPeripheral(serial: peripheral.name ?? peripheral.identifier.uuidString)
        }
    }
    
    // 기기 연결가 연결되면 호출되는 메서드입니다.
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.delegate = self
    }
    
    // characteristic 검색에 성공 시 호출되는 메서드입니다.
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {

    }
    
    // writeType이 .withResponse일 때, 블루투스 기기로부터의 응답이 왔을 때 호출되는 함수입니다.
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        // writeType이 .withResponse인 블루투스 기기로부터 응답이 왔을 때 필요한 코드를 작성합니다.(필요하다면 작성해주세요.)
     
    }
    
    // 블루투스 기기의 신호 강도를 요청하는 peripheral.readRSSI()가 호출하는 함수입니다.
    func peripheral(_ peripheral: CBPeripheral, didReadRSSI RSSI: NSNumber, error: Error?) {
        // 신호 강도와 관련된 코드를 작성합니다.(필요하다면 작성해주세요.)
    }

}
