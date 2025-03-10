//
//  AddItemView.swift
//  BragBook
//
//  Created by Taryn Brice-Rowland on 3/17/25.
//


import SwiftUI

struct AddItemView: View {
    @Binding var newTitle: String
    @Binding var newDetails: String
    @Binding var newTags: String
    var onSave: () -> Void
    var onCancel: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("Add New Item")
                .font(.headline)
            TextField("Title", text: $newTitle)
            TextField("Details", text: $newDetails)
            TextField("Tags (comma-separated)", text: $newTags)
            HStack {
                Button("Cancel") { onCancel() }
                Button("Save") { onSave() }
            }
        }
        .padding()
        .frame(minWidth: 300)
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView(newTitle: .constant("Test Title"),
                    newDetails: .constant("Test Details"),
                    newTags: .constant("Tag1, Tag2"),
                    onSave: {},
                    onCancel: {})
    }
}
