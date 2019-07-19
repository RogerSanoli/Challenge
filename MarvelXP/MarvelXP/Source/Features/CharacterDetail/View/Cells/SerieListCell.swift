//
//  SerieListCell.swift
//  MarvelXP
//
//  Created by Roger Sanoli on 19/07/19.
//  Copyright © 2019 RogerSanoli. All rights reserved.
//

import Foundation
import UIKit

class SerieListCell: UITableViewCell {
    
    @IBOutlet weak private var collectionView: UICollectionView!
    @IBOutlet weak private var loading: UIActivityIndicatorView!
    
    private var series: [SerieViewModel]?
    
    public func setup(_ viewModel: SerieListViewModel) {
        
        self.collectionView.isHidden = viewModel.isLoading
        self.loading.isHidden = !viewModel.isLoading
        
        guard !viewModel.isLoading else { return }
        
        self.series = viewModel.serieList
        self.setupCollectionView()
    }
    
    private func setupCollectionView() {
        self.collectionView.register(UINib(nibName: "SerieCell", bundle: nil), forCellWithReuseIdentifier: "SerieCell")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        let cellSize = CGSize(width: 150, height: 150)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        layout.minimumLineSpacing = 1.0
        layout.minimumInteritemSpacing = 1.0
        collectionView.setCollectionViewLayout(layout, animated: false)
    }
}

extension SerieListCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.series?.count ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell: SerieCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SerieCell", for: indexPath) as? SerieCell,
            let viewModel = self.series?[indexPath.row] {
            cell.setup(viewModel)
            return cell
        }
        
        assertionFailure("Invalid cell type.")
        return UICollectionViewCell(frame: .zero)
    }
}
