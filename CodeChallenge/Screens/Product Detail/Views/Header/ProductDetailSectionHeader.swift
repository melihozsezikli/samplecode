//
//  ProductDetailSectionHeader.swift
//  CodeChallenge
//
//  Created by personal on 19.07.2022.
//

import UIKit
import SnapKit

class ProductDetailSectionHeader: UITableViewHeaderFooterView {

    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = UIColor(named: "black")
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(titleLabel)
    }
    
    private func setupLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
    }
    
    func bind(title: String) {
        titleLabel.text = title
    }
}
