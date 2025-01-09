# SuperSegurosSDKIOS

**SuperSegurosSDKIOS** es un SDK que muestra una interfaz para que tus usuarios puedan **cotizar y contratar un Seguro de Auto** de manera sencilla y rápida.  
Este repositorio contiene todo lo necesario para integrar el SDK en tu proyecto iOS.

---

## 1. Instalación

### Swift Package Manager (SPM)

1. En Xcode, ve a **File > Add Packages...**  
2. Ingresa la URL del repositorio:  https://github.com/BoldBlueTechnologies/SuperSegurosSDKIOS.git

3. Selecciona la rama `main`.
4. Añade el paquete a tu proyecto y, una vez finalizado, podrás importar el módulo con:
```swift
import SuperSegurosSDKIOS
```
## 2. Uso

El SDK ofrece un botón personalizado (SuperSegurosButton) que mostrará la interfaz de cotización y contratación. Puedes integrarlo de dos formas:

2.1 Integración por Código
```swift
import UIKit
import SuperSegurosSDKIOS

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Crear el botón y definir su tamaño/posición
        let customButton = SuperSegurosButton(frame: CGRect(x: 20, y: 100, width: 345, height: 68))
        
        // Agregar el botón a la vista
        view.addSubview(customButton)
    }
}
```
2.2 Integración con Storyboard

Abre tu Storyboard y arrastra un UIView al UIViewController donde quieras colocar el botón.
En el Identity Inspector, cambia la Custom Class de este UIView a SuperSegurosButton.
Ajusta el tamaño deseado, por ejemplo 345 x 68.
(Opcional) Crea un IBOutlet si quieres manipular el botón desde tu código.

## 4. Requerimientos

iOS: iOS 13 o superior
Swift: Swift 5 o superior
Xcode: 14 o superior recomendado


## 5. Soporte
Si tienes dudas, sugerencias o problemas:

Abre un issue en este repositorio.
O contacta al equipo de Bold Blue Technologies.


