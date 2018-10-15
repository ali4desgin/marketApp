//
//  AddFundViewController.swift
//  StoreApp
//
//  Created by MAC on 9/2/18.
//  Copyright © 2018 app. All rights reserved.
//

import UIKit
import  SkyFloatingLabelTextField



class AddFundViewController: UIViewController, PayPalPaymentDelegate, PayPalFuturePaymentDelegate, PayPalProfileSharingDelegate, FlipsideViewControllerDelegate {
    var environment:String = PayPalEnvironmentNoNetwork {
        willSet(newEnvironment) {
            if (newEnvironment != environment) {
                PayPalMobile.preconnect(withEnvironment: newEnvironment)
            }
        }
    }
    
    
    let paypalButton: UIButton = {
        let btn  = UIButton()
        btn.setTitle("PayPal", for: .normal)
      //  btn.setImage(#imageLiteral(resourceName: "ic_add_a_photo_36pt") , for: .normal)
        btn.backgroundColor = main_color
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        return btn
    }()
    let paymentValue: SkyFloatingLabelTextField = {

        let text = SkyFloatingLabelTextField()
        text.errorColor = UIColor.red
        text.textColor = UIColor.lightGray
        text.lineColor = UIColor.lightGray
        text.clearButtonMode = UITextFieldViewMode.whileEditing
        text.autocorrectionType = UITextAutocorrectionType.no
        text.keyboardType = UIKeyboardType.namePhonePad
        text.returnKeyType = UIReturnKeyType.done
        text.clearButtonMode = UITextFieldViewMode.whileEditing;
        text.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        text.lineHeight = 0.5
        text.backgroundColor = .white
        text.selectedLineColor = UIColor.gray
        text.selectedTitleColor = main_color
        text.selectedLineHeight = 0.5
       // text.placeholderRect(forBounds: CGRect(x: 10, y: 10, width: 60 , height: 10))
        text.placeholder = "minimam 5$"
        text.title = "add fund"
        //text.errorColor = UIColor.redColor
        return text
    }()
    
    
    
    
    
    var userwillpay:Float = 0.0
    var resultText = "" // empty
    var payPalConfig = PayPalConfiguration() // default
    
    
    let successView:UIView = {
        let v1  = UIView()
        v1.backgroundColor = UIColor.blue
        return v1
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        title = "Add Fund"
        
        
        
        setupViews()
        setupSuccessView();
        successView.isHidden = true
        
        // Set up payPalConfig
        payPalConfig.acceptCreditCards = false
        payPalConfig.merchantName = "Store App ltd."
        payPalConfig.merchantPrivacyPolicyURL = URL(string: "https://www.paypal.com/webapps/mpp/ua/privacy-full")
        payPalConfig.merchantUserAgreementURL = URL(string: "https://www.paypal.com/webapps/mpp/ua/useragreement-full")
        
        // Setting the languageOrLocale property is optional.
        //
        // If you do not set languageOrLocale, then the PayPalPaymentViewController will present
        // its user interface according to the device's current language setting.
        //
        // Setting languageOrLocale to a particular language (e.g., @"es" for Spanish) or
        // locale (e.g., @"es_MX" for Mexican Spanish) forces the PayPalPaymentViewController
        // to use that language/locale.
        //
        // For full details, including a list of available languages and locales, see PayPalPaymentViewController.h.
        
        payPalConfig.languageOrLocale = Locale.preferredLanguages[0]
        
        // Setting the payPalShippingAddressOption property is optional.
        //
        // See PayPalConfiguration.h for details.
        
        payPalConfig.payPalShippingAddressOption = .payPal;
        
        print("PayPal iOS SDK Version: \(PayPalMobile.libraryVersion())")
        
    }
    
    
    
