# SearchingImageMVVM

Unsplash API를 활용한 이미지 검색 앱입니다. Pinterest 스타일의 그리드 레이아웃으로 이미지를 표시하며, 무한 스크롤을 지원합니다.

**SwiftUI**와 **UIKit** 두 가지 UI 구현을 포함하고 있습니다.

## 기술 스택

- **SwiftUI**: AsyncImage, PinterestGrid, NavigationStack, @StateObject
- **UIKit**: Programmatic UI, DiffableDataSource, Combine, PinterestLayout
- **Architecture**: MVVM
- **Networking**: URLSession + async/await + Codable
- **iOS 16.0+**, 외부 의존성 없음

## 실행 방법

Xcode에서 Scheme을 선택하여 각 버전을 실행할 수 있습니다:

- **SearchingImageSwiftUI** - SwiftUI 버전
- **SearchingImageUIKit** - UIKit 버전

## Before → After

| Before (2020) | After |
|---|---|
| UIKit + Storyboard + IBOutlet | SwiftUI + UIKit (Programmatic) |
| RxSwift / RxCocoa / RxDataSources | async/await + @Published + Combine |
| Alamofire | URLSession (native) |
| SwiftyJSON | Codable (native) |
| SDWebImage | AsyncImage / URLSession (native) |
| CocoaPods (6개 의존성) | 외부 의존성 0개 |
| iOS 10.0 | iOS 16.0 |

## 프로젝트 구조

```
SearchingImageMVVM/
├── App/
│   ├── SearchingImageApp.swift          # @main (SwiftUI/UIKit 전환)
│   ├── Info.plist
│   ├── Assets.xcassets/
│   └── Base.lproj/LaunchScreen.storyboard
├── Model/
│   └── ImageInfo.swift                  # UnsplashPhoto (Codable, Hashable)
├── Networking/
│   ├── APIClient.swift                  # async/await URLSession
│   └── Constants.swift
├── ViewModel/
│   ├── SearchViewModel.swift            # SwiftUI용 (@MainActor ObservableObject)
│   └── SearchViewModelUIKit.swift       # UIKit용 (Combine @Published)
└── View/
    ├── ImageGridView.swift              # [SwiftUI] 메인 그리드
    ├── ImageCardView.swift              # [SwiftUI] AsyncImage 카드
    ├── PinterestLayout.swift            # [SwiftUI] Pinterest 그리드
    └── UIKit/
        ├── SearchViewController.swift   # [UIKit] DiffableDataSource + Combine
        ├── ImageCell.swift              # [UIKit] Programmatic 셀
        └── PinterestCollectionViewLayout.swift  # [UIKit] 커스텀 레이아웃
```

## 스크린샷

<img width="361" alt="screenshot1" src="https://user-images.githubusercontent.com/5820255/92993249-fc630200-f52a-11ea-97eb-0bf691eec0cb.png">
<img width="361" alt="screenshot2" src="https://user-images.githubusercontent.com/5820255/92993243-f79e4e00-f52a-11ea-844f-59154a675a96.png">
