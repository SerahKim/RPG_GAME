import "dart:io";
import "package:rpg_game/rpgCharacter.dart";
import "package:rpg_game/rpgMonster.dart";
import 'package:rpg_game/loadData.dart';

class Game {
  late Character character;
  late Monster monster;
  bool keepGaming = true;
  int defeatMonster = 0;
  List<String> defeatedMonsterList = [];

  LoadData loadData = LoadData();

  Game() {
    character = loadData.loadCharacterStats(); // 캐릭터 초기화
    monster = loadData.getRandomMonster(); // 몬스터 초기화
  }

  void startGame() {
    defeatMonster = defeatedMonsterList.length;

    if (character.health <= 0) {
      print('게임을 종료합니다.');
      loadData.saveResult(character.name!, character.health, '패배');

      exit(1);
    } else if (defeatMonster != 0) {
      while (true) {
        print('다음 몬스터와 대결하시겠습니까?(y/n)');
        String? response = stdin.readLineSync();

        if (response == 'y') {
          monster = loadData.randomGenerate(
              defeatedMonsterList); //물리친 몬스터를 제외한 새로운 몬스터를 monster 변수에 할당
        } else if (response != null && response == 'n') {
          print('게임을 종료합니다.');
          exit(1);
        } else {
          print('y 또는 n을 입력해주세요.');
        }
      }
    } else if (defeatMonster == 0) {
      print('축하합니다! 모든 몬스터를 물리쳤습니다.');
      loadData.saveResult(character.name!, character.health, '승리');
      keepGaming = false;
    }
  }

  void battle() {
    while (keepGaming) {
      print('${character.name}의 턴');
      print('행동을 선택하세요 (1: 공격, 2: 방어)');
      String? battleChoice = stdin.readLineSync();

      if (battleChoice == '1') {
        character.attackMonster(monster);
        if (monster.health <= 0) {
          // 몬스터를 처치했을 경우
          defeatedMonsterList = loadData.removeMonster(monster.name);
          startGame();
        } else {
          // 몬스터를 처치하지 못했을 경우 몬스터의 턴

          print('${monster.name}의 턴');
          monster.attackCharacter(character);
          character.showStatus();
          monster.showStatus();
          print('\n');
        }
      } else if (battleChoice == '2') {
        character.defend(monster);
        print('${monster.name}의 턴');
        monster.attackCharacter(character);
        character.showStatus();
        monster.showStatus();
        print('\n');
      } else {
        print('1 또는 2를 입력해주세요.');
      }
    }
  }
}
