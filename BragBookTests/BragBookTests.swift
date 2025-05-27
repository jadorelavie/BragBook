import XCTest
@testable import BragBook // Import the main app module

class JournalViewModelTests: XCTestCase {

    var sut: JournalViewModel!
    var persistenceController: PersistenceController!

    override func setUpWithError() throws {
        try super.setUpWithError()
        persistenceController = PersistenceController(inMemory: true)
        sut = JournalViewModel(persistenceController: persistenceController)
    }

    override func tearDownWithError() throws {
        sut = nil
        persistenceController = nil
        try super.tearDownWithError()
    }

    func testAddEntry() throws {
        // Given
        let title = "Test Title"
        let text = "Test Text"
        let date = Date()

        // When
        sut.addEntry(title: title, text: text, date: date)

        // Then
        XCTAssertEqual(sut.entries.count, 1, "There should be one entry after adding.")
        XCTAssertNotNil(sut.entries.first, "The first entry should not be nil.")
        XCTAssertEqual(sut.entries.first?.title, title, "The entry's title should match the input.")
        XCTAssertEqual(sut.entries.first?.text, text, "The entry's text should match the input.")
        
        // Optional: Check date more carefully if needed, accounting for potential minor differences if not using exact same Date object
        // For example, by comparing timeIntervalSince1970 or components.
        // XCTAssertEqual(sut.entries.first?.date, date, "The entry's date should match the input.")
    }

    func testFetchEntries() throws {
        // Given: Directly add a sample JournalEntryEntity to the persistenceController's context
        let context = persistenceController.container.viewContext
        let newEntry = JournalEntryEntity(context: context)
        let entryId = UUID()
        let entryTitle = "Fetched Title"
        let entryText = "Fetched Text"
        let entryDate = Date()

        newEntry.id = entryId
        newEntry.title = entryTitle
        newEntry.text = entryText
        newEntry.timestamp = entryDate
        
        do {
            try context.save()
        } catch {
            XCTFail("Failed to save context for testFetchEntries: \(error)")
            return
        }

        // When: Re-initialize sut to trigger fetchEntries in its init, or make fetchEntries public
        // As per previous decision, fetchEntries is private, so we re-initialize.
        sut = JournalViewModel(persistenceController: persistenceController)
        // If fetchEntries() were public, we would call:
        // sut.fetchEntries() 

        // Then
        XCTAssertEqual(sut.entries.count, 1, "There should be one entry after fetching.")
        XCTAssertNotNil(sut.entries.first, "The fetched entry should not be nil.")
        XCTAssertEqual(sut.entries.first?.title, entryTitle, "The fetched entry's title should match.")
        XCTAssertEqual(sut.entries.first?.id, entryId, "The fetched entry's ID should match.")
    }
    
    // Example of a test that checks if the list is initially empty
    func testInitialEntriesIsEmpty() throws {
        // When sut is initialized with an empty in-memory store
        // Then
        XCTAssertTrue(sut.entries.isEmpty, "Entries should be empty initially.")
    }
    
    func testDeleteEntry() throws {
        // Given: Add an entry first
        let title1 = "Entry to Delete"
        sut.addEntry(title: title1, text: "Some text", date: Date())
        XCTAssertEqual(sut.entries.count, 1, "Should have 1 entry before delete.")

        let title2 = "Another Entry"
        sut.addEntry(title: title2, text: "More text", date: Date())
        XCTAssertEqual(sut.entries.count, 2, "Should have 2 entries before delete.")

        // When: Delete the first entry
        if let entryToDelete = sut.entries.first(where: { $0.title == title1 }) {
            // The deleteEntry(at offsets: IndexSet) method is designed for SwiftUI's onDelete.
            // To test deletion of a specific known entry, we might need a different method in ViewModel
            // or find its index. For simplicity, let's assume we delete at index 0.
            // This requires knowing the order, which addEntry and fetchEntries (with sort) provides.
             guard let indexToDelete = sut.entries.firstIndex(where: { $0.title == title1 }) else {
                XCTFail("Could not find the entry to delete by title.")
                return
            }
            sut.deleteEntry(at: IndexSet(integer: indexToDelete))
        } else {
            XCTFail("Test setup error: Could not find the entry titled '\(title1)' to delete.")
            return
        }
        
        // Then
        XCTAssertEqual(sut.entries.count, 1, "Should have 1 entry after deleting one.")
        XCTAssertFalse(sut.entries.contains(where: { $0.title == title1 }), "Deleted entry should no longer be present.")
        XCTAssertTrue(sut.entries.contains(where: { $0.title == title2 }), "The other entry should still be present.")
    }
}
