# SHINVIA

**스트레스 DSR 기반 자산관리 플랫폼**

SHINVIA는 금융 프로필과 대출·정책금융 정보, 생애 계획을 한 흐름으로 살펴보는 웹 애플리케이션입니다. 현재 재무상태를 바탕으로 DSR과 대출 부담을 계산하고, 사용자 조건에 맞는 금융지원상품을 탐색하며, 미래 이벤트가 재무상태에 미치는 영향을 시뮬레이션합니다.

> 이 저장소에는 애플리케이션 소스가 포함되어 있습니다. 실행 설정, DB 스키마, 외부 API 자격증명은 별도 관리 대상이므로 아래 준비 사항을 확인하세요.

## 주요 기능

### 금융 프로필과 계정 데이터

- 회원 가입, 로그인, 이메일 인증 및 계정 복구
- 금융 프로필 입력과 계정·카드 데이터 연동 흐름
- MyData 연동 및 개발용 mock client 지원 코드

### 대출 분석과 금융 계산

- DSR 및 스트레스 DSR 계산
- 대출 상환 시나리오 비교와 부채 상환 우선순위 분석
- 단계별 금리, 과거 금리, 시장 내재 금리, 손익분기 금리 시뮬레이션
- 개인 금융 스트레스 테스트와 대출 부담 분석

### 금융상품·정책 추천

- 정책대출, 자산형성상품, 사회연대금융, 복지서비스 안내
- 외부 상품 데이터의 수집·정규화·저장 흐름
- 사용자 프로필을 활용한 정책상품 조건 평가 및 추천
- 연령, 소득, 순자산, 신용, 지역, 고용, 복지 조건별 판정 근거 제공

### 금융 라이프 플랜과 미래 시뮬레이션

- 생애 이벤트를 배치해 시나리오별 재무 흐름 비교
- 결혼, 출산, 차량 구매, 월세 이동, 전세 이동, 주택 구입, 대출 상환 시뮬레이션
- 이벤트별 비용 산출, 순차 재무상태 반영, 실행 가능성 분석
- 목표·저축 레버 조합을 활용한 미래 자산 시뮬레이션
- 완료 시나리오 저장 및 리포트 조회

### 리포트

- 자산·부채, 금융 라이프 플랜, 여유자금 관련 요약 카드
- 리포트 구성 및 PDF 렌더링 기능

## 기술 스택

| 구분 | 기술 |
|---|---|
| Language | Java 17 |
| Application | Spring Boot 4.0, Spring MVC, Spring Security |
| View | Thymeleaf, HTML, CSS, JavaScript |
| Persistence | MyBatis, MySQL Connector/J |
| Integration | Spring REST Client, OAuth2 Client |
| Supporting services | Redis, Spring Mail |
| Testing | JUnit 5, Spring Boot Test, MyBatis Test |
| Build | Gradle Wrapper |

## 프로젝트 구조

```text
src/main/java/com/via/shinvia/
├── account, mydata       계정·마이데이터 연동
├── dsr, loananalysis     DSR 계산과 대출 분석
├── loan                  대출상품 및 금리 시뮬레이션
├── policy, welfare       정책금융·복지 데이터와 추천
├── lifecycle             생애 이벤트 설문·시뮬레이션
├── futuresim             목표·미래 재무 시뮬레이션
├── stresstest            개인 금융 스트레스 테스트
├── report                리포트와 PDF 렌더링
├── config                공통 설정·메뉴 구성
└── security, login, user 인증·회원 기능

src/main/resources/
├── templates/            Thymeleaf 화면과 화면 조각
├── static/               CSS, JavaScript, 이미지
└── mapper/               MyBatis SQL 매퍼

src/test/java/            단위·통합 테스트
docs/                     구현 설명과 데이터베이스 참고 문서
```

## 실행 준비

- JDK 17
- MySQL 인스턴스와 프로젝트에서 사용하는 스키마·기준 데이터
- Redis, 이메일, OAuth2 및 외부 금융 API를 사용하는 기능의 로컬 설정값
- Gradle Wrapper 실행 환경

### 설정 파일

애플리케이션 설정에는 DB 접속정보, 이메일·OAuth2 설정, 외부 API 키 등이 포함될 수 있습니다. 이 저장소의 `.gitignore`는 `application.properties`, `application-*.yml`, `*.yml`, `*.sql` 파일을 제외하므로, 필요한 로컬 설정과 DB 초기화 자료가 저장소에 모두 포함되어 있지는 않습니다.

팀에서 전달받은 환경별 설정과 DB 자료를 `src/main/resources/`의 Spring Boot 설정 위치에 준비하세요. 각 자격증명은 공유 저장소에 커밋하지 말고 환경변수나 로컬 전용 설정으로 관리해야 합니다. 설정을 받지 못했다면 프로젝트 담당자에게 실행용 프로필, 필수 환경변수 이름, DB 초기화 방법을 확인하세요.

외부 데이터 동기화의 애플리케이션 시작 시 실행 여부는 설정으로 제어됩니다. 로컬 DB와 API 자격증명이 준비되지 않은 상태에서는 동기화를 켜지 마세요.

### 실행

Windows PowerShell:

```powershell
./gradlew.bat bootRun
```

macOS / Linux:

```bash
./gradlew bootRun
```

기본 로컬 주소는 `http://localhost:8080`입니다. 실제 기동 여부와 사용 포트는 로컬 설정에 따라 달라질 수 있습니다.

### 테스트와 빌드

```powershell
# 테스트
./gradlew.bat test

# 실행 가능한 애플리케이션 패키지 생성
./gradlew.bat bootJar
```

macOS / Linux에서는 `./gradlew test`, `./gradlew bootJar`를 사용하세요. 통합 테스트 중 DB나 외부 서비스가 필요한 항목은 해당 테스트의 요구조건을 먼저 확인하세요.

## 참고 문서

- [구현 문서 목록](docs/)
- [라이프 플랜 시뮬레이션 결과 테이블 SQL](docs/lifecycle-scenario-result-schema.sql)
- [라이프 플랜 기준 데이터 입력 참고 문서](docs/lifecycle-reference-full-insert.md)

세부 구현 기록에는 단계별 금리, 과거 금리, 시장 내재 금리, 손익분기 금리 관련 문서가 있습니다.

## 주의 사항

- 상품 추천 결과는 입력 정보와 저장된 상품 데이터에 기반한 참고 정보이며, 금융기관의 실제 승인이나 최종 심사를 보장하지 않습니다.
- 추천 점수는 사용자 선호를 반영한 상품 정렬용 적합도이며 승인 확률이 아닙니다.
- 정책·금리·기준 데이터는 출처와 갱신 시점에 따라 달라질 수 있습니다.
- `.gitignore`에서 제외되는 설정·SQL 파일이 있으므로 신규 개발자는 저장소에 실제 포함된 파일만으로 DB까지 완전히 초기화할 수 있다고 가정하지 마세요.
