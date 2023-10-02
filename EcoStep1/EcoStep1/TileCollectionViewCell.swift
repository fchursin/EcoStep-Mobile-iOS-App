//
//  TileCollectionViewCell.swift
//  EcoStep1
//
//  Created by Федор on 29.03.2022.
//

import UIKit


struct TileCollectionViewCellViewModel{
    let name:String
    let type:String
    let widthMultiplier: Double
    let description:String
}

class TileCollectionViewCell: UICollectionViewCell{
    static let identifier = "TileCollectionViewCell"
    
  
  
    
    private let label:UILabel = {
        let label = UILabel()
        
        label.textColor = UIColor(red: 0.357, green: 0.78, blue: 0.357, alpha: 1)
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 2
        
//        label.backgroundColor = .green
        
        return label
    }()
    
    let image:UIImageView = {
        let image = UIImageView()
        
        image.backgroundColor = .clear
        image.contentMode = .scaleAspectFit
        image.tintColor = .black
        
//        image.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        
        return image
    }()
    
    let button:UIButton = {
        let button = UIButton()
        
        button.addTarget(self, action: #selector(animateChanges), for:.touchUpInside)
        
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(label)
        contentView.addSubview(image)
        contentView.addSubview(button)
        contentView.addSubview(descriptionLabel)
    }
    
    let descriptionLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 5
        label.textColor = UIColor(red: 0.357, green: 0.78, blue: 0.357, alpha: 1)
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20)
        label.isHidden = true
        return label
    }()
    
    @objc func animateChanges(){
        UIView.animate(withDuration: 0.5) {
            self.showDescription()
        }
        
    }
    
    func showDescription(){
        if descriptionLabel.isHidden == true{
            image.isHidden = true
            label.isHidden = true
            descriptionLabel.isHidden = false
        }
        else{
            descriptionLabel.isHidden = true
            image.isHidden = false
            label.isHidden = false
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        button.frame = contentView.bounds
        
        contentView.layer.borderWidth = 3
        contentView.layer.cornerRadius = 20
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner,.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        contentView.layer.borderColor = UIColor(red: 0.357, green: 0.78, blue: 0.357, alpha: 1).cgColor
        
        
        
        image.frame = CGRect(x:contentView.frame.width * 0.2, y: contentView.frame.height*0.060386473429951695, width: contentView.frame.width*0.6, height: contentView.frame.height*0.6)
        
        
        label.frame = CGRect(x: contentView.frame.width*0.25/2, y: image.frame.height, width: contentView.frame.width*0.75, height: contentView.frame.height*0.5)
        button.frame = CGRect(x: 0, y: 0, width: contentView.frame.width*0.9, height: contentView.frame.height*0.9)
        descriptionLabel.frame = CGRect(x:contentView.frame.width * 0.05, y: contentView.frame.height*0.05, width: contentView.frame.width*0.9, height: contentView.frame.height*0.9)
        
        descriptionLabel.isHidden = true
        image.isHidden = false
        label.isHidden = false
        
//        image.frame = contentView.bounds
    }
    
    func getImage(typeOfman:String)->String{
        var finalImg:String = ""
        
        switch typeOfman{
        case "food":
            if foodmanGet>=1{
                finalImg = "cookieMan"
            }
            else{
                finalImg = "cookieManNotAchieved"
            }
        case "transport":
            if transportManGet >= 15{
                finalImg = "ecocar"
            }
            else{
                finalImg = "ecocarNotOpened"
            }
        case "drinks":
            if drinkManGet >= 10{
                finalImg = "ecocup"
            }
            else{
                finalImg = "ecocupNotAchieved"
            }
        default:
            print("error")
        }
        
        return finalImg
    }
    
    func configure(with viewModel: TileCollectionViewCellViewModel){
        contentView.backgroundColor = .white
        label.text = viewModel.name
        descriptionLabel.text = viewModel.description
        if viewModel.type == "housing"{
            image.image = UIImage(systemName: "questionmark")
        }
        else{
            
            image.image = UIImage(named: getImage(typeOfman: viewModel.type))
        }
        
        

   
    }
    
}

