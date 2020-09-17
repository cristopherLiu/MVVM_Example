//
//  RootController.swift
//  MVVM_Example
//
//  Created by hjliu on 2020/9/10.
//  Copyright © 2020 劉紘任. All rights reserved.
//

import Foundation

class PostListController {
  
  let viewModel: PostListViewModel
  private let dataService: DataService
  
  private var sourceData = [RowViewModel]()
  
  init(
    viewModel: PostListViewModel = PostListViewModel(),
    dataService: DataService = DataService()
  ) {
    self.viewModel = viewModel
    self.dataService = dataService
  }
  
  // Start
  func start() {
    
    self.viewModel.isLoading.value = true
    
    self.dataService.fetchData { (datas) in
      self.viewModel.isLoading.value = false
      self.buildViewModels(datas: datas)
    }
  }
  
  // MARK: - Data source
  private func buildViewModels(datas: [Base]) {
    
    var sectionTable = [String: [RowViewModel]]()
    var vm: RowViewModel?
    
    for data in datas {
      
      let groupingKey = sectionGroupingKey(data)
      
      if let textPost = data as? TextPost {
        
        let avatarImage = AsyncImage(url: textPost.avatarURL, placeholderImage: #imageLiteral(resourceName: "avatarPlaceholder"),imageDownloadHelper: ImageDownloadHelper())
        let textCellViewModel = TextCellViewModel(name: textPost.poster, avatar: avatarImage, postText: textPost.text)
        vm = textCellViewModel
        
      } else if let photoPost = data as? PhotoPost {
        
        let avatarImage = AsyncImage(url: photoPost.avatarURL, placeholderImage: #imageLiteral(resourceName: "avatarPlaceholder"),imageDownloadHelper: ImageDownloadHelper())
        let postImage = AsyncImage(url: photoPost.imageURL, imageDownloadHelper: ImageDownloadHelper())
        let photoCellViewModel = PhotoCellViewModel(name: photoPost.poster, avatar: avatarImage, postImage: postImage)
        photoCellViewModel.cellPressed = {
          print("Open a photo viewer!")
        }
        vm = photoCellViewModel
      }
      
      if let vm = vm {
        if var rows = sectionTable[groupingKey] {
          rows.append(vm)
          sectionTable[groupingKey] = rows
        } else {
          sectionTable[groupingKey] = [vm]
        }
      }
    }
    
    self.viewModel.sectionViewModels.value = converToSectionViewModel(sectionTable)
  }
  
  func cellIdentifier(for viewModel: RowViewModel) -> String {
    switch viewModel {
    case is PhotoCellViewModel:
      return PhotoCell.cellIdentifier()
    case is TextCellViewModel:
      return TextCell.cellIdentifier()
    default:
      fatalError("Unexpected view model type: \(viewModel)")
    }
  }
  
  /// Convert the date-hashed row viewmodels into array-based section viewmodels
  private func converToSectionViewModel(_ sectionTable: [String: [RowViewModel]]) -> [SectionViewModel] {
    // Sort the array base on the date
    let sortedGroupingKey = sectionTable.keys.sorted(by: dateStringDescComparator())
    
    return sortedGroupingKey.map {
      let rowViewModels = sectionTable[$0]!
      return SectionViewModel(rowViewModels: rowViewModels, headerTitle: $0)
    }
  }
  
  private func sectionGroupingKey(_ base: Base) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-mm-dd"
    return formatter.string(from: base.time)
  }
  
  private func dateStringDescComparator() -> ((String, String) -> Bool) {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-mm-dd"
    return { (d1Str, d2Str) -> Bool in
      if let d1 = formatter.date(from: d1Str), let d2 = formatter.date(from: d2Str) {
        return d1 > d2
      } else {
        return false
      }
    }
  }
}


