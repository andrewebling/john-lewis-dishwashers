# Dishwashers
Technical test for John Lewis by Andrew Ebling.

# Requirements

* Xcode 7.3.1/iOS 9 SDK
* Carthage 0.11.0 or later

# Building

1. Clone the project
1. Open a terminal and issue the following command within the top level project directory: ```carthage update --platform iOS```
1. Open the Xcode project file and build in the normal way

I chose to use Carthage over Cocoapods because:
 * It's more modern/up to date/likely to be maintained longer
 * Doesn't require the use of an Xcode Workspace, so less chance of confusion, should a developer/reviewer open the Project file instead
 * All the libraries I want to use are compatible
 * Simpler
 * More flexible in the future
 
Also happy using Cocoapods where necessary, however.

# Architecture

The app uses the standard MVC architecture, taking care to avoid the _Massive View Controller_ problem, by breaking out responsibilities like server access & ```UICollectionViewDatasource``` implementation into other classes, enabling them to be tested in isolation, independently of the view controller lifecycle.

Alternative architectures like MVVM and VIPER were considered, but for an app of this size & complexity, did not represent the Agile mantra _"Simplest Possible Thing"_.

# Unit Testing

The app was developed mostly test first, with a emphasis on model and controller classes, long with integration tests for JSON server responses.

For UI testing, a fake was used decouple the collection view cell from the Storyboard, which might aid reuse in future projects.

In addition, a few Storyboard configuration tests were included, which would enable a Continuous Integration system to guard against a fundamentally broken Storyboard file (perhaps one in a "walking wounded" but still compiling state, as a result of a bad attempted merge).

# Testing

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

 * If the network connection was offline when a request is tried, re-trying the request later, so content loads as soon as a usable network connection becomes available.
 * Unit testing improvements - I still miss ```OCMock``` and reverting to fakes feels like a big backwards step. While it's still possible to use ```OCMock``` with Swift code, it requires the tests to be written in Objective-C. Given the lifetime of test code generally exceeds the code under test, this would not be desirable. In addition use of Storyboards make classical dependency injection impossible (since you aren't in control of the view controller initialization any more).
 * If this app was being developed/maintained by a larger team, I would probably recommend moving away from Storyboards. This would aid straight forward dependency injection and sidestep Storyboard merge conflicts, which can be a problem with large teams using a standard SCM branching strategy like GitFlow.
 * UITests
 * UI scripts which could be used for automating capturing and updating screenshots for the App Store, when integrated into a solution like Fastlane.