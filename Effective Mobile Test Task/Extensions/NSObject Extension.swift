//
//  NSObject.swift
//  Effective Mobile Test Task
//
//  Created by Анна Шапагатян on 31.05.24.
//

import UIKit

extension NSObject {
    class var name: String {
        return String(describing: self)
    }
    
    func configLabel(imageString: String, string: String, label: UILabel) {
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: imageString)
        let attachmantImage = attachment.image
        let attachmentString = NSAttributedString(attachment: attachment)
        let myString = NSMutableAttributedString(string: string)
        myString.append(attachmentString)
        label.attributedText = myString
    }
}
