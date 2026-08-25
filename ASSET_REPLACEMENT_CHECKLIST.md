# Dysymmetrical Asset Replacement Checklist

## Purpose

This checklist covers the assets needed to make the current Roblox asymmetric-horror project playable and presentable. It is based on the repository structure and the placeholder folders currently present in the fork.

Forsaken can be used as a high-level reference for mood, pacing, camera language, and genre conventions. Do not copy, extract, reupload, or modify Forsaken-only assets. Every replacement should be newly created, purchased with a clear commercial license, or taken from a source whose license explicitly allows use in this Roblox game.

## Priority key

| Priority | Meaning |
|---|---|
| P0 — Required to test | The game may fail to start, spawn players, or run a round without it. |
| P1 — Required for a playable first build | The main round can run, but the experience is incomplete without it. |
| P2 — Strong polish | Improves clarity, atmosphere, and retention but can wait until the core loop works. |
| P3 — Later content | Extra variety for future updates. |

## P0: Required for a working round

| Status | Asset group | What must be created or replaced | Expected project location | Acceptance check |
|---|---|---|---|---|
| [ ] | Map | At least one complete map model with a `Map` container, playable geometry, collision, lighting support, and safe boundaries. | `ServerStorage/Maps/` | A round can clone the map without errors and remove it cleanly at round end. |
| [ ] | Map spawn folders | A `SpawnPoints` folder with at least one layout containing a killer spawn and enough survivor spawns. | Inside the map’s `Map` container | All assigned players appear inside the map and not inside walls, void space, or the lobby. |
| [ ] | Map runtime folders | `InGame`, `Items`, and `PermAbilities` folders if the existing managers expect them. | Inside the map’s `Map` container | Map setup and cleanup complete without missing-folder errors. |
| [ ] | Killer rig | A usable killer character model with a `Humanoid`, `HumanoidRootPart`, body parts, proper rig type, and required character attributes. | `ServerStorage/Assets/Characters/Killer/` | The killer spawns, moves, animates, uses abilities, and can be removed at round end. |
| [ ] | Survivor rig | A usable survivor character model with a `Humanoid`, `HumanoidRootPart`, body parts, proper rig type, and required character attributes. | `ServerStorage/Assets/Characters/Survivor/` | Survivors spawn, move, interact with objectives, take damage, and respawn or return to the lobby safely. |
| [ ] | Hitbox setup | Killer and survivor hitbox models or parts, using the project’s expected names and layout. | `ServerStorage/Assets/Hitboxes/` | Attacks and ability hit checks detect the correct targets without hitting through the map. |
| [ ] | Character module match | Each playable character module must point to a real model and valid animation/ability data. | `ReplicatedStorage/Characters/Killers/` and `ReplicatedStorage/Characters/Survivors/` | Selecting the character does not produce missing-model or missing-animation errors. |
| [ ] | Server spawn support | Any required folders, attachments, spawn markers, or attributes used by `ServerCharacterManager`. | Map and character assets | Role assignment and character setup finish without a server error. |

## P1: Required for the first playable build

### Killer assets

| Status | Asset | Details |
|---|---|---|
| [ ] | Killer base model | Original silhouette, materials, face, accessories, and readable attack posture. Keep the design distinct from Forsaken characters. |
| [ ] | Killer ability effects | Original visual effects for each ability: trails, impact flashes, teleport markers, warning indicators, or other required feedback. |
| [ ] | Killer ability animations | Idle, walk, run, attack, ability start, ability end, stun, hurt, and death animations as needed by the character module. |
| [ ] | Killer ability sounds | Attack, ability activation, teleport, cooldown-ready, hit, miss, stun, and end-round sounds. Use original sounds or properly licensed sound effects. |
| [ ] | Killer hit feedback | A clear effect when an attack or ability successfully affects a survivor. |
| [ ] | Killer intro assets | A short original intro animation or UI presentation plus a name card. The current project has killer-intro hooks and a Nullex Voyd intro module, so all referenced models, cameras, animations, and sounds must exist. |
| [ ] | Killer portrait/icon | A small original icon for selection screens, shop screens, HUD, and end screens. |

### Survivor assets

