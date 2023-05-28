//
//  FinanceViewController.swift
//  algel
//
//  Created by Toygun Çil on 6.05.2023.
//

import UIKit

class FinanceViewController: UIViewController {

    @IBOutlet weak var seperatorView: UIView!
    @IBOutlet weak var financeCV: UICollectionView!
    @IBOutlet weak var financeTypeCV: UICollectionView!
    
    var items: [Int] = Array(1...5)
    var financeList: FinanceListResponse? = GlobalService.sharedGlobal.financeList {
        didSet {
            financeCV.reloadData()
        }
    }
    var income: Bool = true {
        didSet {
            viewModel.getFinanceList { value in
                GlobalService.sharedGlobal.financeList = value
                self.financeList = value
            }
        }
    }
    let viewModel = FinanceViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        financeCV.dataSource = self
        financeCV.delegate = self
        financeTypeCV.dataSource = self
        financeTypeCV.delegate = self
        
        financeCV.register(UINib(nibName: String(describing: FinanceCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: FinanceCell.self))
        financeTypeCV.register(UINib(nibName: String(describing: IncomeCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: IncomeCell.self))
        financeTypeCV.register(UINib(nibName: String(describing: SpentCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: SpentCell.self))
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getFinanceList { value in
            GlobalService.sharedGlobal.financeList = value
            self.financeList = value
        }
    }
    
    func setupUI() {
        configureBackgroundColor()
        financeTypeCV.backgroundColor = .clear
        financeCV.backgroundColor = .clear
        let index = IndexPath(item: 0, section: 0)
        financeTypeCV.selectItem(at: index, animated: true, scrollPosition: .left)
    }
}

extension FinanceViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == financeTypeCV {
            return 2
        } else {
            if income {
                return financeList?.income.count ?? 0
            } else {
                return financeList?.outgone.count ?? 0
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == financeTypeCV {
            if indexPath.item == 0 {
                guard let incomeCell = financeTypeCV.dequeueReusableCell(withReuseIdentifier: String(describing: IncomeCell.self), for: indexPath) as? IncomeCell else {
                    return UICollectionViewCell()
                }
                incomeCell.incomeBackgroundView.layer.cornerRadius = 12
                incomeCell.layer.applySketchShadow(color: UIColor.black, alpha: 0.1, x: 0, y: 4, blur: 10, spread: 0)
                return incomeCell
            } else {
                guard let spentCell = financeTypeCV.dequeueReusableCell(withReuseIdentifier: String(describing: SpentCell.self), for: indexPath) as? SpentCell else {
                    return UICollectionViewCell()
                }
                spentCell.spentBackgroundView.layer.cornerRadius = 12
                spentCell.layer.applySketchShadow(color: UIColor.black, alpha: 0.1, x: 0, y: 4, blur: 10, spread: 0)
                return spentCell
            }
        } else {
            guard let financeCell = financeCV.dequeueReusableCell(withReuseIdentifier: String(describing: FinanceCell.self), for: indexPath) as? FinanceCell else {
                return UICollectionViewCell()
            }
            financeCell.financeBackgroundView.layer.cornerRadius = 6
            financeCell.layer.applySketchShadow(color: UIColor.black, alpha: 0.1, x: 2, y: 2, blur: 10, spread: 0)
            if income {
                if let finance = financeList {
                    financeCell.amountLabel.text = finance.income[indexPath.item].price
                    financeCell.adressLabel.text = "\(finance.income[indexPath.item].pickupAdress) - \(finance.income[indexPath.item].dropAdress)"
                    financeCell.productTypeLabel.text = finance.income[indexPath.item].type
                    financeCell.takenRoadLabel.text = finance.income[indexPath.item].road
                }
            } else {
                if let finance = financeList {
                    financeCell.amountLabel.text = finance.outgone[indexPath.item].price
                    financeCell.adressLabel.text = "\(finance.outgone[indexPath.item].pickupAdress) - \(finance.outgone[indexPath.item].dropAdress)"
                    financeCell.productTypeLabel.text = finance.outgone[indexPath.item].type
                    financeCell.takenRoadLabel.text = finance.outgone[indexPath.item].road
                }
            }
            return financeCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == financeTypeCV {
            switch indexPath.row {
            case 0:
                income = true
            case 1:
                income = false
            default:
                print("error")
            }
            financeCV.reloadData()
        }
    }
}

extension FinanceViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == financeTypeCV {
            return CGSize(width: 170, height: 160)
        } else {
            return CGSize(width: collectionView.frame.width - 30, height: 80)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == financeTypeCV {
            return UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        } else {
            return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        }
    }
}
