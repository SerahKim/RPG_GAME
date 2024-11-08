# console RPG Game

---

- 다트로 구현된 텍스트형 RPG 게임

### date

---

- 2024.11.04~2024.11.08
- 내일배움캠프 앱창업 3주차

### 프로그램 실행 방법

---

1. git repository 클론하기

'''
git clone https://github.com/SerahKim/RPG_GAME.git
'''

2. 게임 실행

'''
cd test
dart run rpg_game_test.dart
'''

### 프로젝트 구조

---

- bin/character.txt : 캐릭터 정보가 저장된 텍스트 파일
- bin/monsters.txt : 몬스터 정보가 저장된 텍스트 파일

- lib/loadData.dart : 캐릭터 및 몬스터 정보 불러오기, 결과 저장
- lib/rpgCharacter.dart : 캐릭터 이름 받아오기 및 캐릭터 동작 구현(공격, 방어, 상태보기)
- lib/rpgMonster.dart : 몬스터 동작 구현(공격, 상태보기)
- lib/rpgGame : 각 파일에서 만들어진 class를 호출하여 게임 로직 구현

### 기본 기능

---

- 캐릭터 생성
  - 게임 시작 시 사용자로부터 이름을 입력받음.
  - 이름은 한글 또는 영문 대소문자만 허용. (특수문자 및 숫자 불가)
- 몬스터 생성
  - 텍스트 파일에 저장된 몬스터의 정보를 랜덤으로 가져옴.
  - 한번 소환된 후 턴이 끝난 몬스터는 게임이 끝날 때까지 호출되지 않음.
- 캐릭터 동작
  - 공격
    - 몬스터 공격
    - 몬스터의 체력이 0이하가 되면 캐릭터의 승리
  - 방어
    - 사용자가 방어 태세에 돌입하면 몬스터 데이터 파일에 설정된 최대 공격력에 캐릭터의 방어력을 제외한 데미지를 받게됨.
    - 받은 데미지의 값만큼 캐릭터의 체력이 추가됨.
- 몬스터 동작
  - 공격
    - 몬스터 데이터에 입력된 공격력을 최대로, 랜덤하게 공격력 생성
    - 몬스터의 공격력은 캐릭터의 방어력보다 작을 수 없음.
    - 캐릭터가 받는 공격의 값은 몬스터의 공격력에 캐릭터의 방어력을 뺀 값.
