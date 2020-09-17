//
//  RowViewModel.swift
//  MVVM_Example
//
//  Created by hjliu on 2020/9/10.
//  Copyright © 2020 劉紘任. All rights reserved.
//

import Foundation

protocol RowViewModel {
}

/// Conform this protocol to handles user press action
protocol ViewModelPressible {
  var cellPressed: (()->Void)? { get set }
}

protocol CellConfiguraable {
  func setup(viewModel: RowViewModel)
}

