//
//  ProfileVC.swift
//  PracticalTest
//
//  Created by Hardik on 8/1/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
struct ProfileResponse : Codable {
   
       let flag : String!// "1",
       let userId : String!// "10",
       let userEmail : String!// "will_13@mailinator.com",
       let firstName : String!// "Will",
       let lastName : String!// "Smith",
       let mobile : Int!// 2345678331
    
    
}
struct commonResponse : Codable{
//   let flag:String!// "0",
//   let message:String!// "User is inactive, please contact administrator."
    let Status :Int!//200
}

struct ResponseZometo: Codable {
    let categories: [Category]!

    enum CodingKeys: String, CodingKey {
        case categories = "categories"
    }
}

// MARK: - Category
struct Category: Codable {
    let categories: Categories!

    enum CodingKeys: String, CodingKey {
        case categories = "categories"
    }
}

// MARK: - Categories
struct Categories: Codable {
    let id: Int!
    let name: String!

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}

class ProfileVC: BaseVC {

    @IBOutlet weak var viewLandScape: UIView!
    @IBOutlet weak var viewProtrate: UIView!
    @IBOutlet weak var tfF_Name: UITextField!
    @IBOutlet weak var tfS_Name: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfMobileNo: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfRepeat: UITextField!
    @IBOutlet weak var tfFirstName: UITextField!
    @IBOutlet weak var tfSurname: UITextField!
    @IBOutlet weak var tfMail: UITextField!
    @IBOutlet weak var tfNo: UITextField!
    @IBOutlet weak var tfPass: UITextField!
    @IBOutlet weak var tfRe_pass: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        docallAPI()

