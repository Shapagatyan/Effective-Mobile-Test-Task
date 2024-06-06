//
//  UICollectionView Extension.swift
//  Effective Mobile Test Task
//
//  Created by Анна Шапагатян on 31.05.24.
//

import UIKit

extension UICollectionView {
    func registerCell(cell: UICollectionViewCell.Type) {
        self.register(UINib(nibName: cell.name, bundle: nil), forCellWithReuseIdentifier: cell.name)
    }
    
    func registerSectionHeader(view: UICollectionReusableView.Type) {
        register(UINib(nibName: view.name, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: view.name)
    }
}
