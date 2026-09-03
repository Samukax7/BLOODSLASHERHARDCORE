# BLOOD SLASHER HARDCORE — Plano da Demo Web MVP

## Documento de execução para a N.O.V.A. no VSCode

**Engine:** Godot Engine 4  
**Linguagem:** GDScript  
**Alvo principal:** Web, navegador desktop e mobile em paisagem  
**Renderer:** Compatibility  
**Resolução interna:** 640 × 360, proporção 16:9  
**Meta:** demo curta, jogável do menu ao CTA final  
**Documento relacionado:** GDD.md

---

## 1. Ordem principal

Criar uma demo funcional usando placeholders. Não esperar sprites, vozes ou música finais.

A demo precisa iniciar, apresentar a história, permitir jogar a primeira fase completa, mostrar o resultado e terminar com um CTA para futuros colaboradores.

Não implementar sistemas fora deste documento antes que o fluxo inteiro esteja jogável.

---

## 2. Objetivo da demo

Entregar uma experiência de aproximadamente **6 a 10 minutos** contendo:

1. Menu principal.
2. Introdução narrativa em português.
3. Primeira fase linear.
4. Três tipos de inimigos.
5. Duas arenas de horda.
6. Um chefe simples.
7. Sistema de combo e kills.
8. Modo Fúria.
9. Narrador provisório por texto e áudio substituível.
10. Tela de resultado.
11. CTA com link para o projeto.

A demo não precisa representar todo o conteúdo planejado no GDD. Ela deve provar movimento, corrente, hordas, humor, violência visual e identidade sonora.

---

## 3. Princípios de implementação

- O projeto deve rodar mesmo sem arte final.
- Todo sistema visual precisa aceitar substituição de placeholders por sprites.
- Usar cenas pequenas e componentes reutilizáveis.
- Evitar heranças profundas.
- Usar sinais para eventos de gameplay.
- Não adicionar plugins ou addons no primeiro ciclo.
- Não usar threads.
- Não criar multiplayer.
- Não criar inventário.
- Não criar árvore de habilidades.
- Não produzir as outras 11 fases.
- Fazer commits pequenos e descritivos.
- Testar no navegador ao final de cada milestone.

---

## 4. Fluxo de cenas

    Boot
      ↓
    MainMenu
      ↓
    Intro
      ↓
    Stage01
      ↓
    Results
      ↓
    CollaboratorCTA

### 4.1 Boot

Responsabilidades:

- Carregar configurações.
- Inicializar áudio.
- Verificar se está rodando na Web.
- Abrir o MainMenu.
- Não exibir splash longa.

### 4.2 MainMenu

Elementos:

- Logo BLOOD SLASHER HARDCORE.
- Fundo infernal provisório.
- Silhueta do protagonista.
- Botão JOGAR.
- Botão CONTROLES.
- Botão OPÇÕES.
- Botão CRÉDITOS.
- Indicador de versão: DEMO WEB 0.1.

A primeira interação do usuário também deve liberar o áudio no navegador.

### 4.3 Intro

Introdução formada por seis painéis 16:9. Inicialmente usar ColorRects, silhuetas e texto.

Controles:

- Avançar.
- Voltar.
- Pular introdução.
- Avanço automático opcional.
- Clique, toque, teclado e controle.

Texto provisório:

**Painel 1**

> Ele viveu rápido. Brigou mais do que devia.

**Painel 2**

> Uma noite, a estrada finalmente cobrou a dívida.

**Painel 3**

> Quando abriu os olhos, o asfalto ainda queimava. Mas aquele não era mais o seu mundo.

**Painel 4**

> Disseram que o Inferno seria eterno.

**Painel 5**

> Ele ouviu a palavra “eterno”... e sorriu.

**Painel 6**

> Se existe redenção, ela está no fim desta estrada. Se não existe, ele destruirá o Inferno tentando.

Depois do último painel, carregar Stage01.

---

## 5. Stage 01 — Rodovia dos Condenados

### 5.1 Estrutura

A fase deve ser construída como uma linha curta, composta por cinco setores.

| Setor | Conteúdo | Objetivo |
|---|---|---|
| 01 — Despertar | Cratera e tutorial | Ensinar movimento, salto e ataques |
| 02 — Posto em Chamas | Arena de horda 1 | Apresentar Condenado e Perseguidor |
| 03 — Ponte das Correntes | Travessia curta | Introduzir Atirador e perigo ambiental |
| 04 — Pedágio das Almas | Arena de horda 2 | Combinar os três inimigos |
| 05 — Portão Infernal | Chefe O Cobrador | Encerrar a demo com clímax |

