# BLOOD SLASHER HARDCORE

## Game Design Document — v0.1

**Engine:** Godot Engine 4  
**Genre:** hack and slash 2D lateral, ação arcade e combate por hordas  
**Direção visual:** pixel art 2D sangrenta, personagens compactos e modulares  
**Plataforma inicial:** PC, teclado e controle  
**Meta de desempenho:** 60 FPS  
**Estado:** pré-produção  
**Documento vivo:** mecânicas e valores serão recalibrados durante o vertical slice.

---

## 1. Visão do jogo

### 1.1 High concept

**BLOOD SLASHER HARDCORE** é um hack and slash 2D de ritmo agressivo em que o jogador atravessa fases lineares, enfrenta hordas de criaturas e transforma cada arena em um registro visual da batalha. Armas brancas definem o estilo de combate. Sangue residual, partículas, metal pesado dinâmico e um narrador de kills tornam a carnificina parte da interface e da recompensa.

### 1.2 Pitch curto

> Avance. Corte. Não interrompa o massacre.

O jogador precisa manter movimento e agressividade para alimentar o **Ritmo de Carnificina**. Combos longos elevam a trilha sonora, a resposta do narrador, a pontuação e a intensidade visual. Ser atingido ou permanecer passivo reduz o ritmo.

### 1.3 Fantasia do jogador

- Ser uma máquina de combate rápida e precisa.
- Dominar armas brancas com identidades distintas.
- Controlar uma multidão de inimigos sem perder o fluxo.
- Produzir sequências visualmente brutais e satisfatórias.
- Buscar notas, recordes e sobrevivência cada vez maiores.

### 1.4 Público

Jogadores que gostam de hack and slash, ação arcade, hordas, pixel art, metal e sistemas de pontuação. O jogo deve ser fácil de compreender nos primeiros minutos e difícil de dominar.

---

## 2. Pilares de design

### 2.1 Movimento fluido

O jogador deve sentir controle imediato. Corrida, salto, queda, aterrissagem, esquiva e ataques precisam se conectar com pouca latência e cancelamentos bem definidos.

### 2.2 Arma é identidade

Cada arma muda alcance, velocidade, movimentação, controle de grupo, risco e finalizações. Trocar a arma deve parecer trocar de personagem sem abandonar o protagonista.

### 2.3 Hordas legíveis

Muitos inimigos podem ocupar a tela, mas seus ataques precisam ser antecipáveis. Silhueta, cor, som e animação devem comunicar ameaça antes do dano.

### 2.4 Escalada audiovisual

O sistema de kills controla música, narrador, interface e efeitos. O espetáculo cresce junto com o desempenho.

### 2.5 Violência residual

A arena deve conservar marcas do combate: manchas, gotas, partes e objetos destruídos. Os resíduos desaparecem de forma controlada para preservar desempenho e leitura.

### 2.6 Produção modular

Personagens, armas, inimigos e efeitos compartilham uma base técnica. O sistema deve permitir adicionar conteúdo sem reescrever o combate.

---

## 3. Estrutura geral

### 3.1 Modos

#### Campanha

- 12 fases lineares iniciais.
- Divisão em três atos de quatro fases.
- Arenas de horda conectadas por trechos de avanço.
- Elites e minibosses distribuídos ao longo das fases.
- Um chefe principal ao final de cada ato.
- Pontuação, tempo, dano recebido, maior combo e nota final.

#### Sobrevivência

- Arena contínua.
- Ondas progressivas.
- Composição semialeatória de inimigos.
- Modificadores periódicos.
- Elites e chefes em intervalos definidos.
- Placar baseado em tempo, kills, combo e dificuldade.
- Reaproveitamento das arenas, inimigos e sistemas da campanha.

### 3.2 Estrutura da campanha

| Ato | Fases | Objetivo de produção |
|---|---:|---|
| I — Ruptura | 1–4 | Ensinar movimento, duas armas, inimigos básicos e primeiro chefe |
| II — Carnificina | 5–8 | Combinar arquétipos, introduzir elites e perigos ambientais |
| III — Extinção | 9–12 | Exigir domínio do arsenal, variantes brutais e chefe final |

### 3.3 Estrutura de uma fase

