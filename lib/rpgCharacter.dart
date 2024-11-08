import 'dart:io';
import 'package:rpg_game/loadData.dart';
import 'package:rpg_game/rpgMonster.dart';

class Character {
  String? name;
  int health;
  int attack;
  int defense;

  LoadData loadData = LoadData();
  Character(this.name, this.health, this.attack, this.defense);

  String? getCharacterName() {
    bool isValidName = false;
    RegExp namePattern = RegExp(r'^[a-zA-Z가-힣]+$');

    while (!isValidName) {
      print('캐릭터 이름을 입력하세요: ');
      name = stdin.readLineSync();

      if (name == null || name!.isEmpty) {
        print('입력이 비어있습니다. 캐릭터 이름을 다시 입력해주세요.');
      } else if (namePattern.hasMatch(name!)) {
        print('게임을 시작합니다!');
        isValidName = true;
        return name; //입력값이 올바르면 루프를 종료하고 name을 반환
      } else {
        print('특수문자나 숫자가 포함되지 않아야 합니다. 캐릭터 이름을 다시 입력해주세요.');
      }
    }
  }

  void attackMonster(Monster monster) {
    monster.health -= attack;
    if (monster.health <= 0) {
      print('$name이(가) ${monster.name}에게 $attack의 데미지를 입혔습니다.\n');
      print('${monster.name}을 물리쳤습니다!');
    } else {
      print('$name이(가) ${monster.name}에게 $attack의 데미지를 입혔습니다.\n');
    }
  }

  void defend(Monster monster) {
    int getDamage = monster.maxAttack - defense;
    health += getDamage;

    print(
        '$name이(가) 방어 태세를 취하여 $getDamage만큼 피해를 막았습니다. $getDamage만큼의 추가 체력을 얻습니다.\n 현재 체력 : $health\n');
  }

  void showStatus() {
    print('$name - 체력 : $health, 공격력: $attack, 방어력: $defense');
  }
}
