//
//  PhotoCellViewModel.swift
//  MVVM_Example
//
//  Created by hjliu on 2020/9/17.
//  Copyright © 2020 劉紘任. All rights reserved.
//

import Foundation

class PhotoCellViewModel: RowViewModel, ViewModelPressible {
  
  let name: String
  let avatar: AsyncImage
  let postImage: AsyncImage
  var cellPressed: (() -> Void)?
  
  init(name: String,
       avatar: AsyncImage,
       postImage: AsyncImage,
       cellPressed: (() -> Void)? = nil) {
    self.name = name
    self.avatar = avatar
    self.postImage = postImage
    self.cellPressed = cellPressed
  }
}
