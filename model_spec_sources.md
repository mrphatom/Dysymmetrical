# Roblox Model Specification Research Notes

## Official sources checked

- https://create.roblox.com/docs/art/modeling/specifications
- https://create.roblox.com/docs/avatar/character-bodies/specifications
- https://create.roblox.com/docs/art/modeling/rigging
- https://create.roblox.com/docs/art/modeling/texture-specifications
- https://create.roblox.com/docs/performance-optimization/improve
- https://create.roblox.com/docs/tutorials/curriculums/environmental-art/optimize-your-experience
- https://create.roblox.com/docs/tutorials/use-case-tutorials/animation/create-an-animation

## Verified platform constraints

Roblox's general mesh guidance says an individual mesh must not exceed 20,000 triangles. Geometry should be watertight, use quads where possible, and avoid zero-thickness geometry and backfaces. Generic rigged meshes should freeze transforms, use a root at zero, and keep each vertex influenced by no more than four bones.

Roblox's standard avatar-body specification is stricter when building Marketplace-style R15 body assets: the body is split into 15 named mesh objects, the total body triangle maximum is 10,742 triangles, and the listed body parts have individual limits. A game character does not automatically need to be uploaded as a Marketplace body, so this document uses those limits as a safe ceiling and sets lower game-specific budgets for mobile performance.

Roblox's texture guidance supports PNG, JPG, TGA, and BMP uploads. Roblox supports high resolutions, but its guidance recommends 256x256 for small objects, 512x512 for medium objects, and 1024x1024 for larger objects. Each mesh object supports one material assignment, and PBR maps use albedo, normal, roughness, metalness, and optional emissive masks.

Roblox's performance guidance identifies triangle count, unique meshes, draw calls, transparent overdraw, shadow casting, precise collision fidelity, too many model parts, and unnecessary avatar hierarchy changes as common performance costs. Reusing identical meshes and textures, using Automatic or Performance render fidelity, reducing shadow casting on appropriate parts, and using simple custom collision geometry are recommended mitigation strategies.

Roblox's animation guidance requires a rig with joints or bones, and published animations receive asset IDs for use in scripts. The project should therefore receive a rigged character plus a named animation list and uploaded IDs, not only an unrigged mesh.

## Project-specific context

The repository contains placeholder folders for killer models, survivor models, skins, hitboxes, emotes, and killer intros. The existing code expects Humanoids, HumanoidRootParts, character modules, animation data, sound IDs, hitbox support, and map spawn folders. The first asset pack should target one killer and one survivor, then expand only after the first round is playable.