| Status | Asset | Details |
|---|---|---|
| [ ] | Survivor base model | Original survivor rig or a properly licensed compatible rig. It must work with the project’s movement and animation code. |
| [ ] | Survivor animation set | Idle, walk, run, sprint, jump/fall if used, injured, downed, revived, stunned, interaction, emote, and death animations. |
| [ ] | Survivor interaction animation | A loop for repairing or completing an objective, including a clean stop when the prompt is cancelled. |
| [ ] | Survivor ability animations | Start, active, success, failure, and recovery animations for every survivor ability in use. |
| [ ] | Survivor ability effects | Original effects for healing, shielding, revealing, escaping, stunning, or other ability actions. |
| [ ] | Survivor sounds | Footsteps, injured breathing, interaction loop, ability sounds, damage, downed, revive, and escape sounds. |
| [ ] | Survivor portraits/icons | Original icons for loadouts, selection, HUD, scoreboard, and end screens. |

### Objective assets

| Status | Asset | Details |
|---|---|---|
| [ ] | Objective model | One or more original map objects that survivors can complete, such as a console, generator-like machine, radio, ritual device, or signal terminal. Do not copy Forsaken’s models or names. |
| [ ] | Objective prompt anchor | Each objective must be a `BasePart`, `Model`, or `Attachment` tagged `DysObjective`, with an optional `ObjectivePrompt` child. |
| [ ] | Objective states | Unfinished, active, completed, disabled, and round-reset visual states. |
| [ ] | Objective effects | Sparks, lights, particles, screen indicators, or other feedback when progress begins and when the objective completes. |
| [ ] | Objective audio | Interaction loop, progress ticks, completion sound, and optional killer alert sound. |
| [ ] | Objective placement | Several safe locations on the map with enough distance from spawns and sensible sight-line balance. |
| [ ] | Objective testing markers | Temporary Studio-only markers showing tag, prompt, and completion state while testing. Remove or hide them before release. |

## P1: UI and presentation assets

The project already contains UI systems for settings, inventory, shop, emotes, abilities, hitmarkers, player lists, intros, and other screens. The following replacements should be original and should not reuse Forsaken layouts, logos, icons, fonts, or copied screenshots.

| Status | UI area | Required replacement or polish |
|---|---|---|
| [ ] | Lobby screen | Title treatment, queue state, player count, start state, and readable background. |
| [ ] | Role reveal | Killer/survivor reveal panel, role icon, short transition, and accessible text. |
| [ ] | Round HUD | Timer, objective progress, ability slots, stamina or health state, and team information where appropriate. |
| [ ] | Objective HUD | Total objectives, completed count, current interaction state, and survivor-friendly feedback. |
| [ ] | Ability HUD | Icons, key prompts, cooldown state, unavailable state, charges, and clear error feedback. |
| [ ] | End screen | Killer win, survivor win, draw or cancelled-round state, rewards, and return-to-lobby control. |
| [ ] | Inventory | Original item, character, skin, and emote icons with clear locked/equipped states. |
| [ ] | Shop | Original item cards, purchase state, ownership state, price display, and confirmation feedback. |
| [ ] | Settings | Consistent background, sliders, toggles, text labels, and safe mobile scaling. |
| [ ] | Emote panel | Original emote icons and previews. Avoid copied emote thumbnails or dances. |
| [ ] | Notifications | Damage, objective completion, ability failure, round transition, and system messages. |
| [ ] | Typography | A readable font set with a license that allows use in the game. Keep the gloomy style through weight, spacing, and color rather than copying another game’s exact treatment. |
| [ ] | Icons | Original or properly licensed icons for abilities, objectives, settings, roles, items, and menus. |

## P2: Atmosphere and world-building

| Status | Asset group | Recommended additions |
|---|---|---|
| [ ] | Map dressing | Original props such as doors, fences, cables, crates, signs, lamps, machinery, debris, vegetation, and cover objects. |
| [ ] | Lighting | Dark, readable lighting with a clear survivor path, controlled shadows, fog, color correction, and safe visibility around objectives. |
| [ ] | Sky and environment | Original skybox or a properly licensed environment, plus distant silhouettes or fog cards if needed. |
| [ ] | Ambient audio | Wind, machinery, distant impacts, room tone, radio noise, and other non-intrusive loops. |
| [ ] | Chase audio | Original chase music or licensed tracks with clear start, escalation, and stop behavior. |
| [ ] | Stingers | Round start, killer reveal, objective completion, last survivor, escape, victory, and defeat stingers. |
| [ ] | Camera effects | Original or built-in effects for damage, terror/chase state, teleport, stun, and round transitions. Keep them readable and provide a low-effects option if possible. |
| [ ] | Decals and signs | Original warning labels, map signs, objective labels, and environmental storytelling. |
| [ ] | Performance pass | Low-cost collision, sensible part counts, limited particle emitters, and streaming-safe layout. |

