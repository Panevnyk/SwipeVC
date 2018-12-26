# SwipeVC

<p align="center">  
<img src="https://github.com/Panevnyk/SwipeVC/blob/master/Images/Combine_three_animators.gif" width="200"> 
<img src="https://github.com/Panevnyk/SwipeVC/blob/master/Images/Combine_three_animators_top.gif" width="200">
</p>

<p align="center">  
<img src="https://github.com/Panevnyk/SwipeVC/blob/master/Images/Combine_three_animators2.gif" width="200">
<img src="https://github.com/Panevnyk/SwipeVC/blob/master/Images/Combine_three_animators2_top.gif" width="200">
</p>

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
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let firstViewController = storyboard.instantiateViewController(withIdentifier: "FirstViewController") as! FirstViewController
        let secondViewController = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        let thirdViewController = storyboard.instantiateViewController(withIdentifier: "ThirdViewController") as! ThirdViewController
        
        viewControllers = [firstViewController, secondViewController, thirdViewController]
    }
}
```

For use tabBar, you should inject tabBar property. You can use SVCTabBar or your custom realization.

#### SVCTabBar example:
```swift
final class ExampleSwipeViewController: SVCSwipeViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarInjection()
    }

    private func tabBarInjection() {
        tabBarType = .top
        
        let defaultTabBar = SVCTabBar()
        
        // Init first item
        let firstItem = SVCTabItem(type: .system)
        firstItem.imageViewAnimators = [SVCTransitionAnimator(transitionOptions: .transitionFlipFromTop)]
        firstItem.setImage(UIImage(named: "ic_location_menu_normal")?.withRenderingMode(.alwaysOriginal), for: .normal)
        firstItem.setImage(UIImage(named: "ic_location_menu_selected")?.withRenderingMode(.alwaysOriginal), for: .selected)
        
        // Init second item
        let secondItem = SVCTabItem(type: .system)
        secondItem.imageViewAnimators = [SVCTransitionAnimator(transitionOptions: .transitionFlipFromRight)]
        secondItem.setImage(UIImage(named: "ic_users_menu_normal")?.withRenderingMode(.alwaysOriginal), for: .normal)
        secondItem.setImage(UIImage(named: "ic_users_menu_selected")?.withRenderingMode(.alwaysOriginal), for: .selected)
        
        // Init third item
        let thirdItem = SVCTabItem(type: .system)
        thirdItem.imageViewAnimators = [SVCTransitionAnimator(transitionOptions: .transitionFlipFromBottom)]
        thirdItem.setImage(UIImage(named: "ic_media_menu_normal")?.withRenderingMode(.alwaysOriginal), for: .normal)
        thirdItem.setImage(UIImage(named: "ic_media_menu_selected")?.withRenderingMode(.alwaysOriginal), for: .selected)
        
        defaultTabBar.items = [firstItem, secondItem, thirdItem]
        
        // inject tab bar
        tabBar = defaultTabBar
    }
}
```

You can you use different Animators for SVCTabItem. SwipeVC has SVCBounceAnimator(), SVCRotationAnimator(), SVCImagesAnimator(), SVCTransitionAnimator() ...
Or create your own Animator simply realized SVCAnimator protocol.

#### SVCAnimator example:

```swift
let tabBarItem = SVCTabItem(type: .system)
tabBarItem.imageViewAnimators = [SVCBounceAnimator()]
tabBarItem.titleLabelAnimators = [SVCTransitionAnimator(transitionOptions: .transitionFlipFromBottom)]
```

```swift
open class SomeCustomAnimator: SVCAnimator {
    open func select(onView view: UIView) {
        // Some select animation
    }

    open func deselect(onView view: UIView) {
        // Some deselect animation
    }
}

// And simple set animator to your item(image or title)
tabBarItem.imageViewAnimators = [SomeCustomAnimator()]
tabBarItem.titleViewAnimators = [SomeCustomAnimator()]
```

You can you movable line view in your tabBar.

#### SVCMovableView example:

```swift
func tabBarInjection() {
    let defaultTabBar = SVCTabBar()
    showMovableView(onDefaultTabBar: defaultTabBar)

    // Add some items ...

    // inject tab bar
    tabBar = defaultTabBar
}

func showMovableView(onDefaultTabBar defaultTabBar: SVCTabBar) {
    defaultTabBar.movableView.isHidden = false
    defaultTabBar.movableView.backgroundColor = ExampleSwipeViewController.defaultStyleColor
    defaultTabBar.movableView.bouncing = 0.5
    defaultTabBar.movableView.width = 64
    defaultTabBar.movableView.height = 1
    defaultTabBar.movableView.attach = .bottom
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
