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

widget 是 immutable object，這表示一旦一個 widget 被創建，它的屬性就不能再被修改。這樣做可以讓界面的渲染更有效率，因為框架只需要比較新的 widget tree 和之前的 tree 之間的差異，然後僅更新變更的部分。此外，使用 immutable object 可以使程式碼更可預測和更容易理解。
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

The state class extends ChangeNotifier, which means that it can notify others about its own changes. For example, if the current word pair changes, some widgets in the app need to know.(實現狀態管理，可以在狀態發生變化時通知使用它的 widget 進行重建。)

ChangeNotifier 包含 notifyListeners() 方法，當狀態改變時，該方法會被調用，然後會通知所有使用它的 widget 進行重建。
因此，當你使用 ChangeNotifier 來管理狀態時，你只需要調用 notifyListeners() 方法來通知 widget 進行重建，而不需要手動操作 widget tree。

通常使用 Provider 庫來實現。使用了 ChangeNotifier 和 InheritedWidget 技術來實現狀態共享和管理。使用 Provider 庫，你可以將一個 ChangeNotifier 作為狀態管理的核心，然後通過 Provider.of(context) 方法來獲取它，並且當狀態改變時，使用它的 widget 會自動進行重建。

總之，ChangeNotifier 是 Flutter 中實現簡單狀態管理的一種方式，它與 Provider 庫一起使用，可以輕鬆地管理 widget 的狀態並實現重建。
