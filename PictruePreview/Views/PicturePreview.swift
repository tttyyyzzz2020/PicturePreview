//
//  PicturePreview.swift
//  PictruePreview
//
//  Created by yongzhan on 2020/6/11.
//  Copyright © 2020 yongzhan. All rights reserved.
//

import SwiftUI

struct PicturePreview: View {
    var pictures = Picture.data()
    @Binding var selectedPicture: Picture?
    @State var innerSelectedPictrue : Picture?
    
    var body: some View {
        GeometryReader { gr in
            ZStack {
                self.renderScrollView(gr: gr)
                self.renderCloseButton(gr: gr)
                
                if self.innerSelectedPictrue != nil {
                    self.renderBigPicture(gr: gr)
                }
            }
        }
    }
    
    func renderBigPicture(gr: GeometryProxy) -> some View {
        Group{
            Image(self.innerSelectedPictrue!.imageName)
                .resizable()
                .aspectRatio(4/7,contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width - 60)
                .cornerRadius(8)
                .shadow(radius: 8)
                .onTapGesture {
                    withAnimation{
                         self.innerSelectedPictrue = nil
                    }
            }
        }
    }
    
    func renderCloseButton(gr: GeometryProxy) ->  some View {
        Button(action: {
            withAnimation{
                self.selectedPicture = nil
                self.innerSelectedPictrue = nil
            }
        }) {
            Circle()
                .stroke(Color.red, lineWidth: 2)
                .frame(width: 40, height: 40)
                .background(Image(systemName: "xmark").foregroundColor(Color.red))
        }
        .position(x: gr.frame(in: .local).midX, y: gr.frame(in: .local).maxY - 50)
        .opacity(self.innerSelectedPictrue != nil ? 0 : 1)
    }
    
    func computedScale(width: CGFloat, itemMidX: CGFloat) -> CGFloat {
        let offsetX = itemMidX - (width / 2)
        if offsetX > 5 || offsetX < -5 {
            return 1 - abs(offsetX / width)
        } else {
            return 1
        }
    }
    
    func renderScrollView(gr: GeometryProxy) -> some View{
        ScrollView(.horizontal, showsIndicators: false) {
            HStack{
                ForEach(self.pictures) { picture in
                    GeometryReader{ gr2 in
                        Image(picture.imageName)
                            .resizable()
                            .aspectRatio(4/7, contentMode: .fit)
                            .scaleEffect(self.selectedPicture == nil ? .zero :  self.computedScale(width: gr.frame(in: .global).width, itemMidX: gr2.frame(in: .global).midX))
                            .cornerRadius(6)
                            .shadow(radius: 6)
                            .onTapGesture {
                               withAnimation{
                                     self.innerSelectedPictrue = picture
                                }
                        }
                    }
                    .frame(width: 280, height: 490)
                }
            }
            .padding(.vertical)
        }
        .position(x: gr.frame(in: .local).midX, y: gr.frame(in: .local).midY)
        .blur(radius: self.innerSelectedPictrue != nil ? 20 : 0)
    }
}

struct PicturePreview_Previews: PreviewProvider {
    static var previews: some View {
        PicturePreview(selectedPicture: .constant(Picture.data().first!))
    }
}
