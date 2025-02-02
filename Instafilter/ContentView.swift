//
//  ContentView.swift
//  Instafilter
//
//  Created by Aaryan Kothari on 03/04/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//
import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI


struct ContentView: View {
    @State private var image : Image?
    @State private var filterIntensity = 0.5
    
    @State private var showingImagePicker = false
    @State private var inputImage : UIImage?
    
    @State var currentFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    var body: some View{
        
        let intensity = Binding<Double>(
                  get: {
                      self.filterIntensity
                  },
                  set: {
                      self.filterIntensity = $0
                      self.applyProcessing()
                  }
        )
      
        
        NavigationView{
            VStack{
                ZStack{
                    Rectangle()
                        .fill(Color.secondary)
                    
                if self.image != nil {
                        self.image?
                        .resizable()
                        .scaledToFit()
                }else{
                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }.onTapGesture {
                    self.showingImagePicker = true
                }
                HStack{
                    Text("Intensity")
                    Slider(value: intensity)
                }
                
                
                HStack{
                    Button("Change Filter"){
                        
                    }
                    Spacer()
                    
                    Button("Save"){
                        
                    }
                }
            }.padding([.horizontal,.bottom])
            .navigationBarTitle("Instafilter")
                .sheet(isPresented: $showingImagePicker, onDismiss: loadImage){
                    ImagePicker(image: self.$inputImage)
                    
            }
        }
    }
    
    func loadImage(){
        guard let inputImage = inputImage else { return }
        
        let beginImage =  CIImage(image: inputImage)
        
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        
        applyProcessing()
    }
    
    func applyProcessing(){
        currentFilter.intensity = Float(filterIntensity)
        
        guard let outputImage = currentFilter.outputImage else {return}
          
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent){
            let uiImage = UIImage(cgImage: cgimg)
              
        image = Image(uiImage: uiImage)
    }
}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class ImageSaver: NSObject{
    
    func writeToPhotoAlbum(image: UIImage){
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }
    @objc func saveError(_ image : UIImage, didFinishSavingWithError error : Error?, contextInfo : UnsafeRawPointer){
                      print("save finished")
                  }
}

struct ContentView5: View{
    @State private var image : Image?
    @State private var showingImagePicker = false
    @State private var inputImage : UIImage?
    var body: some View{
        VStack {
            image?
            .resizable()
            .scaledToFit()
            
            Button("SelectImage"){
                self.showingImagePicker = true
            }.sheet(isPresented: $showingImagePicker, onDismiss: loadImage ) {
                ImagePicker(image: self.$inputImage)
            }
        }
    }
    
    func loadImage(){
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
        let imageSaver = ImageSaver()
        imageSaver.writeToPhotoAlbum(image: inputImage)
    }
}

//struct ContentView2: View {
//    @State private var blurAmouunt : CGFloat = 0 {
//        didSet{
//            print(blurAmouunt)
//        }
//    }
//    var body: some View {
//        VStack {
//            Text("Hello, World!")
//                .blur(radius: blurAmouunt)
//            Slider(value: $blurAmouunt, in: 0...20)
//        }
//    }
//}
//
//struct ContentView : View{
//    @State private var showingActionSheet = false
//    @State private var backgroundColor = Color.white
//    var body : some View {
//        Text("Hello, world!")
//        .frame(width: 300, height: 300)
//        .background(backgroundColor)
//            .onTapGesture {
//                self.showingActionSheet = true
//        }.actionSheet(isPresented: $showingActionSheet) {
//            ActionSheet(title: Text("Change Background"), message: Text("Select new colour"), buttons: [
//                .default(Text("Red")){ self.backgroundColor = .red },
//                .default(Text("Green")){ self.backgroundColor = .green },
//                .default(Text("Blue")){ self.backgroundColor = .blue },
//                .default(Text("yelllow")){ self.backgroundColor = .yellow },
//                .cancel()
//            ])
//        }
//    }
//}
//





//MARK:- adding filters
/*
struct ContentView : View{
    @State private var image : Image?
  
    var  body : some View {
        VStack{
            image?
            .resizable()
            .scaledToFit()
            }.onAppear(perform: loadImage)
    }
    func loadImage(){
        guard let imputImage = UIImage(named: "Example") else {
            return
        }
        
        let beginImage = CIImage(image: imputImage)
        
        //more code to come
        
        let context = CIContext()
        
        let  currentFilter = CIFilter.sepiaTone()
        
        currentFilter.inputImage = beginImage
        currentFilter.intensity = 0.5
        
        
        guard let outputImage = currentFilter.outputImage else {return}
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent){
            let uiImage = UIImage(cgImage: cgimg)
            
            image = Image(uiImage: uiImage)
        }
        
    }
}
*/
