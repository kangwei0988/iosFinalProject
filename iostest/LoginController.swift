//
//  LoginController.swift
//  iostest
//
//  Created by User24 on 2019/12/26.
//  Copyright © 2019 kang. All rights reserved.
//

import UIkit
import Alamofire

class LoginController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var account: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBAction func login(_ sender: UIButton) {
        Alamofire.request("https://ntoumotogo.kangs.idv.tw/iosLogin",
               method: .post,
               parameters: ["Account_name": "\(account.text)", "_password": "\(password.text)"],
               encoding: JSONEncoding.default,
               headers: nil).responseData { response in
        if let data = response.result.value, let content = try? decoder.decode(loginState.self,from:data){
            if content.state == "login"{
                
            }
        }
        else{
            print("error")
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
