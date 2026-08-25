# Dysymmetrical Character Model Production Specification

## 1. Purpose

This specification defines the first production asset pack for one original killer and one original survivor. The target is a dark, readable horror style that performs well on mobile devices and fits the current Roblox character and ability framework.

Forsaken may be used as a broad reference for atmosphere, pacing, silhouette contrast, and horror presentation. The final models, textures, animations, icons, sounds, names, and UI must be original or properly licensed. Do not extract or reupload assets from another experience.

## 2. Important distinction: platform limits versus project budgets

Roblox’s general modeling documentation says that an individual mesh must not exceed 20,000 triangles.[1] That is a platform ceiling, not a good target for a mobile multiplayer character. The budgets below are lower project targets intended to leave room for multiple players, maps, effects, UI, and networked gameplay.

Roblox’s standard avatar-body specification lists a 10,742-triangle maximum for the full set of Marketplace body assets.[2] The project should stay below that total for the base body whenever possible, then budget accessories and effects separately. If a model is intended for Marketplace publication, the stricter Marketplace rules must be checked again before upload.

| Category | Roblox or technical ceiling | Dysymmetrical target |
|---|---:|---:|
| One individual mesh | 20,000 triangles maximum for general meshes.[1] | Prefer 1,000–6,000; hard project cap 8,000 per mesh. |
| Survivor base body | Roblox body specification total is 10,742 triangles for the standard body set.[2] | 6,000–8,000 triangles total. |
| Killer base body | Same general body guidance applies.[1] [2] | 8,000–10,000 triangles total. |
| Killer with essential accessories | Project budget | 10,000–12,000 triangles total. |
| Survivor with essential accessories | Project budget | 7,000–9,000 triangles total. |
| Extra cosmetic accessory | Project budget | 300–1,200 triangles each. |
| Small prop attached to a character | Project budget | 100–600 triangles. |
| Character texture atlas | Roblox supports larger textures, but lower sizes reduce memory use.[4] | 1024x1024 maximum for a hero character; 512x512 preferred for mobile. |
| Accessory texture | Project budget | 256x256 or 512x512. |

The triangle figures are render triangles, not polygon counts from a modeling program. The artist must check the triangulated result before export. Keep the final asset below the target rather than treating the hard cap as a goal.

## 3. Shared character requirements

Both characters must be supplied as a clean, playable Roblox character model. The model must contain a `Humanoid`, `HumanoidRootPart`, `Head`, an `Animator` through the normal Humanoid setup, and the body parts or joints expected by the selected rig type. The model should have `HumanoidRootPart` set as its `PrimaryPart` where the framework expects a primary part.

The recommended format is an R15-compatible humanoid rig because Roblox’s standard character and animation workflow is built around the R15 hierarchy.[3] Do not mix R6, R15, and custom bone names in the same character without checking the existing character and animation managers first.

| Requirement | Production rule |
|---|---|
| Rig type | Use one consistent R15-compatible rig for the first killer and survivor. |
| Root | Include a stable `HumanoidRootPart`; keep its pivot and movement behavior consistent with the existing framework. |
| Body hierarchy | Preserve the standard names when using R15: `LowerTorso`, `UpperTorso`, `Head`, upper/lower limbs, hands, and feet.[2] |
| Root orientation | Character faces positive Z and stands in positive Y when exported, matching Roblox’s character guidance.[2] |
| Pose on export | Use a clean I-pose, A-pose, or T-pose. Freeze transforms before export.[1] [2] |
| Skinning | A vertex may use no more than four bone influences; do not weight vertices to the root bone.[1] [2] |
| Geometry | Use closed, clean geometry where possible. Avoid holes, backfaces, zero-thickness surfaces, and unnecessary internal faces.[1] |
| Collision | Use simple invisible collision parts or the existing hitbox system. Do not use the detailed render mesh as the attack collision. |
| Scripts | Do not place gameplay scripts, server logic, or unreviewed modules inside the character model. |
| Parts | Target no more than 10 visible body/accessory MeshParts for the survivor and 14 for the killer. Combine pieces where the material and texture can remain the same. |
| Materials | Target no more than 6 unique visual materials per character, and no more than 8 for the killer. Each mesh object should use one material assignment.[4] |
| Transparency | Avoid layered transparent surfaces. Use opaque geometry for most clothing, masks, armor, and body parts. |
| Shadows | Allow important silhouette pieces to cast shadows; disable shadows on tiny or purely decorative parts when profiling shows a benefit. |
| Render fidelity | Start with `Automatic` or `Performance` on non-hero mesh parts and verify the result in Studio.[5] |

## 4. Survivor model specification

The survivor should be readable at a distance and should look less visually dominant than the killer. Use a compact silhouette, clear head and hands, and clothing shapes that do not hide the body joints. The design should support sprinting, injured states, objective interaction, downed states, revival, and emotes.

