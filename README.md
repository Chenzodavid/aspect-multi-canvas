# Aspect Multi-Canvas for OBS Studio

A fork by [Chenzo David](https://chenzodavid.com) adding **multiple simultaneous canvases at any aspect ratio** — run your main 16:9 canvas plus 1:1 Square, 4:5 Portrait, 9:16 Vertical, or any custom resolution at the same time, each with its own scenes, stream destinations, and recordings.

- Tools menu → **Add Aspect Canvas** — pick a preset ratio or type a custom width x height
- Tools menu → **Remove Aspect Canvas** — remove an extra canvas
- Each canvas streams and records independently and is saved across OBS restarts
- Each canvas must have a unique resolution

Fork home: https://chenzodavid.com

# Credit and license

Based on [Vertical Canvas](https://github.com/Aitum/obs-vertical-canvas) by [Aitum](https://aitum.tv), which provides the entire canvas engine this fork builds on. Licensed under the GPL (see [LICENSE](LICENSE)); this fork remains GPL — if you share the plugin, share this source with it.

# Build

- Stand-alone build (Windows)
    - Install Visual Studio 2022 Build Tools (C++ workload) and CMake
    - `cmake --preset windows-x64 && cmake --build --preset windows-x64`
    - Output: `build_x64/RelWithDebInfo/vertical-canvas.dll`
- See the [original project](https://github.com/Aitum/obs-vertical-canvas) for other platforms

# Translations
Please read [Translations](TRANSLATIONS.md)