### 5.2 Tutorial contextual

Não usar caixa de texto longa.

Mostrar instruções próximas ao personagem:

- A/D ou setas: mover.
- Espaço: saltar.
- J: ataque leve.
- K: ataque pesado.
- Shift ou L: esquiva.
- R: ativar Fúria quando o medidor estiver cheio.

Ocultar cada instrução depois que a ação for executada.

### 5.3 Limites da fase

- Sem caminhos alternativos.
- Sem exploração extensa.
- Sem colecionáveis.
- Sem checkpoint complexo.
- Reinício no início do setor atual.
- Duração alvo: 4 a 7 minutos.

---

## 6. Protagonista

O protagonista é o motoqueiro arruaceiro já definido:

- Topete greaser preto.
- Óculos escuros.
- Sorriso confiante e insano.
- Jaqueta preta com spikes.
- Faixa vermelha.
- Camiseta clara.
- Jeans rasgados.
- Botas pesadas.
- Luvas com spikes.
- Corrente grossa com peso metálico espinhoso.

### 6.1 Cena

    Player
    ├── CharacterBody2D
    ├── VisualRoot
    │   ├── AnimatedSprite2D_Body
    │   ├── AnimatedSprite2D_Chain
    │   ├── FlashSprite
    │   └── RageEffect
    ├── CollisionShape2D
    ├── Hurtbox
    ├── HitboxContainer
    ├── FloorSensor
    ├── AnimationPlayer
    ├── Components
    │   ├── HealthComponent
    │   ├── MovementComponent
    │   ├── CombatComponent
    │   └── RageComponent
    └── Audio

### 6.2 Movimento MVP

Implementar:

- Corrida lateral.
- Salto com altura variável.
- Coyote time curto.
- Buffer de salto.
- Controle aéreo.
- Esquiva terrestre.
- Virada de direção.
- Pequeno knockback ao receber dano.

Não implementar wall jump, agarrar borda ou air dash no MVP.

### 6.3 Combate MVP

Implementar:

- Combo leve de três golpes.
- Ataque pesado.
- Ataque aéreo simples.
- Esquiva.
- Dano.
- Hitstop.
- Knockback.
- Stagger.
- Morte e reinício do setor.

Não implementar aparo, execuções, troca de arma ou combos ramificados nesta etapa.

### 6.4 Controles provisórios

| Ação | Teclado | Controle |
|---|---|---|
| Mover | A/D ou setas | Analógico ou direcional |
| Saltar | Espaço | Botão inferior |
| Ataque leve | J | Botão esquerdo |
| Ataque pesado | K | Botão superior |
| Esquiva | Shift ou L | Ombro direito |
| Fúria | R | Dois gatilhos ou botão dedicado |
| Pausa | Esc | Start |

Criar todas as ações no Input Map. O código nunca deve consultar teclas físicas diretamente.

---

## 7. Modo Fúria

### 7.1 Acúmulo

O medidor recebe energia por:

- Causar dano.
- Eliminar inimigos.
- Atingir vários inimigos.
- Manter combo.
- Derrotar elites ou o chefe.

Receber dano reduz uma pequena parte do medidor, mas não zera tudo.

### 7.2 Ativação

Quando o medidor estiver completo e o jogador pressionar a ação rage:

1. Pausar o gameplay por aproximadamente 0,15 segundo.
2. Aproximar a câmera.
3. Exibir flash vermelho.
4. Exibir legenda:

> SAI DA FRENTE, SATANÁS!

5. Tocar arquivo de voz quando disponível.
6. Ativar Fúria por 8 segundos.
7. Restaurar câmera.

### 7.3 Efeitos

Durante a Fúria:

- Velocidade de ataque aumentada.
- Dano e stagger aumentados.
- Ataque pesado sem custo.
- Sangue e partículas intensificados.
- Kills estendem a duração em pequena quantidade.
- Extensão total limitada.
- Jogador não fica totalmente invulnerável.
- HUD pulsa em vermelho.

A frase é usada apenas na ativação da Fúria.

---

## 8. Inimigos

### 8.1 Condenado

Função: inimigo básico.

- Caminha até o jogador.
- Ataque corpo a corpo simples.
- Baixa vida.
- Stagger fácil.
- Pode aparecer em grupos.

### 8.2 Perseguidor

Função: pressão rápida.

- Movimento veloz.
- Pequena pausa antes do salto.
- Ataque em investida.
- Pouca vida.
- Deve ser reconhecido pela silhueta e som.

### 8.3 Atirador Infernal

Função: controle de espaço.

- Mantém distância.
- Exibe linha ou efeito de preparação.
- Dispara projétil lento.
- Longa recuperação após o tiro.
- Deve poder ser interrompido.

