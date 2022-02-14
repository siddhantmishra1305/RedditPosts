//
//  DefaultsManager.swift
//  Reddit
//
//  Created by Siddhant Mishra on 13/02/22.
//
import Foundation

struct PersistenceMangaer{
    
    static let defaults = UserDefaults.standard
    private init(){}
    
    // save Data method
    static func saveFavImages(domainSchema: [PostInfo],key:String){
        do{
            let encoder = JSONEncoder()
            let domainsSchema = try encoder.encode(domainSchema)
            defaults.setValue(domainsSchema, forKey: key)
        }catch let err{
            print(err)
        }
    }
    
    //retrieve data method
    static func getFavImages(key:String) -> [PostInfo]{
        
        guard let domainSchemaData = defaults.object(forKey: key) as? Data else { return [PostInfo]() }
        do{
            let decoder = JSONDecoder()
            let domainsSchema = try decoder.decode([PostInfo].self, from: domainSchemaData)
            return domainsSchema
        }catch let err{
            print(err)
            return [PostInfo]()
        }
    }
}
