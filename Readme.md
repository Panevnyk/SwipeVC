# SwipeVC

SwipeVC lib created for helping you manage view controllers simply sliding left and right.
You can inject tabBar for manage this screens by tap on item ( like UITabBar ).
NavigationBar give for you possible for cool animation of change tab bar items and titles, that can be simply customize.For added NavigationBar you should simply inject it.
We added different type of insets for give possible of customizing design as you need(contentInsets, tabBarInsets, viewControllersInsets).

## CocoaPods

For SwipeVC, use the following entry in your Podfile:

```rb
pod 'SwipeVC'
```

Then run `pod install`.

In any file you'd like to use SwipeVC in, don't forget to
import the framework with `import SwipeVC`.

## Usage

For use SVCSwipeViewController, you can simply extend you ViewController from SVCSwipeViewController. And add view controllers to viewControllers property.

```swift
final class ExampleSwipeViewController: SVCSwipeViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        addViewControllers()
    }

    private func addViewControllers() {
        let firstViewController = storyboard!.instantiateViewController(withIdentifier: "FirstViewController") as! FirstViewController
        let secondViewController = storyboard!.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController

        viewControllers = [firstViewController, secondViewController]
    }
}
```
For use tabBar, you should inject tabBar property. You can use SVCDefaultTabBar or SVCDefaultCollectionTabBar or your custom realization.

#### SVCDefaultTabBar example:
```swift
final class ExampleSwipeViewController: SwipeViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarInjection()
    }

    private func tabBarInjection() {
        let defaultTabBar = SVCDefaultTabBar()
        defaultTabBar.backgroundColor = UIColor.orange

        /// Init first item
        let firstItem = SVCTabItem(title: "First Item",
        image: UIImage(named: "icFirstItem"))
        firstItem.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        /// Init second item
        let secondItem = SVCTabItem(title: "Second Item",
        image: UIImage(named: "icSecondItem"))
        secondItem.titleLabel?.font = UIFont.systemFont(ofSize: 15)

        defaultTabBar?.items = [firstItem, secondItem]

        /// inject tab bar
        tabBar = defaultTabBar
    }
}
```

#### SVCDefaultCollectionTabBar example:
```swift
final class ExampleSwipeViewController: SVCSwipeViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarInjection()
    }

    private func tabBarInjection() {
        let defaultCollectionTabBar = SVCDefaultCollectionTabBar()
        defaultCollectionTabBar.backgroundColor = UIColor.orange
        defaultCollectionTabBar.textFont = UIFont.systemFont(ofSize: 15)
        defaultCollectionTabBar.textColor = UIColor.black
        defaultCollectionTabBar.texts = ["First", "Second", "Third", "Fourth"]

        /// inject tab bar
        tabBar = defaultCollectionTabBar
    }
}
```
For use NavigationBar, you should inject navigationBar property,  and you should realize SVCNavigationBarDelegate in you child view controller. You can use SVCDefaultNavigationBar or your custom realization for navigationBar injection.

#### SVCDefaultNavigationBar example:
```swift
final class ExampleSwipeViewController: SVCSwipeViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarInjection()
        navigationBarInjection()
    }

    private func navigationBarInjection() {
        let defaultNavigationBar = SVCDefaultNavigationBar()
        defaultNavigationBar.backgroundColor = UIColor.blue
        defaultNavigationBar.titleTextColor = UIColor.white
        navigationBar = defaultNavigationBar
    }
}

final class FirstViewController: UIViewController, SVCNavigationBarDelegate {
    func navigationBarRightGroupItems() -> [NavigationItem]? {
        return[NavigationItem(image: UIImage(named: "icUser"),
        target: self,
        action: #selector(buttonAction()))]
    }

    func navigationBarBottomView() -> UIView? {
        let bottomView = BottomNavBarView(frame: CGRect(x: 0,
        y: 0,
        width: UIScreen.main.bounds.size.width,
        height: 40))
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
