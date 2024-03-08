//
//  ContentView.swift
//  ThumbnailsDemo
//
//  Created by Lorenzo Brown on 3/5/24.
//

import SwiftUI
import Foundation


let thumbnails: [any View] = [sampleView1, sampleView2, sampleView3, sampleView4, sampleView5, sampleView6, sampleView7]


@MainActor
struct PDFGrid: View {
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(Array(thumbnails.enumerated()), id: \.offset) { index, thumbnail  in
                    ThumbnailView(viewModel: ThumbnailViewModel(idString: index.description, viewToCreate: thumbnail))
                }
            }
        }
    }
    
}
#Preview {
    PDFGrid()
}


@ViewBuilder var sampleView1: some View {
        ZStack {
            Color.green
            VStack {
                Text("This is a sample view")
                    .font(.title)
                Divider()
                Text("Generated from a PDF")
                    .font(.caption2)
            }
        }
    }

@ViewBuilder var sampleView2: some View {
        ZStack {
            Color.blue
            VStack {
                Text("This is a sample view")
                    .font(.title)
                Divider()
                Text("Generated from a PDF")
                    .font(.caption2)
            }
        }
    }
    
    @ViewBuilder var sampleView3: some View {
            ZStack {
                Color.yellow
                VStack {
                    Text("This is a sample view")
                        .font(.title)
                    Divider()
                    Text("Generated from a PDF")
                        .font(.caption2)
                }
            }
        }
    
    @ViewBuilder var sampleView4: some View {
            ZStack {
                Color.yellow
                VStack {
                    Text("This is a sample view")
                        .font(.title)
                    Divider()
                    Text("Generated from a PDF")
                        .font(.caption2)
                }
            }
        }

    
    @ViewBuilder var sampleView5: some View {
            ZStack {
                Color.purple
                VStack {
                    Text("This is a sample view")
                        .font(.title)
                    Divider()
                    Text("Generated from a PDF")
                        .font(.caption2)
                }
            }
        }
    
    @ViewBuilder var sampleView6: some View {
            ZStack {
                Color.orange
                VStack {
                    Text("This is a sample view")
                        .font(.title)
                    Divider()
                    Text("Generated from a PDF")
                        .font(.caption2)
                }
            }
        }
    
    @ViewBuilder var sampleView7: some View {
            ZStack {
                Color.indigo
                VStack {
                    Text("This is a sample view")
                        .font(.title)
                    Divider()
                    Text("Generated from a PDF")
                        .font(.caption2)
                }
            }
        }


// This function would need to be called on startup to keep files from blowing up
func deleteOldThumbnailFiles(in directoryPath: String, daysOld: Int) {
    if daysOld < 0 {
        return
    }
    var negativeNumberOfDays = daysOld
    negativeNumberOfDays.negate()
    
    let fileManager = FileManager.default
    let calendar = Calendar.current
    
    do {
        let files = try fileManager.contentsOfDirectory(atPath: directoryPath)
        
        for file in files {
            let filePath = (directoryPath as NSString).appendingPathComponent(file)
            let attributes = try fileManager.attributesOfItem(atPath: filePath)
            
            if let modificationDate = attributes[.modificationDate] as? Date {
                if let daysAgo = calendar.date(byAdding: .day, value: negativeNumberOfDays , to: Date()), modificationDate < daysAgo {
                    try fileManager.removeItem(atPath: filePath)
                    print("Deleted \(file)")
                }
            }
        }
    } catch {
        print("An error occurred: \(error)")
    }
}
