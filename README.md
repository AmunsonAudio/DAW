CoLabs
CoLabs is an easy to use application for streaming high-quality, low-latency peer-to-peer audio between devices over the internet or a local network.
Simply choose a unique session name (with optional password), and instantly connect multiple people together to make music, remote sessions, podcasts, etc. Easily record the audio from everyone, as well as playback any audio content to the whole group.
Connects multiple users together to send and receive audio among all in a group, with fine-grained control over latency, quality and overall mix. Includes optional input compression, noise gate, and EQ effects, along with a master reverb. All settings are dynamic, network statistics are clearly visible.
Works as a standalone application on macOS, Windows, iOS, and Linux, and as an audio plugin (AU, VST) on macOS and Windows. Use it on your desktop or in your DAW, or on your mobile device.
Easy to setup and use, yet still provides all the details that audio nerds want to see. Audio quality can be instantly adjusted from full uncompressed PCM (16, 24, or 32 bit) or with various compressed bitrates (16-256 kbps per channel) using the low-latency Opus codec, and you can do this independently for any of the users you are connected with in a group.



IMPORTANT TIPS
CoLabs does not use any echo cancellation, or automatic noise reduction in order to maintain the highest audio quality. As a result, if you have a live microphone signal you will need to also use headphones to prevent echos and/or feedback.
For best results, and to achieve the lowest latencies, connect your computer with wired ethernet to your router if you can. Although it will work with WiFi, the added network jitter and packet loss will require you to use a bigger safety buffer to maintain a quality audio signal, which results in higher latencies.
CoLabs does NOT currently use any encryption for the data communication, so while it is unlikely that it will be intercepted, please keep that in mind. All audio is sent directly between users peer-to-peer, the connection server is only used so that the users in a group can find each other.
Installing
Windows and Mac
There are binary releases for macOS and Windows available at sonobus.net or in the releases of this repository on GitHub.
Linux
Building
The original GitHub repository for this project is at github.com/AmunsonAudio/DAW
To build from source on macOS and Windows, all of the dependencies are a part of this GIT repository, including prebuilt Opus libraries. The build now uses CMake 3.15 or above on macOS, Windows, and Linux platforms, see details below.
On macOS
Make sure you have CMake >= 3.15 and XCode. Then run:
./setupcmake.sh
./buildcmake.sh

The resulting application and plugins will end up under build/CoLabs_artefacts/Release when the build completes. If you would rather have an Xcode project to look at, use ./setupcmakexcode.sh instead and use the Xcode project that gets produced at buildXcode/CoLabs.xcodeproj.
On Windows
You will need CMake >= 3.15, and Visual Studio 2017 installed. You'll also need Cygwin installed if you want to use the scripts below, but you can also use CMake in other ways if you prefer.
./setupcmakewin.sh
./buildcmake.sh

The resulting application and plugins will end up under build/CoLabs_artefacts/Release when the build completes. The MSVC project/solution can be found in build/CoLabs_artefacts as well after the cmake setup step.


On Linux
The first thing to do in a terminal is go to the Linux directory:
cd linux

And read the BUILDING.md file for further instructions.
License and 3rd Party Software
CoLabs is derived from an open source code, and it is licensed under the GPLv3, the full license text is in the LICENSE file. Some of the dependencies have their own more permissive licenses.
It is built using JUCE 6 (slightly modified on a public fork), and AOO (Audio over OSC), which also uses the Opus codec. I'm using the very handy tool git-subrepo to include the source code for my forks of those software libraries in this repository.
https://github.com/AmunsonAudio/AmunsonAudioServer
The standalone CoLabs application also provides a connection server internally, which you can connect to on port 10999, or port forward TCP/UDP 10999 from your internet router to the machine you are running it on.
