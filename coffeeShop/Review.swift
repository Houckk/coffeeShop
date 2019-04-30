//
//  Review.swift
//  LeagueOfLegends
//
//  Created by 18ericz on 4/28/19.
//  Copyright © 2019 18ericz. All rights reserved.
//

import Foundation
import Firebase
import FirebaseUI

class Review {
    var email: String
    var title: String
    var review: String
    var documentID: String
    var dictionary: [String: Any] {
        return ["email": email, "title":title, "review": review, "documentID": documentID]
    }
    
    init(email: String, title: String, review: String, documentID: String){
        self.email = email
        self.title = title
        self.review = review
        self.documentID = documentID
    }
    
    convenience init() {
        let currentUserID = Auth.auth().currentUser?.email ?? "Unknown"
        
        self.init(email: currentUserID, title: "", review: "", documentID: "")
    }
    
    
    func saveData(champion: Food , completed: @escaping (Bool) -> ()) {
        let db = Firestore.firestore()

        let dataToSave = self.dictionary
        if self.documentID != "" {
            let ref = db.collection("Review").document(self.documentID).collection("reviews").document(self.documentID)
            ref.setData(dataToSave) { (error) in
                if let error = error {
                    print("ERROR UPDATING DOCUMENT")
                    completed(false)
                } else {
                    print("DOCUMENT UPDATED")
                    completed(true)
                }
            }
        } else{
            var ref: DocumentReference? = nil
            ref = db.collection("Review").document(self.documentID).collection("reviews").addDocument(data: dataToSave){error in
                if let error = error {
                    print("Error creating new document")
                    completed(false)
                    
                } else {
                    print("New document created")
                    completed(true)
                }
            }
        }
    }

}
