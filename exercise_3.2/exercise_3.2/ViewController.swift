//
//  ViewController.swift
//  exercise_3.2
//
//  Created by Scores_Main_User on 1/4/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var viewDrag: UIImageView!
    let minimumWidth : CGFloat = CGFloat(100.0)
    let maximumWidth : CGFloat = CGFloat(300.0)
    let minimumHeight : CGFloat = CGFloat(100.0)
    let maximumHeight : CGFloat = CGFloat(300.0)
    private var center_y : Double  = 0.0
    private var center_x : Double = 0.0
    private var x_boundry : CGFloat = CGFloat(0.0)
    private var y_boundry : CGFloat = CGFloat(0.0)
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let frameSize: CGPoint = CGPoint(x: UIScreen.main.bounds.size.width*0.5,y: UIScreen.main.bounds.size.height*0.5)
        self.center_x = Double(frameSize.x)
        self.center_y = Double(frameSize.y)
        self.x_boundry = UIScreen.main.bounds.size.width
        self.y_boundry = UIScreen.main.bounds.size.height
        print(self.y_boundry)
    }
    
    @IBAction func handleDoubleTap(_ sender: UITapGestureRecognizer)
    {
        self.viewDrag.transform = CGAffineTransform.identity;
        self.viewDrag.frame.size = CGSize(width: 200, height: 200)
        
    }
    
    @IBAction func handlePan(_ gesture: UIPanGestureRecognizer) {
        // 1
        let translation = gesture.translation(in: view)
        
        // 2
        guard let gestureView = gesture.view else {
            return
        }
        // calculation eplxained: center of the view +  the trnsition + halg of the view (height/width)
        //      needs to be smaller than the view boundry / needs to be bigger than 0
        // draging right
        let positiveDrag_x = gestureView.center.x + translation.x + gestureView.frame.size.width / 2
        // dragging left
        let negativeDrag_x = gestureView.center.x + translation.x - gestureView.frame.size.width / 2
        //dragging down
        let positiveDrag_y = gestureView.center.y + translation.y + gestureView.frame.size.height / 2
        //dragging up
        let negativeDrag_y = gestureView.center.y + translation.y - gestureView.frame.size.height / 2
        
        
        if positiveDrag_x <= self.x_boundry && negativeDrag_x >= 0
        {
            if positiveDrag_y <= self.y_boundry && negativeDrag_y >= 40
            {
                gestureView.center = CGPoint(
                    x: gestureView.center.x + translation.x,
                    y: gestureView.center.y + translation.y
                )
            }
        }
        
        
        
        print(gestureView.center.y - gestureView.frame.size.height / 2)
        
        gesture.setTranslation(.zero, in: view)
        
        guard gesture.state == .ended else {
            return
        }
        
        
//
//        // 1
//        let velocity = gesture.velocity(in: view)
//        let magnitude = sqrt((velocity.x * velocity.x) + (velocity.y * velocity.y))
//        let slideMultiplier = magnitude / 200
//
//        // 2
//        let slideFactor = 0.1 * slideMultiplier
//        // 3
//        var finalPoint = CGPoint(
//            x: gestureView.center.x + (velocity.x * slideFactor),
//            y: gestureView.center.y + (velocity.y * slideFactor)
//        )
//
//        // 4
//        finalPoint.x = min(max(finalPoint.x, 0), view.bounds.width)
//        finalPoint.y = min(max(finalPoint.y, 0), view.bounds.height)
//
//        // 5
//        UIView.animate(
//            withDuration: Double(slideFactor * 2),
//            delay: 0,
//            // 6
//            options: .curveEaseOut,
//            animations: {
//                gestureView.center = finalPoint
//            })
    }
    
    
    @IBAction func handlePinch(_ gesture: UIPinchGestureRecognizer) {
        guard gesture.view != nil else {
            return
        }
        
        //        gestureView.transform = gestureView.transform.scaledBy(
        //          x: gesture.scale,
        //          y: gesture.scale
        //        )
        
        let newWidth = gesture.scale * self.viewDrag.frame.width
        let newHeight = gesture.scale * self.viewDrag.frame.height
        
        // You need to have the maximum and minimum values for comparison already stored
        if (newWidth >= self.minimumWidth && newWidth <= self.maximumHeight) && (newHeight >= self.minimumHeight && newHeight <= self.maximumHeight)
        {
            self.viewDrag.frame.size = CGSize(width: newWidth, height: newHeight)
        }
        
        gesture.scale = 1
    }
    @IBAction func handleTap(_ gesture: UITapGestureRecognizer)
    {
        if gesture.state == .ended
        {
            self.viewDrag.backgroundColor = .cyan
            
            
        }
        
    }
    
    @IBAction func lognTapHandle(_ sender: UILongPressGestureRecognizer)
    {
        self.viewDrag.center = CGPoint(x: center_x, y: center_y)
    }
    
    @IBAction func handleRotate(_ gesture: UIRotationGestureRecognizer)
    {
        guard let gestureView = gesture.view else {
            return
        }
        
        gestureView.transform = gestureView.transform.rotated(
            by: gesture.rotation
        )
        gesture.rotation = 0
    }
    
    @IBAction func swipeLeft(_ sender: UISwipeGestureRecognizer)
    {
        print("swiped left")
        self.viewDrag.center.x = 0 + self.viewDrag.frame.width / 2
        
    }
    
    @IBAction func swipeRight(_ sender: UISwipeGestureRecognizer)
    {
        print("swiped right")
        self.viewDrag.center.x = self.x_boundry - self.viewDrag.frame.width / 2
    }
    
    @IBAction func swipeDown(_ sender: UISwipeGestureRecognizer)
    {
        self.viewDrag.center.y = self.y_boundry - self.viewDrag.frame.height / 2

    }
    
    @IBAction func swipeUp(_ sender: UISwipeGestureRecognizer)
    {
        self.viewDrag.center.y = 0 + self.viewDrag.frame.height / 2
    }
}

//extension ViewController: UIGestureRecognizerDelegate
//{
//    
//    func gestureRecognizer( _ gestureRecognizer: UIGestureRecognizer,
//      shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
//    ) -> Bool
//    {
//      return true
//    }
//    
//}
