//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Anish kumar dubey on 29/11/22.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    
    //@State private var scrums = DailyScrum.sampleData
    
    @StateObject private var store = ScrumStore()
    @State private var errorWrapper: ErrorWrapper?
    
    var body: some Scene {
        WindowGroup {
            //            MeetingView()
            NavigationView{
                ScrumsView(scrums: $store.scrums){
//                    ScrumStore.save(scrums: store.scrums){ result in
//                        if case .failure(let error) = result {
//                            fatalError(error.localizedDescription)
//                        }
//                    }
                    Task{
                        do{
                            try await ScrumStore.save(scrums: store.scrums)
                        }catch{
                            //fatalError("Error saving scrums.")
                            errorWrapper =  ErrorWrapper(error: error, guidance: "Try again later")
                        }
                    }
                }
            }
            .task {
                do{
                    store.scrums = try await ScrumStore.load()
                }catch{
                    //fatalError("Error loading scrums")
                    errorWrapper = ErrorWrapper(error: error, guidance: "Scrumdinger will load sample data and continue.")
                }
            }
            .sheet(item: $errorWrapper, onDismiss: {
                store.scrums = DailyScrum.sampleData
            }){ wrapper in
                ErrorView(errorWrapper: wrapper)
            }
//            .onAppear{
//                ScrumStore.load{result in
//                    switch result {
//                    case .failure(let error):
//                        fatalError(error.localizedDescription)
//                    case .success(let scrums):
//                        store.scrums = scrums
//                    }
//                }
//            }
        }
    }
}
