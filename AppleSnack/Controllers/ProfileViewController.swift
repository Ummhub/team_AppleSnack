//
//  File.swift
//  AppleSnack
//
//  Created by 조규연 on 2023/08/14.
//

import UIKit

class ProfileViewController:UIViewController, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var profileView: UIImageView!
    
    let profileManager = ProfileManager.shared
    let snackManager = SnackManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.textColor = UIColor(red: 0.48, green: 0.90, blue: 0.51, alpha: 1.00)
        editButton.tintColor = UIColor(red: 0.48, green: 0.90, blue: 0.51, alpha: 1.00)
        titleLabel.font = UIFont(name: "NotoSansKR-Bold", size: 24)
        
        if let profileData = profileManager.getProfileCoreData().first {
            nameField.text = profileData.name
            githubTextView.text = profileData.github
            blogTextView.text = profileData.blog
            emailField.text = profileData.email
            
            if let imageDate = profileData.photo, let image = UIImage(data: imageDate) {
                profileImage.image = image
            }
        }
        
        makeImageLayer()
        makeTextViewLayer()
        
        blogTextView.delegate = self
        githubTextView.delegate = self
    }
    
    // ➡️ 이 부분 추가했습니다!!
    override func viewDidLayoutSubviews() {
        profileView.clipsToBounds = true
        profileView.layer.cornerRadius = profileView.bounds.height / 2
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateProgressView()
        requestProgressUpdate()
    }
    
    func requestProgressUpdate() {
        snackArray = snackManager.getSnackFromCoreData()
        updateProgressView()
    }
    
    @IBAction func editButtonTapped(_ sender: UIButton) {
        toggleFieldState(nameField, sender: sender)
        toggleFieldState(emailField, sender: sender)
        toggleTextViewState(blogTextView, sender: sender)
        toggleTextViewState(githubTextView, sender: sender)
        profileImage.isUserInteractionEnabled.toggle()
        
        if let profileData = profileManager.getProfileCoreData().first {
            profileData.name = nameField.text
            profileData.github = githubTextView.text
            profileData.blog = blogTextView.text
            profileData.email = emailField.text
            
            if let newImage = profileImage.image {
                profileData.photo = newImage.pngData()
            }
            
            profileManager.updateProfile(newToDoData: profileData) {}
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var blogTextView: UITextView!
    
    @IBOutlet weak var githubTextView: UITextView!
    
    
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var currentValueLabel: UILabel!
    
    @IBOutlet weak var levelLabel: UILabel!
    
    @IBOutlet weak var currentValueLabelLeadingConstraint: NSLayoutConstraint!
    
    lazy var snackArray = snackManager.getSnackFromCoreData()
    
    var currentValue: Float = 0.0
    var level: Int = 0
    var maxValue: Float = 100
    
    func updateProgressView() {
        currentValue = Float(snackArray.count)
        let repeatedValue = currentValue.truncatingRemainder(dividingBy: maxValue)

        level = Int(currentValue / maxValue)
        levelLabel.text = "Lv: \(level)"
        
        progressView.progress = repeatedValue / maxValue
        currentValueLabel.text = "\(Int(repeatedValue))℃"
        let ratio = CGFloat(repeatedValue / maxValue)
        
        currentValueLabelLeadingConstraint.constant = progressView.bounds.width * ratio
    }
    
    func toggleFieldState(_ field: UITextField, sender: UIButton) {
        field.isEnabled.toggle()
        
        if field.isEnabled {
            sender.setTitle("완료", for: .normal)
        } else {
            sender.setTitle("수정", for: .normal)
        }
    }
    
    func toggleTextViewState(_ textView: UITextView, sender: UIButton) {
        textView.isEditable.toggle()
        
        if textView.isEditable {
            sender.setTitle("완료", for: .normal)
        } else {
            sender.setTitle("수정", for: .normal)
        }
    }
}