| Item | Survivor requirement |
|---|---|
| Base body | 6,000–8,000 triangles total, including the visible body mesh but excluding temporary debug hitboxes. |
| Accessories | 1–3 essential accessories, 300–1,200 triangles each. Avoid long thin pieces that catch on map geometry. |
| Total first-pass target | 7,000–9,000 triangles including essential accessories. |
| Silhouette | Readable head, shoulders, hands, feet, and torso. Avoid excessive dangling geometry. |
| Clothing | Use simple layered shapes or fitted mesh parts. Keep straps, loose cloth, and hair within the body collision volume. |
| Face | A simple original face or mask with an optional separate expression texture. Do not rely on copied portraits. |
| Color | Use one main readable color family and one accent color so the survivor is visible in dark lighting. |
| Interaction visibility | Hands and the front of the torso must remain visible during objective animations. |
| Downed state | The rig must deform or pose safely without feet, hair, or accessories exploding through the floor. |
| Mobile readability | Details should be expressed through silhouette, large color blocks, and limited texture contrast instead of tiny geometry. |

### Survivor animation set

The minimum first-pass survivor animation set is:

| Animation | Requirement |
|---|---|
| Idle | Looping neutral idle with subtle breathing. |
| Walk | Looping walk for normal movement. |
| Run or sprint | Looping faster movement with clear forward lean. |
| Jump, fall, and land | Include only if the current controller uses them. |
| Injured idle and movement | Readable reduction in posture and speed. |
| Downed | Downed pose, crawl or idle loop, and recovery transition if used. |
| Interaction loop | Loop for holding an objective prompt; it must stop cleanly when cancelled. |
| Interaction success | Short completion pose or hand gesture. |
| Revive | Start, looping hold, completion, and cancel transitions if the game supports reviving. |
| Ability start and end | One pair for each survivor ability. |
| Stun or hit reaction | Short reaction that does not lock the rig permanently. |
| Death or elimination | A clear end pose or animation. |
| Emotes | Only original emotes that match the character and are approved for the game. |

## 5. Killer model specification

The killer needs a strong silhouette and should remain readable during chase scenes, ability effects, fog, and dark lighting. The design may be more detailed than the survivor, but the model must not use detail as a substitute for readable gameplay feedback.

| Item | Killer requirement |
|---|---|
| Base body | 8,000–10,000 triangles total. |
| Essential accessories | 1–4 accessories, 300–1,500 triangles each. |
| Total first-pass target | 10,000–12,000 triangles including essential accessories. |
| Proportion | Prefer no more than 1.15 times the survivor’s height until hitbox and camera behavior are tested. |
| Silhouette | The head, shoulders, arms, and attack tool must remain clear against the map. |
| Attack tool | Keep the weapon or hand effect within a predictable area so hitboxes remain fair. |
| Ability markers | Teleport points, warning shapes, trails, and other ability effects should be separate assets from the body. |
| Face or mask | Use an original shape or texture with a strong value contrast. Avoid copied masks, logos, or character likenesses. |
| Cloth and chains | Keep loose parts short, low-cost, and away from movement-critical joints. |
| Lighting response | Test the model under the planned dark lighting; black-on-black materials are not acceptable if players cannot identify the killer. |

### Killer animation set

The minimum first-pass killer animation set is:

| Animation | Requirement |
|---|---|
| Idle | Looping threatening idle with controlled movement. |
| Walk and chase run | Distinct movement loops with readable acceleration feel. |
| Basic attack | Windup, active hit moment, and recovery. The damage window must match the code. |
| Attack miss | Optional separate miss recovery if the framework supports it. |
| Ability activation | One start animation for each ability. |
| Ability active or loop | Required for abilities that last longer than one frame. |
| Ability end or recovery | Clean return to movement without leaving the rig locked. |
| Data Anchor placement | Pose or animation for placing the anchor. |
| Data Anchor teleport | Start and arrival animation or effect timing that matches the server action. |
| Callback Ping | Start and end states that match the movement-speed change. |
| Stun or hit reaction | Clear but short reaction. |
| Death or elimination | End-round pose or animation. |
| Intro | Optional cinematic or UI intro using original camera, animation, and sound assets. |

## 6. Textures and materials

Use a small number of shared materials and atlases so repeated assets can batch more effectively. Roblox supports basic textures and PBR textures, but PBR should be used selectively for hero surfaces rather than every small detail.[4] Roblox’s guidance also notes that duplicate textures and excessive transparency can hurt rendering performance.[5]

| Map | Recommended size | Use |
|---|---:|---|
| Survivor albedo | 512x512 preferred; 1024x1024 maximum for the first hero survivor | Main body and clothing. |
| Killer albedo | 512x512 preferred; 1024x1024 maximum | Main body, mask, clothing, and essential props. |
| Normal map | Same atlas size as the albedo only when it improves the hero asset | Large folds, mask relief, or important surface shape. |
| Roughness/metalness | Grayscale, packed or separated according to the chosen pipeline | Only on metal, wet, glossy, or highly important surfaces. |
| Emissive mask | 256x256 or 512x512 unless the effect is a hero feature | Eyes, markings, device lights, or ability surfaces. |
| Small accessory | 256x256 | Simple hat, pouch, tool, or small prop. |

