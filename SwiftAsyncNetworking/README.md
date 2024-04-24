# SwiftAsyncNetworking
Created by Alphan Ogün

SwiftAsyncNetworking is ag lightweight Swift package that provides asynchronous networking capabilities using Swift's async/await concurrency model. 
Specifically created for Getir Final Project

## Features

- **Async/Await Concurrency:** Utilizes Swift's async/await concurrency model for performing network requests asynchronously, making networking code cleaner and more readable.
- **Error Handling:** Provides a set of predefined error types (`NetworkError`) for handling common networking errors such as invalid data or invalid URLs.
- **Customizable Headers and Parameters:** Allows customization of HTTP headers and parameters for each network request by conforming to the `NetworkRequestable` protocol.

## Installation

You can easily integrate SwiftAsyncNetworking into your Swift projects using Swift Package Manager (SPM).

1. Open your Xcode project.
2. Go to File >  Add Package Dependencies...
3. Add local... > Select the package directory.

## Usage

Using SwiftAsyncNetworking to perform network requests is straightforward:

1. Define your network request by conforming to the `NetworkRequestable` protocol.
2. Create an instance of `NetworkClient`.
3. Call the `performRequest` method on the client instance with your request object.

### Example

First, define your network request by creating a struct that conforms to the `NetworkRequestable` protocol:

```swift
import SwiftAsyncNetworking

struct MyRequest: NetworkRequestable {
    let baseURL = "https://api.example.com"
    let path = "/endpoint"
    let method = HTTPMethod.get
    let parameters: Encodable? = nil
    let headers: [String: String]? = ["Authorization": "Bearer token"]
```

Next, create a `NetworkClient` instance:

```swift
let networkClient = NetworkClient()


Finally, perform the network request using the `performRequest` method:

```swift
do {
    let response: MyResponseModel = try await networkClient.performRequest(request: MyRequest())
    // Handle response
} catch {
    // Handle error
}
```
