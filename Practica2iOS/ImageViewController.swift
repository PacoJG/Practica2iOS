//
//  ImageViewController.swift
//  Practica2iOS
//
//  Created by Francisco Jaime on 30/05/22.
//

import UIKit
import WebKit

class ImageViewController: UIViewController {

    let webView = WKWebView()
    var a_i = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        a_i.style = .large
        a_i.color = .red
        a_i.hidesWhenStopped = true
        a_i.center = self.view.center
        self.view.addSubview(a_i)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if(existeArchivoLocal("geo_vertical.jpg")){
            mostrarArchivo()
        }
        else{
            // TODO: Implementa la descarga con URLSession
            // TODO: Validar la conexión a Internet...
            if InternetStatus.instance.internetType != "none" {
                descargaArchivo()
            }
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
    func descargaArchivo(){
        if let url = URL(string: "http://janzelaznog.com/DDAM/iOS/vim/geo_vertical.jpg"){
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            let session = URLSession.shared
            let tarea = session.dataTask(with: request) { bytes, response, error in
                if error != nil{
                    print ("ocurrio un error \(error!.localizedDescription)")
                }
                else{
                    self.guardaArchivo(bytes!, "geo_vertical.jpg")
                    DispatchQueue.main.async {
                        self.mostrarArchivo()
                        self.a_i.stopAnimating()
                    }
                }
            }
            a_i.startAnimating()
            tarea.resume()
        
        }
        else{
            print("No se puede consultar la ruta para descargar")
        }
        
    }
    
    func guardaArchivo(_ bytes: Data, _ nombre: String){
        let urlAdocs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let urlAlArchivo = urlAdocs.appendingPathComponent(nombre)
        do {
            try bytes.write(to: urlAlArchivo)
        }
        catch {
            print ("no se puede salvar el archivo \(error.localizedDescription)")
        }
    }
    
    
    func mostrarArchivo() {
        //setting home directory
        let homeDirURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        if let rutaArchivo = URL(string: homeDirURL.path + "/geo_vertical.jpg"){
            if FileManager.default.fileExists(atPath: rutaArchivo.path) {
                let request = URLRequest(url: URL(fileURLWithPath: rutaArchivo.path))
                        DispatchQueue.main.async {
                            self.webView.load(request)
                            self.a_i.stopAnimating()
                        }

            }
            else {
                print(" no existe el archivo")
            }
        }
        self.a_i.startAnimating()
    }
    
    
    func existeArchivoLocal (_ nombre:String) -> Bool {
        // 1. Obtener la ruta a documents
        
        // 2. comprobar si existe el archivo
        // 2.a. el objeto URL tiene una propiedad path....
        let urlAdocs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let urlAlArchivo = urlAdocs.appendingPathComponent(nombre)
        self.a_i.startAnimating()
        return FileManager.default.fileExists(atPath: urlAlArchivo.path)
    }


}
