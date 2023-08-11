//
//  TodoCell.swift
//  TodoList
//
//  Created by t2023-m0062 on 2023/08/08.
//

import UIKit

class TodoCell: UITableViewCell {
    
    @IBOutlet weak var checkBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    func configureCell(isCompleted: Bool) {
        if isCompleted {
            checkBtn.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            textLabel?.textColor = .gray
            textLabel?.attributedText = strikeThrough()
        } else {
            checkBtn.setImage(UIImage(systemName: "circle"), for: .normal)
            textLabel?.textColor = .black
            guard let text = textLabel?.text else { return }
            textLabel?.attributedText = NSAttributedString(string: text)
        }
    }
    
    func strikeThrough() -> NSAttributedString{
        guard let text = textLabel?.text else { return  NSAttributedString() }
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: text)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
    
    //시간 추가하려면 여기에 추가하기

}
