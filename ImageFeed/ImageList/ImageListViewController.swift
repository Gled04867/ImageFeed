//
//  ViewController.swift
//  ImageFeed
//
//  Created by Gleb on 02.03.2026.
//

import UIKit

class ImageListViewController: UIViewController {

    @IBOutlet private var tableView: UITableView!
    
    private let photosName: [String] = Array(0..<20).map{"\($0)"}
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 200
        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        
    }
    
    func configCell(for cell: ImageListCell, with indexPath: IndexPath) {
        if let image = UIImage(named: photosName[indexPath.row]) {
            cell.imageInCell.image = image
            cell.dateLabel.text = dateFormatter.string(from: Date())
        } else {
            return
        }
        if indexPath.row % 2 == 0 {
            let likeButton = UIImage(named: "Active")
            cell.likeButton.setImage(likeButton, for: .normal)
        } else {
            let likeButton = UIImage(named: "No Active")
            cell.likeButton.setImage(likeButton, for: .normal)
        }
    }


}

extension ImageListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let image = UIImage(named: photosName[indexPath.row]) else {
            return 0
        }
        let insets = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
        let imageViewWidth = tableView.bounds.width - insets.left - insets.right
        let scale = imageViewWidth/image.size.width
        let height = image.size.height * scale
        let cellHeight = height + insets.top + insets.bottom
        return cellHeight
    }
}

extension ImageListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photosName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImageListCell.reuseIdentifier, for: indexPath)
        
        guard let imageListCell = cell as? ImageListCell else {
            return UITableViewCell()
        }
        
        configCell(for: imageListCell, with: indexPath)
        return imageListCell
    }
    
    
}
