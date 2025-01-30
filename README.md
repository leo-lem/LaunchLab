<!--
TODO: remove To-Dos
TODO: remove trailer?
TODO: remove demo?
-->

# Transferagentur: LaunchLab

<details>
<summary>Important Notes About this README</summary>

- This README is the central guide to your application.
  Its quality is important since your supervisor and client will use this file as a manual for your application.
- You must customize this README to your project.
  We expect you to use the pre-defined sections below and add the content explained in the To-Dos.
  These sections are based on an [empirical study by Prana et al](https://doi.org/10.1007/s10664-018-9660-3).
- Please place all multimedia content included in this README (e.g., your logo, trailer, or poster) in the [media]('/media/') folder.
- Please __mark completed to-dos as finished__ in the lists below.
- Use the [Markdown Guide](https://www.markdownguide.org) to get started with Markdown. Consider using Markdown's formatting options, like the ```code block environment```.
- Install a Markdown linter like [markdownlint for VS Code](https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint) in your IDE to improve your README's quality.
- Visual Studio Code offers a Markdown preview that displays this file in its rendered form.
  Other IDEs might offer such a feature as well.
- __DO NOT DELETE THIS NOTES SECTION AND THE TO-DOS!__

</details>

<details>
<summary>To-Dos</summary>

- [x] Edit the Project Title.
- [x] Optionally, you can add useful customized [badges](https://shields.io).

</details>

## Introduction

[LaunchLab Webpage](https://eric-liebrecht.github.io/launchlab/).

LaunchLab is your startup companion. From zero to your own startup. We guide you along your journey.

This application was created during the M-Lab course 2024 at the University of Hamburg for the client Transferagentur. Our client wanted to facilitate the startup founding consultation process. So we built LaunchLab. The sky is the limit!

![](media/trailer.mp4)

### Key features
- Your learning path journey to guide you through all the steps from refining your idea to founding your company.
- Create your indiviual pitch deck, business plan at the press of a button.
- Direct link to real consultants to profit from valuable expertise.
- Integrated AI Co-Founder to help you out when you don't know the next steps.

### Deep Dive

If you're interested in deeper insights, have a look at our [Requirements Analysis](media/RAD.pdf) and [System Design Document](media/SDD.pdf).

<details>
<summary>To-Dos</summary>

- [x] Describe __what__ application you created and explain its main features (= implemented functional requirements) and qualities (= implemented non-functional requirements).
  Example:
  We present a communication app for iOS that enables visitors of a fair to network and exchange contact information with each other.
  The app's main features are: [...] The app's main qualities are: [...]
- [x] Describe __why__ you created this application.
  Example: This application was created during the M-Lab course 2020 at Universität Hamburg for the client Hamburg Messe.
  The client required an initial prototype to facilitate the communication and exchange of fair visitors. [...]
- [x] Include (a link to) your trailer here.
- [x] Optionally, you can place copies of your RAD and SDD artifacts in the __media__ folder and add links to them in your description.

</details>

## Getting Started

__IMPORTANT__: _The steps marked [Real Device] will be required if you want to run the app on a real device. A simulator should work without them._

### Prerequisites

1. A [Mac](https://www.apple.com/mac/).
2. [Xcode](https://developer.apple.com/xcode/) installed.
3. [Real Device] An [AppleID](https://account.apple.com) with an associated Apple Developer License.

<details>
<summary>To-Dos</summary>

- [x] List minimal system requirements (e.g., macOS version xyz) and required skills (e.g., knowledge to run the command-line interface) to install and run your application(s) here.

</details>

### Installation

1. Clone this repository.
2. Open Xcode and select `Open Existing Project`.
3. Select this project's [LaunchLab.xcodeproj](Launchlab.xcodeproj).

<details>
<summary>To-Dos</summary>

- [x] Add a list of all necessary steps to install your application, e.g., how to install required libraries like Flutter.
  If a library's installation process is very complex and might change significantly within the upcoming months, you can add a link to the library's official installation manual.
- [x] Test the correctness and completeness of the installation steps on a clean machine, e.g., on a computer in the Informatikum's computer pool.
  You should also ask fellow students not participating in M-Lab for problems in understanding and executing the steps.
  __Consider this as the most critical section of your README. We do not accept "But it runs on my machine" excuses.__
- [x] If you provide multiple software components with this repository, e.g., a frontend and a backend application, consider adding a minimal and a full version of your installation description here.
  The minimal version describes how to run all components on a local computer; the full version describes (roughly) how to deploy your components, e.g., when a backend should run on a server.
- [x] Consider using virtualization tools, like [Docker](https://www.docker.com) or [Kubernetes](https://kubernetes.io), to minimize the installation effort for your users.

</details>

### How To Run

1. [Real Device] In `LaunchLab > Signing & Capabilities`
  - change the `Team` to AppleID-linked personal team.
  - change the `Bundle Identifier` to something unique (`de.<your-name>.launchlab` should work).
2. Select an appropriate simulator or physical device to run the app on.
3. Select `Product > Run` in the menu bar.

<details>
<summary>To-Dos</summary>

- [x] Add a list of all necessary steps to run your application after completing the installation.

</details>

### Demo

__IMPORTANT__: _The demo is intended as a proof of concept, not a complete working app. While the transitions and flow of the app are there, not all features reflect the app's final level of detail._

Our dynamic prototype is available in [Figma](https://www.figma.com/proto/MECpKOYJoJrZaTg00w5DQ9/Hanna?page-id=0%3A1&node-id=105-1623&p=f&viewport=547%2C592%2C0.04&t=uieIVfoOzrLT9jbn-1&scaling=scale-down&content-scaling=fixed&starting-point-node-id=105%3A1623).
<details>
<summary>To-Dos</summary>

This section is optional. You can remove it if you cannot provide a demo of your application.

- [x] If you use a prototyping tool like Figma for your clickdummy, we recommend adding a public link to your clickdummy demo here.
- [x] Please indicate if the demo has limitations and until when it will be available.

</details>

## Project Team

| <img src="media/team/hanna.jpg" width=50 /> | <img src="media/team/henrik.jpg" width=50 /> | <img src="media/team/jai.jpg" width=50 /> | <img src="media/team/eric.jpg" width=50 /> | <img src="media/team/maxi.jpg" width=50 /> | <img src="media/team/leo.jpg" width=50 /> |
| :---: | :---: | :---: | :---: | :---: | :---: |
| Hanna Lagerbauer | Henrik Marcussen | Jai Kamboj | Eric Liebrecht | Maximilian Stabe | Leopold Lemmermann |
| __Design__ | __AI__ | __Content__ | __Comms.__ | __iOS__ | __Lead__ |

<details>
<summary>To-Dos</summary>

- [x] Minimal: List the names of all team members.
- [x] Optional: Add further information, e.g., a photo of yourself or a link to your personal website.

</details>