### 8.4 Cena-base

    EnemyBase
    ├── CharacterBody2D
    ├── VisualRoot
    ├── CollisionShape2D
    ├── Hurtbox
    ├── HitboxContainer
    ├── DetectionArea
    ├── AnimationPlayer
    ├── StateMachine
    └── Components
        ├── HealthComponent
        ├── MovementComponent
        └── CombatComponent

Estados mínimos:

- Spawn.
- Idle.
- Chase.
- Telegraph.
- Attack.
- Recover.
- Hit.
- Dead.

---

## 9. Chefe — O Cobrador

### 9.1 Apresentação

O Cobrador bloqueia o Portão Infernal.

Diálogo:

**O Cobrador**

> Nenhuma alma atravessa o Pedágio dos Condenados.

**Motoqueiro**

> Não sou alma, não. Sou problema.

O jogador recebe controle depois do diálogo.

### 9.2 Ataques

1. Golpe horizontal lento.
2. Pancada no chão com onda curta.
3. Investida de uma extremidade à outra.
4. Invocação de dois Condenados.

### 9.3 Fases

**Fase A — 100% a 50%**

- Usa golpe, pancada e investida.
- Intervalos claros.

**Fase B — abaixo de 50%**

- Aumenta velocidade.
- Invoca Condenados uma vez.
- Arena ganha fogo visual nas extremidades.
- Não alterar completamente o moveset.

### 9.4 Vitória

- Desativar hitboxes.
- Tocar animação provisória de derrota.
- Abrir o portão.
- Mostrar estrada e reino demoníaco ao fundo.
- Avançar para Results.

---

## 10. Hordas

Criar um HordeController por arena.

Responsabilidades:

- Fechar limites da arena.
- Criar ondas.
- Contar inimigos vivos.
- Limitar atacantes simultâneos.
- Abrir a arena quando terminar.
- Emitir sinais para HUD e câmera.

### 10.1 Arena 1

- Onda 1: 3 Condenados.
- Onda 2: 2 Condenados + 2 Perseguidores.
- Onda 3: 4 Condenados + 2 Perseguidores.

### 10.2 Arena 2

- Onda 1: 3 Condenados + 1 Atirador.
- Onda 2: 2 Perseguidores + 2 Atiradores.
- Onda 3: 4 Condenados + 2 Perseguidores + 1 Atirador.

Máximo inicial: 10 inimigos simultâneos. Aumentar apenas depois de testar o export Web.

---

## 11. Combo, kills e narrador

### 11.1 HUD

Mostrar:

- Vida.
- Medidor de Fúria.
- Quantidade de kills.
- Combo atual.
- Chamada atual do narrador.
- Barra do chefe quando necessário.

### 11.2 Regras

- Combo aumenta ao causar dano.
- Combo expira depois de curto período sem acertar.
- Kill adiciona tempo ao combo.
- Receber dano reduz ou encerra o combo.
- Não criar ranking de estilo complexo nesta demo.

### 11.3 Chamadas

Criar sistema dirigido por IDs. O áudio pode ser adicionado depois sem mudar o gameplay.

| Gatilho | ID | Texto |
|---|---|---|
| Início da fase | highway_to_hell | HIGHWAY TO HELL! |
| Primeira horda | cowboys_from_hell | COWBOYS FROM HELL! |
| Combo alto | seek_and_destroy | SEEK AND DESTROY! |
| Sangue acumulado | raining_blood | RAINING BLOOD! |
| Quebra do portão | breaking_the_law | BREAKING THE LAW! |
| Explosão ou multikill | symphony_of_destruction | SYMPHONY OF DESTRUCTION! |
| Sobreviver com pouca vida | painkiller | PAINKILLER! |
| Entrada do chefe | hell_awaits | HELL AWAITS! |
| Morte do jogador | fade_to_black | FADE TO BLACK! |

Regras:

- Cooldown global.
- Prioridade por evento.
- Não repetir imediatamente.
- Mostrar legenda mesmo sem áudio.
- Voz futura: grave, gutural, inglês inteligível e sotaque brasileiro.

---

## 12. Sangue e efeitos

### 12.1 MVP

Implementar:

- Partículas curtas no impacto.
- Mancha no chão.
- Flash branco ou vermelho no inimigo.
- Pequeno tremor de câmera.
- Hitstop.
- Corpo desaparecendo após a animação de morte.

Não implementar física detalhada de membros no primeiro ciclo.

### 12.2 Limites Web

