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


<br>


## iOS Developer 🥕

| **신서연** | **정교은** | **이서영** |
| :---: | :---: | :---: |
| <img width="200" height="200" alt="image" src="https://github.com/user-attachments/assets/6129a005-d16d-4698-9a1b-30080aed9aaa" /> | <img width="200" height="200" alt="image" src="https://github.com/user-attachments/assets/47d228e8-8722-4d26-a6fe-d4c6a8177067" /> | <img width="200" height="200" alt="image" src="https://github.com/user-attachments/assets/c4edb1b3-c34c-4e52-b5c0-94087178e85c" /> |
| `Map View` | `Detail View` | `List View` |



### 상세 구현 내용

<details>
<summary><b>신서연</b></summary>

<br>

- 지도 위에 5개의 매물 칩(`MapProductChipView`) 배치
  - 칩 탭 시 선택 상태 칩(`SelectedMapProductChipView`)으로 전환
  - 하단에 플로팅 카드(`MapProductFloatingView`) 애니메이션으로 등장
  - 플로팅 카드 등장 시 목록보기 버튼 · 현재위치 버튼도 함께 위로 이동 (SnapKit constraint 업데이트 + 애니메이션)
- 지도 빈 영역 탭 → 칩 선택 해제 + 플로팅 카드 사라짐
- 상단 헤더 필터 버튼 탭 → 필터 바텀시트 진입 (List와 동일한 `FilterBottomSheetViewController` 공유)
- 목록보기 버튼 탭 → `CATransition` (.fromLeft) 으로 List 화면으로 전환
- 실제 매물 데이터는 API로 fetch하여 플로팅 카드에 반영

</details>

<details>
<summary><b>정교은</b></summary>

<br>

- `UICollectionView` (CompositionalLayout) 기반으로 섹션 구성
  - 이미지 캐러셀 / 판매자 프로필 / 상품 정보 / 상품 설명 / 거래 장소 / 추천 상품
- 이미지 캐러셀 가로 페이징 + `ImageIndicatorView`로 현재 인덱스 표시
- 스크롤 시 헤더 스타일 전환: 이미지 하단에 헤더가 닿는 시점에 배경·아이콘 색상 변경 + StatusBar 스타일도 함께 전환
- 추천 상품 가로 스크롤
- 하단 바 찜 버튼 활성/비활성 토글
- 채팅하기 버튼 탭 → 간편문의 바텀시트 등장
  - 5개 옵션 라디오 버튼 (첫 번째 옵션 디폴트 선택)
  - 핸들바 아래로 80px 이상 드래그 or dimmed 영역 탭 → 바텀시트 닫힘
  - "직접 입력" 선택 시 텍스트필드 노출, 전송하기 버튼 비활성화 → 텍스트 입력 시 활성화
  - 전송하기 탭 → 바텀시트 닫힘 + 하단에서 토스트 슬라이드 업 → 2.5초 후 자동 dismiss

</details>

<details>
<summary><b>이서영</b></summary>

<br>

**List View**
- 헤더 필터 칩 다중선택 → API 필터 파라미터(거래조건 · 거래방식 · 가격정보)로 매물 목록 재조회
- 빈 결과 시 `EmptyView` 노출 + 초기화 버튼으로 필터 리셋
- 필터 버튼 탭 → `FilterBottomSheetViewController` 진입
  - 화면 높이의 80%로 펼쳐짐 → 핸들바 위로 드래그 시 전체 확장
  - 거래조건 · 거래방식 · 가격정보 칩 토글, 가격 범위 텍스트필드, 초기화 · 적용 버튼
- 매물이 2개 이상일 경우 3번째 row에 지도 배너 자동 삽입
- 지도 배너 · 지도보기 버튼 탭 → `CATransition` (.fromRight) 으로 Map 화면으로 전환
- 리스트 셀 탭 → `productId` 전달하여 Detail 화면으로 진입

**공통 컴포넌트 (`Global/Components`)**
- `CategoryTabBar` — 가로 스크롤 카테고리 탭 바. 선택된 탭 하단에 인디케이터 표시
- `ChipButton` — 탭 시 선택/해제 상태가 토글되는 버튼. `onToggle` 클로저로 상태 변화 전달
- `FilterChip` — `ChipButton`을 가로 스크롤로 나열하는 다중선택 칩 컨테이너. 선택된 항목 목록을 `onSelectionChanged`로 전달
- `FilterSortBar` — "판매중만 보기" · "동네매물만 보기" 체크박스 + 정렬 드롭다운으로 구성된 서브 필터 바
- `FullHeader` — List 화면 헤더. `SearchBarHeader` + `CategoryTabBar` + `FilterChip` + `FilterSortBar` 조합
- `SearchBarHeader` — 뒤로가기 버튼 + 검색창 + 필터 버튼으로 구성된 헤더. 필터 버튼 탭 시 delegate로 바텀시트 진입
- `SimpleHeader` — Map 화면 헤더. `SearchBarHeader` + `FilterChip`만 조합한 경량 버전
- `ViewToggleButton` — 지도보기 ↔ 목록보기 전환 버튼. 아이콘 + 텍스트 pill 형태

</details>

<br>



## 개발 환경

![iOS](https://img.shields.io/badge/iOS-26.4%2B-000000?style=for-the-badge&logo=apple&logoColor=white)
![Swift](https://img.shields.io/badge/Swift-6.3%2B-F05138?style=for-the-badge&logo=swift&logoColor=white)
![Xcode](https://img.shields.io/badge/Xcode-26.4.1%2B-147EFB?style=for-the-badge&logo=xcode&logoColor=white)

<br>

## Architecture

<img src="https://img.shields.io/badge/MVC-000000?style=for-the-badge&logo=swift&logoColor=white">

각 Feature는 `Controller / View / Model` 레이어로 구성되며, `Global`에 공용 컴포넌트와 Extension을 분리해 관리합니다.

<br>

## Library & Stack

<img src="https://img.shields.io/badge/uikit-2396F3?style=for-the-badge&logo=uikit&logoColor=white"> <img src="https://img.shields.io/badge/snapkit-FFFC00?style=for-the-badge&logo=snapchat&logoColor=white"> <img src="https://img.shields.io/badge/Then-000000?style=for-the-badge&logo=swift&logoColor=white"> <img src="https://img.shields.io/badge/Kingfisher-F05138?style=for-the-badge&logo=swift&logoColor=white">

<img src="https://img.shields.io/badge/git-F05032?style=for-the-badge&logo=git&logoColor=white"> <img src="https://img.shields.io/badge/github-181717?style=for-the-badge&logo=github&logoColor=white"> <img src="https://img.shields.io/badge/notion-000000?style=for-the-badge&logo=notion&logoColor=white"> <img src="https://img.shields.io/badge/figma-F24E1E?style=for-the-badge&logo=figma&logoColor=white"> <img src="https://img.shields.io/badge/discord-5865F2?style=for-the-badge&logo=discord&logoColor=white">



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
│   ├── 📁 Components/
│   └── 📁 Extension/
├── 📁 Network/
│   ├── 📁 Base/
│   ├── 📁 DTO/
│   └── 📁 Service/
├── 📁 Resources/
│   ├── 📃 Assets.xcassets
│   └── 📁 Fonts
└── 📁 Features/
    ├── 📁 List/
    │   ├── 📁 Controller/
    │   ├── 📁 Model/
    │   └── 📁 View/
    ├── 📁 Map/
    │   ├── 📁 Controller/
    │   ├── 📁 Model/
    │   └── 📁 View/
    └── 📁 Detail/
        ├── 📁 Controller/
        └── 📁 View/
```
