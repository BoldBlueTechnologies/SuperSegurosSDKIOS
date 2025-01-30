//
//  contractePolicyViewController.swift
//  SuperSegurosSDKIOS
//
//  Created by Christian Martinez on 26/11/24.
//


import UIKit

class contractePolicyViewController: stylesViewController {
 
        
    @IBOutlet weak var txtMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
               let fullText = """
               \(PayQuotationData.shared.name ?? "") \(PayQuotationData.shared.paternalSurname ?? "") \(PayQuotationData.shared.maternalSurname ?? ""), con tu nueva póliza de seguro, puedes tener la tranquilidad de saber que tu auto está protegido, conducir sin preocupaciones.
               
               Importante: Tu póliza será vigente un día después de tu contratación. Enviaremos los datos de tu póliza a tu correo electrónico y teléfono proporcionado.
               
               Tu cuenta funciona para Súper y Midoconline.
               """
               
            
               let attributedString = NSMutableAttributedString(
                   string: fullText,
                   attributes: [.font: UIFont.poppinsRegular(size: 13)]
               )
               
            
               let nameComplete = "\(PayQuotationData.shared.name ?? "") \(PayQuotationData.shared.paternalSurname ?? "") \(PayQuotationData.shared.maternalSurname ?? "")"
               let boldTexts = [
                   nameComplete,
                   "Importante:"
               ]
               
             
               for boldText in boldTexts {
                   if let range = fullText.range(of: boldText) {
                       let nsRange = NSRange(range, in: fullText)
                       attributedString.addAttribute(
                           .font,
                           value: UIFont.poppinsSemiBold(size: 13),
                           range: nsRange
                       )
                   }
               }
               
             
               txtMessage.attributedText = attributedString
               txtMessage.numberOfLines = 0
        
    
    }
    @IBAction func contactAction(_ sender: Any) {
        
        let urlString = "https://wa.me/522219156675/?text=¡Hola!, Necesito asistencia en Súper Seguros SDK."

        if let url = URL(string: urlString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
    }
    
    @IBAction func continueAction(_ sender: Any) {
        
        
        let storyboard = UIStoryboard(name: "Storyboard", bundle: Bundle.module)
        let switchViewController = storyboard.instantiateViewController(withIdentifier: "internoPolicy") as! internoPolicySuperMxViewController
        switchViewController.modalPresentationStyle = .popover
        switchViewController.isModalInPresentation = true
        self.present(UINavigationController(rootViewController: switchViewController), animated: true, completion: nil)
    }
}