## P2: Emotes, items, and progression

The repository includes item and emote hooks, including Cola, Medkit, a TPose emote, and shop/inventory systems. These should be reviewed before release.

| Status | Asset | Details |
|---|---|---|
| [ ] | Cola model/icon | Original 3D model, icon, use animation, sound, and effect. |
| [ ] | Medkit model/icon | Original 3D model, icon, use animation, sound, and healing effect. |
| [ ] | Emote set | Original idle, gesture, or movement emotes with thumbnails and animation IDs owned by the project. |
| [ ] | Item animations | Pickup, equip, use, cancel, and drop animations where the code expects them. |
| [ ] | Item sounds | Pickup, equip, use, success, failure, and drop sounds. |
| [ ] | Achievement icons | Original icons for any achievements referenced by `ReplicatedStorage/Assets/Achievements.luau`. |
| [ ] | Reward visuals | Original currency, XP, level-up, and reward presentation assets if progression is enabled. |

## P3: Future content pack

These items are not required for the first playable test, but they will make the game feel like a complete product rather than a single prototype.

| Status | Future content |
|---|---|
| [ ] | Additional killer with a separate model, ability effects, ability animations, sounds, portrait, and intro. |
| [ ] | Additional survivor with a separate model, ability effects, animations, sounds, and portrait. |
| [ ] | Second and third maps with different objective layouts and chase routes. |
| [ ] | Character skins that use the correct killer/survivor ownership path and do not mix role assets. |
| [ ] | Map-specific objective variants. |
| [ ] | Alternate lobby and end-screen themes. |
| [ ] | More licensed or original music and ambient sound variations. |
| [ ] | Spectator, replay, or post-round presentation assets if those systems are added. |

## Asset ownership and licensing record

Every uploaded asset should have a small record before it enters the place. Keep the record outside the player-facing UI and include enough information to prove that the project can use the asset.

| Field | Example value |
|---|---|
| Asset name | Original survivor injured animation |
| Creator | Team member or vendor name |
| Source | Original work, Roblox Creator Store, commissioned work, or licensed library |
| License | Original ownership, commercial license, or exact marketplace terms |
| Roblox asset ID | Add after upload |
| Upload owner | Personal account or group account |
| Permission evidence | Contract, receipt, license URL, or written permission |
| In-game use | Survivor injured state |
| Replacement needed? | Yes/No |

Do not use an asset when its creator, license, or upload permission is unclear. Do not assume that an asset being visible in a Roblox game makes it legal to extract or reuse.

## Studio acceptance checklist

Before calling the first build playable, test the following on a Windows or Mac computer in Roblox Studio:

| Status | Test |
|---|---|
| [ ] | Rojo sync or place import completes without missing required instances. |
| [ ] | Server starts with no red errors in Output. |
| [ ] | Lobby loads and waits correctly for enough players. |
| [ ] | A valid map loads and is removed cleanly after the round. |
| [ ] | Killer and survivor characters spawn at valid locations. |
| [ ] | Every character model has a working Humanoid and HumanoidRootPart. |
| [ ] | Data Anchor placement and second-use teleport work. |
| [ ] | Callback Ping finishes without leaving the killer permanently slowed. |
| [ ] | Killer and survivor abilities play their animations and effects. |
| [ ] | Invalid ability or emote requests do not create server errors. |
| [ ] | Survivors can complete a tagged objective and the objective disables afterward. |
| [ ] | Completing all active objectives ends the round for survivors. |
| [ ] | The timer ends the round correctly when objectives are not completed. |
| [ ] | Killer death and survivor elimination paths end or continue the round correctly. |
| [ ] | The end screen appears and the next lobby state resets map, objectives, prompts, and players. |
| [ ] | No copied Forsaken assets, names, logos, UI screenshots, or sounds remain in the release build. |

## Recommended order

First create one simple original map, one killer rig, one survivor rig, and the hitbox setup. Then test the existing role and round flow before adding more content. Next add the objective models and verify the objective loop. After that, replace the minimum HUD and role screens, then add ability animations, sounds, and atmosphere. Only once this first vertical slice works should additional characters, skins, maps, and cosmetic polish be added.

## Repository references

- [Dysymmetrical repository](https://github.com/mrphatom/Dysymmetrical)
- [Roblox ProximityPrompt documentation](https://create.roblox.com/docs/ui/proximity-prompts)
- [Roblox client-server security guidance](https://create.roblox.com/docs/scripting/security/client-server-boundary)
