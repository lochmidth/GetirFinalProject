<p align="center">
  <img src="GetirFinalProject/Recources/Assets.xcassets/AppIcon.appiconset/1024.png" alt="Getir Lite App Icon" width="150" height="150">
</p>

<div align="center">
  <h1>Getir Lite - Patika.dev Final Project by Alphan Ogün</h1>
</div>

Welcome to Getir Lite. A Simplified version of the Getir app! This app allows user to browse through products, add or remove to cart and checkout seamlessly.

## Table of Contents
- [Features](#features)
  - [Screenshots](#screenshots)
  - [Tech Stack](#tech-stack)
  - [Architecture](#architecture)
  - [Unit Tests](#unit-tests)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Usage](#usage)
  - [Listing - Browse Products](#listing---browse-products)
  - [Product Detail](#product-details)
  - [Basket](#basket)
- [Known Issues](#known-issues)
- [Improvements](#improvements)

## Features

 **Browse Products:**
- Explore a variety of products available for purchase.
- (Note that none of the products nor suggested products are real. They are been provided by a mock api.)
  
 **Manage Your Basket:**
- Easily add or remove products to your shopping cart for later purchase.
- With the implemented Core Data, Do not lose your cart when re-launching the app.
  
 **Checkout:**
- Simulate the checkout process to complete your order!

 ## Screenshots

| Image 1                | Image 2                | Image 3                |
|------------------------|------------------------|------------------------|
| ![Listing1](https://github.com/lochmidth/GetirFinalProject/blob/main/Screenshots/Listing%20Empty.png) | ![Listing2](https://github.com/lochmidth/GetirFinalProject/blob/main/Screenshots/Listing%20with%20Products.png) | ![Detail1](https://github.com/lochmidth/GetirFinalProject/blob/main/Screenshots/Product%20Detail%20Empty.png) |
| Listing Without PRoducts    | Listing With Products    | Product Detail (Not In Cart)    |

| Image 4                | Image 5                | Image 6                |
|------------------------|------------------------|------------------------|
| ![Detail2](https://github.com/lochmidth/GetirFinalProject/blob/main/Screenshots/Product%20Detail%20with%20Products.png) | ![Basket1](https://github.com/lochmidth/GetirFinalProject/blob/main/Screenshots/Basket%201.png) | ![Basket2](https://github.com/lochmidth/GetirFinalProject/blob/main/Screenshots/Basket%202.png) |
| Product Detail (In Cart)    | Basket    | Basket (Product Removed)    |

## Tech Stack

- **Xcode:** Version 15.3
- **Language:** Swift 5.10
- **Minimum iOS Version:** 13.0
- **Dependency Manager:** SPM

## Architecture

![Architecture](https://ckl-website-static.s3.amazonaws.com/wp-content/uploads/2016/04/Viper-Module.png.webp)

In developing Getir Final Project, VIPER (View-Interactor-Presenter-Entity-Router) architecture is being used for these key reasons:

- **Clear Separation:**  VIPER architecture separates UI, business logic, and navigation for cleaner, more maintainable code.
- **Test-Driven Development:** VIPER's modular structure enables comprehensive unit testing, ensuring app stability.
- **Scalability:** VIPER's modular design allows easy addition of features and modifications.

### Unit Tests

- All of the presenters and interactors of every module
- CartService
- SwiftAsyncNetworking, GetirSDK (my own local SPMs)
  are tested.

## Getting Started

### Prerequisites

Before you begin, ensure you have the following:

- Xcode installed

Also, make sure that these dependencies are added in your project's target:

- [Kingfisher](https://github.com/onevcat/Kingfisher):  Kingfisher is a lightweight and pure Swift library for downloading and caching images from the web.
- [SwiftAsyncNetworking](https://github.com/lochmidth/GetirFinalProject/tree/main/SwiftAsyncNetworking):  My own local package for concurrent networking. (Available documentation in project directory)
- [GetirSDK](https://github.com/lochmidth/GetirFinalProject/tree/main/GetirSDK):  My own local package to mimic the GetirService. (Available documentation in project directory)

### Installation

1. Clone the repository:

    ```bash
    git clone https://github.com/lochmidth/GetirFinalProject.git
    ```

2. Open the project in Xcode:

    ```bash
    cd GetirFinalProject
    open GetirFinalProject.xcodeproj
    ```
3. Add required dependencies using Swift Package Manager:

   ```bash
   - Kingfisher
   - SwiftAsyncNetworking (local)
   - GetirSDK (local)
    ```

6. Build and run the project.

## Usage

###  Listing - Browse Products

1. Open the app on your simulator or device.
2. Browse through products, add or remove to cart by tapping on steppers
3. Navigate to Product Detail by tapping on the relevant product.

<p align="left">
  <img src="https://github.com/lochmidth/GetirFinalProject/blob/main/Screenshots/ListingGIF.gif" alt="Listing" width="200" height="400">
</p>

---

### Product Detail 

1. See additional information about the product if provided.
2. By tapping on "Add to Cart" or stepper buttons, manage your cart.

<p align="left">
  <img src="https://github.com/lochmidth/GetirFinalProject/blob/main/Screenshots/ProductDetailGIF.gif" alt="Listing" width="200" height="400">
</p>

---

### Basket

1. Tap on the upper-right Basket View for navigating to Basket.
2. Manage your cart by adding or removing already-in-cart products.
3. Add from suggested producs to cart if interested.
4. Tap checkout button to checkout, or clear the cart by tapping on trash icon.

<p align="left">
  <img src="https://github.com/lochmidth/GetirFinalProject/blob/main/Screenshots/BasketGIF.gif" alt="Listing" width="200" height="400">
</p>

---

## Known Issues
- When updating BasketViewController by adding or removing product from cart, UI flicks for a really short time due to collectionView.reload()

## Improvemets
- A more pleasent and seamless animations can be add for a better user experience.
- Localization for other languages can be added to be able to reach more user.
- Consolidate CartService into GetirSDK to adhere more closely to the SOLID principles, particularly the Single Responsibility Principle.
