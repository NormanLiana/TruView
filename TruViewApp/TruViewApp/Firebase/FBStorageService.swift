
import Foundation
import FirebaseStorage

class FirebaseStorageService {
    static var manager = FirebaseStorageService()
    
    private let storage: Storage!
    private let storageReference: StorageReference
    private let imagesFolderReference: StorageReference
    
    private init() {
        storage = Storage.storage()
        storageReference = storage.reference()
        imagesFolderReference = storageReference.child("images")
    }
    
    func storeImage(image: Data,  completion: @escaping (Result<URL,Error>) -> ()) {
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        let uuid = UUID()
        let imageLocation = imagesFolderReference.child(uuid.description)
        imageLocation.putData(image, metadata: metadata) { (responseMetadata, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                imageLocation.downloadURL { (url, error) in
                    guard error == nil else {completion(.failure(error!));return}
//MARK: still need to create app errors
                    guard let url = url else {completion(.failure(error!));return}
                    completion(.success(url))
                }
            }
        }
    }
}



