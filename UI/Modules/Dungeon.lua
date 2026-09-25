# Sistema de Masmorra, Chefão e Mecânicas de Combate

## 1. Mecânica do Chefão (Boss) e Totens de Cura
* **Invocação de Totens:** Periodicamente, o chefão invoca **4 Totens de Recuperação de Vida**.
* **Invulnerabilidade do Chefão:** Enquanto pelo menos um totem de cura estiver ativo, o chefão fica imune a qualquer tipo de dano (dano recebido = 0).
* **Condição de Retorno:** Os jogadores devem priorizar a destruição dos 4 totens. Assim que todos os totens forem destruídos, o escudo de invulnerabilidade do chefão é removido e ele volta a receber dano normalmente.

## 2. Sistema de Esquiva e Ataques (Boss e NPCs)
* **Comportamento de Ataque:** Tanto o chefão quanto os minion/NPCs da masmorra realizam ataques direcionados aos jogadores.
* **Mecânica de Desvio / Esquiva (Dodge):**
  * **Indicadores visuais (Telegrafia):** Antes de cada ataque forte ou de área (AoE) do boss e dos NPCs, uma zona de impacto/alerta é exibida no chão.
  * **Janela de Esquiva:** O jogador pode acionar a habilidade de esquiva/dash no tempo correto para evitar completamente o dano do ataque.
  * **IA de Inimigos:** Se o jogador esquivar com sucesso, o ataque do NPC/Boss errará e entrará em tempo de recarga (cooldown).

---

### Exemplo de Implementação em Código (Lógica da Masmorra / Boss)

```python
import time

class Totem:
    def __init__(self, totem_id, health=100):
        self.totem_id = totem_id
        self.health = health
        self.is_alive = True

    def take_damage(self, amount):
        if not self.is_alive:
            return
        self.health -= amount
        if self.health <= 0:
            self.health = 0
            self.is_alive = False
            print(f" Totem {self.totem_id} foi destruído!")

class Boss:
    def __init__(self, name="Chefão da Masmorra", max_health=1000):
        self.name = name
        self.max_health = max_health
        self.health = max_health
        self.totems = []
        self.is_vulnerable = True

    def spawn_totems(self):
        print(f"\n [HABILIDADE] {self.name} invocou 4 Totens de Cura! O Chefão agora está INVULNERÁVEL!")
        self.totems = [Totem(i+1, health=150) for i in range(4)]
        self.is_vulnerable = False

    def update_vulnerability(self):
        # Verifica se todos os totens foram destruídos
        active_totems = [t for t in self.totems if t.is_alive]
        if not active_totems and not self.is_vulnerable:
            self.is_vulnerable = True
            print(f"\n Todos os totens foram destruídos! {self.name} voltou a ser VULNERÁVEL a danos!")

    def take_damage(self, amount):
        self.update_vulnerability()
        if not self.is_vulnerable:
            print(f" {self.name} está imune a dano! Destrua os totens de cura primeiro.")
            return 0
        self.health -= amount
        print(f" {self.name} recebeu {amount} de dano! Vida restante: {self.health}/{self.max_health}")
        return amount

    def attack_player(self, player):
        print(f"\n [ATAQUE DO BOSS] {self.name} está preparando um ataque pesado contra {player.name}!")
        player.try_dodge(damage=50, attacker_name=self.name)

class Player:
    def __init__(self, name="Jogador"):
        self.name = name
        self.health = 200
        self.is_dodging = False

    def dodge(self):
        self.is_dodging = True
        print(f" {self.name} realizou uma esquiva!")

    def try_dodge(self, damage, attacker_name):
        if self.is_dodging:
            print(f" SUCCESS: {self.name} desviou do ataque de {attacker_name} e não sofreu dano!")
            self.is_dodging = False # Reseta estado após desviar
        else:
            self.health -= damage
            print(f" HIT: {self.name} foi atingido por {attacker_name} recebendo {damage} de dano! Vida atual: {self.health}")

# Exemplo de fluxo da luta
if __name__ == "__main__":
    player = Player("Heroi")
    boss = Boss()

    # Dano inicial no Boss
    boss.take_damage(200)

    # Boss invoca totens de cura
    boss.spawn_totems()

    # Tentativa de atacar o boss enquanto totens estão vivos
    boss.take_damage(150)

    # Jogador tenta desviar de um ataque do boss
    player.dodge()
    boss.attack_player(player)

    # Jogador destrói os totens
    print("\n--- Jogador atacando os totens ---")
    for totem in boss.totems:
        totem.take_damage(150)

    # Agora atacando o boss novamente
    boss.take_damage(300)
```v
