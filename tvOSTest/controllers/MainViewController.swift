//
//  ViewController.swift
//  testTV
//
//  Created by Alexey Nikiforov on 19.06.2020.
//  Copyright © 2020 Alexey Nikiforov. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
   
    
    var images: [String] = []
    

    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    
    private func loadData() {
        images.removeAll()
        for i in 0...10 {
            images.append(String((i % 4)+1))
        }
    }
    
    private func setupCollectionVeiwLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 500, height: 500
        )
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 5
        imageCollectionView?.setCollectionViewLayout(flowLayout, animated: true)
        imageCollectionView?.dataSource = self
        imageCollectionView?.delegate = self

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionVeiwLayout()
        loadData()
        imageCollectionView?.reloadData()


        
        
        // Do any additional setup after loading the view.
    }


}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mediaCell", for: indexPath) as? MediaCell else { return UICollectionViewCell()  }
            cell.configure(path: images[indexPath.item])

        return cell
    }
    

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        if (indexPath.row == 2-1)
        {
        
            let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "player") as! PlayerViewController
            present(vc, animated: true)
        }
        else
        {
            let alert = UIAlertController(title: "Wrong select!", message: "Select not second!", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
           
            self.present(alert, animated: true)
        }
    }
}


class DefaultCollectionViewDelegate: NSObject, CollectionViewSelectableItemDelegate {
    var didSelectItem: ((_ indexPath: IndexPath) -> Void)?

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectItem?(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.clear
    
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.green
    }
    
}


protocol CollectionViewSelectableItemDelegate: class, UICollectionViewDelegateFlowLayout {
    var didSelectItem: ((_ indexPath: IndexPath) -> Void)? { get set }
}