- Até 80 manchas ativas.
- Remover as mais antigas.
- Até 120 partículas visíveis simultaneamente.
- Desativar processamento fora da câmera.
- Reutilizar manchas e projéteis quando possível.
- Opção REDUZIR SANGUE no menu.

---

## 13. Áudio

### 13.1 Estrutura

Buses:

- Master.
- Music.
- SFX.
- Voice.
- UI.

### 13.2 Música

Usar uma faixa provisória original ou silenciosa. Não incluir músicas comerciais.

Preparar AudioManager para futuramente receber três camadas:

- Base.
- Bateria e ritmo.
- Camada de Fúria.

### 13.3 Navegador

- O áudio só deve iniciar depois de interação do usuário.
- Usar configurações padrão recomendadas para Web.
- Evitar dezenas de sons simultâneos.
- Priorizar impactos, voz e feedback de UI.

---

## 14. Interface para Web

### 14.1 Desktop

- Teclado.
- Controle.
- Mouse nos menus.

### 14.2 Mobile paisagem

Criar TouchControls opcionais:

- Esquerda.
- Direita.
- Salto.
- Ataque leve.
- Ataque pesado.
- Esquiva.
- Fúria.

Regras:

- Ocultar controles touch quando teclado ou controle for o dispositivo principal.
- Botões grandes e sem cobrir o protagonista.
- Testar em 16:9 e telas mais largas.
- A demo deve solicitar orientação horizontal por mensagem, não bloquear a execução.

TouchControls podem ser implementados depois do teclado, mas antes do primeiro build público.

---

## 15. Tela de resultado

Mostrar:

- Tempo da fase.
- Kills.
- Maior combo.
- Quantidade de Fúrias ativadas.
- Dano recebido.
- Nota provisória.
- Botão CONTINUAR.

Não criar economia ou recompensas permanentes.

---

## 16. CTA para colaboradores

Texto:

> AINDA RESTAM ONZE FASES DO INFERNO.
>
> O reino demoníaco está em construção.
>
> Procuramos artistas de pixel art, animadores, programadores Godot, músicos de metal e vozes.
>
> AJUDE A TERMINAR A CARNIFICINA.

Botões:

- CONHEÇA O PROJETO.
- JOGAR NOVAMENTE.
- MENU PRINCIPAL.

Link do projeto:

https://github.com/Samukax7/BLOODSLASHERHARDCORE

O link externo deve abrir apenas após ação explícita do usuário.

---

## 17. Contrato para as sprites

A estrutura deve aceitar arquivos finais sem alterar scripts.

### 17.1 Protagonista

Pasta:

    res://assets/sprites/player/

Subpastas:

    body/
    chain/
    effects/
    portraits/

Arquivos esperados:

    body/player_idle.png
    body/player_run.png
    body/player_jump.png
    body/player_fall.png
    body/player_land.png
    body/player_dash.png
    body/player_attack_light_01.png
    body/player_attack_light_02.png
    body/player_attack_light_03.png
    body/player_attack_heavy.png
    body/player_attack_air.png
    body/player_hurt.png
    body/player_death.png
    body/player_rage.png

A corrente pode usar arquivos equivalentes na pasta chain.

### 17.2 Padrão de quadro

- Célula: 128 × 128.
- Fundo transparente.
- Personagem voltado para a direita.
- Pivô lógico: centro inferior.
- Linha dos pés: Y = 104.
- Mesmo pivô em todas as animações.
- Corpo ocupa aproximadamente 64 a 72 pixels de altura.
- Espaço restante reservado para corrente, antecipação e efeitos.
- Godot usa flip horizontal para direção oposta.

### 17.3 Inimigos

    res://assets/sprites/enemies/condemned/
    res://assets/sprites/enemies/chaser/
    res://assets/sprites/enemies/shooter/
    res://assets/sprites/bosses/tollkeeper/

Todos devem possuir placeholders com os mesmos nomes finais.

---

## 18. Estrutura de diretórios

    res://
    ├── assets/
    │   ├── sprites/
    │   ├── audio/
    │   ├── fonts/
    │   └── ui/
    ├── data/
    │   ├── enemies/
    │   ├── attacks/
    │   ├── waves/
    │   └── dialogue/
    ├── scenes/
    │   ├── boot/
    │   ├── menu/
    │   ├── intro/
    │   ├── player/
    │   ├── enemies/
    │   ├── bosses/
    │   ├── levels/
    │   ├── ui/
    │   └── effects/
    ├── scripts/
    │   ├── autoload/
    │   ├── components/
    │   ├── player/
    │   ├── enemies/
    │   ├── systems/
    │   └── ui/
    ├── export/
    │   └── web/
    ├── project.godot
    └── export_presets.cfg

