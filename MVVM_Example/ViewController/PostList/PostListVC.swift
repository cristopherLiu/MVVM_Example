//
//  RootVC.swift
//  MVVM_Example
//
//  Created by hjliu on 2020/9/10.
//  Copyright © 2020 劉紘任. All rights reserved.
//

import UIKit

class PostListVC: UIViewController {
  
  // Model
  var viewModel: PostListViewModel {
    return controller.viewModel
  }
  
  lazy var controller: PostListController = {
    return PostListController()
  }()
  
  // UI
  private lazy var tableView: UITableView = {
    let view = UITableView()
    view.backgroundColor = UIColor.clear
    view.delegate = self
    view.dataSource = self
    view.register(PhotoCell.self, forCellReuseIdentifier: PhotoCell.cellIdentifier())
    view.register(TextCell.self, forCellReuseIdentifier: TextCell.cellIdentifier())
    view.separatorStyle = UITableViewCell.SeparatorStyle.none
    view.rowHeight = UITableView.automaticDimension
    view.estimatedRowHeight = 44
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  lazy var loadingIdicator: UIActivityIndicatorView = {
    let indicator = UIActivityIndicatorView(style: .whiteLarge)
    indicator.translatesAutoresizingMaskIntoConstraints = false
    indicator.hidesWhenStopped = true
    self.view.addSubview(indicator)
    NSLayoutConstraint.activate([
      indicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      indicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
    ])
    return indicator
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initView()
    initBinding()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: false) //關閉NV bar
    controller.start()
  }
  
  func initView() {
    
    view.backgroundColor = UIColor.pri
    view.addSubview(tableView)
    
    NSLayoutConstraint.activate([
      tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
      tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
      tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
    ])
  }
  
  func initBinding() {
    
    viewModel.isLoading.addObserver { [weak self] (isLoading) in
      if isLoading {
        self?.loadingIdicator.startAnimating()
      } else {
        self?.loadingIdicator.stopAnimating()
      }
    }
    
    viewModel.sectionViewModels.addObserver(fireNow: false) { [weak self] (models) in
      self?.tableView.reloadData()
    }
  }
}

extension PostListVC: UITableViewDataSource, UITableViewDelegate {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return viewModel.sectionViewModels.value.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let sectionViewModel = viewModel.sectionViewModels.value[section]
    return sectionViewModel.rowViewModels.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let sectionViewModel = viewModel.sectionViewModels.value[indexPath.section]
    let rowViewModel = sectionViewModel.rowViewModels[indexPath.row]
    
    let cell = tableView.dequeueReusableCell(withIdentifier: controller.cellIdentifier(for: rowViewModel), for: indexPath)
    if let cell = cell as? CellConfiguraable {
      cell.setup(viewModel: rowViewModel)
    }
    cell.layoutIfNeeded()
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let sectionViewModel = viewModel.sectionViewModels.value[indexPath.section]
    if let rowViewModel = sectionViewModel.rowViewModels[indexPath.row] as? ViewModelPressible {
      rowViewModel.cellPressed?()
    }
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let view = SectionHeaderView()
    let sectionViewModel = viewModel.sectionViewModels.value[section]
    view.setTitle(sectionViewModel.headerTitle)
    return view
  }
}
