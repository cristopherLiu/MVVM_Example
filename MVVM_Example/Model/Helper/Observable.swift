//
//  Observable.swift
//  MVVM_Example
//
//  Created by hjliu on 2020/9/10.
//  Copyright © 2020 劉紘任. All rights reserved.
//

import Foundation

class Observable<T> {
  var value: T {
    didSet {
      DispatchQueue.main.async {
        self.valueChanged?(self.value)
      }
    }
  }
  
  private var valueChanged: ((T) -> Void)?
  
  init(value: T) {
    self.value = value
  }
  
  /// Add closure as an observer and trigger the closure imeediately if fireNow = true
  func addObserver(fireNow: Bool = true, _ onChange: ((T) -> Void)?) {
    valueChanged = onChange
    if fireNow {
      onChange?(value)
    }
  }
  
  func removeObserver() {
    valueChanged = nil
  }
}
