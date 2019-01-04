![](https://github.com/Chris-Perkins/SwiftTwitch/raw/master/Readme_Imgs/SwiftTwitch.jpg)

[![Version](https://img.shields.io/cocoapods/v/SwiftTwitch.svg?style=flat)](https://cocoapods.org/pods/SwiftTwitch)
[![License](https://img.shields.io/cocoapods/l/SwiftTwitch.svg?style=flat)](https://cocoapods.org/pods/SwiftTwitch)
[![Platform](https://img.shields.io/cocoapods/p/SwiftTwitch.svg?style=flat)](https://cocoapods.org/pods/SwiftTwitch)

**THIS IS AN UNOFFICIAL, FAN-MADE WRAPPER. IT IS IN NO WAY ENDORSED BY TWITCH.TV**

## What is It?

Swift Twitch is a library intended for client-facing applications to interact with the New Twitch API, or the Helix API. This library aims to simplify the process of interacting with Twitch by returning Typed data values to help get your application running as soon as possible.

🥰 Pull requests are very welcome 🥰

## Available API Calls

You can run the following API calls:

| API Method | Swift Function |  
|:-:|:-:|  
Get Extension Analytics | `Twitch.Analytics.getExtensionAnalytics`
Get Game Analytics | `Twitch.Analytics.getGameAnalytics`
Get Bits Leaderboard | `Twitch.Bits.getBitsLeaderboard`
Create Clip | `Twitch.Clips.createClip`
Get Clips | `Twitch.Clips.getClips`
Get Top Games | `Twitch.Games.getTopGames`
Get Games | `Twitch.Games.getGames`
Get Streams | `Twitch.Streams.getStreams`
Get Streams Metadata | `Twitch.Streams.getStreamsMetadata`
Create Stream Marker | `Twitch.Streams.createStreamMarker`
Get Stream Markers | `Twitch.Streams.getStreamMarkers`
Get Users | `Twitch.Users.getUsers`
Get Users Follows | `Twitch.Users.getUsersFollows`
Update User | `Twitch.Users.updateUser`
Get User Extensions | `Twitch.Users.getUserExtensions`
Get Videos | `Twitch.Videos.getVideos`

### Documentation

[The Twitch API Documentation is available here](https://dev.twitch.tv/docs/api/reference/)

[This Library's Documentation is available here](https://htmlpreview.github.io/?https://github.com/Chris-Perkins/SwiftTwitch/blob/master/docs/index.html)

### Example Usage

<details>  
<summary>Example method to check if a user is following another user</summary>  
Let's say I want to find out if two users are following each other. Below is how I might utilize that by using the `Get User Follows` API method:

```Swift
import SwiftTwitch

class AwesomeClass {
    func spectacularFunction() {
        TwitchTokenManager.shared.accessToken = "$SomeValidToken"

        let user1Id = "1234"
        let user2Id = "5678"
        Twitch.Users.getUsersFollows(followerId: user1Id, followedId: user2Id) { result in 
            switch result {
            case .success(let getUsersFollowsData):
                /* If the total = 1, we know that user1 is following user2 
                   as it is documented in the Twitch API docs. */
                if getUsersFollowsData.total == 1 {
                    print("User \(user1Id) is following user \(user2Id)!")
                } else {
                    print("User \(user1Id) is not following user \(user2Id)")
                }
            case .failure(let data, let response, let error):
                print("The API call failed! Unable to determine relationship.")
            }
        }
    }
}

```
</details>

## Get Started

### I don't have an access token!

In order to use this library, you must first have an application register on the Twitch Developer portal. You can register your application quickly [on Twitch's official application creation dashboard](https://glass.twitch.tv/console/apps/create). After this step, there are two methods to retrieving API keys.

#### Automatic Access Token Retrieval

TODO :)

#### Manually Retrieve Access Token

[To manually retrieve an access token, please utilize this guide by Twitch.](https://dev.twitch.tv/docs/authentication/getting-tokens-oauth/#oauth-implicit-code-flow)

### I have my access token, now what?

Now that you have an access token, you can provide it to the application in the following manner.

```Swift
TwitchTokenManager.shared.accessToken = "$Your_Token"
```

Once this command is run, all of your API calls are now automatically authenticated! Now go make some API calls. :)

## Example Project

To run the example project, clone the repo, and run `pod install` from the Example directory. After that, open the resulting `.xcworkspace` file and go nuts!


## Installation

1. Install [CocoaPods](https://cocoapods.org)
1. Add this repo to your `Podfile`

	```ruby
	target 'Example' do
		# IMPORTANT: Make sure use_frameworks! is included at the top of the file
		use_frameworks!

		pod 'SwiftTwitch'
	end
	```
1. Run `pod install` in the podfile directory from your terminal
1. Open up the `.xcworkspace` that CocoaPods created
1. Done!

## License

SwiftTwitch is available under the MIT license. See the LICENSE file for more info.
