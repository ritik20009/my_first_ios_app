//
//  CustomUserTableView.swift
//  iOSLearningApp
//
//  Created by Ritik Raj on 23/09/22.
//

import Foundation
import UIKit
import SnapKit

class CustomUserTableViewCell: UITableViewCell {
    
    private let Constantitems = ConstantItems.items
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configure()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var key = UILabel()
    var value = UILabel()
    let ProfileImgView = UIImageView()
    private let containerView = UIView()
    private let userdatacons = UserDetailField.constants
    func configure() {
        self.contentView.addSubview(containerView)
        self.contentView.backgroundColor = .white
        containerView.backgroundColor = .white
        containerView.snp.makeConstraints{make in
            make.top.left.equalToSuperview().offset(10)
            make.right.bottom.equalToSuperview().offset(-10)
        }
        self.containerView.addSubview(key)
        self.containerView.addSubview(value)
        key.snp.makeConstraints{ make in
            make.top.left.equalToSuperview().offset(5)
            make.bottom.right.equalToSuperview()
        }
        value.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(5)
            make.left.equalTo(key).offset(250)
            make.bottom.right.equalToSuperview()
        }
    }
    func setData(data: UserDetail?, index: Int){
        if(index==0){
            self.containerView.addSubview(ProfileImgView)
            ProfileImgView.image = UIImage(named: Constantitems[5])
            ProfileImgView.clipsToBounds=true
            ProfileImgView.layer.cornerRadius=100
            ProfileImgView.snp.makeConstraints{ make in
                make.centerX.centerY.equalToSuperview()
                make.height.width.equalTo(200)
            }
            containerView.snp.makeConstraints { make in
                make.height.equalTo(230)
            }
            guard let avatarurl = data?.avatar_url else{
                return
            }
            let setImage = {(data: Data) -> Void in
                guard let image = UIImage(data: data) else{
                    return
                }
                self.ProfileImgView.image = image
            }
            let network = NetworkManager()
            network.fetchImage(url: avatarurl, completion: setImage)
        }
        if(index==1){
            self.value.numberOfLines=0
            key.text = self.userdatacons[index-1]
            value.text = data?.name ?? Constantitems[0]
        }
        if(index==2){
            self.value.numberOfLines=0
            key.text = self.userdatacons[index-1]
            value.text = data?.company ?? Constantitems[0]
        }
        if(index==3){
            self.value.numberOfLines=0
            key.text = self.userdatacons[index-1]
            value.text = data?.location ?? Constantitems[0]
        }
        if(index==4){
            self.value.numberOfLines=0
            key.text = self.userdatacons[index-1]
            value.text = data?.login ?? Constantitems[0]
        }
        if(index==5){
            key.text = self.userdatacons[index-1]
            let repo_cnt : Int
            repo_cnt = (data?.public_repos) ?? 0
            value.text = "\(repo_cnt)"
        }
        if(index==6){
            key.text = self.userdatacons[index-1]
            let followers_cnt : Int
            followers_cnt = (data?.followers) ?? 0
            value.text = "\(followers_cnt)"
        }
        if(index==7){
            key.text = self.userdatacons[index-1]
            let following_cnt : Int
            following_cnt = (data?.following) ?? 0
            value.text = "\(following_cnt)"
        }
    }
}
