//
//  DetailViewModel.swift
//  Reddit Client
//
//  Created by Женя on 31.05.2021.
//

import Foundation

class DetailViewModel: ObservableObject {
    
    //MARK: - Private properties
    
    private var imageSaver: ImageSaver

    //MARK: - Public properties

    var url: String?
    var saveButtonEnable: Bool
    @Published var imageWasSaved = false
    
    //MARK: - Initialization
    
    init(url: String?, saveButtonEnable: Bool = false) {
        self.url = url
        self.saveButtonEnable = saveButtonEnable
        imageSaver = ImageSaver()
        imageSaver.didFinishSaving = {
            self.imageWasSaved = true
        }
    }
    
    //MARK: - Public methods

    func savePhoto() {
        imageSaver.savePhoto(from: url)
    }
}
