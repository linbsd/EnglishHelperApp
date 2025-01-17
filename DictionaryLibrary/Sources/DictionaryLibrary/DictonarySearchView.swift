//
//  SwiftUIView.swift
//  
//
//  Created by 老房东 on 2022-03-08.
//

import SwiftUI
import CommomLibrary

public struct DictonarySearchView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var vm = DictonarySearchViewModel()
    
    public init(){}
    
    func FilterView() -> some View {
        return FilteredList(
            sortDescriptors: [
                NSSortDescriptor(
                    key: "name",
                    ascending: true,
                    selector: #selector(NSString.localizedStandardCompare(_:))
                )
            ],
            predicate: NSPredicate(format: "name LIKE[c] %@", "*\(vm.searchText)*")
            //predicate: NSPredicate(format: "name CONTAINS %@", searchText)
        ){ (item:Word) in
            NavigationLink {
                WordDetailView(item: item)
            } label: {
                HStack{
                    if let url = item.picture?.viewModel.path{
                        PictureView(url: URL(string: url))
                            .frame(width: 60, height: 60)
                            .shadow(radius: 10)
                    }
                    Text("\(item.viewModel.name)")
                }
            }
        }
    }
    
    public var body: some View {
        VStack{
            if vm.loadStatue == .load {
                ProgressView()
                    .onAppear {
                        vm.fetchData(viewContext: viewContext)
                    }
            }else{
                FilterView()
            }
        }
        .navigationTitle(vm.loadStatue == .load ? "Syncing Words..." : "Words")
        .navigationBarTitleDisplayMode(.inline)
        .searchable(
            text: $vm.searchText,
//            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Look up for dictonary"
        )
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    vm.loadStatue = .load
                } label: {
                    Image(systemName: "arrow.clockwise.circle")
                }
                
            }
        }
    }
}

struct DictonarySearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DictonarySearchView()
                .environment(\.managedObjectContext,PersistenceController.preview.container.viewContext)
        }
    }
}
