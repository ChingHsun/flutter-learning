# learn_flutter

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Learning Note

### Widget

a widget is a basic building block for constructing user interfaces.
A widget is an immutable object used to build UI, which can be a simple text or a complex nested layout.
The entire UI in Flutter is composed of widgets.

因此要改變 widget 的外觀或行為，必須創建一個新的 widget，並將其替換原來的 widget。
這通常是通過創建一個具有所需更改的屬性的新 widget 實例並將其傳遞給框架來完成的。
這個過程被稱為重建 widget tree，這是 Flutter 實現高性能和流暢動畫的關鍵。

#### stateless widget (an immutable static widget) or a stateful widget (a mutable dynamic widget)

- stateless widget: an immutable static widget. typically used to display static content.
- stateful widget: a mutable dynamic widget. rebuild their UI when user interaction or other events occur

StatefulWidget 和 StatelessWidget 的不同點是它們是否包含 mutable state。
Stateful widget 包含一個可變的 State 物件，並且 State 可以改變 widget 的外觀或行為。
然而，StatefulWidget 本身仍然是 immutable 的，這表示它的屬性無法被修改，並且在它被創建之後不能再修改。
因此，當狀態改變時，widget 並不會被修改，而是通過創建一個新的 widget 實例來重建 widget tree。在 Flutter 中，這是通過調用 State 的 setState() 方法觸發的。
總結來說，StatefulWidget 包含 mutable state，但 widget 本身仍然是 immutable 的，因此需要重建 widget tree 來反映狀態的改變。這使得 Flutter 界面的渲染更加高效，因為只有需要更新的部分才會被重建，而不是整個 widget tree。

### ChangeNotifier

The state class extends ChangeNotifier, which means that it can notify others about its own changes.
For example, if the current word pair changes, some widgets in the app need to know.
(實現狀態管理，可以在狀態發生變化時通知使用它的 widget 進行重建。)

ChangeNotifier 包含 notifyListeners() 方法，當狀態改變時，該方法會被調用，然後會通知所有使用它的 widget 進行重建。
因此，當你使用 ChangeNotifier 來管理狀態時，你只需要調用 notifyListeners() 方法來通知 widget 進行重建，而不需要手動操作 widget tree。

通常使用 Provider 庫來實現。使用了 ChangeNotifier 和 InheritedWidget 技術來實現狀態共享和管理。使用 Provider 庫，你可以將一個 ChangeNotifier 作為狀態管理的核心，然後通過 Provider.of(context) 方法來獲取它，並且當狀態改變時，使用它的 widget 會自動進行重建。

總之，ChangeNotifier 是 Flutter 中實現簡單狀態管理的一種方式，它與 Provider 庫一起使用，可以輕鬆地管理 widget 的狀態並實現重建。

### WordPair

WordPair 是一個結構化的資料型別, 應用時機通常是在需要產生一些隨機的、容易記憶的、有意義的名稱時，例如在產生隨機用戶名、產品名稱、專案名稱等場景下

### late vs ?

late 和 ? 都是用於聲明可為空的變數，場景使用不一樣

late： lazily initialized。不需要立即初始化該變數，而是在第一次使用該變數之前進行初始化。
需要確保在第一次使用該變數之前對其進行初始化，否則會引發異常。可以避免不必要的初始化開銷。

?：optional execution operator used for declaring nullable variables or performing operations on nullable variables，

```
 late GlobalKey historyListKey;
 GlobalKey? historyListKey;
```

### final vs const

final 的值可以在運行時決定，而 const 的值必須在編譯時決定。
這意味著，const 變數只能包含字面值（literal）(每次運行時相同)，而 final 變數可以包含任何運行時常量(運行時不一定相同)，例如 DateTime.now()
const 變數是隱含 final 的。但反過來不成立，也就是說 final 變數不一定是 const 變數。
const 變數可以在類定義的層級上聲明，而 final 變數只能在函數和方法的層級上聲明。

### GlobalKey

GlobalKey 用於在 widget tree 中標識特定的 widget。
可以用於從 widget tree 中查找特定的 widget，並且它可以被用於訪問 widget 的狀態和方法。
用於實現一些複雜的功能，如狀態管理、動畫、手勢處理和渲染等。

Flutter 是一個 widget 樹，每個 widget 都有一個獨一無二的 key，用於區分不同的 widget。
通常情況下，Flutter 可以根據 widget 的類型和位置來區分，但有時候需要直接引用特定的 widget。
這時就可以使用 GlobalKey，通過 key 來查找 widget。

另一個使用場景是在 widget 樹中訪問 widget 的狀態和方法。
當 widget 需要在不同的 widget 中共享狀態時，可以使用 GlobalKey 來實現狀態管理。
例如，當構建一個包含多個 widget 的表單時，需要收集所有輸入欄位的值，可以使用 GlobalKey 來訪問每個輸入欄位的狀態和值，並將它們合併成一個表單值。
