import "dart:io";
import "dart:math";
import "package:rpg_game/rpgCharacter.dart";
import "package:rpg_game/rpgMonster.dart";

class LoadData {
  late Character character;
  late Monster monster;
  List<String> monsterData = [];

  //동기 방식으로 캐릭터 스탯 불러오기
  Character loadCharacterStats() {
    try {
      final file = File('../bin/characters.txt');
      final contents = file.readAsStringSync();
      final stats = contents.split(',');
      if (stats.length != 3) throw FormatException('Invalid character data');

      int health = int.parse(stats[0]);
      int attack = int.parse(stats[1]);
      int defense = int.parse(stats[2]);

      //캐릭터 객체 생성
      character = Character(
          '', health, attack, defense); //name은 사용자로부터 받아와야하기 떄문에 null값으로 초기화
      character.name = character
          .getCharacterName(); //getCharacterName을 통해 사용자로부터 입력받은 이름을 name에 할당
      print(
          '${character.name} - 체력 : $health, 공격력 : $attack, 방어력 : $defense\n');
      return Character(character.name, health, attack, defense);
    } catch (e) {
      print('캐릭터 데이터를 불러오는 데 실패했습니다: $e');
      exit(1);
    }
  }

  Monster randomGenerate(List<String> monsterList) {
    //랜덤하게 몬스터 데이터를 읽어오는 부분
    final randomIndex =
        Random().nextInt(monsterList.length); //stats list 길이 내에서 랜덤한 인덱스 생성
    String randomMonsterData = monsterList[randomIndex]; //랜덤 인덱스를 통해 몬스터 데이터 선택
    final monsterStats = randomMonsterData
        .split(','); //랜덤으로 선택된 몬스터의 스탯을 쉼표로 기준으로 monsterStats 리스트 생성
    if (monsterStats.length != 3) {
      throw FormatException('Invalid monster data');
    }

    String name = monsterStats[0];
    int health = int.parse(monsterStats[1]);
    int maxAttack = int.parse(monsterStats[2]);

    //Monster 객체 생성
    print('새로운 몬스터가 나타났습니다!');
    print('$name - 체력 : $health, 공격력 : $maxAttack\n');
    return monster = Monster(name, health, maxAttack);
  }

// 동기 방식으로 랜덤하게 몬스터 스탯 불러오기
  Monster getRandomMonster() {
    try {
      final file = File('../bin/monsters.txt');
      final contents = file.readAsStringSync();
      monsterData =
          contents.split('\n'); //줄바꿈을 기준으로 리스트 생성, monsterData를 클래스 변수에 저장
      //랜덤하게 몬스터 데이터를 읽어오는 부분
      return randomGenerate(monsterData);
    } catch (e) {
      print('몬스터 데이터를 불러오는 데 실패했습니다: $e');
      exit(1);
    }
  }

  List<String> removeMonster(String defeatedMonsterName) {
    monsterData
        .removeWhere((data) => data.contains(defeatedMonsterName)); //물리친 몬스터 제거
    return monsterData;
  }

  void saveResult(String characterName, int leftHealth, String gameResult) {
    print('결과를 저장하시겠습니까? (y/n)');
    String? resultChoice = stdin.readLineSync();
    while (true) {
      if (resultChoice != null && resultChoice == 'y') {
        try {
          String resultData =
              '캐릭터 이름 : $characterName, 남은 체력 : $leftHealth, 게임 결과 : $gameResult';

          // 파일에 결과 저장
          File('../bin/result.txt').writeAsStringSync(resultData);
          print('게임 결과가 성공적으로 저장되었습니다.');
          print('게임을 종료합니다.');
          exit(1);
        } catch (e) {
          print('결과를 저장하는 중 오류가 발생했습니다: $e');
        }
      } else if (resultChoice == 'n') {
        print('결과가 저장되지 않습니다.');
        print('게임을 종료합니다.');
        exit(1);
      } else {
        print('y 또는 n을 입력해주세요.');
      }
    }
  }
}