    fileprivate func  setupViews()  {
        self.view.backgroundColor = UIColor(white: 1, alpha: 1)
        self.navigationController?.navigationBar.barTintColor = main_color
        self.navigationController?.navigationBar.barTintColor = main_color
        self.navigationController?.navigationBar.tintColor = white_color
        self.tabBarController?.tabBar.tintColor = white_color
        let navBarHieght = navigationController?.navigationBar.frame.size.height
        // subviews
        
        
        self.view.addSubview(paymentValue)
        self.view.addSubview(paypalButton)
        self.view.addSubview(successView)
        
        paymentValue.anchor(self.view.topAnchor, left: self.view.leftAnchor, bottom: nil, right: self.view.rightAnchor, topConstant: navBarHieght! + 30, leftConstant:25, bottomConstant: 0, rightConstant: 25, widthConstant: 0, heightConstant: 50)
        
        paypalButton.anchor(self.paymentValue.topAnchor, left: self.view.leftAnchor, bottom: nil, right: self.view.rightAnchor, topConstant:   60, leftConstant:25, bottomConstant: 0, rightConstant: 25, widthConstant: 0, heightConstant: 50)
        successView.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        // targest
        paypalButton.addTarget(self, action: #selector(makePayPalPayment), for: .touchDown)
    }
    
    
    
    
    
    
    
    fileprivate func setupSuccessView(){
   
    }
    
    
    
    @objc func makePayPalPayment(){
        
        let value = Float(paymentValue.text!)
        
        
        if let paymentValueReal  = value {
            if paymentValueReal > 5.0 && paymentValueReal < 1000.0 {
                userwillpay = paymentValueReal
                buyClothingAction()
            }else{
                
               let msg =  Alerter.make(title: "Error", message: "minmuman value is 5$ and maximumam is 1000$")
                present(msg, animated: true, completion: nil)
            }
        }else{
            let msg =  Alerter.make(title: "Error", message: "Invalid payment value")
            present(msg, animated: true, completion: nil)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        PayPalMobile.preconnect(withEnvironment: environment)
        
        //buyClothingAction()
    }
    
    
    // MARK: Single Payment
    func buyClothingAction() {
        // Remove our last completed payment, just for demo purposes.
        resultText = ""
        
        // Note: For purposes of illustration, this example shows a payment that includes
        //       both payment details (subtotal, shipping, tax) and multiple items.
        //       You would only specify these if appropriate to your situation.
        //       Otherwise, you can leave payment.items and/or payment.paymentDetails nil,
        //       and simply set payment.amount to your total charge.
        
        // Optional: include multiple items
        let item1 = PayPalItem(name: "Add Fund To Your Balance", withQuantity: 1, withPrice: NSDecimalNumber(string: String(userwillpay)), withCurrency: "USD", withSku: "Hip-0037")
//        let item2 = PayPalItem(name: "Free rainbow patch", withQuantity: 1, withPrice: NSDecimalNumber(string: "0.00"), withCurrency: "USD", withSku: "Hip-00066")
//        let item3 = PayPalItem(name: "Long-sleeve plaid shirt (mustache not included)", withQuantity: 1, withPrice: NSDecimalNumber(string: "37.99"), withCurrency: "USD", withSku: "Hip-00291")
//
        let items = [item1] // , item2, item3
        let subtotal = PayPalItem.totalPrice(forItems: items)
        
        // Optional: include payment details
        let shipping = NSDecimalNumber(string: "0.01")
        let tax = NSDecimalNumber(string: "0.01")
        let paymentDetails = PayPalPaymentDetails(subtotal: subtotal, withShipping: shipping, withTax: tax)
        
        let total = subtotal.adding(shipping).adding(tax)
        
        let payment = PayPalPayment(amount: total, currencyCode: "USD", shortDescription: "Store App Payment", intent: .sale)
        
        payment.items = items
        payment.paymentDetails = paymentDetails
        
        if (payment.processable) {
            let paymentViewController = PayPalPaymentViewController(payment: payment, configuration: payPalConfig, delegate: self)
            present(paymentViewController!, animated: true, completion: nil)
        }
        else {
            // This particular payment will always be processable. If, for
            // example, the amount was negative or the shortDescription was
            // empty, this payment wouldn't be processable, and you'd want
            // to handle that here.
            print("Payment not processalbe: \(payment)")
        }
        
    }
    
    // PayPalPaymentDelegate
    
    func payPalPaymentDidCancel(_ paymentViewController: PayPalPaymentViewController) {
        print("PayPal Payment Cancelled")
        resultText = ""
        
        
        successView.isHidden = true
        
        
        paymentViewController.dismiss(animated: true, completion: nil)
    }
    
    func payPalPaymentViewController(_ paymentViewController: PayPalPaymentViewController, didComplete completedPayment: PayPalPayment) {
        print("PayPal Payment Success !")
        paymentViewController.dismiss(animated: true, completion: { () -> Void in
            // send completed confirmaion to your server
            print("Here is your proof of payment:\n\n\(completedPayment.confirmation)\n\nSend this to your server for confirmation and fulfillment.")
            let crrentBalance = Float(UserDefaults.standard.value(forKey: "balance") as! String)
            let updatedBalance  = crrentBalance! + Float((completedPayment.paymentDetails?.subtotal!)!)
            UserDefaults.standard.set(updatedBalance, forKey: "balance")
            self.resultText = completedPayment.description
            print(completedPayment.paymentDetails?.subtotal!)
            self.showSuccess()
        })
    }
    
    
    // MARK: Future Payments
    
    @IBAction func authorizeFuturePaymentsAction(_ sender: AnyObject) {
        let futurePaymentViewController = PayPalFuturePaymentViewController(configuration: payPalConfig, delegate: self)
        present(futurePaymentViewController!, animated: true, completion: nil)
    }
    
    
    func payPalFuturePaymentDidCancel(_ futurePaymentViewController: PayPalFuturePaymentViewController) {
        print("PayPal Future Payment Authorization Canceled")
       successView.isHidden = true
        
        
        futurePaymentViewController.dismiss(animated: true, completion: nil)
    }
    
    func payPalFuturePaymentViewController(_ futurePaymentViewController: PayPalFuturePaymentViewController, didAuthorizeFuturePayment futurePaymentAuthorization: [AnyHashable: Any]) {
        print("PayPal Future Payment Authorization Success!")
        // send authorization to your server to get refresh token.
        futurePaymentViewController.dismiss(animated: true, completion: { () -> Void in
            self.resultText = futurePaymentAuthorization.description
            self.showSuccess()
        })
    }
    
    // MARK: Profile Sharing
    
    @IBAction func authorizeProfileSharingAction(_ sender: AnyObject) {
        let scopes = [kPayPalOAuth2ScopeOpenId, kPayPalOAuth2ScopeEmail, kPayPalOAuth2ScopeAddress, kPayPalOAuth2ScopePhone]
        let profileSharingViewController = PayPalProfileSharingViewController(scopeValues: NSSet(array: scopes) as Set<NSObject>, configuration: payPalConfig, delegate: self)
        present(profileSharingViewController!, animated: true, completion: nil)
    }
    
    // PayPalProfileSharingDelegate
    
    func userDidCancel(_ profileSharingViewController: PayPalProfileSharingViewController) {
        print("PayPal Profile Sharing Authorization Canceled")
        // successView.isHidden = true
        profileSharingViewController.dismiss(animated: true, completion: nil)
    }
    
    func payPalProfileSharingViewController(_ profileSharingViewController: PayPalProfileSharingViewController, userDidLogInWithAuthorization profileSharingAuthorization: [AnyHashable: Any]) {
        print("PayPal Profile Sharing Authorization Success!")
        
        // send authorization to your server
        
        profileSharingViewController.dismiss(animated: true, completion: { () -> Void in
            self.resultText = profileSharingAuthorization.description
            self.showSuccess()
        })
        
    }
    
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "pushSettings" {
            // [segue destinationViewController] setDelegate:(id)self];
            if let flipSideViewController = segue.destination as? FlipsideViewController {
                flipSideViewController.flipsideDelegate = self
            }
        }
    }
    
    
    // MARK: Helpers
    
    func showSuccess() {
        successView.isHidden = false
        successView.alpha = 1.0
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.5)
        UIView.setAnimationDelay(2.0)
        successView.alpha = 0.0
        UIView.commitAnimations()
        self.navigationController?.pushViewController(SideMenViewController(), animated: true)
    }
    
    
    
    
    // MARK: Memory
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
}

