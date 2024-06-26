//
//  PlaylistTopTableViewCell.swift
//  Listen24-7
//
//  Created by İrem Sever on 25.04.2024.
//

import UIKit

class PlaylistTopTableViewCell: UITableViewCell {
    static let identifier = "PlaylistTopTableViewCell"
    @IBOutlet weak var lblPlaylistName: UILabel!
    @IBOutlet weak var imgCover: UIImageView!
    @IBOutlet weak var buttonTittle: UIButton!
    @IBOutlet weak var lblPlaylistInfo: UILabel!
    @IBOutlet weak var imgCoverBlack: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        buttonTittle.isEnabled = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        lblPlaylistName.font = UIFont(name: "Futura-Bold", size: 17)
        lblPlaylistName.textColor = UIColor.black
        
        lblPlaylistInfo.font = UIFont(name: "Futura", size: 15)
        lblPlaylistInfo.textColor = UIColor.white
        
        addBottomCornerRadius(to: imgCover, radius: 50)
        addBottomCornerRadius(to: imgCoverBlack, radius: 50)
    }
    
    func configureCover(data: PlaylistResponse?) {
        guard let imgURLString = data?.image, let imgURL = URL(string: imgURLString) else {
            imgCover.image = nil
            imgCoverBlack.image = nil
            lblPlaylistName.text = nil
            lblPlaylistInfo.text = nil
            return
        }
        
        lblPlaylistName?.text = data?.name
        lblPlaylistInfo?.text = data?.description
        
        URLSession.shared.dataTask(with: imgURL) { [weak self] (data, response, error) in
            guard let self = self, let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async {
                self.imgCover.isHidden = true
            }
            
            DispatchQueue.global().async {
                guard let image = UIImage(data: data) else { return }
                  //Blur effect
                 let ciImage = CIImage(image: image)
                 let blurFilter = CIFilter(name: "CIGaussianBlur")
                 blurFilter?.setValue(ciImage, forKey: kCIInputImageKey)
                 blurFilter?.setValue(10, forKey: kCIInputRadiusKey) // Adjust the blur radius as needed
                 guard let blurredImage = blurFilter?.outputImage else { return }
                 
                 let context = CIContext()
                 if let cgImage = context.createCGImage(blurredImage, from: blurredImage.extent) {
                 let blurredUIImage = UIImage(cgImage: cgImage)
                
                DispatchQueue.main.async {
                     let imageView = UIImageView(frame: self.imgCover.bounds)
                     imageView.contentMode = .scaleAspectFill
                     imageView.image = blurredUIImage
                     self.imgCover.addSubview(imageView)
                     self.imgCover.sendSubviewToBack(imageView)
                    //self.imgCover.image = image
                    self.imgCover.isHidden = false 
                }
                
            }
            }
        }.resume()
    }
    
    func addBottomCornerRadius(to view: UIView, radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: view.bounds,
                                    byRoundingCorners: [.bottomLeft, .bottomRight],
                                    cornerRadii: CGSize(width: radius, height: radius))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        view.layer.mask = shape
    }
}
