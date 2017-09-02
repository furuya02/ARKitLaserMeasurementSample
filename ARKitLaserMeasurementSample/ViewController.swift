//
//  ViewController.swift
//  ARKitLaserMeasurementSample
//
//  Created by . SIN on 2017/09/02.
//  Copyright © 2017年 SAPPOROWORKS. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var label: UILabel!
    
    
    var laser:Laser!
    var timer: Timer!
    var recordingButto: RecordingButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sceneView.delegate = self
        sceneView.showsStatistics = true
        let scene = SCNScene()
        sceneView.scene = scene
        
        laser = Laser(arScnView: sceneView)
        self.recordingButto = RecordingButton(self) // 録画ボタン
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sceneView.session.pause()
    }

    // MARK: - Action
    @IBAction func touchDownButton(_ sender: Any) {
        startLaserBean()
    }
    
    @IBAction func TouchUpInsideButton(_ sender: Any) {
        stopLaserBean()
    }

    @IBAction func TouchUpOutsideButton(_ sender: Any) {
        stopLaserBean()
    }
    
    // MARK: - Laser Beam
    func startLaserBean(){
        laser.on()
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    func stopLaserBean(){
        laser.off()
        timer.invalidate()
    }

    @objc func update(tm: Timer) {
        let hitResults = sceneView.hitTest(sceneView.center, types: [.featurePoint])
        if !hitResults.isEmpty {
            if let hitResult = hitResults.first {
                let center = SCNVector3(hitResult.worldTransform.columns.3.x, hitResult.worldTransform.columns.3.y, hitResult.worldTransform.columns.3.z)
                self.laser.update(center: center)
                label.text = String.init(format: "%.2fm", arguments: [hitResult.distance])
            }
        }
    }
}

