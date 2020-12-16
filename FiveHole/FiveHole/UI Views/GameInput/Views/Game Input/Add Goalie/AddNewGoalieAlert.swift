//
//  AddNewGoalieAlert.swift
//  FiveHole
//
//  Created by Stryker, Nathan P on 12/16/20.
//

import SwiftUI
import PhotosUI

struct AddNewGoalieAlert: View {
    @Binding var showingAddNewGoalie: Bool
    @State private var isPhotoPresented: Bool = false
    @State private var fName = ""
    @State private var lName = ""
    @State private var teamName = ""
    @State private var inputImage: UIImage?
    
    var body: some View {
        
        
        ZStack {
            VStack {
                RoundedRectangle(cornerRadius: 8.0, style: .continuous)
                    .fill(LinearGradient(.NPSDarkStart, .NPSDarkEnd))
                HStack{
                    Button(action: {
                        let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()
                        self.showingAddNewGoalie.toggle()
                    }){
                        Text("Save")
                            .foregroundColor(.NPSTextColor)
                            .minimumScaleFactor(0.01)
                            .scaledToFill()
                            .lineLimit(1)
                    }.buttonStyle(ColorfulButtonStyle())
                    Spacer()
                    Button(action: {
                        let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()
                        self.showingAddNewGoalie.toggle()
                    }){
                        Text("Cancel")
                            .foregroundColor(.NPSTextColor)
                            .minimumScaleFactor(0.01)
                            .scaledToFill()
                            .lineLimit(1)
                    }.buttonStyle(ColorfulButtonStyle())
                }
                
            }.padding()
            HStack {
                VStack{
                    Spacer()
                        .frame(height: 5)
                    TextField("First Name", text: $fName)
                        .frame(height: 44)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding([.leading, .trailing], 10)
                        .cornerRadius(16)
                        .background(Color.NPSShadowColor)
                        .clipShape(RoundedRectangle(cornerRadius: 10)) // clip corners
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray))
                        .padding([.leading, .trailing], 5)
                    
                    TextField("Last Name", text: $lName)
                        .frame(height: 44)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding([.leading, .trailing], 10)
                        .cornerRadius(16)
                        .background(Color.NPSShadowColor)
                        .clipShape(RoundedRectangle(cornerRadius: 10)) // clip corners
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray))
                        .padding([.leading, .trailing], 5)
                    
                    TextField("Team Name", text: $teamName)
                        .frame(height: 44)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding([.leading, .trailing], 10)
                        .cornerRadius(16)
                        .background(Color.NPSShadowColor)
                        .clipShape(RoundedRectangle(cornerRadius: 10)) // clip corners
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray))
                        .padding([.leading, .trailing], 5)
                    
                    Spacer()
                        .frame(height: 95)
                }.padding()
                VStack {
                    Spacer()
                        .frame(height: 5)
                    ZStack{
                        RoundedRectangle(cornerRadius: 8.0, style: .continuous)
                            .fill(LinearGradient(.NPSBackgroundGradientEnd, .NPSButtonEnd))
                            .frame(width: 150, height: 160)
                            .padding()
                            .onTapGesture(count: 1, perform: {
                                self.isPhotoPresented.toggle()
                            }).sheet(isPresented: $isPhotoPresented) {
                                let configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
                                PhotoPicker(configuration: configuration, isPhotoPresented: $isPhotoPresented, image: $inputImage)
                            }
                        
                        if inputImage != nil {
                            Image(uiImage: inputImage!)
                                .frame(width: 150, height: 160, alignment: .center)
                        }else {
                            Image(systemName: "camera")
                                .frame(width: 150, height: 160, alignment: .center)
                        }
                        
                    }
                    Spacer()
                }
                Spacer()
            }
            
        }.frame(width: UIScreen.main.bounds.width, height: 290)
        
    }
}

struct PhotoPicker: UIViewControllerRepresentable {
    
    let configuration: PHPickerConfiguration
    @Binding var isPhotoPresented: Bool
    @Binding var image: UIImage?
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        let controller = PHPickerViewController(configuration: configuration)
        controller.delegate = context.coordinator
        return controller
    }
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) { }
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // Use a Coordinator to act as your PHPickerViewControllerDelegate
    class Coordinator: PHPickerViewControllerDelegate {
        
        private let parent: PhotoPicker
        
        init(_ parent: PhotoPicker) {
            self.parent = parent
        }
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            print(results)
            //TODO Asgn image results here to the picker results... Not sure how to do that
            parent.isPhotoPresented = false // Set isPresented to false because picking has finished.
        }
    }
    
    
}

struct AddNewGoalieAlert_Previews: PreviewProvider {
    static var previews: some View {
        AddNewGoalieAlert(showingAddNewGoalie: .constant(true))
    }
}
