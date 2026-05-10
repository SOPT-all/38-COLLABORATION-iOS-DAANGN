# 38-COLLABORATION-iOS-DAANGN
>LETS SOPT 38기 합동세미나 iOS 앱 3조 

## iOS Developer
| **신서연** | **정교은** | **이서영** |
| :---: | :---: | :---: |
|<img width="200" height="200" alt="image" src="https://github.com/user-attachments/assets/4cc75e46-1efd-4eb0-928b-2236d28b7e83" />|<img width="200" height="200" alt="image" src="https://github.com/user-attachments/assets/e7dfd23c-1a76-47fb-a190-1f0a2cbc634e" />|<img width="200" height="200" alt="image" src="https://github.com/user-attachments/assets/dd7ecd7e-e13b-4798-9cbd-aa02555d083e" />

## 시연 영상


## 개발 환경
![iOS](https://img.shields.io/badge/iOS-26.4%2B-000000?style=for-the-badge&logo=apple&logoColor=white)
![Swift](https://img.shields.io/badge/Swift-6.3%2B-F05138?style=for-the-badge&logo=swift&logoColor=white)
![Xcode](https://img.shields.io/badge/Xcode-26.4.1%2B-147EFB?style=for-the-badge&logo=xcode&logoColor=white)


## Library & Stack
<img src="https://img.shields.io/badge/swift-F05138?style=for-the-badge&logo=swift&logoColor=white"> <img src="https://img.shields.io/badge/uikit-2396F3?style=for-the-badge&logo=uikit&logoColor=white">
<img src="https://img.shields.io/badge/snapkit-FFFC00?style=for-the-badge&logo=snapchat&logoColor=white"></br></br>
<img src="https://img.shields.io/badge/git-F05032?style=for-the-badge&logo=git&logoColor=white"> <img src="https://img.shields.io/badge/github-181717?style=for-the-badge&logo=github&logoColor=white"> <img src="https://img.shields.io/badge/notion-000000?style=for-the-badge&logo=notion&logoColor=white"> <img src="https://img.shields.io/badge/figma-F24E1E?style=for-the-badge&logo=figma&logoColor=white"> <img src="https://img.shields.io/badge/discord-5865F2?style=for-the-badge&logo=discord&logoColor=white"> 
</br>


## Git Flow

- develop 브랜치는 생성하지 않고 이슈 번호에 맞는 브랜치를 만들어서 작업한 후, main 브랜치로 PR 후 머지합니다.
- PR 작성자 이외의 다른 팀원들이 코드 리뷰를 진행하고, 문제가 없을 경우에 approve 합니다.
- 충돌이 생기게 되는 경우 리드 및 팀원에게 공유합니다.
- 모든 작업 전에는 pull을 받습니다.


## Convention

### Branch
타입/#이슈번호-구현할 기능

`feat/#2-loginVC`

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
3. 제목제목은 50자 이내로, 간결하게 명령조로 작성합니다. 상세 설명이 필요한 경우 description에 작성합니다.
`타입: 커밋 내용`

`feat: 로그인 기능 구현`


## Foldering
```
38-COLLABORATION-iOS-DAANGN/
├── App/
│   ├── AppDelegate.swift
│   └── SceneDelegate.swift
├── Global/
│   ├── Extension/
│   └── Literals/
├── Network/
│   └── API/
├── Resources/
│   └── Assets.xcassets
└── Features/
    ├── List/
    │   ├── OOOViewController.swift
    │   ├── OOOView.swift
    │   └── OOOViewModel.swift
    ├── Map/
    |   ├── OOOViewController.swift
    |   ├── OOOView.swift
    |   └── OOOViewModel.swift
    └── Detail/
        ├── OOOViewController.swift
        ├── OOOView.swift
        └── OOOViewModel.swift
```
