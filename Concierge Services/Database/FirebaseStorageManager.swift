import SwiftUI
import FirebaseCore
import FirebaseStorage

class FirebaseStorageManager: ObservableObject {
    
    let storage = Storage.storage()
    
    func uploadImage(image: UIImage, userId: String, ownerId: String, imageUploaded: @escaping (Bool) -> ()) {
        let storageRef = storage.reference().child("images").child(userId).child(ownerId).child(String(Date().millisecondsSince1970)+".jpg")
        
        //let resizedImage = image.aspectFittedToHeight(200)
        
        let data = image.jpegData(compressionQuality: 0.9)
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        if let data = data {
            storageRef.putData(data, metadata: metadata) { (metadata, error) in
                if let error = error {
                    print("Error while uploading file: ", error)
                    imageUploaded(false)
                }
                
                if let metadata = metadata {
                    print("Metadata: ", metadata)
                    imageUploaded(true)
                }
            }
        }
    }
    
    func uploadFile(fileUrl: URL, userId: String, ownerId: String, fileUploaded: @escaping (URL?) -> ()) {
        
        //let fileExtension = String(filepath[...filepath.lastIndex(of: ".")!])
        //print("File extension: " + fileExtension)
        
        let storageRef = storage.reference().child("images").child(userId).child(ownerId).child(String(Date().millisecondsSince1970) + fileUrl.pathExtension)
        
        //let localFile = URL(string: filepath)!
        
        let uploadTask = storageRef.putFile(from: fileUrl, metadata: nil) { metadata, error in
            guard let metadata = metadata else {
                print("Error uploading file: ", error)
                fileUploaded(nil)
                return
            }
            
            let size = metadata.size
            storageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    print("Error uploading file: ", error)
                    fileUploaded(nil)
                    return
                }
                fileUploaded(downloadURL)
            }
        }
    }
    
    func listAllFiles(userId: String, ownerId: String, loadedFiles: @escaping ([StorageReference]) -> ()) {
        let storageRef = storage.reference().child("images").child(userId).child(ownerId)
        
        var filenames: [StorageReference] = []
        
        // List all items in the images folder
        storageRef.listAll { (result, error) in
            if let error = error {
                print("Error while listing all files: ", error)
                loadedFiles(filenames)
            }
            
            for item in result!.items {
                filenames.append(item)
                print("Item in images folder: ", item)
            }
            loadedFiles(filenames)
        }
    }
    
    func deleteItem(item: StorageReference, fileDeleted: @escaping (Bool) -> ()) {
        item.delete { error in
            if let error = error {
                print("Error deleting item", error)
                fileDeleted(false)
            } else {
                fileDeleted(true)
            }
        }
    }
}
