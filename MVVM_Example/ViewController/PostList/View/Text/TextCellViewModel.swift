//
//  TextCellViewModel.swift
//  MVVM_Example
//
//  Created by hjliu on 2020/9/17.
//  Copyright © 2020 劉紘任. All rights reserved.
//

import Foundation

class TextCellViewModel: RowViewModel {
  
  let name: String
  let avatar: AsyncImage
  let postText: String
  
  init(name: String,
       avatar: AsyncImage,
       postText: String
  ) {
    self.name = name
    self.avatar = avatar
    self.postText = postText
  }
}
