# BLOOD SLASHER HARDCORE

Hack and slash 2D lateral, criado na Godot Engine 4 e planejado primeiro como uma demo Web.

> Avance. Corte. Não interrompa o massacre.

## Estado atual

O **Milestone 0 — Bootstrap** está implementado:

- projeto Godot 4 com renderer Compatibility;
- resolução interna de 640 × 360;
- Input Map para teclado e controle;
- estrutura inicial de diretórios;
- fluxo automático `Boot → MainMenu`;
- Autoloads mínimos (`GameState`, `SceneRouter`, `AudioManager`, `SaveManager`);
- preset Web single-threaded, sem PWA;
- menu provisório navegável por teclado, controle e mouse.

Validação realizada com **Godot 4.7.2**: o projeto inicia sem erros e o preset Web gera corretamente `index.html`, JavaScript, PCK e WASM em `export/web/`.

O código ainda não contém gameplay. A visão completa está no [GDD](GDD.md), e o escopo executável da demo está em [DEMO_WEB_MVP.md](DEMO_WEB_MVP.md).

## Como executar

1. Abra `project.godot` na Godot Engine 4.
2. Execute o projeto com `F6`/`F5`.
3. Para gerar a versão Web, instale os templates de exportação e use o preset **Web**.

Pela linha de comando, com a Godot disponível no `PATH`:

```sh
godot --path . --editor
godot --headless --path . --export-release Web export/web/index.html
```

## Próximo passo

Iniciar o **Milestone 1 — Fluxo completo com placeholders**, acrescentando Intro, Stage01 vazia, Results e CTA.
