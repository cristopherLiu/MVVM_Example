//
//  DataService.swift
//  MVVM_Example
//
//  Created by hjliu on 2020/9/10.
//  Copyright © 2020 劉紘任. All rights reserved.
//

import Foundation

class DataService {
  
  /// Making feed stubs
  private lazy var bases: [Base] = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-mm-dd"
    let bases: [Base] = (0...60).map { idx in
      
      let id = "\(idx)"
      let time = formatter.date(from: String(format: "2049-06-%02d", (idx/6)+1))!
      let avatarURL = "https://picsum.photos/45/45/?random"
      let poster = String.anyName
      
      if idx % 3 == 1 {
        let desc = String.loremIpsum
        return TextPost(id: id, time: time, avatarURL: avatarURL, poster: poster, text: desc)
      } else {
        let imageURL = randomUrl
        return PhotoPost(id: id, time: time, avatarURL: avatarURL, poster: poster, imageURL: imageURL)
      }
    }
    return bases
  }()
  
  private let urls = [
    "https://picsum.photos/300/300/?random",
    "https://picsum.photos/200/400/?random",
    "https://picsum.photos/400/500/?random",
    "https://picsum.photos/500/200/?random"
  ]
  
  private var randomUrl: String {
    let randIdx = Int(arc4random_uniform(UInt32(urls.count)))
    return urls[randIdx]
  }
  
  /// Fetch feeds from server
  func fetchData(complete: @escaping ([Base]) -> Void) {
    DispatchQueue.global().async {
      sleep(3) // fake response time
      DispatchQueue.main.async {
        complete(self.bases)
      }
    }
  }
}


public extension String {
  /// Ramdomly generated text
  static var loremIpsum: String {
    let baseStr = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas blandit aliquet orci, tincidunt pellentesque eros condimentum quis. Morbi efficitur, metus at tristique gravida, nisi nisi accumsan dolor, a porttitor libero libero eu nunc. Aenean augue mi, facilisis in vulputate at, luctus eget nibh. Nulla condimentum metus sit amet nunc commodo, at tempor velit hendrerit. Vivamus vitae pharetra quam, a fermentum diam. Aliquam dapibus justo ut turpis mattis, in feugiat purus fringilla. In hac habitasse platea dictumst."
    let strLst = baseStr.components(separatedBy: " ")
    let offset = Int(arc4random_uniform(UInt32(strLst.count)))
    let substringLst = strLst[offset..<strLst.count]
    return substringLst.joined(separator: " ")
  }
  
  private static var nameList = ["Emily", "Michael", "Hannah", "Jacob", "Alex", "Ashley", "Tyler", "Taylor", "Andrew", "Jessica", "Daniel", "Katie", "John", "Emma", "Matthew", "Lauren", "Ryan", "samantha", "Austin", "Rachel", "David", "olivia", "Chris", "Kayla", "Nick", "Anna", "Brandon", "Megan", "Nathan", "Alyssa", "Anthony", "Alexis", "Grace", "Justin", "Madison", "Joshua", "elizabeth", "Jordan", "Nicole", "Jake", "Jack", "Abby", "Dylan", "Victoria", "james", "Brianna", "kyle", "Morgan", "Kevin", "Amber", "Ben", "Sydney", "Noah", "Brittany", "Eric", "Haley", "Sam", "Natalie", "Christian", "Julia", "Josh", "Savannah", "Zach", "Danielle", "Joseph", "Courtney", "Logan", "Rebecca", "Jonathan", "Paige", "Adam", "Jasmine", "Aaron", "Sara", "Jason", "Stephanie", "Christopher"]
  
  /// Ramdomly generated name
  static var anyName: String {
    let randIdx = Int(arc4random_uniform(UInt32(nameList.count)))
    return nameList[randIdx]
  }
}
