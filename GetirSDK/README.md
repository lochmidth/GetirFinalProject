# GetirService
Created by Alphan Ogün

GetirService is a Swift package that provides a service layer for fetching products and suggested products from a mock API. It utilizes SwiftAsyncNetworking for performing asynchronous network requests.

## Features

- **Async/Await Concurrency:** Utilizes Swift's async/await concurrency model for performing network requests asynchronously, making networking code cleaner and more readable.
- **Dependency Injection:** Allows injecting a custom `NetworkClientProtocol` implementation into `GetirService` for easier testing and customization.

## Installation

You can integrate GetirService into your Swift projects using Swift Package Manager (SPM).

1. Open your Xcode project.
2. Go to File >  Add Package Dependencies...
3. Add local... > Select package directory.

## Usage

Using GetirService to fetch products and suggested products is straightforward:

1. Import GetirService and SwiftAsyncNetworking modules.
2. Create an instance of `GetirService`.
3. Call the `fetchProducts` and `fetchSuggestedProducts` methods on the service instance.

### Example

```swift
import GetirService

// Create an instance of GetirService
let getirService = GetirService()

// Fetch products
do {
    let products = try await getirService.fetchProducts()
    // Handle products
} catch {
    // Handle error
}

// Fetch suggested products
do {
    let suggestedProducts = try await getirService.fetchSuggestedProducts()
    // Handle suggested products
} catch {
    // Handle error
}

