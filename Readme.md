
# SwipeVC

SwipeVC lib created for helping you manage view controllers simply sliding left and right.
You can inject tabBar for manage this screens by tap on item ( like UITabBar ).
NavigationBar give for you possible for cool animation of change tab bar items and titles, that can be simply customize.For added NavigationBar you should simply inject it.
We added different type of insets for give possible of customizing design as you need(contentInsets, tabBarInsets, viewControllersInsets).

## Project Status

This project is actively under development. We consider it ready for production use.

## CocoaPods

For SwipeVC, use the following entry in your Podfile:

```rb
pod 'SwipeVC'
```

Then run `pod install`.

In any file you'd like to use SwipeVC in, don't forget to
import the framework with `import SwipeVC`.

## Usage

For use SwipeViewController, you can simply extend you ViewController from SwipeViewController. And add view controllers to viewControllers property.

```swift
final class ExampleSwipeViewController: SwipeViewController {

override func viewDidLoad() {
super.viewDidLoad()
addViewControllers()
}

private func addViewControllers() {
let firstViewController = storyboard!.instantiateViewController(withIdentifier: "FirstViewController") as! FirstViewController
let secondViewController = storyboard!.instantiateViewController(withIdentifier: "SeondViewController") as! SeondViewController

viewControllers = [firstViewController, secondViewController]
}

}
```
For use tabBar, you should inject tabBar property. You can use DefaultTabBar or DefaultCollectionTabBar or your custom realization.

```swift
final class ExampleSwipeViewController: SwipeViewController {

override func viewDidLoad() {
super.viewDidLoad()
tabBarInjection()
}

private func tabBarInjection() {
let DefaultTabBar = DefaultTabBar()
DefaultTabBar.backgroundColor = UIColor.orange
tabBar = DefaultTabBar

let firstItem = SwitchItem(title: "First Item", image: UIImage(named: "icFirstItem"))
firstItem.titleLabel?.font = UIFont.systemFont(ofSize: 15)
let secondItem = SwitchItem(title: "Second Item", image: UIImage(named: "icSecondItem"))
secondItem.titleLabel?.font = UIFont.systemFont(ofSize: 15)

tabBar?.items = [firstItem, secondItem]
}

}
```
For use NavigationBar, you should inject navigationBar property,  and you should realize NavigationBarDelegate in you child view controller. You can use DefaultNavigationBar or your custom realization for navigationBar injection.

```swift
final class ExampleSwipeViewController: SwipeViewController {

override func viewDidLoad() {
super.viewDidLoad()
tabBarInjection()
navigationBarInjection()
}

private func navigationBarInjection() {
let defaultNavigationBar = DefaultNavigationBar()
defaultNavigationBar.backgroundColor = UIColor.blue
defaultNavigationBar.titleTextColor = UIColor.white
navigationBar = defaultNavigationBar
}

}

final class FirstViewController: UIViewController, NavigationBarDelegate {

func navigationBarRightGroupItems() -> [NavigationItem]? {
return[NavigationItem(image: #imageLiteral(resourceName: "icUser"),
target: self,
action: #selector(buttonAction()))]
}

func navigationBarBottomView() -> UIView? {
let bottomView = BottomNavBarView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 40))
return bottomView
}

func navigationBarTitle() -> String? {
return "First View Controller"
}

}
```

## Contributing

Hey! Do you like SwipeVC? Awesome! We could actually really use your help!

Open source isn't just writing code. SwipeVC could use your help with any of the
following:

- Finding (and reporting!) bugs.
- New feature suggestions.
- Answering questions on issues.
- Documentation improvements.
- Reviewing pull requests.
- Helping to manage issue priorities.
- Fixing bugs/new features.

If any of that sounds cool to you, send a pull request!

## License

SwipeVC is released under an MIT license. See [License.txt](License.txt) for more information.

