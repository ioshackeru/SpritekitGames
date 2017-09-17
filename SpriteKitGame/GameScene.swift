//
//  GameScene.swift
//  SpriteKitGame
//
//  Created by Tomer Buzaglo on 14/09/2017.
//  Copyright © 2017 iTomerBu. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    //entry point:
    override func didMove(to view: SKView) {
        addMovingBackgrounds()
        cage()
        addBall()
        addPaddle()
        addBricks()
    }
    
    func addBricks(){
        let numBricks:CGFloat = 5
        let padd = CGFloat(1)
        let sentinel = SKSpriteNode(imageNamed: "brick")
        sentinel.size = CGSize(width: sentinel.frame.width / 4, height: sentinel.frame.height / 4)
        var xOffset = (frame.width - numBricks * (sentinel.frame.width) + padd) / 2
        
        for _ in 0...Int(numBricks){
            let b = SKSpriteNode(imageNamed: "brick")
            b.size = CGSize(width: b.frame.width / 4, height: b.frame.height / 4)
            b.position.x = xOffset
            b.position.y = frame.height - b.frame.height
            
            xOffset += (b.frame.width + padd)
            
            b.physicsBody = SKPhysicsBody(rectangleOf: b.frame.size)
            b.physicsBody?.isDynamic = false
            addChild(b)
        }
        
        let s = UIStackView()
        
    }
    
    func cage(){
        let borderBody =  SKPhysicsBody(edgeLoopFrom: frame)
        borderBody.affectedByGravity = false
        borderBody.friction = 0
        borderBody.isDynamic = false // not affected by forces!
        self.scene?.physicsBody = borderBody
    }
    
    func addShapes(){
        let triangle = SKSpriteNode(imageNamed: "triangle")
        triangle.position = CGPoint(x: frame.width * 0.5, y: frame.midY)
        triangle.physicsBody = SKPhysicsBody(texture: triangle.texture!, size: triangle.frame.size)
        addChild(triangle)
        
        let rect = SKSpriteNode(imageNamed: "rectangle")
        rect.position = CGPoint(x: frame.width * 0.75, y: frame.midY)
        rect.physicsBody = SKPhysicsBody(rectangleOf: rect.frame.size)
        addChild(rect)
        
        //cage
        scene?.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
    }
    
    
    func addPaddle(){
        let paddle = SKSpriteNode(imageNamed: "paddle")
        paddle.name = "paddle"
        paddle.position = CGPoint(x: frame.midX, y: 0.05 * frame.height)
        let paddleBody = SKPhysicsBody(rectangleOf: CGSize(width: paddle.size.width, height: paddle.size.height))
        paddleBody.isDynamic = false // not affected by forces!
        
        paddle.physicsBody = paddleBody
        paddle.zPosition = 1
        addChild(paddle)
    }
    
    func addBall(){
        let circle = SKSpriteNode(imageNamed: "pokeball")
        circle.name = "ball"
        circle.size = CGSize(width: circle.size.width / 2, height: circle.size.height / 2)
        circle.position = CGPoint(x: frame.width * 0.25, y: frame.midY)
        
        let circleBody = SKPhysicsBody(circleOfRadius: circle.frame.width / 2)
        circleBody.friction = 0
        circleBody.restitution = 1 // totally elastic
        circleBody.affectedByGravity = false
        circleBody.angularDamping = 0 // how much impulse do we loose when rotated
        circleBody.linearDamping = 0 // how much impulse do we loose when moved
        circleBody.allowsRotation = true
        circle.zPosition = 1
        
        circle.physicsBody = circleBody
        
        
        addChild(circle)
        
        circleBody.applyImpulse(CGVector(dx: 10, dy: 10))
        circleBody.applyTorque(.pi / 4)
    }
    
    
    func addBackground(){
        let background = SKSpriteNode(imageNamed: "back2")
        background.name = "background"
        background.size = frame.size
        background.zPosition  = -1
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(background)
        
        let background2 = SKSpriteNode(imageNamed: "back2")
        background2.name = "background2"
        background2.size = frame.size
        background2.zPosition  = -1
        background2.position = CGPoint(x: frame.width + frame.midX, y: frame.midY)
        addChild(background2)
        
        let move = SKAction.move(by: CGVector(dx: -background.size.width, dy: 0), duration: 5)
        
        let goBack = SKAction.move(by: CGVector(dx: background.size.width, dy: 0), duration: 0)
        
        
        let repeatAction = SKAction.repeatForever(SKAction.sequence([move, goBack]))
        background2.run(repeatAction)
        background.run(repeatAction)
    }
    
    // Called before each frame is rendered
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    
    
    func addMovingBackgrounds(){
        let background1 = SKSpriteNode(imageNamed: "back2")
        let background2 = SKSpriteNode(imageNamed: "back2")
        
        
        
        //only mutual settings:
        let both = [background1, background2]
        both.forEach { (b) in
            b.name = "back"
            b.size = self.frame.size
            b.zPosition = -1
            addChild(b)
        }
        
        background1.position = CGPoint(x: frame.midX, y: frame.midY)
        background2.position = CGPoint(x: frame.midX + background2.frame.size.width, y: frame.midY)
        
        
        let moveLeft = SKAction.moveBy(x: -background1.frame.width, y: 0, duration: 5)
        let goBack = SKAction.moveBy(x: background1.frame.width, y: 0, duration: 0)
        
        
        let magic = SKAction.repeatForever(SKAction.sequence([moveLeft, goBack]))
        
        
        background1.run(magic)
        background2.run(magic)
    }
    
    
    
    func addSpaceship(location:CGPoint){
        let spaceship = SKSpriteNode(imageNamed: "Spaceship")
        spaceship.size = CGSize(width: 70, height: 70)
        
        spaceship.position = location
        
        let zoomOut = SKAction.scale(by: 0.1, duration: 0)
        
        let zoom = SKAction.scale(by: 10, duration: 0.3)
        
        let rotateAction = SKAction.rotate(byAngle: -.pi / 2, duration: 0.1)
        
        
        let repeatAction = SKAction.repeat(rotateAction, count: 9)
        
        
        let vect = CGVector(dx: frame.width , dy: 0)
        let move = SKAction.move(by: vect, duration: 0.1)
        
        let allOneByOne = SKAction.sequence([
            zoomOut,
            zoom,
            repeatAction,
            SKAction.group([
                SKAction.playSoundFileNamed("Swoosh 3-SoundBible.com-1573211927.mp3", waitForCompletion: false),
                move]),
            SKAction.fadeOut(withDuration: 0.3),
            SKAction.removeFromParent()
            ]
        )
        
        spaceship.run(allOneByOne)
        
        addChild(spaceship)
    }
    
    var isFingerOnPaddle = false
}

//MARK: Handle Touche Events:
extension GameScene{
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        let location:CGPoint = touch.location(in: self)
        
        //find the paddle or crash!
        guard let paddle = childNode(withName: "paddle") else {fatalError("No Paddle?")}
        
        if (paddle.frame.contains(location)){
            isFingerOnPaddle = true
        }
        //addSpaceship(location: location)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isFingerOnPaddle = false
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first,
            let paddle = childNode(withName: "paddle") else {return}
        
        let location = touch.location(in:self)
        
        
        
        paddle.position.x = location.x
    }
    
}





















