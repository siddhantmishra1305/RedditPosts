//
//  PostDetailView.swift
//  Reddit
//
//  Created by Siddhant Mishra on 13/02/22.
//

import UIKit

class PostDetailView: UIView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var title_lbl: UILabel!
    @IBOutlet weak var markAsFavBtn: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var author_lbl: UILabel!
    @IBOutlet weak var postDescription: UILabel!
    
    var imageData:PostInfo!{
        didSet{
            self.activityIndicator.startAnimating()
            
            title_lbl.text = imageData.author_fullname
//            author_lbl.text = imageData.author_fullname
            postDescription.text = imageData.title
            
            imageView.imageFromServerURL(urlString: imageData.url_overridden_by_dest ?? imageData.thumbnail ?? "", placeHolder: UIImage(named: "exclamationmark.triangle")) {[weak self] result in
                self?.activityIndicator.stopAnimating()
                if !result{
                    self?.imageView.image = UIImage(named: "exclamationmark.triangle")
                }
            }
        }
    }
    
    var isFav:Bool!{
        didSet{
            if isFav{
                self.markAsFavBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            }else{
                self.markAsFavBtn.setImage(UIImage(systemName: "heart"), for: .normal)
            }
        }
    }
}
