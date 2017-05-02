//
//  TopicTableViewCell.swift
//  iQuiz
//
//  Created by Duncan Andrew on 4/28/17.
//  Copyright © 2017 Duncan Andrew. All rights reserved.
//

import UIKit

class TopicTableViewCell: UITableViewCell {

    @IBOutlet weak var topicTitle: UILabel!
    @IBOutlet weak var topicDescr: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        topicDescr.lineBreakMode = .byWordWrapping
        topicDescr.numberOfLines = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