---

## 19. Autoloads mínimos

| Autoload | Função |
|---|---|
| GameState | Fluxo, dados da tentativa e estatísticas |
| SceneRouter | Troca de cenas |
| AudioManager | Música, efeitos e voz |
| SaveManager | Configurações locais e recordes |

Não transformar jogador, hordas, HUD ou chefe em Autoload.

---

## 20. Configuração Web

- Renderer Compatibility.
- Export Web single-threaded.
- Canvas adaptável.
- Sem dependência de SharedArrayBuffer.
- Resolução interna 640 × 360.
- Stretch Mode: canvas_items.
- Aspect: expand.
- Teclado, controle e touch.
- Build inicial com shell HTML padrão.
- Não criar PWA no primeiro milestone.
- Não usar shader dependente de Forward+.
- Comprimir áudio e texturas de forma adequada.
- Manter carregamento inicial curto.
- Testar em Chrome e Firefox desktop.
- Testar ao menos um navegador Android antes do CTA público.

A exportação Web single-threaded é preferida para compatibilidade. Sistemas devem permanecer no thread principal.

---

## 21. Orçamento técnico inicial

| Item | Limite inicial |
|---|---:|
| Inimigos simultâneos | 10 |
| Manchas de sangue | 80 |
| Partículas visíveis | 120 |
| Projéteis simultâneos | 12 |
| Duração alvo | 6–10 minutos |
| FPS | 60 desktop, mínimo aceitável de 30 em mobile |
| Resolução interna | 640 × 360 |

Medir antes de aumentar limites.

---

## 22. Milestones

### Milestone 0 — Bootstrap

- Criar project.godot.
- Configurar Compatibility.
- Criar Input Map.
- Criar pastas.
- Criar cenas vazias.
- Configurar fluxo Boot → Menu.
- Criar preset Web.

**Aceite:** projeto abre sem erros e exporta uma tela vazia para Web.

### Milestone 1 — Fluxo completo com placeholders

- MainMenu.
- Intro com seis painéis.
- Stage01 vazia.
- Results.
- CTA.
- Navegação completa.

**Aceite:** usuário percorre toda a demo sem gameplay.

### Milestone 2 — Sandbox de combate

- Player.
- Movimento.
- Combo leve.
- Pesado.
- Esquiva.
- Fúria.
- Um Condenado.
- Dano e morte.

**Aceite:** combate simples é jogável no navegador.

### Milestone 3 — Primeira fase

- Cinco setores.
- Três inimigos.
- Duas arenas.
- O Cobrador.
- Reinício de setor.
- Resultado.

**Aceite:** fase pode ser concluída do início ao fim.

### Milestone 4 — Identidade

- Sangue.
- Combo.
- Narrador por texto.
- Áudios provisórios.
- Câmera.
- Diálogo do chefe.
- CTA final.

**Aceite:** a demo comunica a proposta mesmo com sprites parciais.

### Milestone 5 — Web pública

- Touch controls.
- Otimização.
- Testes em navegador.
- Correções de escala.
- Build final.
- Instruções de hospedagem.

**Aceite:** link abre, carrega, toca áudio após interação e permite concluir a demo.

---

## 23. Critérios finais de aceite

A demo está pronta quando:

- Abre diretamente no navegador.
- Menu funciona com mouse, teclado e toque.
- Introdução pode ser avançada e pulada.
- Jogador consegue mover, saltar, atacar, esquivar e ativar Fúria.
- Frase “SAI DA FRENTE, SATANÁS!” aparece apenas na Fúria.
- Três inimigos possuem funções diferentes.
- As duas hordas terminam corretamente.
- O Cobrador pode ser derrotado.
- Combo, kills e narrador funcionam.
- Tela de resultado exibe dados reais.
- CTA abre o repositório após clique.
- Não há erro crítico no console do navegador.
- Sprites finais podem substituir placeholders sem alterar scripts.

---

## 24. Primeira tarefa para a N.O.V.A. no VSCode

Executar apenas o **Milestone 0** e depois validar:

1. Ler GDD.md e este documento.
2. Criar o projeto Godot 4 com renderer Compatibility.
3. Criar estrutura de diretórios.
4. Configurar resolução 640 × 360.
5. Configurar Input Map.
6. Criar cenas Boot e MainMenu com placeholders.
7. Criar Autoloads mínimos com interfaces vazias e comentários.
8. Criar preset de exportação Web single-threaded.
9. Abrir e executar o projeto.
10. Exportar um build Web de teste.
11. Registrar no README o que funciona e o próximo passo.

Não avançar para combate até que o build Web básico seja confirmado.
