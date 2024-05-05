[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2FGDSC-DGU%2F2024-SolutionChallenge-earlips-frontend&count_bg=%238B8B8B&title_bg=%231FA9DC&icon=wechat.svg&icon_color=%23E7E7E7&title=Connecting+your+ears+to+your+lips%2C+Earlips&edge_flat=false)](https://hits.seeyoufarm.com)

 <div><img src="https://capsule-render.vercel.app/api?type=waving&height=200&color=0:1FA9DC,100:D5E9AA&text=Earlips&descAlignY=100&descAlign=62&textBg=false&fontColor=FFFFFF&fontSize=70&animation=fadeIn&rotate=0&strokeWidth=0&descSize=20" /></div>



# 👋 introduce team member

## [Front-End](/frontend/naemansan/README.md)

| name                                        |major        |GDSC  | Email                |
| -------------------------------------------- | -------------- | ------ | -------------------- |
| [서희찬](https://github.com/seochan99)       | Computer Science | LEAD | gmlcks0513@dgu.ac.kr |
| [황현정](https://github.com/bunju20) | Computer Science     | General | ghkd4009@gmail.com |


---

# 🛠️ Tech

## Frameworks
![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![FastAPI](https://img.shields.io/badge/FastAPI-009688?style=for-the-badge&logo=fastapi&logoColor=white)

## Server
![Google Cloud](https://img.shields.io/badge/Google%20Cloud-4285F4?style=for-the-badge&logo=google-cloud&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)

## Stack

![http](https://img.shields.io/badge/http-0.13.6-red?style=for-the-badge)
![uuid](https://img.shields.io/badge/uuid-3.0.7-blue?style=for-the-badge)

![PyMySQL](https://img.shields.io/badge/PyMySQL-1.0.3-374da9?style=for-the-badge)
![Scikit-learn](https://img.shields.io/badge/Scikit--learn-1.2.1-orange?style=for-the-badge)

---

## Flutter Project Build Instructions
```
flutter pub get
flutter run

## If you encounter any issues in iOS build, follow these steps to clean your build cache for iOS
cd ios
rm Podfile.lock
rm Podfile
rm -rf Pods
pod cache clean --all
cd ..
flutter clean
flutter pub get
cd ios
pod install
flutter pub get
flutter run

## If you encounter any issues in Android build, follow these steps to clean your build cache for Android 
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter run
```
## Project Introduction
<img width="100%" alt="image" src="https://github.com/GDSC-DGU/2024-SolutionChallenge-earlips-frontend/assets/85238126/1db0ed9d-2afc-4f17-aa1e-51e0b03f278a">

## Architecture
<img width="100%" alt="image" src="https://github.com/GDSC-DGU/2024-SolutionChallenge-earlips-frontend/assets/85238126/20616201-352f-4983-8266-4f2298200275">

### 💻 demonstration video
[![예제](https://github.com/GDSC-DGU/2024-SolutionChallenge-earlips-frontend/assets/85238126/1db0ed9d-2afc-4f17-aa1e-51e0b03f278a)](https://youtu.be/DLwqB820kL8) 
https://youtu.be/DLwqB820kL8



### ✨ Screen

| Home Screen | Learning Screen | Phoneme Screen | Word Screen |
|-------------|-----------------|----------------|-------------|
| ![Home Screen](https://github.com/GDSC-DGU/2024-SolutionChallenge-earlips-frontend/assets/85238126/2cd6880c-c41e-40cf-9083-3123bbe650e6) | ![학습페이지](https://github.com/GDSC-DGU/2024-SolutionChallenge-earlips-frontend/assets/85238126/751e16d6-2652-4fad-94d7-96b732635370) | ![발음기호](https://github.com/GDSC-DGU/2024-SolutionChallenge-earlips-frontend/assets/85238126/bbd023dc-556c-4a8d-b965-ac1ce5c6e174) | ![단어학습하기](https://github.com/GDSC-DGU/2024-SolutionChallenge-earlips-frontend/assets/85238126/a3c3a348-2b66-4927-abb0-06132f2a4015) |

**Home Screen** : Pronunciation score and daily learning graphs   
**Learning Screen**: Learning logs by date   
**Phoneme Screen** : Visuals and guides for phoneme articulation   
**Word Screen** : Features *sound-to-vibration buttons* , GIFs for pronunciation practice, interactive phoneme guides with Google's Gemini, detailed phoneme explanations, and *voice recording with result review*

| Sentance Screen(fix) | Paragraph Screen | Script Screen | live Screen(fix) |
|-------------|-----------------|----------------|-------------|
| ![문장학습](https://github.com/bunju20/2024-SolutionChallenge-earlips-frontend/assets/85238126/2c4b86d8-7e27-48d9-9f56-86e5c3e1ea51) |![문단학습하기](https://github.com/bunju20/2024-SolutionChallenge-earlips-frontend/assets/85238126/9ddaf06b-a493-45d5-83f7-655770ab6db4) | ![대본만들고결과값](https://github.com/bunju20/2024-SolutionChallenge-earlips-frontend/assets/85238126/1b1d506e-4b53-4c53-bce9-1eaab7a5dc10) | ![라이브](https://github.com/bunju20/2024-SolutionChallenge-earlips-frontend/assets/85238126/d8b06861-7395-4c2d-8f7d-58fe6ccd8847) |

**Sentence Screen**: Same layout as the Word Screen.   
**Paragraph Screen**: Allows users to record their voice for a given script and receive feedback.   
**Script Screen**: Users can write their own scripts and record their voice for feedback.   
**Live Screen**: Displays the user's pronunciation in real time.   

---

## 🎯 Commit Convention

- feat: Add a new feature
- fix: Bug fix
- docs: Documentation updates
- style: Code formatting, missing semicolons, cases where no code change is involved
- refactor: Code refactoring
- test: Test code, adding refactoring tests
-hore: Build task updates, package manager updates

## 💡 PR Convetion

| 아이콘 | 코드                       | 설명                     |
| ------ | -------------------------- | ------------------------ |
| 🎨     | :art                       | Improving structure/format of the code   |
| ⚡️    | :zap                       | Performance improvement               |
| 🔥     | :fire                      | 	Code/file deletion          |
| 🐛     | :bug                       | Bug fix             |
| 🚑     | :ambulance                 | Critical fix|
| ✨     | :sparkles                  | New features               |
| 💄     | :lipstick                  | Adding/updating UI/style files |
| ⏪     | :rewind                    | Reverting changes     |
| 🔀     | :twisted_rightwards_arrows | Branch merging            |
| 💡     | :bulb                      | Adding/updating comments         |
| 🗃      | :card_file_box             | Database-related modifications   |

## Lisence
