//
//  onBoardVC.swift
//  EcoStep1
//
//  Created by Федор on 27.05.2022.
//

import UIKit


class onBoardVC: UIViewController{
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!

    var slides: [onboardingSlide] = []
    
    var currentPageOnBoard = 0 {
        didSet{
            pageControl.currentPage = currentPageOnBoard
            if currentPageOnBoard == slides.count - 1{
                nextButton.setTitle("Get Started", for: .normal)
            }
            else{
                nextButton.setTitle("Next", for: .normal)
            }
        }
    }
    
    func layoutAllViews(){
        collectionView.frame = CGRect(x:0.0*self.view.frame.width, y:0.0*self.view.frame.height, width:1.0*self.view.frame.width,height:0.796875*self.view.frame.height)
        nextButton.frame = CGRect(x:0.3188405797101449*self.view.frame.width, y:0.8828125*self.view.frame.height, width:0.36231884057971014*self.view.frame.width,height:0.05580357142857143*self.view.frame.height)
        pageControl.frame = CGRect(x:0.35990338164251207*self.view.frame.width, y:0.8203125*self.view.frame.height, width:0.28019323671497587*self.view.frame.width,height:0.029017857142857144*self.view.frame.height)
    }
    
    @IBAction func nextButtonClicked(_ sender: UIButton) {
        if currentPageOnBoard == slides.count - 1{
            if isMainScreen{
                saveDef.set(true, forKey: "firstLaunch")
                saveDef.synchronize()
                dismiss(animated: true)
            }
            else{
                if onBoardPage == "actions"{
                    saveDef.set(true, forKey: "actionsFirstLaunch")
                    saveDef.synchronize()
                    dismiss(animated: true)
                }
                else if onBoardPage == "treeks"{
                    saveDef.set(true, forKey: "treeksFirstLaunch")
                    saveDef.synchronize()
                    dismiss(animated: true)
                }
            }
        }
        else{
            currentPageOnBoard += 1
            let indexPath = IndexPath(item: currentPageOnBoard, section: 0)
            collectionView.isPagingEnabled = false
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            collectionView.isPagingEnabled = true
            collectionView.setNeedsLayout()
        }
        
    }
    
    var isMainScreen = true
    
    override func viewWillAppear(_ animated: Bool) {
        layoutAllViews()
        
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        nextButton.layer.cornerRadius = 20
        nextButton.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMinXMinYCorner,.layerMaxXMinYCorner,.layerMaxXMaxYCorner]
        
        if saveDef.bool(forKey: "firstLaunch") == false{
        
            slides = [
                onboardingSlide(title: "Track Your Foootpint", description: "There are 2 indicators.\n First one is a numerical indicator.\n The second one is a Tree that will die if your footprint is too high.", image: UIImage(named: "slideOnBoardFirstX4")!),
                onboardingSlide(title: "Get Personal Tips", description: "You will get 3 personal tips on how to reduce your footprint. To get more just click on a Tip, it will be marked as completed and new one will appear in a moment. ", image: UIImage(named: "secondSlide")!),
                onboardingSlide(title: "Enter Your Actions", description: "There are 3 screens that are dedicated to Food Drinks and Transport. There you can enter your actions. To move between them just scroll down.", image: UIImage(named: "thirdSlideWithoutTxt")!),
                onboardingSlide(title: "Treeks", description: "Treeks are points that you get while using app. You can open special boxes by spending them and get such benefits as deffirent types of tips and app customization.", image:UIImage(named:"fifthSlideB")!),
                onboardingSlide(title: "How To Get Treeks", description: "In each section you will see such a progress bar. Progress increases after each entered action. For each filled section you get a Treek. Use more get more!", image: UIImage(named: "sixthSlide")!)
            ]
        }
        else if saveDef.bool(forKey: "actionsFirstLaunch") == false && onBoardPage == "actions"{
            isMainScreen = false
            slides = [
                onboardingSlide(title: "Enter Your Actions", description: "There are 3 screens that are dedicated to Food Drinks and Transport. There you can enter your actions. To move between them just scroll down.", image: UIImage(named: "thirdSlideWithoutTxt")!),
                onboardingSlide(title: "Enter Your Meals As You Wish", description: "You can enter your meal size either by providing a weight or by setting amount of eaten pieces of your meal.", image: UIImage(named: "slideFood")!),
                onboardingSlide(title: "Enter Your Drinks As You Wish", description: "You can enter your drink size either by providing a volume or by choosing a cup type and providing amount of cups drunk.", image: UIImage(named: "seventhSlide")!)
            ]
        }
        else if saveDef.bool(forKey: "treeksFirstLaunch") == false && onBoardPage ==  "treeks"{
            isMainScreen = false
            slides = [
                onboardingSlide(title: "Treeks", description: "Treeks are points that you get while using app. You can open special boxes by spending them and get such benefits as deffirent types of tips. For example, at first you can get only food tips, but if you get a Drinks Man you can get drinks tips too.", image: UIImage(named: "treeksSlide")!),
                onboardingSlide(title: "How To Get Treeks", description: "In each section you will see such a progress bar. Progress increases after each entered action. For each filled section you get a Treek. Use more get more!", image: UIImage(named: "sixthSlide")!)
            ]
        }
        
        pageControl.numberOfPages = slides.count
    }
    
}

extension onBoardVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: onboardingCollectionViewCell.identifier, for: indexPath) as! onboardingCollectionViewCell
        
        cell.setup(slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPageOnBoard = Int(scrollView.contentOffset.x/width)
    }
    
}

struct onboardingSlide{
    let title: String
    let description: String
    let image: UIImage
}

class onboardingCollectionViewCell:UICollectionViewCell{
    
    static let identifier = String(describing: onboardingCollectionViewCell.self)
    
    @IBOutlet weak var slideImageView: UIImageView!
    @IBOutlet weak var slideTitleLabel: UILabel!
    @IBOutlet weak var slideDescriptionLabel: UILabel!
    
    func setup(_ slide: onboardingSlide){
        
        slideImageView.frame = CGRect(x:0.0*self.frame.width, y:-0.012605042016806723*self.frame.height, width:1.0*self.frame.width,height:0.6890756302521008*self.frame.height)
        
        slideTitleLabel.frame = CGRect(x:0.0*self.frame.width, y:0.6876750700280112*self.frame.height, width:1.0*self.frame.width,height:0.07703081232492998*self.frame.height)
        
        slideTitleLabel.adjustsFontSizeToFitWidth = true
        slideTitleLabel.minimumScaleFactor = 0.1
        slideTitleLabel.numberOfLines = 0
        slideTitleLabel.lineBreakMode = .byClipping
        
        slideDescriptionLabel.frame = CGRect(x:0.00966183574879227*self.frame.width, y:0.7759103641456583*self.frame.height, width:0.9806763285024155*self.frame.width,height:0.10084033613445378*self.frame.height)
        
        slideDescriptionLabel.adjustsFontSizeToFitWidth = true
        slideDescriptionLabel.minimumScaleFactor = 0.1
        slideDescriptionLabel.numberOfLines = 0
        slideDescriptionLabel.lineBreakMode = .byClipping
     
        
        slideImageView.image = slide.image
        slideTitleLabel.text = slide.title
        slideDescriptionLabel.text = slide.description
    }
    
}
