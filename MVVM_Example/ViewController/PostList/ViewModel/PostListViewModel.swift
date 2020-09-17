//
//  RootViewModel.swift
//  MVVM_Example
//
//  Created by hjliu on 2020/9/10.
//  Copyright © 2020 劉紘任. All rights reserved.
//

import UIKit

class PostListViewModel {
  let isLoading = Observable<Bool>(value: false)
  let sectionViewModels = Observable<[SectionViewModel]>(value: [])
  let showImageDialog = Observable<UIImage>(value: UIImage())
}