1. Entrada e apresentação do ambiente.
2. Trecho curto de movimentação.
3. Arena de horda básica.
4. Travessia com ameaça ambiental ou encontro especial.
5. Arena de combinação tática.
6. Elite, miniboss ou chefe.
7. Tela de resultado.

Duração provisória por fase: **8 a 15 minutos**.

---

## 4. Loop principal

1. Entrar em uma fase.
2. Avançar pelo cenário.
3. Encontrar uma arena bloqueada.
4. Eliminar a horda.
5. Coletar vida, energia, arma ou bônus.
6. Manter o Ritmo de Carnificina.
7. Vencer elite ou chefe.
8. Receber nota e desbloqueios.
9. Melhorar equipamento ou selecionar a próxima fase.
10. Repetir buscando maior domínio e pontuação.

---

## 5. Movimento

O plano inicial é um side-scroller em **eixo lateral único**, com deslocamento horizontal, salto e plataformas. Não há eixo de profundidade de beat 'em up nesta versão.

### 5.1 Ações básicas

- Mover para esquerda e direita.
- Saltar.
- Salto com altura variável conforme duração do botão.
- Esquiva terrestre.
- Esquiva aérea limitada.
- Queda rápida.
- Ataque leve.
- Ataque pesado.
- Especial da arma.
- Aparo ou defesa contextual.
- Execução.
- Interação e coleta.
- Troca de arma, se houver arma secundária.

### 5.2 Requisitos de sensação

- Buffer de entrada para ataques e salto.
- Coyote time curto.
- Cancelamentos documentados por golpe.
- Virada rápida sem quebrar animações críticas.
- Hitstop nos impactos.
- Tremor de câmera proporcional ao golpe.
- Recuperação rápida após aterrissagem comum.
- Controle aéreo suficiente para corrigir trajetória, sem remover compromisso.

Os valores exatos serão definidos no sandbox de combate.

---

## 6. Combate

### 6.1 Kit universal

| Ação | Função |
|---|---|
| Ataque leve | Combo rápido e geração segura de ritmo |
| Ataque pesado | Quebra de postura, lançamento e dano |
| Ataque aéreo | Continuação ou abertura de combo |
| Especial | Mecânica exclusiva da arma |
| Esquiva | Reposicionamento e invulnerabilidade curta |
| Aparo | Defesa de alto risco e alta recompensa |
| Execução | Finalização de alvo vulnerável |
| Troca/arremesso | Adaptação tática e expressão do jogador |

### 6.2 Regras de combo

- Golpes leves conectam em cadeias curtas.
- Golpes pesados encerram, lançam ou alteram a direção do combo.
- Certos ataques podem ser cancelados por esquiva.
- Inimigos possuem resistência a stagger e lançamento.
- Repetir o mesmo golpe reduz pontuação de estilo, mas não o dano.
- Ataques em múltiplos alvos aumentam a geração de massacre.
- Finalizações concedem alto valor e breve segurança.

### 6.3 Recursos de combate

#### Vida

Recurso de sobrevivência. A recuperação deve ser limitada e ligada a drops, execução, checkpoint ou modificadores.

#### Energia da arma

Consumida pelo especial. Recuperada com combate ativo, aparos ou kills.

#### Ritmo de Carnificina

Medidor temporário alimentado por dano, kills, aparos e variedade. Diminui quando o jogador fica passivo, erra por muito tempo ou recebe dano.

### 6.4 Escala do narrador

Nomes provisórios:

1. FIRST BLOOD
2. MULTIKILL
3. SLAUGHTER
4. BLOODSTORM
5. TOTAL MASSACRE

O narrador utiliza uma fila com prioridade. Chamadas importantes não podem ser interrompidas por eventos menores. Todas as falas devem possuir legenda opcional.

---

## 7. Arsenal

### 7.1 Armas iniciais propostas

| Arma | Velocidade | Alcance | Controle | Identidade |
|---|---|---|---|---|
| Espada | Média | Médio | Equilibrado | Base para aprender o jogo |
| Machado | Baixa | Médio | Alto | Dano, stagger e decapitação |
| Lâminas duplas | Alta | Curto | Médio | Mobilidade e combos longos |
| Lança | Média | Longo | Alto | Manter distância e perfurar linhas |
| Martelo | Muito baixa | Curto/médio | Muito alto | Impacto, chão e lançamento |
| Katana | Alta | Médio | Baixo/médio | Precisão, aparo e cortes críticos |
| Motosserra | Variável | Curto | Alto | Dano contínuo e risco próximo |

