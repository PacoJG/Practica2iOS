//
//  ExcelViewController.swift
//  Practica2iOS
//
//  Created by Francisco Jaime on 27/05/22.
//

import UIKit
import WebKit

class ExcelViewController: UIViewController {
    
    let webView = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        if let url = URL(string: "http://janzelaznog.com/DDAM/iOS/vim/localidades.xlsx"){
            webView.load(URLRequest(url: url))
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if(cargaImagenLocal("localidades.xlsx")){
            let data = obtnImgLocal("localidades.xlsx")
            //self.imageView.image = UIImage(data: data)
        }
        else{
            // TODO: Implementa la descarga con URLSession
            // TODO: Validar la conexión a Internet...
            /*if let url = URL(string:DataManager.instance.baseURL + "/" + lItem.pict) {
                let request = URLRequest(url: url)
                let sesion = URLSession.shared
                let tarea = sesion.dataTask(with: request) { bytes, response, error in
                    if error != nil {
                        print ("ocurrio un error \(error!.localizedDescription)")
                    }
                    else {
                        let image = UIImage(data: bytes!)
                        self.guardaImagen(bytes!, lItem.pict)
                        DispatchQueue.main.async {
                            self.imageView.image = image
                            self.a_i.stopAnimating()
                        }
                    }
                }
                tarea.resume()
            }*/
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
    func guardaArchivo(_ bytes:Data, _ nombre:String){
        let urlAdocs = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask)[0]
        let urlAlArchivo = urlAdocs.appendingPathComponent(nombre)
        do{
            try bytes.write(to: urlAlArchivo)
        }
        catch{
            print("no se puede salvar la imagen \(error.localizedDescription)")
        }
        
    }
    func obtnImgLocal(_ nombre:String)->Data{
        
    
    let urlAdocs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    let urlAlArchivo = urlAdocs.appendingPathComponent(nombre)
    
        guard let data = FileManager.default.contents(atPath: urlAlArchivo.path) else{
            return Data()
        }
        return data
   // return FileManager.default.contents(atPath: urlAlArchivo.path)
    }
    
    func cargaImagenLocal (_ nombre:String) -> Bool {
        // 1. Obtener la ruta a documents
        
        // 2. comprobar si existe el archivo
        // 2.a. el objeto URL tiene una propiedad path....
        let urlAdocs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let urlAlArchivo = urlAdocs.appendingPathComponent(nombre)
        
        return FileManager.default.fileExists(atPath: urlAlArchivo.path)
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