        doSettextFillData(userid: "10")
        
    }
    
    func setDataProtate() {
        print("setdata")
//        if tfF_Name.isEditing == true {
//            print("hihihih")
        tfF_Name.text = tfFirstName.text
        //        }else if tfS_Name.isEditing == true{
        tfS_Name.text = tfSurname.text
        //        }else if tfEmail.isEditing == true{
        tfEmail.text = tfMail.text
        //        }else if tfMobileNo.isEditing == true{
        tfMobileNo.text = tfNo.text
        //        }else if tfPassword.isEditing == true{
        tfPassword.text = tfPass.text
        //        }else if tfRepeat.isEditing == true{
        tfRepeat.text = tfRe_pass.text
    }

    func setDataLandScape()  {
        //setDataLandScape()
        print("setDataProtate")
//        else if tfFirstName.isEditing == true{
            tfFirstName.text = tfF_Name.text
//        }else if tfSurname.isEditing == true{
            tfSurname.text = tfS_Name.text
//        }else if tfMail.isEditing == true{
            tfMail.text = tfEmail.text
//        }else if tfNo.isEditing == true{
            tfNo.text = tfMobileNo.text
//        }else if tfPass.isEditing == true{
            tfPass.text = tfPassword.text
//        }else if tfRe_pass.isEditing == true{
            tfRe_pass.text = tfRepeat.text
//        }
        
    }
    
    func doSettextFillData(userid : String!){
        
        let request = AlamofireSingleTon.sharedInstance
        let service = "http://dev72hjweb.websiteserverhost.com/salvelink/public/api/profile!userId=" + userid
        request.requestTypeGet(serviceName: service) { (Data, error) in
            
            if Data != nil{
                do{
                    let response = try JSONDecoder().decode(ProfileResponse.self, from: Data!)
                    if response.flag == "1"{
                        if self.viewProtrate.isHidden{
                            self.tfFirstName.text = response.firstName
                            self.tfSurname.text = response.lastName
                            self.tfMail.text = response.userEmail
                            self.tfNo.text = String(response.mobile)
                        }else{
                            self.tfF_Name.text = response.firstName
                            self.tfS_Name.text = response.lastName
                            self.tfEmail.text = response.userEmail
                            self.tfMobileNo.text = String(response.mobile)
                        }
                    }else{
                        print("flag != 1 ")
                    }
                    
                }catch{
                    
                }
            }else{
                print("parse error")
            }
        }
        
        
    }
    
    func doSaveApi(){
        var paramdata = [ String : String ]()
        let paramProtet = ["email":tfEmail.text!,
                     "password": tfPassword.text!,
                     "device_platform":"iOS",
                     "device_id":"",
                     "mobile" : String(tfMobileNo.text!),
                     "firstName":tfF_Name.text!,
                     "lastName":tfS_Name.text!,
                     "userId":"10"]
        let paramLandscape = ["email":tfMail.text!,
                             "password": tfPass.text!,
                             "device_platform":"iOS",
                             "device_id":"",
                             "mobile" : String(tfNo.text!),
                             "firstName":tfFirstName.text!,
                             "lastName":tfSurname.text!,
                             "userId":"10"]
        if viewProtrate.isHidden{
            print("paramLandscape")
            paramdata = paramLandscape
        }else{
            print("paramProtet")
            paramdata = paramProtet
        }
        let service = "http://dev72hjweb.websiteserverhost.com/salvelink/public/api/updateprofile!email=will_13@mailinator.com&password=123456&device_platform=iOS&=&=&device_id=D2277F72-8CF5-4334-8365-4EBC033B7EC2&mobile=2345678331&firstName=Will&lastName=Smith&userId=10"
        let request = AlamofireSingleTon.sharedInstance
        
        request.requestPost(serviceName: service, parameters: paramdata) { (Data, Error) in
            if Data != nil{
                do{
                    let respose = try JSONDecoder().decode(commonResponse.self, from: Data!)
//                    if respose.flag == "1"{
//                        self.showAlertMessage(title: "", msg: respose.message)
//                    }else{
//                        self.showAlertMessage(title: "", msg: respose.message)
//                    }
                }catch{
                    
                }
            }else{
                print("parse error")
            }
        }
    }
    
    func doValidate() -> Bool{
        var validate = true
        
        if self.viewProtrate.isHidden{
            if tfFirstName.text == ""{
                validate = false
                showAlertMessage(title: "", msg: "Please Enter FirstName")
            }
            if tfSurname.text == ""{
                validate = false
                showAlertMessage(title: "", msg: "Please Enter SureName")
            }
            if tfMail.text == ""{
                validate = false
                showAlertMessage(title: "", msg: "Please Enter Email")
            }
            if tfNo.text == ""{
                validate = false
                showAlertMessage(title: "", msg: "Please Enter MobileNo.")
            }
           
           
            if tfPass.text == ""{
                validate = false
                showAlertMessage(title: "", msg: "Please Enter Password")
            }
            if tfRe_pass.text == ""{
                validate = false
                showAlertMessage(title: "", msg: "Please Enter Repeat Password")
            }
            
            if tfRe_pass.text != tfPass.text {
                validate = false
                showAlertMessage(title: "", msg: "Password and repeat must be same")
            }
        }else{
            if tfF_Name.text == ""{
                validate = false
                showAlertMessage(title: "", msg: "Please Enter FirstName")
            }
            if tfS_Name.text == ""{
                validate = false
                showAlertMessage(title: "", msg: "Please Enter SureName")
            }
            if tfEmail.text == ""{
                validate = false
                showAlertMessage(title: "", msg: "Please Enter Email")
            }
            if tfMobileNo.text == ""{
                validate = false
                showAlertMessage(title: "", msg: "Please Enter MobileNo.")
            }
            
            
            if tfPassword.text == ""{
                validate = false
                showAlertMessage(title: "", msg: "Please Enter Password")

            }
            if tfRepeat.text == ""{
                validate = false
                showAlertMessage(title: "", msg: "Please Enter Repeat Password")
                
            }
            if tfRepeat.text != tfPassword.text {
                validate = false
                showAlertMessage(title: "", msg: "Password and repeat must be same")
            }
        }
        
        
        return validate
    }
    
    func docallAPI(){
        let param = ["user-key" : "1b3c8b37ea96785391fa55c288ac385c"]
        let request = AlamofireSingleTon.sharedInstance
        let service = "https://developers.zomato.com/api/v2.1/categories"
        request.requestPost(serviceName: service, parameters: param) { (Data, error) in
            if Data != nil{
                do{
                    let response = try JSONDecoder().decode(commonResponse.self, from: Data!)
                    if response.Status == 200{
                        
                    }
                }catch{
                    print("error")
                }
            }else{
                print("parse error")
            }
        }
    }

    
    override func viewWillLayoutSubviews() {
       
        if UIDevice.current.orientation == UIDeviceOrientation.portrait{
            print("portrait")
//            setDataProtate()
            setDataLandScape()
            viewProtrate.isHidden = false
            viewLandScape.isHidden = true
        }else if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft{
            print("landscapeLeft")
           // setDataLandScape()
             setDataProtate()
            viewProtrate.isHidden = true
            viewLandScape.isHidden = false
        }
        else if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight{
            print("landscapeRight")
//            setDataLandScape()
             setDataProtate()
            viewProtrate.isHidden = true
            viewLandScape.isHidden = false
        }
        else if UIDevice.current.orientation == UIDeviceOrientation.portraitUpsideDown{
            print("portraitUpsideDown")
//            setDataProtate()
            setDataLandScape()
            viewProtrate.isHidden = false
            viewLandScape.isHidden = true
        }
        
    }


    override var shouldAutorotate: Bool {
        return true
    }
    
    @IBAction func onClickTermAndCondition(_ sender: Any) {
    }
    @IBAction func onClickStop(_ sender: Any) {
    }
    @IBAction func onClickSave(_ sender: Any) {
        
        if doValidate(){
            doSaveApi()
        }
    }
    
    @IBAction func tapback(_ sender: Any) {
         self.navigationController!.popViewController(animated: true)
    }
    @IBAction func onClickBack(_ sender: Any) {
        self.navigationController!.popViewController(animated: true)
    }
    

}

extension UINavigationController {

override open var shouldAutorotate: Bool {
    get {
        if let visibleVC = visibleViewController {
            return visibleVC.shouldAutorotate
        }
        return super.shouldAutorotate
    }
}

override open var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
    get {
        if let visibleVC = visibleViewController {
            return visibleVC.preferredInterfaceOrientationForPresentation
        }
        return super.preferredInterfaceOrientationForPresentation
    }
}

override open var supportedInterfaceOrientations: UIInterfaceOrientationMask{
    get {
        if let visibleVC = visibleViewController {
            return visibleVC.supportedInterfaceOrientations
        }
        return super.supportedInterfaceOrientations
    }
}}