O vertical slice começa com **espada** e **machado**. As demais entram depois que a arquitetura de arma estiver validada.

### 7.2 Dados de arma

Cada arma será um recurso de dados independente contendo:

- Cena visual.
- Ícone.
- Dano base.
- Velocidade.
- Consumo de energia.
- Lista de ataques.
- Áudios.
- Efeitos.
- Regras de cancelamento.
- Intensidade de sangue.
- Reação preferencial do inimigo.

---

## 8. Personagens e animação modular

### 8.1 Direção visual

- Proporções compactas e cartunescas.
- Cabeça, mãos e armas maiores que o realista.
- Silhueta reconhecível em movimento.
- Pixel art detalhada sem perder leitura.
- Influência visual de personagens de arena modernos, sem copiar designs existentes.

### 8.2 Sistema híbrido

Um personagem completamente recortado pode parecer uma marionete. A solução será híbrida:

- Corpo-base animado quadro a quadro.
- Cabeça, cabelo, acessórios e armas em camadas substituíveis.
- Braços ou mãos alternativos para categorias de arma quando necessário.
- Trilhas, flashes, sangue e partículas em camadas independentes.
- Frames desenhados especificamente para impactos, poses extremas e finalizações.

### 8.3 Conjunto mínimo de animações

- Idle.
- Corrida.
- Início do salto.
- Subida.
- Queda.
- Aterrissagem.
- Esquiva no chão.
- Esquiva aérea.
- Dano leve.
- Dano pesado.
- Morte.
- Ataques leves.
- Ataques pesados.
- Ataques aéreos.
- Especial.
- Aparo.
- Execuções por categoria de inimigo.

---

## 9. Inimigos

### 9.1 Arquétipos

| Arquétipo | Função |
|---|---|
| Carniceiro | Unidade básica de enxame |
| Perseguidor | Pressiona com velocidade |
| Brutamontes | Ocupa espaço e resiste a stagger |
| Atirador | Obriga movimento e priorização |
| Voador | Interrompe padrões terrestres |
| Escudeiro | Exige quebra, aparo ou ataque por ângulo |
| Invocador | Aumenta a população da arena |
| Parasita | Fortalece ou transforma aliados |
| Elite mutante | Combina duas ou mais funções |

### 9.2 Regras de legibilidade

- Cada ataque possui antecipação visual e sonora.
- Ataques fora da tela geram indicador quando necessário.
- Inimigos não devem atacar simultaneamente sem limite.
- O Diretor de Hordas controla permissões de ataque.
- Elites possuem cor, tamanho ou efeito distintivo.
- O dano de contato só existe quando fizer sentido para o inimigo.

### 9.3 Estados comuns

- Spawn.
- Idle ou avaliação.
- Perseguição.
- Preparação.
- Ataque.
- Recuperação.
- Stagger.
- Lançado.
- Caído.
- Vulnerável à execução.
- Morte.

---

## 10. Diretor de Hordas

O Diretor controla ritmo e composição. Ele não precisa de geração procedural complexa no início.

### 10.1 Responsabilidades

- Orçamento de ameaça por onda.
- Custo individual por inimigo.
- Limite de inimigos simultâneos.
- Limite de atacantes simultâneos.
- Pontos de spawn válidos.
- Intervalo entre grupos.
- Introdução gradual de arquétipos.
- Escalada por desempenho e dificuldade.
- Conclusão da arena e abertura das portas.

### 10.2 Composição

Cada arena possui uma lista autoral de ondas. O Diretor pode variar quantidade, lado de entrada e presença de elites dentro de limites definidos pelo designer.

### 10.3 Dificuldade

A dificuldade deve alterar agressividade, janela de reação, composição de hordas, frequência de elites, recursos recuperados e penalidade sobre o medidor. Evitar transformar dificuldade apenas em aumento de vida.

---

## 11. Sangue, partículas e destruição

### 11.1 Camadas do efeito

1. Flash e hitstop.
2. Rajada curta de partículas.
3. Gotas físicas ou simuladas.
4. Mancha no chão ou parede.
5. Marca temporária no personagem.
6. Parte corporal ou fragmento em golpes específicos.
7. Tremor, som e reação do alvo.

