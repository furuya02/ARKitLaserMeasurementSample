//
//  Laser.swift
//  LaserMeasurement
//
//  Created by SIN on 2017/09/01.
//  Copyright © 2017年 js.ne.sapporoworks. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

class Laser: SCNNode {
    
    var node: SCNNode!
    
    fileprivate override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(arScnView: ARSCNView) {
        super.init()
        
        geometry = SCNSphere(radius: 0.03)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.red.withAlphaComponent(0.5)
        geometry?.materials = [material]
        position = SCNVector3(0, 0, 0)
        
        let sphere = SCNSphere(radius: 0.01)
        let sphereMaterial = SCNMaterial()
        sphereMaterial.diffuse.contents = UIColor.red
        sphere.materials = [sphereMaterial]
        node = SCNNode(geometry: sphere)
        node.position = SCNVector3(0, 0, 0)
        
        arScnView.scene.rootNode.addChildNode(self)
        arScnView.scene.rootNode.addChildNode(node)
        off()
    }
    
    func update(center: SCNVector3) {
        position = center
        node.position = center
    }
    
    func on(){
        isHidden = false
        node.isHidden = false
    }

    func off(){
        isHidden = true
        node.isHidden = true
    }

}
