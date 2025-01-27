//
//  noContractedPolicyViewController.swift
//  SuperSegurosSDKIOS
//
//  Created by Christian Martinez on 20/01/25.
//



import UIKit

class noContractedPolicyViewController: stylesViewController {
 
    
@IBOutlet weak var txtMessage: UILabel!

override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.navigationBar.isHidden = true
    
           let fullText = """
           \(PayQuotationData.shared.name ?? "") \(PayQuotationData.shared.paternalSurname ?? "") \(PayQuotationData.shared.maternalSurname ?? ""), hemos enviado a tu correo y teléfono registrado la emisión de tu póliza. Por favor, descárgala y consulta las opciones de pago disponibles.
           
           Importante: Realiza el pago antes de la fecha límite de 15 días de lo contrario se cancelara tu póliza. Tener la tranquilidad de saber que tu auto está protegido y conducir sin preocupaciones
           
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

@IBAction func continueAction(_ sender: Any) {
    
    let storyboard = UIStoryboard(name: "Storyboard", bundle: Bundle.module)
    let switchViewController = storyboard.instantiateViewController(withIdentifier: "internoPolicy") as! internoPolicySuperMxViewController
    switchViewController.modalPresentationStyle = .popover
    switchViewController.isModalInPresentation = true
    self.present(UINavigationController(rootViewController: switchViewController), animated: true, completion: nil)
    
}
}
