//  Created by Muhammed Buğra on 31.10.2023.

import UIKit

class ViewController: UIViewController {
    
    enum turn {
        case ouh
        case iks
    }
    
    
    
    @IBOutlet weak var TurnLabel: UILabel!
    
    @IBOutlet weak var a1: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var a3: UIButton!
    
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    
    @IBOutlet weak var c1: UIButton!
    @IBOutlet weak var c2: UIButton!
    @IBOutlet weak var c3: UIButton!
    
    var firstturn = turn.iks
    var currentTurn = turn.iks
    
    var ouh = "O"
    var iks = "X"
    var board = [UIButton]()
    
    var ouhScore = 0
    var iksScore = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        initboard()
    }
    func initboard()
    {
        board.append(a1)
        board.append(a2)
        board.append(a3)
        board.append(b1)
        board.append(b2)
        board.append(b3)
        board.append(c1)
        board.append(c2)
        board.append(c3)
        
    }
    
    @IBAction func BoardTapAction(_ sender: Any) {
        addToBoard(sender)
        
        if checkVictory(iks){
            iksScore += 1
            resultAlert(title: "Crosses Win!")
        }
        if checkVictory(ouh){
            ouhScore += 1
            resultAlert(title: "Noughts Win!")
        }
        
        if(fullBoard())
        {
            resultAlert(title: "Draw")
        }
    }
    
    func checkVictory(_ s: String) -> Bool {
        
        // Horizontal victory
        if thisSymbol(a1,s ) && thisSymbol(a2, s) && thisSymbol(a3, s){
            return true
        }
        if thisSymbol(b1,s ) && thisSymbol(b2, s) && thisSymbol(b3, s){
            return true
        }
        if thisSymbol(c1,s ) && thisSymbol(c2, s) && thisSymbol(c3, s){
            return true
        }
        // vertical victory
        if thisSymbol(a1,s ) && thisSymbol(b1, s) && thisSymbol(c1, s){
            return true
        }
        if thisSymbol(a2,s ) && thisSymbol(b2, s) && thisSymbol(c3, s){
            return true
        }
        if thisSymbol(a3,s ) && thisSymbol(b3, s) && thisSymbol(c3, s){
            return true
        }
        
        // diagonal victory
        if thisSymbol(a1,s ) && thisSymbol(b2, s) && thisSymbol(c3, s){
            return true
        }
        if thisSymbol(a3,s ) && thisSymbol(b2, s) && thisSymbol(c1, s){
            return true
        }
        return false
    }
    
    func thisSymbol(_ button: UIButton, _ symbol: String) -> Bool {
        return button.title(for: .normal) == symbol
    }
    
    func resultAlert(title : String){
        let message = "\nNoughts " + String(ouhScore) + "\n\nCrosses " + String(iksScore)
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "reset", style: .default, handler: {(_) in self.resetBoard()
        }))
        self.present(ac , animated: true)
    }
    func resetBoard(){
        
        for button in board
        {
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        if(firstturn == turn.ouh)
        {
            firstturn = turn.iks
            TurnLabel.text = iks
        }
        else if(firstturn == turn.iks)
        {
            firstturn = turn.ouh
            TurnLabel.text = ouh
        }
        currentTurn = firstturn
    }
    func fullBoard() -> Bool
    {
        for button in board{
            if button.title(for: .normal) == nil
            {
                return false
            }
        }
        return true
    }
    
    func addToBoard(_ sender: Any) {
        if ((sender as AnyObject).title(for: .normal) == nil ) {
            if(currentTurn == turn.ouh){
                
                (sender as AnyObject).setTitle(ouh, for: .normal)
                currentTurn = turn.iks
                TurnLabel.text = iks
                
            }
            else if(currentTurn == turn.iks){
                
                (sender as AnyObject).setTitle(iks, for: .normal)
                currentTurn = turn.ouh
                TurnLabel.text = ouh
            }
        }
    }
}
