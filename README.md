## CSHelper
![image](https://github.com/dudwnssss/SSU_CSHelper/assets/76581866/6cbf5b27-0875-4973-9d8d-e1b75d20b50e)


## Topic
- **[CSHelper - FAQ 기반 고객응대 반자동화 서비스]**
- **팀 구성** : 딥러닝 3명, 서버 1명, iOS 1명
- **맡은 역할** :  iOS 개발
- **개발 기간** : 2023.08 ~ 2022.09 (3주)

## Main Functions
1. 로컬 회원가입, 로그인
2. 상담자 등록
3. 상담 내역 조회
4. 챗봇 형태의 상담
5. 상담 메모

## Tech
- **Language** : Swift
- **Architecture** : MVVM 
- **Reactive** : Custom Observable
- **UI** : CodeBase, Snapkit, Custom View
- **etc** : Diffable DataSource, Compositional Layout

## Experience
-  **Moya를 적용한 네트워크 통신 모듈화**: <br>
    개발기간과, 서버 API를 고려하여 Alamofire를 추상화한 프레임워크인 Moya를 사용. endpoint를 열거형으로 관리하여 확장성 및 재사용성을 높이고 API 추가, 수정에 따른 개발 시간 단축
    
- **채팅 UI 및**, **챗봇 기능 구현**: <br>
컬렉션뷰를 multipleCell로 구성하고, 셀 타입에 따라 UI를 별도로 처리.  ****딥러닝 모델에서 문의를 분석하는 동안 로딩 화면을 표시하여 사용자 경험 향상<br>
KeyboardLayoutGuide, ScrollView의 확장함수를 활용하여 키보드 유무, 채팅 추가, 삭제에 따른 UI 업데이트에 대응, 사용자들에게 익숙한 채팅 경험 제공.

- **Modern CollectionView를 활용한 MultiSection 컬렉션뷰 구현**: <br>
 Compositional Layout을 사용하여 유저와 상호작용 유무에 따라 레이아웃을 별도로 구현. ListConfiguration을 사용하여, SwipeAction으로 삭제기능 구현
- **Custom Observable을 사용 및 MVVM 아키텍쳐 적용**: <br>
Reactive Programming을 이해하고자, 라이브러리에 의존하지 않고 Custom Observerble을 구현하여 비동기 이벤트를 처리, View, ViewController, ViewModel을 분리하여 코드의 확장성과 재사용성 향상