### 11.2 Sangue residual

- Decais reutilizados por pool.
- Limite configurável por plataforma.
- Remoção pelos mais antigos.
- Desaparecimento gradual apenas quando necessário.
- Variações de tamanho e rotação.
- Opção de reduzir ou desativar gore.
- Partes maiores usam física apenas enquanto estão visíveis e relevantes.

### 11.3 Orçamento inicial

- Até 20 inimigos comuns simultâneos no vertical slice.
- Até 150 manchas residuais no perfil desktop.
- Partículas com emissões curtas.
- Objetos fora da câmera entram em modo simplificado.
- Pooling será aplicado primeiro a sangue, projéteis e spawns frequentes.
- Outros pools só serão criados após medição no profiler.

---

## 12. Música e áudio

### 12.1 Metal dinâmico

Cada faixa pode ser dividida em stems:

- Base ambiente.
- Bateria.
- Guitarra rítmica.
- Baixo reforçado.
- Lead ou camada extrema.

O MusicManager mistura camadas segundo o Ritmo de Carnificina, sem reiniciar a música.

### 12.2 Áudio de impacto

O impacto combina som da arma, material atingido, peso do inimigo, camada de sangue, grave adicional em golpes críticos e silêncio muito curto ou compressão em finalizações importantes.

### 12.3 Narrador

- Fila por prioridade.
- Cooldown para evitar repetição.
- Variações de cada chamada.
- Legendas opcionais.
- Volume separado nas configurações.

---

## 13. Câmera e apresentação

- Câmera lateral com antecipação na direção do movimento.
- Limites definidos pela fase.
- Travamento suave durante arenas.
- Tremor com intensidade configurável.
- Zoom pontual em chefe, execução e eventos.
- Indicadores para ameaças fora da tela.
- Interface deve continuar legível sobre fundos vermelhos e partículas.

---

## 14. Interface

### 14.1 HUD

- Vida.
- Energia da arma.
- Ritmo de Carnificina.
- Contador de kills.
- Categoria atual do narrador.
- Ícone da arma.
- Indicadores de elite ou objetivo.
- Chefes usam barra dedicada.

### 14.2 Resultado da fase

- Tempo.
- Kills.
- Maior combo.
- Maior nível de massacre.
- Dano recebido.
- Mortes.
- Variedade de golpes.
- Nota final.
- Melhor recorde local.

### 14.3 Acessibilidade

- Remapeamento de controles.
- Controle independente de tremor.
- Controle de flashes.
- Nível de gore.
- Legendas do narrador.
- Escala de interface.
- Modos de contraste.
- Pausa completa no single-player.
- Assistência opcional de timing para aparo.

---

## 15. Arquitetura na Godot Engine 4

### 15.1 Princípios

- Composição de componentes em vez de heranças profundas.
- Lógica de gameplay separada da apresentação.
- Conteúdo dirigido por dados.
- Sinais para comunicação entre sistemas desacoplados.
- Autoloads limitados a serviços realmente globais.
- Estado de combate controlado por código; animação representa o estado, mas não decide regras críticas sozinha.

### 15.2 Nós principais

- **CharacterBody2D:** jogador e inimigos com movimento controlado.
- **Area2D:** hitboxes, hurtboxes, zonas de execução e coleta.
- **CollisionShape2D:** formas de colisão.
- **AnimatedSprite2D ou Sprite2D:** renderização pixel art.
- **AnimationPlayer:** autoria de animações, ativação de hitboxes e eventos.
- **AnimationTree:** transições avançadas e state machine visual.
- **GPUParticles2D:** sangue, faíscas e rastros.
- **TileMapLayer:** camadas de cenário e colisão.
- **Camera2D:** câmera e limites.
- **AudioStreamPlayer e AudioStreamPlayer2D:** música, UI e áudio posicional.

### 15.3 Separação entre estado e animação

A state machine de gameplay define estados como MOVE, ATTACK, DASH, HIT, EXECUTION e DEAD. O AnimationTree recebe esse estado para apresentar transições. Eventos de animação podem abrir hitboxes, mas dano, custo, cancelamentos e permissões permanecem nos scripts e recursos de dados.

