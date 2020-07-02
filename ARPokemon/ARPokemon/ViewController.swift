//
//  ViewController.swift
//  ARPokemon
//  Created by Nareshri Babu on 2020-05-06.
//  Copyright © 2020 Nareshri Babu. All rights reserved.
//  This app was created for learning purposes.
//  All images were only used for learning purposes and do not belong to me.
//  All sounds were only used for learning purposes and do not belong to me.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        sceneView.autoenablesDefaultLighting = true
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        
        if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "Pokemon Cards", bundle: Bundle.main) {
            
            configuration.trackingImages = imageToTrack
            
            configuration.maximumNumberOfTrackedImages = 3
            
        }
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    // MARK: - ARSCNViewDelegate
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        
        let node = SCNNode()
        
        DispatchQueue.main.async {
            
            if let imageAnchor = anchor as? ARImageAnchor {
                
                let plane = SCNPlane(
                    width: imageAnchor.referenceImage.physicalSize.width,
                    height: imageAnchor.referenceImage.physicalSize.height)
                
                plane.firstMaterial?.diffuse.contents = UIColor(white: 1.0, alpha: 0.5)
                
                let planeNode = SCNNode(geometry: plane)
                
                planeNode.eulerAngles.x = -.pi / 2 //- means clockwise and pi/2 is 90 degrees
                
                node.addChildNode(planeNode)
                
                
                if imageAnchor.referenceImage.name == "eevee-card" {
                    if let pokeScene = SCNScene(named: "art.scnassets/eevee.scn") {
                        
                        if let pokeNode = pokeScene.rootNode.childNodes.first {
                            
                            pokeNode.eulerAngles.x = .pi / 2 //turn eevee to be horizontal on the plane
                            
                            planeNode.addChildNode(pokeNode)
                            
                        }
                    }
                }
                
                if imageAnchor.referenceImage.name == "oddish-card" {
                    if let pokeScene = SCNScene(named: "art.scnassets/oddish.scn") {
                        
                        if let pokeNode = pokeScene.rootNode.childNodes.first {
                            
                            pokeNode.eulerAngles.x = .pi / 2 //turn eevee to be horizontal on the plane
                            
                            planeNode.addChildNode(pokeNode)
                            
                        }
                    }
                }
                

                if imageAnchor.referenceImage.name == "charmander-card" {
                    
                    if let pokeScene = SCNScene(named: "art.scnassets/charmander.scn") {
                        
                        if let pokeNode = pokeScene.rootNode.childNodes.first {
                            
                            pokeNode.eulerAngles.x = .pi / 2 //turn eevee to be horizontal on the plane
                            
                            planeNode.addChildNode(pokeNode)
                        }
                    }
                }
                
                
            }

        }
        return node

    }
    
    
}
