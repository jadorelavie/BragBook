import XCTest

final class BragBookUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments += ["-UITesting"] // Optional: Add launch argument for specific app setup for UI tests
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
        try super.tearDownWithError()
    }

    @MainActor
    func testAddJournalEntry() throws {
        // 1. Tap the "plus" button to bring up the add entry sheet.
        // Assuming "My Journal" is the navigation title and "plus" image is the button.
        // The "plus" button is often the first button in the trailing navigation bar items.
        // If this doesn't work, a more specific accessibilityIdentifier would be needed on the Button in ContentView.
        let plusButton = app.navigationBars["My Journal"].buttons.element(matching: .button, identifier: "plus").firstMatch
        // Fallback if the above is too specific or "plus" is not the actual identifier for system images.
        // let plusButton = app.navigationBars["My Journal"].buttons.element(boundBy: 0) // Assuming it's the first trailing button

        if !plusButton.waitForExistence(timeout: 5) {
             XCTFail("Plus button not found. Consider adding .accessibilityIdentifier(\"addEntryButton\") to the Button in ContentView.")
             return
        }
        plusButton.tap()

        // 2. On the "Add Entry" screen:
        // Wait for the "Add Entry" navigation bar to appear
        XCTAssertTrue(app.navigationBars["Add Entry"].waitForExistence(timeout: 2), "The 'Add Entry' view did not appear.")

        let titleTextField = app.textFields["Title"]
        XCTAssertTrue(titleTextField.waitForExistence(timeout: 2), "Title text field not found.")
        titleTextField.tap()
        titleTextField.typeText("My UI Test Entry")

        // TextEditor can be tricky. It often resolves to a generic TextView.
        // If there's only one TextEditor on screen, this is usually safe.
        let bodyTextEditor = app.textViews.firstMatch 
        XCTAssertTrue(bodyTextEditor.waitForExistence(timeout: 2), "Body text editor not found.")
        bodyTextEditor.tap()
        // Dismiss keyboard if it's obscuring the text editor or save button
        // Sometimes needed, especially if text editor is large
        // if app.keyboards.buttons["Done"].exists {
        //    app.keyboards.buttons["Done"].tap()
        // }
        bodyTextEditor.typeText("This is the body of my UI test entry.")
        
        let saveButton = app.buttons["Save"]
        XCTAssertTrue(saveButton.waitForExistence(timeout: 2), "Save button not found.")
        saveButton.tap()

        // 3. Verify that the new entry appears in the list on the main screen.
        // The list might take a moment to update.
        XCTAssertTrue(app.staticTexts["My UI Test Entry"].waitForExistence(timeout: 5), "The new entry title did not appear in the list.")
    }
    
    @MainActor
    func testNavigateToEditAndSave() throws {
        // Pre-condition: Add an entry first to ensure one exists.
        // For a real test suite, you might have a helper function or rely on a specific state.
        // Reusing parts of testAddJournalEntry for setup:
        let plusButton = app.navigationBars["My Journal"].buttons.element(matching: .button, identifier: "plus").firstMatch
        if !plusButton.waitForExistence(timeout: 5) {
             // If the add button isn't found, we can't proceed with this test.
             // This test depends on the add functionality working.
             XCTFail("Plus button not found, cannot set up for edit test.")
             return
        }
        plusButton.tap()
        
        let initialTitle = "Entry To Edit"
        let updatedTitle = "Edited Test Entry"

        let titleTextField = app.textFields["Title"]
        XCTAssertTrue(titleTextField.waitForExistence(timeout: 2), "Title text field not found on add screen.")
        titleTextField.tap()
        titleTextField.typeText(initialTitle)

        let bodyTextEditor = app.textViews.firstMatch
        XCTAssertTrue(bodyTextEditor.waitForExistence(timeout: 2), "Body text editor not found on add screen.")
        bodyTextEditor.tap()
        bodyTextEditor.typeText("Initial body for edit test.")
        
        let saveButtonOnAddScreen = app.buttons["Save"]
        XCTAssertTrue(saveButtonOnAddScreen.waitForExistence(timeout: 2), "Save button not found on add screen.")
        saveButtonOnAddScreen.tap()

        // Now, tap on the entry in the list.
        let listEntry = app.staticTexts[initialTitle]
        XCTAssertTrue(listEntry.waitForExistence(timeout: 5), "The entry to be edited ('\(initialTitle)') did not appear in the list.")
        listEntry.tap()

        // On the "Edit Entry" screen:
        XCTAssertTrue(app.navigationBars["Edit Entry"].waitForExistence(timeout: 2), "The 'Edit Entry' view did not appear.")
        
        let titleTextFieldEdit = app.textFields[initialTitle] // The TextField will initially contain the old title
        XCTAssertTrue(titleTextFieldEdit.waitForExistence(timeout: 2), "Title text field not found on edit screen.")
        titleTextFieldEdit.tap()
        // Clear existing text before typing new text.
        // There isn't a direct "clear text" in XCUITest for text fields.
        // A common workaround is to tap, select all, then type.
        // Or, delete character by character if needed.
        // For simplicity, trying to triple tap to select all then type.
        titleTextFieldEdit.doubleTap() // Often selects all text
        titleTextFieldEdit.typeText(updatedTitle) // Type new title (replaces selection)
        
        // Optionally modify the body too. For this test, title change is enough to verify.

        let saveButtonOnEditScreen = app.buttons["Save"]
        XCTAssertTrue(saveButtonOnEditScreen.waitForExistence(timeout: 2), "Save button not found on edit screen.")
        saveButtonOnEditScreen.tap()

        // Verify the changes are reflected on the main screen.
        XCTAssertTrue(app.staticTexts[updatedTitle].waitForExistence(timeout: 5), "The updated entry title ('\(updatedTitle)') did not appear in the list.")
        XCTAssertFalse(app.staticTexts[initialTitle].exists, "The old entry title ('\(initialTitle)') should no longer exist.")
    }

    // Original testExample and testLaunchPerformance can be kept or removed.
    // For this task, I'll comment them out to focus on the new tests.
    /*
    @MainActor
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    */
}