### 15.4 Estrutura de cenas

    Main.tscn
    ├── World
    │   ├── CurrentLevel
    │   ├── Actors
    │   ├── Effects
    │   └── Decals
    ├── CameraRig
    ├── HUD
    └── PauseLayer

    Player.tscn
    ├── CharacterBody2D
    ├── VisualRoot
    │   ├── Body
    │   ├── Head
    │   ├── Weapon
    │   └── EffectsAnchor
    ├── AnimationPlayer
    ├── AnimationTree
    ├── Hurtbox
    ├── HitboxContainer
    ├── GroundSensor
    ├── Components
    │   ├── HealthComponent
    │   ├── CombatComponent
    │   ├── MovementComponent
    │   └── StatusComponent
    └── Audio

    EnemyBase.tscn
    ├── CharacterBody2D
    ├── VisualRoot
    ├── AnimationPlayer
    ├── AnimationTree
    ├── Hurtbox
    ├── HitboxContainer
    ├── Detection
    ├── Components
    └── StateMachine

### 15.5 Resources customizados

Arquivos .tres editáveis no Inspector:

- WeaponData.
- AttackData.
- EnemyData.
- WaveData.
- StageData.
- DifficultyData.
- AudioCueData.
- BloodProfile.
- CharacterVisualData.

Campos de AttackData:

- Identificador.
- Dano.
- Dano de postura.
- Knockback.
- Hitstop.
- Janela ativa.
- Custo de energia.
- Intensidade de câmera.
- Perfil de sangue.
- Cancelamentos permitidos.
- Animação.
- Som.
- Efeito visual.

### 15.6 Autoloads propostos

| Autoload | Responsabilidade |
|---|---|
| GameManager | Fluxo global e sessão atual |
| SceneRouter | Troca segura de menus e fases |
| SaveManager | Configurações, progresso e recordes |
| AudioManager | Buses, música dinâmica e sons globais |
| EventBus | Eventos globais raros e bem definidos |

O Diretor de Hordas, câmera, HUD e pools pertencem à fase atual, evitando globais desnecessários.

### 15.7 Estrutura de pastas

    res://
    ├── art/
    │   ├── characters/
    │   ├── enemies/
    │   ├── environments/
    │   ├── effects/
    │   └── ui/
    ├── audio/
    │   ├── music/
    │   ├── sfx/
    │   └── narrator/
    ├── data/
    │   ├── attacks/
    │   ├── weapons/
    │   ├── enemies/
    │   ├── waves/
    │   └── stages/
    ├── scenes/
    │   ├── actors/
    │   ├── enemies/
    │   ├── levels/
    │   ├── ui/
    │   └── effects/
    ├── scripts/
    │   ├── autoload/
    │   ├── components/
    │   ├── combat/
    │   ├── ai/
    │   └── systems/
    ├── shaders/
    └── tests/

### 15.8 Input Map inicial

- move_left
- move_right
- jump
- drop_down
- attack_light
- attack_heavy
- weapon_special
- parry
- dash
- execute
- interact
- swap_weapon
- pause

### 15.9 Colisões

Camadas provisórias:

1. Mundo.
2. Jogador.
3. Inimigos.
4. Hurtbox do jogador.
5. Hurtbox dos inimigos.
6. Hitbox do jogador.
7. Hitbox dos inimigos.
8. Projéteis.
9. Interações.
10. Sensores e triggers.

A matriz deve ser documentada no projeto para impedir colisões acidentais.

---

## 16. Resolução e pixel art

### 16.1 Base provisória

- Resolução interna inicial: **640 × 360**, 16:9.
- Escala inteira quando possível.
- Filtro nearest para sprites.
- Pixel snap e configuração de câmera testados em movimento.
- Tamanho do personagem definido depois do primeiro mockup de combate.
- HUD desenhado para continuar legível em escalas menores.

A resolução é provisória e deve ser validada no vertical slice antes de produzir cenários completos.

---

## 17. Salvamento

Dados persistentes:

- Fases desbloqueadas.
- Recordes.
- Notas.
- Configurações.
- Armas desbloqueadas.
- Dificuldade.
- Estatísticas gerais.

O save não deve conter referências diretas frágeis a nós de cena. Usar identificadores estáveis e versionamento de formato.

---

## 18. Escopo do vertical slice

### 18.1 Conteúdo

