//
//  PhotosViewController.swift
//  Navigator
//
//  Created by Jazzband on 03.01.2023.
//

import UIKit

class PhotosViewController: UIViewController{

    var isPhotoatCentre: Bool = false

    var photoData: [String] = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20"]

    lazy var phoneView: UIView = {
        let phoneView = UIView()
        phoneView.alpha = 0
        phoneView.isHidden = true
        phoneView.translatesAutoresizingMaskIntoConstraints = false
        return phoneView
    }()

    lazy var imageInCenter: UIImageView = {
        let imageInCenter = UIImageView()
        imageInCenter.alpha = 0
        imageInCenter.isHidden = true
        imageInCenter.translatesAutoresizingMaskIntoConstraints = false
        return imageInCenter
    }()

    lazy var escapeButton: UIButton = {
        let escapeButton = UIButton()
        escapeButton.setImage(UIImage(systemName: "delete.backward.fill"), for: .normal)
        escapeButton.addTarget(self, action: #selector(escapeButtonAction), for: .touchUpInside)
        escapeButton.translatesAutoresizingMaskIntoConstraints = false
        return escapeButton
    }()


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

    @objc func escapeButtonAction(){
        UIView.animate(withDuration: 0.5, delay: 0, animations: {
            self.imageInCenter.alpha = 0
            self.phoneView.alpha = 0
        }) {_ in
            self.phoneView.backgroundColor = UIColor(white: 1, alpha: 0)
            self.phoneView.isHidden = true
            self.imageInCenter.isHidden = true
            self.escapeButton.isHidden = true
        }
        isPhotoatCentre = false
    }

    private func imageTapped() {
        guard isPhotoatCentre == false else { return }
        isPhotoatCentre = true
        escapeButton.alpha = 0
        self.escapeButton.isHidden = false
        self.phoneView.isHidden = false
        self.imageInCenter.isHidden = false
        UIView.animate(withDuration: 1, delay: 0, animations: {
            self.phoneView.backgroundColor = .white
            self.phoneView.alpha = 0.7
        }) {_ in
            UIView.animate(withDuration: 1, delay: 0, animations: {
                self.imageInCenter.alpha = 1
            })
        }
        UIView.animate(withDuration: 0.3, delay: 0.5, animations: {
            self.escapeButton.alpha = 1
        })

    }


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        collectioView.dataSource = self
        collectioView.delegate = self
        collectioView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.id)
        view.addSubview(collectioView)
        view.addSubview(phoneView)
        view.addSubview(imageInCenter)
        view.addSubview(escapeButton)
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
            collectioView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectioView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectioView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            phoneView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            phoneView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            phoneView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            phoneView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            imageInCenter.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            imageInCenter.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            imageInCenter.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            imageInCenter.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            escapeButton.topAnchor.constraint(equalTo: phoneView.topAnchor, constant: 16),
            escapeButton.trailingAnchor.constraint(equalTo: phoneView.trailingAnchor, constant: -16)
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
        CGSize(width: (UIScreen.main.bounds.width - 38)/3, height: 100)
    }

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        imageInCenter.image =  UIImage(named: photoData[indexPath.item])
        imageTapped()

    }


}







