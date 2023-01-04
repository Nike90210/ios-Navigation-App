//
//  PhotosViewController.swift
//  Navigator
//
//  Created by Jazzband on 03.01.2023.
//

import UIKit

class PhotosViewController: UIViewController{

    var photoData: [String] = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20"]

    let collectioView : UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.init())
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 8
        flowLayout.minimumInteritemSpacing = 8
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        collectionView.collectionViewLayout = flowLayout
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        collectioView.dataSource = self
        collectioView.delegate = self
        collectioView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.id)
        view.addSubview(collectioView)
        setConstrainsForCollectioView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        titleSetings()
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }

    func titleSetings(){
        title = "Photo's Gallery"
        let navigationAppearance = UINavigationBarAppearance()
        navigationAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationAppearance.backgroundColor = .black
    }

}

extension PhotosViewController {

    func setConstrainsForCollectioView(){
        NSLayoutConstraint.activate([

            collectioView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectioView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectioView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectioView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photoData.count

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.id, for: indexPath) as! PhotoCollectionViewCell
        cell.PhotoName = photoData[indexPath.item]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (UIScreen.main.bounds.width - 48)/3, height: 100)
    }


}







