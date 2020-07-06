//
//  ViewController.swift
//  TicTacToe Game
//
//  Created by Saad Mahboob on 2/11/20.
//  Copyright © 2020 Saad Mahboob. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var PlayerOneScoreLabel: UILabel!
    @IBOutlet weak var PlayerTwoScoreLabel: UILabel!
    @IBOutlet weak var WinnerLabel: UILabel!
    
    var activePlayer  = 1 //cross
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    let winner =  [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
    var gameIsRunning = true
    var tickScore = 0
    var circleScore = 0
    
    @IBAction func action(_ sender: AnyObject) {
        if(gameState[sender.tag-1] == 0 && gameIsRunning == true){
            gameState[sender.tag-1] = activePlayer
         
            if(activePlayer == 1){
                sender.setImage(UIImage(named: "plus.png"), for: UIControl.State())
                activePlayer = 2
            }
            else{
                sender.setImage(UIImage(named: "minus.png"), for: UIControl.State())
                activePlayer = 1
            }
        }
        
        for combination in winner{
            if gameState[combination[0]] != 0 && gameState[combination[0]] == gameState[combination[1]] && gameState[combination[1]] == gameState[combination[2]]
            {
                gameIsRunning = false
                
                if gameState[combination[0]] == 1{
                    WinnerLabel.text = "Tick has won!"
                    tickScore += 1
                    PlayerOneScoreLabel.text = String(tickScore)
                }
                else{
                    circleScore += 1
                    PlayerTwoScoreLabel.text = String(circleScore)
                    WinnerLabel.text = "Circle has won!"
                }
               
                PlayAgain.isHidden = false
                WinnerLabel.isHidden = false
            }

        }
        
        gameIsRunning = false
        for i in gameState{
            if i == 0{
                gameIsRunning = true
                break
            }
        }
        if gameIsRunning == false{
            WinnerLabel.text = "It was a Draw!"
            PlayAgain.isHidden = false
            WinnerLabel.isHidden = false
        }
    }
    
    @IBOutlet weak var PlayAgain: UIButton!
    
    @IBAction func PlayAgain(_ sender: Any) {
        
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        gameIsRunning = true
        activePlayer = 1
        
        PlayAgain.isHidden = true
        WinnerLabel.isHidden = true
        
        for i in 1...9{
            let button = view.viewWithTag(i) as! UIButton
            button.setImage(nil, for: UIControl.State())
        }

    }
    
    var musicPlay = AVAudioPlayer()

    @IBAction func SoundLabel(_ sender: Any) {
        musicPlay.play()
    }
    
    @IBAction func MuteLabel(_ sender: Any) {
        musicPlay.stop()
    }

    override func viewDidLoad() {
        super.viewDidLoad()        
        do{
            musicPlay = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Sample", ofType: "mp3")!))
            musicPlay.prepareToPlay()
        }
            
        catch{
            print(error)
        }
    }
}
