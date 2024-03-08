//
//  ThumbnailViewModel.swift
//  ThumbnailsDemo
//
//  Created by Lorenzo Brown on 3/7/24.
//

import SwiftUI
import UIKit

@MainActor
class ThumbnailViewModel: ObservableObject {
   // var viewToCreate: some View
    
    @Published var image: UIImage?
    
    private var baseURL = "file:///Users/lorenzobrown/Library/Developer/CoreSimulator/Devices/4C57AEC4-8932-4624-80EE-4C1EC86DE09C/data/Containers/Data/Application/19DD078F-4440-4D33-824C-2AE053EFBFB6/Documents/"
    
    init(idString: String, viewToCreate: some View){
       // guard let drawnImage =  drawPDFfromURL(url: URL(string: "testImage.pdf")) else {
        let pdfURL = render(filename: "testImage\(idString)", content: viewToCreate)
            print("PDF URL: ", pdfURL)
        image = drawPDFfromURL(url: pdfURL)
        //}
        //image = drawnImage
    }
    
    
    func drawPDFfromURL(url: URL) -> UIImage? {
        guard let document = CGPDFDocument(url as CFURL) else { return nil }
        guard let page = document.page(at: 1) else { return nil }
        
        let pageRect = page.getBoxRect(.mediaBox)
        let renderer = UIGraphicsImageRenderer(size: pageRect.size)
        let img = renderer.image { ctx in
            UIColor.white.set()
            ctx.fill(pageRect)
            
            ctx.cgContext.translateBy(x: 0.0, y: pageRect.size.height)
            ctx.cgContext.scaleBy(x: 1.0, y: -1.0)
            
            ctx.cgContext.drawPDFPage(page)
        }
        
        return img
    }
    
    func render(filename: String, content: some View) -> URL {
        // 1: Render Hello World with some modifiers
        let renderer = ImageRenderer(content: VStack{
            content
        })
        
        // 2: Save it to our documents directory
        let url = URL.documentsDirectory.appending(path: "\(filename).pdf")
        
        // 3: Start the rendering process
        renderer.render { size, context in
            // 4: Tell SwiftUI our PDF should be the same size as the views we're rendering
            var box = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            
            // 5: Create the CGContext for our PDF pages
            guard let pdf = CGContext(url as CFURL, mediaBox: &box, nil) else {
                return
            }
            
            // 6: Start a new PDF page
            pdf.beginPDFPage(nil)
            
            // 7: Render the SwiftUI view data onto the page
            context(pdf)
            
            // 8: End the page and close the file
            pdf.endPDFPage()
            pdf.closePDF()
        }
        
        return url
    }
}
