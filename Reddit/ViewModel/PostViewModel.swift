//
//  PostViewModel.swift
//  Reddit
//
//  Created by Siddhant Mishra on 13/02/22.
//

import Foundation
import CoreData

class PostViewModel{
    
    var allPosts : [Children]? = [Children]()
    var filteredPosts : [Children]?
    var serverManager : ServerManagerProtocol!
    
    
    
    init(serverManager : ServerManagerProtocol = ServerManager()) {
        self.serverManager = serverManager
    }
    
    func getPosts(handler:@escaping (Bool, String)->Void){
        serverManager.request(config: .default, router: ServerRequest.getPosts) {[weak self] (result:Result<RedditResponse,NetworkError>) in
            
            switch result{
            case .success(let response):
                self?.allPosts = response.postData?.allPosts
                self?.filteredPosts = self?.allPosts
                handler(true, "Success")
                break
                
            case .failure(let error):
                handler(false, error.description)
                break
            }
        }
    }
    
    func checkIfFav(imageDetail:PostInfo)->Bool{
        let favItems = PersistenceMangaer.getFavImages(key: Constants.bookmarkedItems)
        let itemIndex = favItems.firstIndex{$0.title == imageDetail.title}
        if itemIndex != nil{
            return true
        }
        return false
    }
    
    func markFav(imageDetail:PostInfo){
        var favItems = PersistenceMangaer.getFavImages(key: Constants.bookmarkedItems)
        favItems.append(imageDetail)
        PersistenceMangaer.saveFavImages(domainSchema: favItems, key: Constants.bookmarkedItems)
    }
    
    func unMarkAsFav(imageDetail:PostInfo){
        var favItems = PersistenceMangaer.getFavImages(key: Constants.bookmarkedItems)
        favItems.removeAll{
            $0.title == imageDetail.title
        }
        PersistenceMangaer.saveFavImages(domainSchema: favItems, key: Constants.bookmarkedItems)
    }
    
    func filterPosts(title:String){
        if title.count == 0 {
            allPosts = filteredPosts
        }else{
            allPosts = filteredPosts?.filter{
                $0.postInfo?.title?.contains(title) as! Bool
            }
        }
    }
}

