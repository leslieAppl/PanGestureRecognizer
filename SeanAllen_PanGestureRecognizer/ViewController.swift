//
//  ViewController.swift
//  SeanAllen_PanGestureRecognizer
//
//  Created by leslie on 6/15/20.
//  Copyright © 2020 leslie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var fileImageView: UIImageView!
    @IBOutlet weak var trashImageView: UIImageView!
    
    var fileViewOrigin: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addPanGesture(view: fileImageView)
        fileViewOrigin = fileImageView.frame.origin
        
        view.bringSubviewToFront(fileImageView)
    }

    func addPanGesture(view: UIView) {
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(self.handlePan(sender:)))
        view.addGestureRecognizer(pan)
        
    }
    
    @objc func handlePan(sender: UIPanGestureRecognizer) {
        
        let fileView = sender.view!
        let translation = sender.translation(in: view)
        
        switch sender.state {
        case .began, .changed:
            
            /// Tracking target view's routes corresponding to the pan gesture translation in the coordinate system of the specified view.
            fileView.center = CGPoint(x: fileView.center.x+translation.x, y: fileView.center.y+translation.y)
            
            /// Resetting translation value to zero after pan gesture finished.
            sender.setTranslation(CGPoint.zero, in: view)
            
        case .ended:
            
            if fileView.frame.intersects(trashImageView.frame) {
                
                UIView.animate(withDuration: 0.0) {
                    self.fileImageView.alpha = 0.0
                    self.trashImageView.image = UIImage(named: "fullRecycleBinIcon")
                }
            }
            else {
                UIView.animate(withDuration: 0.3) {
                    fileView.frame.origin = self.fileViewOrigin
                }
            }
            
            
        default:
            break
        }
        
    }
}