Keep UVs in a single 0:1 space for each component and avoid tiny islands that cannot be seen at gameplay distance.[4] Use texture contrast to support role readability: survivors should not disappear into the map, and the killer should not blend into the chase environment.

## 7. Hitbox and attachment specification

The render model and gameplay collision must be separate. The final character package should include or support the project’s existing hitbox system without using high-detail geometry for every attack check.

| Component | Rule |
|---|---|
| Character root | One stable root aligned with `HumanoidRootPart`. |
| Body collision | Simple torso, head, limb, or capsule-like regions as required by the existing hitbox code. |
| Attack hitbox | Server-controlled and created by the ability or hitbox system, not by client-supplied parts. |
| Ability attachments | Add named attachments only where the ability code needs them, such as hand, head, torso, or root positions. |
| Tool grip | Place grip attachments so equipped items do not rotate into the body. |
| Teleport marker | Keep Data Anchor visual placement separate from the character’s collision. |
| Debug mode | Include a Studio-only way to show hitboxes, then disable it for release. |

## 8. File and naming handoff

The artist should deliver both the Roblox-importable model and a small asset manifest. The first character package should map to the existing source layout:

```text
src/ServerStorage/Assets/Characters/Killer/<KillerName>.rbxm
src/ServerStorage/Assets/Characters/Survivor/<SurvivorName>.rbxm
src/ServerStorage/Assets/Hitboxes/<KillerName>.model.json or Roblox model
src/ReplicatedStorage/Characters/Killers/<KillerName>.luau
src/ReplicatedStorage/Characters/Survivors/<SurvivorName>.luau
src/ReplicatedStorage/Assets/KillerIntros/<KillerName>.luau
```

The exact filenames must match the existing character lookup code. Do not rename existing module contracts only to fit an asset filename. Every animation and sound reference in the character module must point to a real asset ID owned by the project account or group.

Each handoff should include:

| Deliverable | Required information |
|---|---|
| Model file | `.fbx`, `.obj`, or Roblox model as appropriate, plus import notes. |
| Rig file | Skeleton naming, rig type, scale, and export pose. |
| Texture files | Albedo and any PBR maps with dimensions and file format. |
| Animation list | Name, purpose, loop setting, priority, and Roblox asset ID after upload. |
| Sound list | Name, purpose, length, and Roblox asset ID after upload. |
| Triangle report | Total and per-mesh triangle counts from the triangulated export. |
| License record | Creator, source, license or permission, upload owner, and intended use. |
| Preview sheet | Front, side, back, neutral pose, and in-game lighting screenshots. |

## 9. Studio acceptance tests

A model is not accepted only because it imports. It must pass the following tests in Roblox Studio on the real project:

| Status | Test |
|---|---|
| [ ] | Model imports without warnings that affect geometry, rigging, or textures. |
| [ ] | Rojo build or place import includes the model in the expected folder. |
| [ ] | The model has the required Humanoid and HumanoidRootPart. |
| [ ] | The model spawns at the correct map spawn point. |
| [ ] | Walk, run, sprint, jump/fall, and idle animations work without broken joints. |
| [ ] | The survivor can hold an objective prompt without the interaction animation breaking. |
| [ ] | The killer can use Data Anchor twice without a stuck pose or movement lock. |
| [ ] | Every ability animation returns control to the character after success, failure, stun, or cancellation. |
| [ ] | Hitboxes match the visible body closely enough for fair gameplay. |
| [ ] | No accessory blocks the camera, objective prompt, or attack feedback. |
| [ ] | The character remains readable under the planned gloomy lighting. |
| [ ] | Mobile device emulation keeps the model visually stable and responsive. |
| [ ] | Render Stats, MicroProfiler, or equivalent profiling shows no unacceptable spike from the character. |
| [ ] | No copied Forsaken asset, name, logo, animation, sound, or texture remains in the package. |

## 10. Recommended first asset pack

To get the first playable build working quickly, create only one original survivor, one original killer, one shared rig style, one objective interaction animation, one basic attack animation, and the animations required by Data Anchor and Callback Ping. Use simple original placeholder textures first, then improve the materials and accessories after the round loop is stable.

Do not begin with multiple skins or elaborate cinematic intros. The first pass should prove that role assignment, movement, abilities, objectives, chase flow, and round endings work with real models. Additional cosmetics can use the same rig and texture conventions later.

## References

[1]: https://create.roblox.com/docs/art/modeling/specifications "Roblox Creator Hub — General mesh specifications"
[2]: https://create.roblox.com/docs/avatar/character-bodies/specifications "Roblox Creator Hub — Character body specifications"
[3]: https://create.roblox.com/docs/art/modeling/rigging "Roblox Creator Hub — Rigging and skinning"
[4]: https://create.roblox.com/docs/art/modeling/texture-specifications "Roblox Creator Hub — Texture specifications"
[5]: https://create.roblox.com/docs/performance-optimization/improve "Roblox Creator Hub — Improve performance"
