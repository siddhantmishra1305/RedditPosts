//
//  PostCell.swift
//  Reddit
//
//  Created by Siddhant Mishra on 13/02/22.
//

import UIKit

class PostCell: UICollectionViewCell {
    
    @IBOutlet weak var galleryImageView: UIImageView!
    @IBOutlet weak var date_lbl: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var title_lbl: UILabel!
    
    var cellData:PostInfo!{
        didSet{
            activityIndicator.startAnimating()
            let timeInterval = TimeInterval(cellData.created!)
            date_lbl.text = Date(timeIntervalSince1970: timeInterval).toString(format: "dd-MMM-yyyy")
            title_lbl.text = cellData.title
            galleryImageView.imageFromServerURL(urlString: cellData.thumbnail ?? cellData.url_overridden_by_dest ?? "", placeHolder: nil) {[weak self] result in
                self?.activityIndicator.stopAnimating()
                if !result{
                    self?.galleryImageView.image = UIImage(named: "exclamationmark.triangle")
                }
            }
        }
    }
}
