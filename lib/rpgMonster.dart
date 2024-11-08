import 'package:rpg_game/rpgCharacter.dart';
import 'package:rpg_game/loadData.dart';
import 'dart:math';

class Monster {
  String name;
  int health;
  int maxAttack;
  int defense = 0;
  int realAttack = 0;

  LoadData loadData = LoadData();
  Monster(this.name, this.health, this.maxAttack);

  void attackCharacter(Character character) {
    realAttack = max(Random().nextInt(maxAttack), character.defense);
    int damage = realAttack - character.defense;

    character.health -= damage;

    print('$name가 ${character.name}에게 $damage의 데미지를 입혔습니다.');
  }

  void showStatus() {
    print('$name - 체력 : $health, 공격력: $realAttack');
  }
}
