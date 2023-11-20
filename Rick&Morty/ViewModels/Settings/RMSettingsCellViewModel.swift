//
//  RMSettingsCellViewModel.swift
//  Rick&Morty
//
//  Created by Celil Çağatay Gedik on 20.11.2023.
//

import UIKit

struct RMSettingsCellViewModel {
    public let type: RMSettingsOption
    
    init(type: RMSettingsOption) { self.type = type }
    
    public var image: UIImage? { return type.iconImage }
    
    public var title: String { return type.displayTitle }
    
    public var iconContainerColor: UIColor { return type.iconContainerColor }
}
