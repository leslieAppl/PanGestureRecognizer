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
        
        switch sender.state {
        case .began, .changed:
            moveViewWithPan(view: fileView, sender: sender)
            
        case .ended:
            
            if fileView.frame.intersects(trashImageView.frame) {
                deleteView(view: fileView)
            }
            else {
                returnViewToOrigin(view: fileView)
            }
            
        default:
            break
        }
    }
    
    func moveViewWithPan(view: UIView, sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: view)
        
        /// Tracking target view's routing corresponding to the pan gesture translation in the coordinate system of the specified view.
        view.center = CGPoint(x: view.center.x+translation.x, y: view.center.y+translation.y)
        
        /// Resetting translation value to zero after pan gesture finished.
        sender.setTranslation(CGPoint.zero, in: view)

    }
    
    func returnViewToOrigin(view: UIView) {
        UIView.animate(withDuration: 0.3) {
            view.frame.origin = self.fileViewOrigin
        }
    }
    
    func deleteView(view: UIView) {
        UIView.animate(withDuration: 0.0) {
            view.alpha = 0.0
            self.trashImageView.image = UIImage(named: "fullRecycleBinIcon")
        }
    }
}

