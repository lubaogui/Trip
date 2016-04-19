//
//  ProductCardView.swift
//  Trip
//
//  Created by Baogui Lu on 4/18/16.
//  Copyright © 2016 Baogui Lu. All rights reserved.
//

import UIKit


protocol ProductCardViewDelegate {
    func avatarButtonClicked(uid: Int);
    func likeButtonClicked(uid: Int, productId: Int);
    func productImageClicked(productId: Int);
    func bookingButtonClicked(productId: Int, uid: Int);
}

class ProductCardView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect) {
     // Drawing code
     }
     */
    //变量
    var product: Product? {
        didSet {
            if product == nil {
                return;
            }
            else {
                self.loadData(product!);
            }
            
        }
    }
    
    var isViewDidInitialized = false;
    var delegate: ProductCardViewDelegate?;
    
    //UI元素
    let productImageView = UIImageView();
    let avatarButton = UIButton();
    let nameButton = UIButton();
    let descriptionLabel = UILabel();
    let addressLabel = UILabel();
    let priceLabel = UILabel();
    let likeButton = UIButton();
    let likeNumLabel = UILabel();
    let bookingButton = UIButton();
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.initUI();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //初始化UI控件
    func initUI() {
        
        if isViewDidInitialized == false {
            
            //产品大图
            productImageView.contentMode = UIViewContentMode.ScaleAspectFill;
            productImageView.clipsToBounds = true;
            
            //用户头像
            avatarButton.layer.cornerRadius = 16.5;
            avatarButton.clipsToBounds = true;
            nameButton.setTitle("Hello", forState: UIControlState.Normal);
            
            //add subview
            self.addSubview(productImageView);
            self.addSubview(avatarButton);
            self.addSubview(nameButton);
            self.addSubview(descriptionLabel);
            self.addSubview(addressLabel);
            self.addSubview(priceLabel);
            self.addSubview(likeButton);
            self.addSubview(likeNumLabel);
            self.addSubview(bookingButton);
            
            //AutoLayout
            productImageView.snp_makeConstraints { (make) in
                make.height.equalTo(200);
                make.top.left.right.equalTo(self);
            }
            
            avatarButton.snp_makeConstraints { (make) in
                make.height.width.equalTo(33);
                make.top.left.equalTo(self).offset(10);
            }
            
            nameButton.snp_makeConstraints { (make) in
                make.height.equalTo(30);
                make.width.equalTo(50);
                make.left.equalTo(avatarButton);
                make.top.equalTo(avatarButton.snp_bottom).offset(10);
            }
            
            descriptionLabel.snp_makeConstraints { (make) in
                make.top.equalTo(productImageView.snp_bottom).offset(15);
                make.left.equalTo(self).offset(10);
            }
            
            addressLabel.snp_makeConstraints { (make) in
                make.top.equalTo(descriptionLabel.snp_bottom).offset(15);
                make.height.equalTo(30);
                make.width.equalTo(200);
            }
            
            priceLabel.snp_makeConstraints { (make) in
                make.left.equalTo(addressLabel);
                make.height.equalTo(30);
                make.width.greaterThanOrEqualTo(60);
            }
            
            likeNumLabel.snp_makeConstraints { (make) in
                make.left.equalTo(priceLabel.snp_right).offset(15);
                make.height.equalTo(30);
                make.width.greaterThanOrEqualTo(60);
            }
            
            bookingButton.snp_makeConstraints { (make) in
                make.right.equalTo(self).offset(-30);
                make.height.equalTo(40);
                make.width.greaterThanOrEqualTo(50);
                make.bottom.equalTo(self).offset(-30);
            }
            
            isViewDidInitialized = true;
            
        }
        
    }
    
    //加载数据
    func loadData(product: Product) {
        productImageView.kf_setImageWithURL(NSURL(string: product.coverImageUrl!)!, placeholderImage: UIImage(named: "product_default_coverimage"), optionsInfo: nil,
            progressBlock: nil, completionHandler: nil);
        avatarButton.imageView?.kf_setImageWithURL(NSURL(string: product.avatarUrl!)!, placeholderImage: UIImage(named: "avatar_default"), optionsInfo: nil, progressBlock: nil, completionHandler: nil);
        nameButton.setTitle(product.username, forState: UIControlState.Normal);
        descriptionLabel.text = product.title;
        addressLabel.text = product.address;
        priceLabel.text = "\(product.price)元";
        likeNumLabel.text = "\(product.likeNum)个人喜欢";
    }
    
    //如果初始化时没有赋值frame,就在赋值frame的时候完成界面对象的属性初始化
    override func layoutSubviews() {
        if (isViewDidInitialized == false) {
            self.initUI();
        }
        super.layoutSubviews();
    }
    
}
