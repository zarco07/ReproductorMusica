//
//  ViewController.swift
//  ReproductorMusica
//
//  Created by Oscar Zarco on 02/09/16.
//  Copyright © 2016 oscarzarco. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var portada: UIImageView!
    @IBOutlet var titulo: UILabel!
    
    @IBOutlet var volumen: UILabel!
    @IBOutlet var listaCanciones: UIPickerView!
    @IBOutlet var volumenStep: UIStepper!
    
    
    private var reproductor : AVAudioPlayer!
    
    var canciones = ["cerdo","lasmanos","seven","teamoymas","thislife"]
    var imagenes = ["cerdo.jpg","lasmanos.jpg","seven.jpg","teamoymas.jpg","thislife.png"]
    var titulos = ["Cerdo - Molotov","Alza las manos - DJ","Seven nation army - White Stripes","Te amo y mas - Diego Luna","This life - Soundtrack"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        listaCanciones.delegate = self
        
        let archivo = canciones[0]
        let titulo = titulos[0]
        let caratula = imagenes[0]
        
        self.titulo.text = titulo
        self.titulo.sizeToFit()
        
        self.portada.image = UIImage(named:caratula)
        
        
        let sonidoURl = NSBundle.mainBundle().URLForResource(archivo, withExtension: "mp3")
        do {
            try reproductor = AVAudioPlayer(contentsOfURL: sonidoURl!)
        }
        catch{
            print("Error al cargar archivo")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    @IBAction func play(sender: UIButton) {
        if !reproductor.playing {
            reproductor.play()
        }
    }
    
    @IBAction func pausa(sender: UIButton) {
        if reproductor.playing {
            reproductor.pause()
        }
    }

    @IBAction func shuffle(sender: UIButton) {
        let random = arc4random_uniform(5)
        cargaCancion(Int(random))
    }
    
    @IBAction func stop(sender: UIButton) {
        if reproductor.playing {
            reproductor.stop()
            reproductor.currentTime = 0
        }
    }
    
    @IBAction func cambioVolumen(sender: UIStepper) {
        self.volumen.text = "Volumen: " + String(sender.value * 10) + "%"
        self.volumen.sizeToFit()
        print(String(sender.value/10))
        reproductor.volume = Float(sender.value/10)
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return canciones.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return titulos[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        cargaCancion(row)
    }
    
    func cargaCancion(pista : Int) {
        let archivo = canciones[pista]
        let titulo = titulos[pista]
        let caratula = imagenes[pista]
        
        self.titulo.text = titulo
        self.titulo.sizeToFit()
        
        self.portada.image = UIImage(named:caratula)
        
        
        let sonidoURl = NSBundle.mainBundle().URLForResource(archivo, withExtension: "mp3")
        do {
            try reproductor = AVAudioPlayer(contentsOfURL: sonidoURl!)
        }
        catch{
            print("Error al cargar archivo")
        }
        reproductor.volume = Float(volumenStep.value/10)
        
        reproductor.play()
        print("Vol:" + String(reproductor.volume))
        
    }
}

