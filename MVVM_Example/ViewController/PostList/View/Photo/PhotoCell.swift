//
//  PhotoCell.swift
//  MVVM_Example
//
//  Created by hjliu on 2020/9/17.
//  Copyright © 2020 劉紘任. All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell, CellConfiguraable {
  
  /// UI
  private lazy var profileImageView: UIImageView = {
    let view = UIImageView()
    view.backgroundColor = UIColor.white
    view.translatesAutoresizingMaskIntoConstraints = false
    view.layer.cornerRadius = 24
    view.clipsToBounds = true
    contentView.addSubview(view)
    return view
  }()
  
  private lazy var nameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 24)
    label.textAlignment = NSTextAlignment.left
    label.textColor = UIColor.w
    label.numberOfLines = 1
    label.lineBreakMode = .byTruncatingTail
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private lazy var bgView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.w
    view.layer.cornerRadius = 16
    view.clipsToBounds = true
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private lazy var contentImageView: UIImageView = {
    let view = UIImageView()
    view.contentMode = .scaleAspectFill
    view.backgroundColor = UIColor.clear
    view.clipsToBounds = true
    view.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(view)
    return view
  }()
  
  // loaging
  lazy var loadingIndicator: UIActivityIndicatorView = {
    let indicator = UIActivityIndicatorView(style: .gray)
    indicator.translatesAutoresizingMaskIntoConstraints = false
    return indicator
  }()
  
  var viewModel: PhotoCellViewModel?
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    backgroundColor = UIColor.clear
    contentView.addSubview(profileImageView)
    contentView.addSubview(nameLabel)
    contentView.addSubview(bgView)
    bgView.addSubview(contentImageView)
    bgView.addSubview(loadingIndicator)
    
    NSLayoutConstraint.activate([
      profileImageView.widthAnchor.constraint(equalToConstant: 48),
      profileImageView.heightAnchor.constraint(equalToConstant: 48),
      profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
      profileImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
      
      nameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
      nameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 16),
      nameLabel.rightAnchor.constraint(lessThanOrEqualTo: contentView.rightAnchor, constant: -16),
      
      bgView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
      bgView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -120),
      bgView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 24),
      bgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
      
      contentImageView.leftAnchor.constraint(equalTo: bgView.leftAnchor, constant: 16),
      contentImageView.rightAnchor.constraint(equalTo: bgView.rightAnchor, constant: -16),
      contentImageView.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 24),
      contentImageView.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -24),
      contentImageView.heightAnchor.constraint(equalToConstant: 350),
      
      loadingIndicator.centerXAnchor.constraint(equalTo: bgView.centerXAnchor),
      loadingIndicator.centerYAnchor.constraint(equalTo: bgView.centerYAnchor),
    ])
    
    self.selectionStyle = UITableViewCell.SelectionStyle.none
    self.accessoryType = UITableViewCell.AccessoryType.none
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    self.selectionStyle = UITableViewCell.SelectionStyle.none
    self.accessoryType = UITableViewCell.AccessoryType.none
  }
  
  func setup(viewModel: RowViewModel){
    guard let viewModel = viewModel as? PhotoCellViewModel else { return }
    self.viewModel = viewModel
    
    profileImageView.image = viewModel.avatar.image
    viewModel.avatar.completeDownload = { [weak self] image in
      self?.profileImageView.image = image
    }
    viewModel.avatar.startDownload()
    
    nameLabel.text = viewModel.name
    
//    contentImageView.image = viewModel.postImage.image
    
    self.loadingIndicator.startAnimating()
    viewModel.postImage.completeDownload = { [weak self] image in
      self?.loadingIndicator.stopAnimating()
      self?.contentImageView.image = image
    }
    viewModel.postImage.startDownload()
    
    setNeedsLayout()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    self.contentImageView.image = nil
    viewModel?.postImage.completeDownload = nil
    viewModel?.cellPressed = nil
  }
}
