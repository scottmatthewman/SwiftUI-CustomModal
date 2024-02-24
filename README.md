# CustomModal

An implementation of a small modal view, with a similar API to SwiftUI's native `.sheet` and `.fullScreenCover` modals.

## Usage

The `.customModalRoot()` modifier must be applied at the top level for your view hierarchy. This will typically be the
first view in the `WindowGroup` setting.

```swift
import SwiftUI
import CustomModal

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .customModalRoot()
        }
    }
}
```

Within any subviews, you can define modals to display, using a Boolean `@State` variable to manage the modal's visibility.

```swift
import SwiftUI
import CustomModal

struct MySubview: View {
  @State private var showModal: Bool = false
  
  var body: some View {
    VStack {
      Text("Press the button to show a modal!")
      
      Button("Show the modal") {
        showModal = true
      }
    }
    .customModal(isPresented: $showModal) {
      Text("This is the modal view.")
    }
  }
}
```

### Dismissing the modal

By default, tapping on the greyed out space around the modal will dismiss it. This can be disabled by passing in a
`backgroundClick` argument of `.ignore`:

```swift
.customModal(isPresented: $showModal, backgroundClick: .ignore) {
  // modal content
}
```

> [!WARNING]
> If you disable background clicks,  it is your responsibility to provide an alternative means of dismissing the modal (see below).

You can also dismiss the modal programmatically inside the modal view itself. If you are coding the modal inline, you can
alter your `isPresented` state variable directly:

```swift
.customModal(isPresented: $showModal, backgroundClick: .ignore) {
  Button("Close") { showModal = false }
}
```

If you are using a custom view for your modal content, you could pass the state variable into a @Binding value. However, the 
preferred method is to use a `.dismissModal` environment function.

`.dismissModal` works in the same way as `.dismiss` for SwiftUI's native views.

```swift
import SwiftUI
import CustomModal

struct MyCustomModal: View {
  @Environment(\.dismissModal) private var dismissModal
  
  var body: some View {
    VStack {
      Text("Alert")
        .font(.title.bold())
      Text("This is an example of a warning-style custom modal")
      Button("Close") {
        dismissModal()
      }
    }
  }
}
```

> [!NOTE]
> If you attempt to access the `dismissModal` environment variable and there is no `.customModalRoot()` in a
> parent view, the call will have no effect.
