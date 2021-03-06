# Project 4 - Chirp

Chirp is a basic twitter app to read and compose tweets the [Twitter API](https://apps.twitter.com/).

Time spent: 35 hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] User sees app icon in home screen and styled launch screen
- [x] User can sign in using OAuth login flow
- [x] User can Logout
- [x] User can view last 20 tweets from their home timeline
- [x] In the home timeline, user can view tweet with the user profile picture, username, tweet text, and timestamp.
- [x] User can pull to refresh.
- [x] User can tap the retweet and favorite buttons in a tweet cell to retweet and/or favorite a tweet.
- [x] User can compose a new tweet by tapping on a compose button.
- [x] Using AutoLayout, the Tweet cell should adjust it's layout for iPhone 7, Plus and SE device sizes as well as accommodate device rotation.
- [x] The current signed in user will be persisted across restarts

The following **optional** features are implemented:

- [ ] Tweet Details Page: User can tap on a tweet to view it, with controls to retweet, favorite, and reply.
- [x] User can view their profile in a profile tab
- [x] User should display the relative timestamp for each tweet "8m", "7h"
- [x] User should be able to unretweet and unfavorite and should decrement the retweet and favorite count.
- [x] Links in tweets are clickable
- [x] User can tap the profile image in any tweet to see another user's profile
   - [x (did not do tagline) ] Contains the user header view: picture and tagline
   - [x] Contains a section with the users basic stats: # tweets, # following, # followers
   - [x] Profile view should include that user's timeline
- [ ] User can load more tweets once they reach the bottom of the feed using infinite loading similar to the actual Twitter client.
- [x] When composing, you should have a countdown in the upper right for the tweet limit.
- [x] After creating a new tweet, a user should be able to view it in the timeline immediately without refetching the timeline from the network.
- [(half done)] User can reply to any tweet, and replies should be prefixed with the username and the reply_id should be set when posting the tweet
- [x] Profile view should include that user's timeline
- [ ] Pulling down the profile page should blur and resize the header image.

The following **additional** features are implemented:

- [x] List anything else that you can get done to improve the app functionality!
Custom font, custom logo, placeholder text, alerts user when over the word limit

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. using one cell and changing the reuse id
2. autolayout

## Video Walkthrough

Here's a walkthrough of implemented user stories:

[Imgur](http://i.imgur.com/F6lfPXm.gifv)

AutoLayout functionality of the app: [Imgur](http://i.imgur.com/L64jfoU.gifv)

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Describe any challenges encountered while building the app:
I had trouble with the profile cells, saving mine versus loading others. I also had autolayout issues and loading a certain user's timeline

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library

## License

    Copyright [yyyy] [name of copyright owner]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
