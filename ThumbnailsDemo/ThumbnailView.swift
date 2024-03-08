//
//  ThumbnailView.swift
//  ThumbnailsDemo
//
//  Created by Lorenzo Brown on 3/7/24.
//

import SwiftUI

struct ThumbnailView: View {
    var viewModel: ThumbnailViewModel
        var body: some View {
            VStack{
                Image(uiImage: (viewModel.image ?? UIImage(named: "bird"))!)
            }
        }
    }


//#Preview {
//    ThumbnailView(viewModel: <#T##ThumbnailViewModel#>)
//}
