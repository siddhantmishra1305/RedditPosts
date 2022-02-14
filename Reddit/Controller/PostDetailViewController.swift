//
//  PostDetailViewController.swift
//  Reddit
//
//  Created by Siddhant Mishra on 13/02/22.
//

import UIKit

class PostDetailViewController: UIViewController {

    @IBOutlet weak var postDetailView: UIView!

    let postViewModel = PostViewModel()
    
    var postInformation : PostInfo!
    let postView = PostDetailView.fromNib()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        postView.imageData = postInformation
        postView.markAsFavBtn.addTarget(self, action: #selector(markAsFav(_:)), for: .touchUpInside)
        postDetailView.addSubview(postView)
        
        if postViewModel.checkIfFav(imageDetail: postInformation){
            postView.isFav = true
        }else{
            postView.isFav = false
        }
        
        self.postDetailView.setShadow(applyShadow: true)
    }
    
    @objc func markAsFav(_ sender: UIButton?) {
        if postView.isFav{
            postView.isFav = false
            postViewModel.unMarkAsFav(imageDetail: postInformation)
        }else{
            postView.isFav = true
            postViewModel.markFav(imageDetail: postInformation)
        }
    }
    
}
