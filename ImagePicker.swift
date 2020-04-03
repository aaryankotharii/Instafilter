//
//  ImagePicker.swift
//  Instafilter
//
//  Created by Aaryan Kothari on 03/04/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import Foundation
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable{
        
    class Coordinator : NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
        var parent: ImagePicker
        
        init(_ parent : ImagePicker){
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    
    
    @Binding var image : UIImage?
    @Environment(\.presentationMode) var presentationMode
    
    func makeCoordinator() -> Coordinator {
         Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
}
