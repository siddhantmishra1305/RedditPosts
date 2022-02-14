//
//  ViewController.swift
//  Reddit
//
//  Created by Siddhant Mishra on 13/02/22.
//

import UIKit

class PostViewController: UIViewController {
    
    @IBOutlet weak var postCollectionView: UICollectionView!
    @IBOutlet weak var searchPostBar: UISearchBar!
    
    let postViewModel = PostViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        postCollectionView.register(UINib(nibName: "PostCell", bundle: nil), forCellWithReuseIdentifier: "PostCell")
        postViewModel.getPosts { [weak self]isSuccess, message in
            if isSuccess{
                DispatchQueue.main.async {
                    self?.postCollectionView.reloadData()
                }
            }
        }
    }
}

extension PostViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.postViewModel.allPosts?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as! PostCell
        cell.cellData  = self.postViewModel.allPosts?[indexPath.row].postInfo
        cell.setShadow(applyShadow: true)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width - 30) / 2
        return CGSize(width: size, height: size + 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let postDetails = self.postViewModel.allPosts?[indexPath.row].postInfo else{
            return
        }
        navigateToDetailScreenWithDetail(postInfo: postDetails)
    }
    
    func navigateToDetailScreenWithDetail(postInfo:PostInfo){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let postDetailVC = storyBoard.instantiateViewController(withIdentifier: "PostDetailViewController") as! PostDetailViewController
        postDetailVC.postInformation = postInfo
        self.navigationController?.pushViewController(postDetailVC, animated: true);
    }
}


extension  PostViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        postViewModel.filterPosts(title: searchText)
        postCollectionView.reloadData()
    }
}
