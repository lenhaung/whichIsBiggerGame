//
//  ViewController.swift
//  whichIsBiggerGame
//
//  Created by Lun H on 2020/3/24.
//  Copyright © 2020 Lun H. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var computerCard: UIImageView!
    @IBOutlet weak var computerCardView: UIView!
    @IBOutlet weak var userCardView: UIView!
    @IBOutlet weak var showNewCard: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var userCard: UIImageView!
    @IBOutlet weak var userMoney: UILabel!
    @IBOutlet weak var computerMoney: UILabel!
    
    var cardNumber = [1,2,3,4,5,6,7,8,9,10,11,12,13]
    var cardFlower = ["clubs","diamonds","hearts","spades"]
    var computerMoneyTotal = 500
    var userMoneyIntTotal = 500
    var card:pokerCard?
    var cardArray = [pokerCard(number: 1, flower: "clubs",imageName:"1clubs")]
    var userCardInt = 0
    var computerCardInt = 0
    var beginToPlay = true
    
    @IBAction func renew(_ sender: UIButton) {  //重玩按鈕
        
        //回覆牌的位置
        let userRect = CGRect(x: 140, y: 599, width: userCardView.frame.width, height: userCardView.frame.height)
        userCardView.frame = userRect
        let comRect = CGRect(x: 140, y: 163, width: computerCardView.frame.width, height: computerCardView.frame.height)
        userCardView.frame = userRect
        computerCardView.frame = comRect
        //
        
        userMoneyIntTotal = 500  //預設玩家有500元
        computerMoneyTotal = 500 //預設電腦有500元
        computerMoney.text = computerMoneyTotal.description //顯示電腦金錢
        userMoney.text = userMoneyIntTotal.description  //顯示玩家金錢
        cardArray = getPoke()  //取得牌組
        cardArray.shuffle()    //洗牌
        
        //隨機產生數字已讀取隨機牌
        userCardInt = Int.random(in: 0...cardArray.count-1)
        computerCardInt = Int.random(in: 0...cardArray.count-1)
        //把牌蓋起來
        userCard.image = UIImage(named: "cardBack")
        computerCard.image = UIImage(named: "cardBack")
        //設定要進行判斷
        beginToPlay = true
        
    }
    
    @IBAction func assureCard(_ sender: Any) {   //顯示結果按鈕
        
        if beginToPlay == true{
            //顯示圖片
            computerCard.image = UIImage(named: cardArray[computerCardInt].imageName)
            userCard.image = UIImage(named: cardArray[userCardInt].imageName)
            
            
            //輸贏要做什麼
            //如果有Ａ的狀況判斷
            if cardArray[userCardInt].number == 1{
                switch cardArray[computerCardInt].number {
                case 1:
                    if cardArray[userCardInt].flower == cardArray[computerCardInt].flower{
                        resultLabel.text = "平手"
                    }else{
                        if returnFlowerNumber(flower: cardArray[userCardInt].flower) > returnFlowerNumber(flower: cardArray[computerCardInt].flower){
                            resultLabel.text = "你贏了"
                            userMoneyIntTotal += 50
                            computerMoneyTotal -= 50
                        }else{
                            resultLabel.text = "你輸了"
                            userMoneyIntTotal -= 50
                            computerMoneyTotal += 50
                        }
                    }
                default:
                    resultLabel.text = "你贏了"
                    userMoneyIntTotal += 50
                    computerMoneyTotal -= 50
                }
            }else{
                if cardArray[computerCardInt].number == 1{
                    resultLabel.text = "你輸了"
                    userMoneyIntTotal -= 50
                    computerMoneyTotal += 50
                }
            }
            
            //都不是A的狀況判斷
            if cardArray[userCardInt].number != 1 && cardArray[computerCardInt].number != 1{
                if cardArray[userCardInt].number > cardArray[computerCardInt].number{
                    resultLabel.text = "你贏了"
                    userMoneyIntTotal += 50
                    computerMoneyTotal -= 50
                }else if cardArray[userCardInt].number == cardArray[computerCardInt].number{
                    //比花色
                    if cardArray[userCardInt].flower == cardArray[computerCardInt].flower{
                        resultLabel.text = "平手"
                    }else{
                        if returnFlowerNumber(flower: cardArray[userCardInt].flower) > returnFlowerNumber(flower: cardArray[computerCardInt].flower){
                            resultLabel.text = "你贏了"
                            userMoneyIntTotal += 50
                            computerMoneyTotal -= 50
                        }else{
                            resultLabel.text = "你輸了"
                            userMoneyIntTotal -= 50
                            computerMoneyTotal += 50
                        }
                    }
                }else{
                    resultLabel.text = "你輸了"
                    userMoneyIntTotal -= 50
                    computerMoneyTotal += 50
                }
            }
            userMoney.text = userMoneyIntTotal.description
            computerMoney.text = computerMoneyTotal.description
            beginToPlay = false
            showNewCard.setTitle("發新牌", for: .normal)
            
        }else{
            userCard.image = UIImage(named: "cardBack")
            computerCard.image = UIImage(named: "cardBack")
            cardArray = getPoke()  //取得牌組
            cardArray.shuffle()    //洗牌
            //隨機產生數字已讀取隨機牌
            userCardInt = Int.random(in: 0...cardArray.count-1)
            computerCardInt = Int.random(in: 0...cardArray.count-1)
            showNewCard.setTitle("翻牌", for: .normal)
            resultLabel.text = ""
            beginToPlay = true
            cardAnimation()
        }
        
        if userMoneyIntTotal == 0{
            gameover(title: "你的錢被電腦贏光了")
        }
        
        if computerMoneyTotal == 0{
            gameover(title:
                "電腦的錢被你贏光了")
        }
    }
     
    func gameover(title:String){   //跳出訊息
        let controller = UIAlertController(title: title, message: "請點選確定重玩",preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "確定", style: .default) { (_) in
            //回覆牌的位置
            let userRect = CGRect(x: 140, y: 599, width: self.userCardView.frame.width, height: self.userCardView.frame.height)
            self.userCardView.frame = userRect
            let comRect = CGRect(x: 140, y: 163, width: self.computerCardView.frame.width, height: self.computerCardView.frame.height)
            self.userCardView.frame = userRect
            self.computerCardView.frame = comRect
            //
            
            self.userMoneyIntTotal = 500  //預設玩家有500元
            self.computerMoneyTotal = 500 //預設電腦有500元
            self.computerMoney.text = self.computerMoneyTotal.description //顯示電腦金錢
            self.userMoney.text = self.userMoneyIntTotal.description  //顯示玩家金錢
            self.cardArray = self.getPoke()  //取得牌組
            self.cardArray.shuffle()    //洗牌
            
            //隨機產生數字已讀取隨機牌
            self.userCardInt = Int.random(in: 0...self.cardArray.count-1)
            self.computerCardInt = Int.random(in: 0...self.cardArray.count-1)
            //把牌蓋起來
            self.userCard.image = UIImage(named: "cardBack")
            self.computerCard.image = UIImage(named: "cardBack")
            //設定要進行判斷
            self.beginToPlay = true
        }
        controller.addAction(alertAction)
        present(controller,animated: true)
        
    }
    
    
    
    @IBAction func giveUp(_ sender: Any) {  //放棄按鈕
        userMoneyIntTotal -= 50
        computerMoneyTotal += 50
        
        cardArray = getPoke()  //取得牌組
        cardArray.shuffle()    //洗牌
        
        //隨機產生數字已讀取隨機牌
        userCardInt = Int.random(in: 0...cardArray.count-1)
        computerCardInt = Int.random(in: 0...cardArray.count-1)
        
        //顯示金額
        userMoney.text = userMoneyIntTotal.description
        computerMoney.text = computerMoneyTotal.description
        beginToPlay = true
        
        //蓋牌
        userCard.image = UIImage(named: "cardBack")
        computerCard.image = UIImage(named: "cardBack")
        
        if userMoneyIntTotal == 0{
            gameover(title: "你的錢被電腦贏光了")
        }
        
        if computerMoneyTotal == 0{
            gameover(title:
                "電腦的錢被你贏光了")
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //初始卡片位置
        let userRect = CGRect(x: 140, y: 599, width: userCardView.frame.width, height: userCardView.frame.height)
        userCardView.frame = userRect
        let comRect = CGRect(x: 140, y: 163, width: computerCardView.frame.width, height: computerCardView.frame.height)
        userCardView.frame = userRect
        computerCardView.frame = comRect
        
        
        cardArray = getPoke()  //取得牌組
        cardArray.shuffle()    //洗牌
        
        //隨機產生數字已讀取隨機牌
        userCardInt = Int.random(in: 0...cardArray.count-1)
        computerCardInt = Int.random(in: 0...cardArray.count-1)
        
        //顯示金額
        userMoney.text = userMoneyIntTotal.description
        computerMoney.text = computerMoneyTotal.description
         
    }
    
    func cardAnimation(){ //發牌動畫
            //執行移動
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 2, delay: 0, options: [], animations: {
                self.userCardView.transform = CGAffineTransform(translationX: 140, y: 0)
            }, completion: nil)
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 2, delay: 0, options: [], animations: {
                self.computerCardView.transform = CGAffineTransform(translationX: 140, y: 0)
            }, completion: nil)
            //回到原位
            computerCardView.transform = .identity
            userCardView.transform = .identity
    }
    
    
    
    
    
    func getPoke() -> [pokerCard] {   //建立52張牌
               for i in 1...cardNumber.count{
                   for j in 1...cardFlower.count{
                       card = pokerCard(number: cardNumber[i-1], flower: cardFlower[j-1],imageName:"\(cardNumber[i-1])\(cardFlower[j-1])")
                       if let card = card{
                           cardArray += [card]
                       }
                   }
               }
               cardArray.removeFirst()
               return cardArray
           }
    
    
    func returnFlowerNumber(flower:String) -> Int{   //回傳花色大小
        switch flower{
        case "spades":
        return 4
        case "hearts":
        return 3
        case "diamonds":
        return 2
        default:
        return 1
        }
    }

}

