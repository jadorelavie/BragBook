//
//  BragBookTests.swift
//  BragBookTests
//
//  Created by Taryn Brice-Rowland on 3/10/25.
//

import Testing
import CoreData
@testable import BragBook // Allows access to internal types like PersistenceController

struct BragBookTests {

    @Test func testPersistenceControllerPreviewInitialization() throws {
        // Access the preview PersistenceController
        let previewController = PersistenceController.preview
        let viewContext = previewController.container.viewContext

        // Verify the viewContext is not nil (implicitly verified by its usage, but good to be mindful)
        // In Swift Testing, we test by expecting conditions to be true.
        // If viewContext was nil, subsequent operations would fail.

        // Fetch JournalEntryEntity objects
        let fetchRequest: NSFetchRequest<JournalEntryEntity> = JournalEntryEntity.fetchRequest()
        
        var fetchedEntries: [JournalEntryEntity] = []
        // Swift Testing doesn't have a direct setUp/tearDown like XCTest for context handling per test.
        // We perform operations directly. Accessing the context needs to be done carefully.
        // For in-memory stores, the data exists as long as the controller exists.
        // `previewController` is a static var, so it persists.
        
        // It's good practice to perform context operations within a closure if possible,
        // but for this static preview, direct access is how it's designed.
        do {
            fetchedEntries = try viewContext.fetch(fetchRequest)
        } catch {
            #expect(false, "Fetching JournalEntryEntity objects failed with error: \(error)")
            // If fetch fails, we can't proceed with other checks.
            return
        }

        // Assert that there are 5 sample entries
        #expect(fetchedEntries.count == 5, "Expected 5 sample entries, found \(fetchedEntries.count)")

        // Assert that the first fetched sample entry has plausible data
        if let firstEntry = fetchedEntries.first {
            #expect(!firstEntry.title!.isEmpty, "First entry's title should not be empty")
            // newItem.timestamp = Date() is non-optional in model and usage
            #expect(firstEntry.timestamp != nil, "First entry's timestamp should not be nil")
            #expect(firstEntry.id != nil, "First entry's id should not be nil")
            #expect(!firstEntry.text!.isEmpty, "First entry's text should not be empty")
        } else {
            #expect(false, "Expected at least one entry, but found none to check.")
        }
    }

    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    }
}
