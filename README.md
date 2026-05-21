# 38-COLLABORATION-iOS-DAANGN
>LETS SOPT 38기 합동세미나 iOS 앱 3조 **당근** 🥕
>

<br>

<img width="100%" alt="당근_1차 과제-1" src="https://github.com/user-attachments/assets/777932f1-fe17-4916-99c7-2fd90d4e6ea4" />
<img width="100%" alt="당근_1차 과제-3" src="https://github.com/user-attachments/assets/47e97d8c-f2df-42a7-9d25-3205a477b2f2" />

<br>

## Redesign Points

<img width="100%" alt="개발파트_공유-1" src="https://github.com/user-attachments/assets/f1ec694c-396a-40c9-a588-77b5d7e6f861" />
<img width="100%" alt="개발파트_공유-2" src="https://github.com/user-attachments/assets/79b53f5d-c490-488f-bdbb-f991ab8f17bf" />

#### ✔︎ Point 1 · 카테고리 Tab 구조로 개편
반복적으로 사용되던 Chip을 정리하고, 카테고리를 Tab 구조로 격상했어요.

#### ✔︎ Point 2 · 거래 조건 Chip 상단 노출
거래 결정에 영향을 주는 조건과 상태 정보는 Chip 라벨로 선별해 상단에 노출했어요.

#### ✔︎ Point 3 · 지도 기반의 매물 탐색
매물의 실제 위치를 지도에서 한눈에 확인할 수 있어요.  
리스트에서 지도로 자연스럽게 진입하고, 바텀시트 위로 완전히 스크롤시 이전 리스트 화면으로 복귀해요.

#### ✔︎ Point 4 · 간편문의 바텀시트
채팅 전에 거래 조건을 선택지로 빠르게 전달할 수 있어요.  
탐색 흐름을 끊지 않고 문의까지 이어지는 UX를 제안했어요.

<div align="center">

<br>


## iOS Developer 🥕

| **신서연** | **정교은** | **이서영** |
| :---: | :---: | :---: |
| <img width="200" height="200" alt="image" src="https://github.com/user-attachments/assets/6129a005-d16d-4698-9a1b-30080aed9aaa" /> | <img width="200" height="200" alt="image" src="https://github.com/user-attachments/assets/47d228e8-8722-4d26-a6fe-d4c6a8177067" /> | <img width="200" height="200" alt="image" src="https://github.com/user-attachments/assets/c4edb1b3-c34c-4e52-b5c0-94087178e85c" /> |

</div>

<br>

<div align="center">

## 개발 환경

![iOS](https://img.shields.io/badge/iOS-26.4%2B-000000?style=for-the-badge&logo=apple&logoColor=white)
![Swift](https://img.shields.io/badge/Swift-6.3%2B-F05138?style=for-the-badge&logo=swift&logoColor=white)
![Xcode](https://img.shields.io/badge/Xcode-26.4.1%2B-147EFB?style=for-the-badge&logo=xcode&logoColor=white)

<br>

## Library & Stack

<img src="https://img.shields.io/badge/uikit-2396F3?style=for-the-badge&logo=uikit&logoColor=white">
<img src="https://img.shields.io/badge/snapkit-FFFC00?style=for-the-badge&logo=snapchat&logoColor=white">
<img src="https://img.shields.io/badge/Then-000000?style=for-the-badge&logo=swift&logoColor=white">

<br>

<img src="https://img.shields.io/badge/git-F05032?style=for-the-badge&logo=git&logoColor=white">
<img src="https://img.shields.io/badge/github-181717?style=for-the-badge&logo=github&logoColor=white">
<img src="https://img.shields.io/badge/notion-000000?style=for-the-badge&logo=notion&logoColor=white">
<img src="https://img.shields.io/badge/figma-F24E1E?style=for-the-badge&logo=figma&logoColor=white">
<img src="https://img.shields.io/badge/discord-5865F2?style=for-the-badge&logo=discord&logoColor=white">

</div>

<br>

## Git Flow

- develop 브랜치는 생성하지 않고 이슈 번호에 맞는 브랜치를 만들어서 작업한 후, main 브랜치로 PR 후 머지합니다.
- PR 작성자 이외의 다른 팀원들이 코드 리뷰를 진행하고, 문제가 없을 경우에 approve 합니다.
- 충돌이 생기게 되는 경우 리드 및 팀원에게 공유합니다.
- 모든 작업 전에는 pull을 받습니다.

<br>

## Convention

### Branch
타입/#이슈번호-구현할 기능 

`사용예시: feat/#2-loginVC`

### Tag
| 태그 | 사용 |
|-----------|------|
| feat | 새로운 기능 구현 시 사용 |
| design | UI 디자인 변경 시 사용 |
| docs | README, 템플릿 등 프로젝트 내 문서 수정 시 사용 |
| fix | 버그나 오류 해결 시 사용 |
| refactor | 코드 리팩토링 시 사용 |
| hotfix | 급하게 치명적인 버그 수정 시 사용 |
| chore | 중요도가 낮은 기타 변경 작업 시 사용 |

### Commit Message
1. 태그는 반드시 **소문자**로 작성합니다.
2. 내용은 **한글**로 작성합니다.
3. 제목은 50자 이내로, 간결하게 명령조로 작성합니다. 상세 설명이 필요한 경우 description에 작성합니다. `타입: 커밋 내용`

<br>

## Foldering
```
38-COLLABORATION-iOS-DAANGN/
├── 📁 App/
│   ├── 📃 AppDelegate.swift
│   └── 📃 SceneDelegate.swift
├── 📁 Global/
│   ├── 📁 Extension/
├── 📁 Network/
│   └── 📁 DTO/
│   └── 📁 Service/
├── 📁 Resources/
│   └── 📃 Assets.xcassets
│   └── 📁 Fonts
└── 📁 Features/
    ├── 📁 List/
    ├── 📁 Map/
    └── 📁 Detail/
└── 📃 Info.plist
```
