//
//  ImageViewerVC.swift
//  MVVM_Example
//
//  Created by hjliu on 2020/9/17.
//  Copyright © 2020 劉紘任. All rights reserved.
//

import UIKit

class ImageViewerVC: DialogVC {
  
  //cancel按鈕
  private lazy var cancelButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage.common_cancel_w, for: .normal)
    button.addTarget(self, action: #selector(tapCancel), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  lazy var imageView: UIImageView = {
    let view = UIImageView()
    view.contentMode = .scaleAspectFit
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private var data: UIImage?
  
  init(image: UIImage) {
    super.init()
    self.data = image
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initView()
//    initBinding()
  }
  
  func initView() {
    
    imageView.image = self.data
    
    view.addSubview(cancelButton)
    
    contentView.backgroundColor = UIColor.clear
    contentView.addSubview(imageView)
    
    
    let screenSize: CGRect = UIScreen.main.bounds
    let width = min(screenSize.width, screenSize.height) - 64
    
    NSLayoutConstraint.activate([
      
      cancelButton.widthAnchor.constraint(equalToConstant: 40),
      cancelButton.heightAnchor.constraint(equalToConstant: 40),
      cancelButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 32),
      cancelButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
      
      contentView.widthAnchor.constraint(equalTo: contentView.heightAnchor),
      contentView.heightAnchor.constraint(equalToConstant: width),
      
      imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
      imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
    ])
  }
  
  // 關閉
  @objc func tapCancel() {
    self.hideWithAnimate()
  }
}
