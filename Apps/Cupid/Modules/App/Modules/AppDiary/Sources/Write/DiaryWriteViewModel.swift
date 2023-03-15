//
//  DiaryWriteViewModel.swift
//  AppDiary
//
//  Created by jcc on 2023/3/13.
//
import Foundation
import UICore
import Photos
import Service

class DiaryWriteViewModel: ViewModel {
    
    static let defaultItem = DiaryWritePictureItemViewModel(pictureType: .Action)
    
    private(set) lazy var items: [DiaryWritePictureItemViewModel] = [Self.defaultItem]
    
    private(set) lazy var urlMap: [String: String] = [:]
    
    var realItems: [DiaryWritePictureItemViewModel] {
        get {
            items.filter {
                $0.pictureType == .OnlyShow
            }
        }
    }
    
    
    func remove(index: Int) {
        self.items.remove(at: index)
    }

    func update(assets:[PHAsset?], images:[UIImage?]) {
        self.items.removeAll()
        self.items.append(Self.defaultItem)
        guard assets.count == images.count else {
            return
        }
        let count = assets.count
        var items: [DiaryWritePictureItemViewModel] = []
        for index in 0...(count - 1) {
            guard let asset = assets[safe:index] as? PHAsset, let image = images[safe:index] as? UIImage else { return }
            let item = DiaryWritePictureItemViewModel(pictureType: .OnlyShow, picture: image, asset: asset)
            if let identifier = item.identifier {
                item.url = self.urlMap[identifier]
            }
            items.append(item)
        }
        self.items.insert(contentsOf: items, at: 0)
    }
    
    func uploadSuccess(index: Int, url: String) {
        guard let identifier = self.items[index].identifier else { return }
        self.urlMap[identifier] = url
        self.items[index].url = url
    }
    
}

class DiaryWritePictureItemViewModel: ViewModel, Equatable {
    enum PictureType {
        case Action
        case OnlyShow
    }
    var pictureType: PictureType = .OnlyShow
    var picture: UIImage?
    var asset: PHAsset?
    var identifier: String?
    var url: String?
    
    init(pictureType: PictureType, picture: UIImage? = nil, asset: PHAsset? = nil) {
        self.pictureType = pictureType
        self.picture = picture
        self.asset = asset
        self.identifier = asset?.localIdentifier
        super.init()
    }
 
    static func == (lhs: DiaryWritePictureItemViewModel, rhs: DiaryWritePictureItemViewModel) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
