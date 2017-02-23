# Dishwashers
Technical test for John Lewis by Andrew Ebling.

# Requirements

* Xcode 8/iOS 10 SDK
* Carthage 0.11.0 or later

# Building

1. Clone the project
1. Open a terminal and issue the following command within the top level project directory: ```carthage update --platform iOS --no-use-binaries```
1. Open the Xcode project file and build in the normal way

I chose to use Carthage over Cocoapods because:
 * It's more modern/up to date/likely to be maintained longer
 * Doesn't require the use of an Xcode Workspace, so less chance of confusion, should a developer/reviewer open the Project file instead
 * All the libraries I want to use are compatible
 * Simpler
 * More flexible in the future
 
Also happy using Cocoapods where necessary, however.

# Solution Notes

I focussed on a test-driven implementation of the main product grid screen, over a more complete but non-TDD implementation of the full specification.

However I also implemented a bare-bones product detail screen, to demonstrate how I would implement the transition and handle passing the data model around.

If implementing the product detail screen in full, I would make required network request on-demand (i.e. as the detail screen is prepared for display), but populate as many fields as possible from the available fields in ```Product``` (including the potentially lower resolution image, as a preview), then populate the remainder of the data once the product detail request returned.

# Architecture

The app uses the standard MVC architecture, taking care to avoid the typical _Massive View Controller_ problem, by breaking out responsibilities like server access & ```UICollectionViewDatasource``` implementation into other classes and extensions, enabling them to be tested in isolation, independently of the view controller lifecycle.

Alternative architectures like MVVM and VIPER were considered, but for an app of this size & complexity, did not represent the Agile mantra of _"Simplest Possible Thing"_.

# Unit Testing

The app was developed mostly test first, with an emphasis on model and controller classes, long with integration tests for JSON server responses.

For UI testing, a fake was used decouple the collection view cell from the Storyboard, which might aid reuse in future projects.

In addition, a few Storyboard configuration tests were included, which would enable a Continuous Integration system to guard against a fundamentally broken Storyboard file (perhaps one in a "walking wounded" but still compiling state, as a result of a bad attempted merge).

# Manual Testing

* I used a combination of using a temporarily invalid API key and Charles Proxy to re-write responses to check the app's behaviour of server errors etc.
* I verified that online/offline behaviour worked as desired, relying on the Alamofire implementation.

# Credits & Libraries Used

* Alamofire - by the Alamofire Software Foundation; a library written in Swift which provides a much more convenient wrapper around more modern iOS networking APIs. I chose this because:

 * It has become an industry standard and a more than worthy replacement for AFNetworking.
 * It greatly reduces code volume around networking requests.
 * It handles online/offline behaviour gracefully.
 * It has a great deal of community support and is at low risk of becoming abandonware in the future. 
* AlamofireImageView - by the Alamofire Software Foundation; a library written in Swift which makes working with images in a network environment much simpler and cleaner. I chose to use this because:
 * It piggybacks Alamofire.
 * It greatly reduces code volume and improves simplicity for populating a grid of ```UIImageView``` objects.
 * It has nice features like gently fading in the image, improving user experience.
* SwiftyJSON - written by tangplin & lingoer; a library written in Swift which makes JSON parsing code a lot more readable and maintainable. Although it's fairly straightforward to write your own JSON parsing code, built on top of ```NSJSONSerialization``` I chose to use this because:
 * JSON parsing code (especially in Swift) can become quite repetitive, verbose and difficult to navigate and maintain (e.g. so-called _"pyramid of doom"_ problem). Given that JSON interfaces can and do change, this is an important consideration.
 * Greatly improved readability of JSON parsing code.
 * Lots of community involvement.
 * Lots of tests.
 * Widely used and stable for some time now.
 
# Points for Improvement
 * Completing the (optional) product screen with full details. I would use a dynamic ```UITableView``` for the specification list and a paged ```UIScrollView``` to allow the user to browse multiple product images.
 * Error handling - in the case of failed JSON parsing in a production app, I would handle the error as gracefully as possible (e.g. not display item in question), post an error report to a server endpoint or log an analytics event. I would do this in preference to bothering the user with error messages for conditions which they can do nothing about.
 * Look and feel - use fonts from branding guidelines and abstract/centralise code relating to branding and overall appearance, most likely using the ```UIAppearance``` API.
 * Implement a custom ```UICollectionViewFlowLayout``` to ensure the grid is laid out nicely in landscape on iPad Pro.
 * If the network connection was offline when a request is tried, re-trying the request later, so content loads as soon as a usable network connection becomes available.
 * Unit testing improvements - I still miss ```OCMock``` and reverting to fakes feels like a big backwards step. While it's still possible to use ```OCMock``` with Swift code, it requires the tests to be written in Objective-C. Given the lifetime of test code generally exceeds the code under test, this would not be desirable. In addition use of Storyboards make classical dependency injection impossible (since you aren't in control of the view controller initialization any more).
 * If this app was being developed/maintained by a larger team, I would probably recommend moving away from Storyboards. This would aid straight forward dependency injection and sidestep Storyboard merge conflicts, which can be a problem with large teams using a standard SCM branching strategy like GitFlow.
 * UITests
 * UI scripts which could be used for automating capturing and updating screenshots for the App Store, when integrated into a solution like Fastlane.
