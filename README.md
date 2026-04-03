# SearchingImageMVVM

Unsplash API를 활용한 이미지 검색 앱입니다. Pinterest 스타일의 그리드 레이아웃으로 이미지를 표시하며, 무한 스크롤을 지원합니다.

## 기술 스택

- **UI**: SwiftUI (AsyncImage, LazyVGrid, NavigationStack)
- **Architecture**: MVVM + ObservableObject
- **Networking**: URLSession + async/await + Codable
- **iOS 16.0+**, 외부 의존성 없음

## Before → After

| Before (2020) | After |
|---|---|
| UIKit + Storyboard + IBOutlet | SwiftUI |
| RxSwift / RxCocoa / RxDataSources | async/await + @Published |
| Alamofire | URLSession (native) |
| SwiftyJSON | Codable (native) |
| SDWebImage | AsyncImage (native) |
| CocoaPods (6개 의존성) | 외부 의존성 0개 |
| iOS 10.0 | iOS 16.0 |

## 프로젝트 구조

```
SearchingImageMVVM/
├── App/
│   ├── SearchingImageApp.swift    # SwiftUI App 진입점
│   ├── Info.plist
│   ├── Assets.xcassets/
│   └── Base.lproj/LaunchScreen.storyboard
├── Model/
│   └── ImageInfo.swift            # UnsplashPhoto (Codable)
├── Networking/
│   ├── APIClient.swift            # async/await URLSession
│   └── Constants.swift            # API 설정
├── ViewModel/
│   └── SearchViewModel.swift      # @MainActor ObservableObject
└── View/
    ├── ImageGridView.swift        # 메인 그리드 화면
    ├── ImageCardView.swift        # 개별 이미지 카드
    └── PinterestLayout.swift      # Pinterest 스타일 그리드
```

## 스크린샷

<img width="361" alt="screenshot1" src="https://user-images.githubusercontent.com/5820255/92993249-fc630200-f52a-11ea-97eb-0bf691eec0cb.png">
<img width="361" alt="screenshot2" src="https://user-images.githubusercontent.com/5820255/92993243-f79e4e00-f52a-11ea-844f-59154a675a96.png">
