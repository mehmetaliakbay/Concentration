//
//  ViewController.swift
//  Concentration
//
//  Created by mehmet ali akbay on 17.10.2021.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards: cardButtons.count / 2)
    
    var flipCount = 0 {
        didSet{
            flipCountLabel.text = "Flips : \(flipCount)"
        }
    }
    
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet var flipCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }else {
            print("chosen card was not in cardButtons")
        }
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        flipCount = 0
        game = Concentration(numberOfPairsOfCards: cardButtons.count/2)
        updateViewFromModel()
        emojiChoices = ["👻", "🎃","😱", "😈", "🍎", "🦇", "🐫", "🌹","🦍","😍"]
    }
    
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            button.titleLabel?.font = UIFont(name: "GillSans-Italic", size: 50)
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                
            }else{
                button.setTitle(" ", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.6910327673, green: 0.6910327673, blue: 0.6910327673, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    var emojiChoices = ["👻", "🎃","😱", "😈", "🍎", "🦇", "🐫", "🌹","🦍","😍"]
    
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
            
        }
        return emoji[card.identifier] ?? "?"
    }
    
}

