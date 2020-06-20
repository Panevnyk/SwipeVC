# SwipeVC

<p align="center">  
<img src="https://github.com/Panevnyk/SwipeVC/blob/master/Images/Bottom_tabBar.gif" width="200">
&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/Panevnyk/SwipeVC/blob/master/Images/Top_tabBar.gif" width="200">
</p>

SwipeVC framework created as a cool animated analog to UITabBarController. SwipeVC gives you the possibility to manage screen not only using TabBar controls but simply sliding left and right.

You can add SVCTabBar with different animations to manage those screens. Also, you have the possibility to customize TabBar a lot. 
Adjust TabBar to top or bottom. Predefine insets by specific rules. Setup different Animators to image and title of the TabBarItem.
Also, you can inject your own custom TabBar, TabBarItem, or specific Animator depends on what level of customization you need.

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
You can set tabBarType property (.top or . bottom) for change tab bar position in SVCSwipeViewController.
SVCSwipeViewController have contentInsets, tabBarInsets, viewControllersInsets properties for customize some spaces in different way if you needed.

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

#### Item animations:

You can use different Animators for SVCTabItem. SwipeVC has SVCBounceAnimator(), SVCRotationAnimator(), SVCImagesAnimator(), SVCTransitionAnimator() ...

```swift
let tabBarItem = SVCTabItem(type: .system)
tabBarItem.imageViewAnimators = [SVCBounceAnimator()]
tabBarItem.titleLabelAnimators = [SVCTransitionAnimator(transitionOptions: .transitionFlipFromBottom)]
```

Or create your own Animator simply realized SVCAnimator protocol.

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

For use movable line view you should set "defaultTabBar.movableView.isHidden = false".
You can customize your  movableView (width, height, bouncing, attach).

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

## Example target

You can check more functionality of SwipeVC in [Example](Example) target.

## License

SwipeVC is released under an MIT license. See [License.txt](License.txt) for more information.