- 1 protagonista.
- 2 armas: espada e machado.
- 4 inimigos: Carniceiro, Perseguidor, Atirador e Brutamontes.
- 1 elite ou miniboss.
- 1 fase linear completa.
- 1 arena de sobrevivência.
- 1 faixa musical com pelo menos três camadas.
- Narrador com cinco níveis de massacre.
- Sangue residual.
- Tela de resultado.
- Teclado e controle.

### 18.2 Critérios de sucesso

- Movimento responde de forma consistente a 60 FPS.
- O jogador entende os ataques inimigos sem tutorial textual longo.
- Espada e machado exigem decisões diferentes.
- Uma horda de 15 a 20 inimigos permanece jogável no hardware-alvo.
- Sangue e partículas não escondem ameaças importantes.
- Música e narrador respondem ao medidor sem atrasos perceptíveis.
- A fase pode ser concluída do início ao fim.
- Sobrevivência reutiliza os sistemas sem duplicar lógica.

### 18.3 Fora do vertical slice

- As 12 fases completas.
- Sete armas finalizadas.
- Todos os chefes.
- Multiplayer.
- Loja ou monetização.
- Progressão extensa.
- Port para consoles.
- Geração procedural complexa.

---

## 19. Roadmap

### M0 — Pré-produção

- Confirmar câmera, plano de movimento e resolução.
- Criar mockup visual.
- Definir protagonista inicial.
- Produzir sandbox de controle.
- Validar pipeline de sprite modular.

### M1 — Sandbox de combate

- Movimento.
- Hitbox e hurtbox.
- Espada.
- Um inimigo.
- Hitstop, câmera e sangue inicial.
- HUD de depuração.

### M2 — Vertical slice

- Conteúdo definido na seção 18.
- Fase completa.
- Sobrevivência básica.
- Música dinâmica.
- Narrador.
- Performance e opções.

### M3 — Produção da campanha

- Pipeline de fases.
- Novos arquétipos.
- Armas restantes.
- Três atos.
- Chefes.
- Progressão.

### M4 — Polimento

- Balanceamento.
- Acessibilidade.
- Recordes.
- Áudio final.
- Otimização.
- Testes.
- Lançamento.

---

## 20. Riscos

| Risco | Resposta |
|---|---|
| Modularidade deixar animação rígida | Usar sistema híbrido e frames específicos de impacto |
| Sangue prejudicar leitura | Limites, contraste, camadas e opção de redução |
| Hordas derrubarem desempenho | Orçamento, culling, pooling seletivo e profiler |
| Muitas armas multiplicarem trabalho | Validar duas antes de ampliar o arsenal |
| Doze fases cedo demais | Produzir vertical slice completo primeiro |
| Narrador ficar repetitivo | Variações, prioridade e cooldown |
| Combate parecer genérico | Ritmo de Carnificina integrando música, score e apresentação |
| Escopo crescer para multiplayer | Manter single-player como base da versão inicial |

---

## 21. Decisões ainda abertas

- Ambientação: infernal, industrial, ocultista, cyber-demoníaca ou híbrida.
- História e motivação do protagonista.
- Quantidade inicial de protagonistas.
- Arma fixa, inventário ou duas armas simultâneas.
- Plataforma final além de PC.
- Direção do narrador: sério, agressivo, sarcástico ou sobrenatural.
- Presença de progressão permanente.
- Modelo de checkpoints.
- Dificuldades disponíveis.
- Suporte futuro a cooperativo local.

Essas decisões não devem bloquear o protótipo de movimento e combate.

---

## 22. Referências técnicas oficiais

- [CharacterBody2D — Godot Docs](https://docs.godotengine.org/en/stable/classes/class_characterbody2d.html)
- [AnimationTree — Godot Docs](https://docs.godotengine.org/en/stable/classes/class_animationtree.html)
- [TileMapLayer — Godot Docs](https://docs.godotengine.org/en/stable/classes/class_tilemaplayer.html)
- [GPUParticles2D — Godot Docs](https://docs.godotengine.org/en/stable/classes/class_gpuparticles2d.html)
- [Resources — Godot Docs](https://docs.godotengine.org/en/stable/tutorials/scripting/resources.html)

---

## 23. Regra de produção

> Nenhuma fase nova deve ser produzida antes que movimento, uma arma, um inimigo e uma arena pequena sejam divertidos sem depender de arte final.

O vertical slice é o núcleo. As 12 fases são a expansão desse núcleo.
