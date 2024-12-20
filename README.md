## Hey! 👋🏼 I'm Garrett and I want to thank you for taking the time to review my take home assessment. What a fun project!

### Steps to Run the App

You shouldn't need to do anything special, though please ensure you are using Xcode 16 then just run the application on your simulator.

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

- I really tried to put some time into setting up the necessary scaffolding for this project to continue to be built on. I wanted to demonstrate how I like to invest heavier up front to put things in place for easy additions/changes later. For example, if a new API was needed, it would be as simple as only creating a new `ApiRequest` and executing it with the existing `ApiService`. Networking, serialization and clean error parsing would already be handled.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?

I time boxed this project to 4 hours. I invested heavily in the initial setup of the application: networking, models, image loading, caching and then spent the last hour or so completing the UI. 

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?

- I didn't take the time to standardize the size of the images I was caching. Ideally, I'd like to have some guardrails in place to keep from caching larger images and compressing them to only what the application needs.
- API request cancellation. Since we aren't doing navigation in this project (yet), I chose to punt on implementating API request cancellation. This would be an immediate need as soon as the app begins to grow.

### Weakest Part of the Project: What do you think is the weakest part of your project?

#### Image Loading

I have to admit, I have gotten really used to used awesome libraries such as Kingfisher or SDWebImage so building this myself was a great exercise! Obviously there is nothing overly complicated with writing data to the disk or fetching it from a url, but combining both of those things with performance and thread safety requires some careful planning. I like where my implementation ended up for the purposes of this application, though I would like to spend more time improving it with things such as compression, request cancellation and maybe even the help of an in memory cache layer.

#### Dependency Management / Injection

I have used libraries such as Needle in the past to manage dependencies, but due to the restriction of no 3rd party libraries and the limited time preventing me from building my own, I opted to just use static properties with comments to improve later.

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.

 - I would've loved to used Swift Tests but was running into some issues asserting certain enums cases (and their associated values) were equal. I have limited experience with Swift Tests, but did find a Swift forum post talking about this limitation. So for now, I just leveraged XCTest.
 - Didn't touch localization in this assessment, but this would be on my mind to add as a fast follower. I see the Fetch app supports Spanish, which is awesome!
 - UI tests would be a nice addition as interactions are added, just didn't have the time to add any
 - For `ApiRequest` to really be able to support all API requests, I would need to add support for encoding a request body before being about to post data
