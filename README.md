# SwiftUI MVVM Firebase
![Project Image](https://res.cloudinary.com/dnpje4e34/image/upload/v1620341535/App_bnsfkj.jpg)



---

## Description

SwiftUI is such a pleasure. When you combine it with Firebase, it’s so much easier now to build robust apps. I want to share my journey in building a simple social media app.
Hopefully this repository will be useful for others. I am always open for feedback, and other contributors would be super cool.

This app uses MVVM architecture and repository to handle the Firebase data source. 

#### Technologies

- Xcode
- SwiftUI
- Firebase
- Combine
- Swift Package Manager


---

## How To Use
Note: This project uses Swift Package Manager to manage dependencies. Since the Firebase SDK is rather large, so it will take a little while.

You will need to set up a Firebase project.

1 Create account

2 Add a Project

3 Download the GoogleService-Info.plist file 

Before you add the GoogleService-Info.plist file to your project, you should probably make sure it’s in a gitignore  file. One simple way to do that is go to Xcode Preferences then Source Control then select git and add GoogleService-Info.plist file to ignored files.

4 Setup Authentication note this app uses Anonymous sign

5 Setup Cloud Firestore
I just selected test mode for now. You will need to change later to suit your needs.

---

## Refferences

[Firebase](https://firebase.google.com/)

[Getting Started with Cloud Firestore and SwiftUI]( https://www.raywenderlich.com/11609977-getting-started-with-cloud-firestore-and-swiftui)

[How To Create A Custom Tab Bar In SwiftUI](https://blckbirds.com/post/custom-tab-bar-in-swiftui/)

[Firebase and SwiftUI’s New Application Lifecycle](https://medium.com/firebase-developers/firebase-and-the-new-swiftui-2-application-life-cycle-e568c9f744e9)

[Learning SwiftUI, MVVM and Firebase](https://ongomobile.medium.com/learning-swiftui-mvvm-and-firebase-bbc3e5073a25)

---

## License

MIT License

Copyright (c) [2021] [Michael Haslam]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

[Back To The Top](#read-me-template)

---



