# FinKart

An **e-commerce order management application** built with Flutter.  
The app includes the following features:
- A **graph view** of orders over time.
- A **paginated list of orders**.
- Search functionality for orders by tags.
- A **detailed view** of individual orders.

This project follows the **MVVM architecture** and uses **Provider** for state management.
The Local authentication is build using **RiverPod** following the **MVC Arcitecture** for demonstation purposes. To prevent the use of any network calls, Authentication is handled using Hive.

---

## Features

1. **Graph View**: Visualize the cumulative order count over time.
2. **Orders List**: Fetch and display orders in a paginated format.
3. **Search**: Search for orders using tags.
4. **Order Details**: View detailed information about any specific order.

---


### Main Libraries Used
- **Provider**: For state management.
- **Hive**: For local storage.
- **FL Chart**: For rendering graphs.
- **Local Auth**: For handling local authentication.
- **Cached Network Image**: For handing network images

---

## Getting Started

### Prerequisites
Make sure you have the following installed:
- Flutter SDK (latest stable version)
- Dart SDK
- An editor like Visual Studio Code or Android Studio

### Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/abdullahhusam/finKart.git
   cd finKart

### Running

1. **Running The Project**:
 ```bash
flutter pub get
flutter run
# finKart
# finKart
