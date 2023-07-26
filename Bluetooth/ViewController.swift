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
    
    lazy var connectBtn: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("연결", for: .normal)
        return button
    }()
    
    lazy var searchLb: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "검색된 블루투스 기기"
        return label
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
        
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    fileprivate func addViews() {
        view.addSubview(baseView)
        baseView.addSubview(topStackView)
        baseView.addSubview(bottomStackView)
        topStackView.addArrangedSubview(stateLb1)
        topStackView.addArrangedSubview(stateLb2)
        topStackView.addArrangedSubview(buttonStackView)
        topStackView.addArrangedSubview(searchLb)
        buttonStackView.addArrangedSubview(startBtn)
        buttonStackView.addArrangedSubview(stopBtn)
        buttonStackView.addArrangedSubview(connectBtn)
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
        
        NSLayoutConstraint.activate(baseViewConstraints)
        NSLayoutConstraint.activate(topStackViewConstraints)

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
