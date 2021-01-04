//
//  ViewController.swift
//  exercise3
//
//  Created by Scores_Main_User on 12/31/20.
//

import UIKit

class ViewController: UIViewController
{
    
    @IBOutlet weak var viewDrag: UIImageView!
    
    @IBOutlet weak var label: NSLayoutConstraint!
    private var X_range = 0...40
    private var Y_range = 40...80
    private let radius = 120.0
    private var center_y = 0.0
    private var center_x = 0.0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //getting the scrren center
        let frameSize: CGPoint = CGPoint(x: UIScreen.main.bounds.size.width*0.5,y: UIScreen.main.bounds.size.height*0.5)
        self.center_x = Double(frameSize.x)
        self.center_y = Double(frameSize.y)
        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        if let touch = touches.first
        {
            let position = touch.location(in: view)
            //checking you are touching inside the scope of the box.
            if X_range.contains(Int(position.x)) && Y_range.contains(Int(position.y))
            {
                if checkInsideCircle(x: Double(position.x), y: Double(position.y))
                {
                    self.viewDrag.backgroundColor = .red
                }
                else
                {
                    self.viewDrag.backgroundColor = .blue
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        changeColor(touches)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        updateViewDragTouchRange()
        
        if let touch = touches.first
        {
            let position = touch.location(in: view)
            
            if checkInsideCircle(x: Double(position.x), y: Double(position.y))
            {
                self.viewDrag.center = CGPoint(x: center_x, y: center_y)
                self.viewDrag.backgroundColor = .red
                
            }
            else
            {
                self.viewDrag.backgroundColor = .gray
            }
        }
        
    }
    
    func checkInsideCircle(x:Double,y:Double) -> Bool
    {
        let x_distance = pow((x-center_x), 2.0)
        let y_distance = pow((y-center_y), 2.0)
        let d = sqrt(x_distance+y_distance)
        return d < radius
    }
    
    private func changeColor(_ touches: Set<UITouch>)
    {
        if let touch = touches.first
        {
            let position = touch.location(in: view)
            self.viewDrag.center = position
            
            if checkInsideCircle(x: Double(position.x), y: Double(position.y))
            {
                self.viewDrag.backgroundColor = .red
            }
            else
            {
                self.viewDrag.backgroundColor = .blue
            }
            
        }
    }
    
    //this function updates the "TouchAble" area each time the the drag ended
    private func updateViewDragTouchRange()
    {
        self.X_range = Int(viewDrag.center.x)-20...Int(viewDrag.center.x)+20
        self.Y_range = Int(viewDrag.center.y)-20...Int(viewDrag.center.y)+20
    }
}

