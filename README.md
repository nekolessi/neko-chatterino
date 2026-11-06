# neko's chatterino ♡

![Neko's Chatterino icon](./resources/icon.ico)

> chatterino but i touched it. many times. with a compiler open

neko's chatterino is my personal fork of [Chatterino Homies](https://github.com/itzAlex/chatterino7), updated with the changes from [Chatterino 2.5.6](https://github.com/Chatterino/chatterino2/releases/tag/v2.5.6).

it keeps the extra homies features, adds a portable windows build, and behaves nicely in the system tray because closing an app and _actually closing it_ are apparently two completely different emotional commitments.

## download her

pick whichever windows-shaped object feels right:

- **[portable ZIP (64-bit)](https://github.com/nekolessi/neko-chatterino/releases/download/v2.5.6-neko.1/NekoChatterino-2.5.6-portable-windows-x64.zip)** — unzip it somewhere and carry it around like a little purse
- **[windows installer (64-bit)](https://github.com/nekolessi/neko-chatterino/releases/download/v2.5.6-neko.1/NekoChatterino-2.5.6-installer-windows-x64.exe)** — clicky clicky next next finish

[release notes + SHA-256 checksums live over here](https://github.com/nekolessi/neko-chatterino/releases/tag/v2.5.6-neko.1)

for the portable version, extract the ZIP, open the `Chatterino2` folder, and run `chatterino.exe`. for the installer version u can probably guess. i believe in you

> [!WARNING]
> neko's chatterino is currently unsigned. windows Smart App Control or an organization policy might block it because the computer does not know me and frankly has trust issues. only download builds from this repository.

## what did i do to it

- dragged it through Chatterino 2.5.5 and 2.5.6 without anyone dying
- kept the Chatterino Homies 7.5.2H1 feature set
- gave it custom neko's chatterino branding + version info
- made the **X** button minimize the app to the system tray
- click the tray icon to restore it; right-click and choose **Exit** to actually leave
- correctly restores maximized windows (small miracle)
- portable build keeps its settings next to the app where i can see them
- disabled unsupported automatic update checks so they stop lying for attention
- includes homies integrations and enhancements for 7TV, BetterTTV, FrankerFaceZ, and friends

## photographic evidence

![Example of global emotes](./resources/readme/global_emotes.png)

![Example of personal badges](./resources/readme/badges.png)

## the tray situation

pressing the **X** does not kill the app. it hides neko's chatterino in the notification area so it can lurk there quietly.

- click the neko's chatterino tray icon to bring the window back
- right-click the icon and choose **Exit** when u actually want it gone
- if you forget this and wonder where it went: same. check the little `^` in the windows taskbar

## something broke :(

if it is specifically a neko's chatterino problem, toss it into [this repo's issue tracker](https://github.com/nekolessi/neko-chatterino/issues) with enough information for me to reenact the tragedy.

if the same thing happens in regular chatterino, report it to the [upstream Chatterino issue tracker](https://github.com/Chatterino/chatterino2/issues) instead.

helpful things to include:

- what u expected
- what actually happened
- how to make it happen again
- windows version
- screenshots/logs if the machine left any clues

## building it yourself (brave)

the current neko work lives on [`upgrade/chatterino-2.5.6`](https://github.com/nekolessi/neko-chatterino/tree/upgrade/chatterino-2.5.6).

```shell
git clone --recurse-submodules --branch upgrade/chatterino-2.5.6 https://github.com/nekolessi/neko-chatterino.git
```

then see [Building on Windows](./BUILDING_ON_WINDOWS.md) for the upstream build instructions. there are submodules. there is Qt. there are consequences

## thank u to the people who did the really scary parts

neko's chatterino stands on the shoulders of:

- [Chatterino](https://github.com/Chatterino/chatterino2), the Twitch chat client underneath all of this
- [Chatterino Homies](https://github.com/itzAlex/chatterino7), which provides the homies feature set used by this fork

this is an independent community fork—not an official Chatterino or Chatterino Homies release. everything remains available under the licenses included in this repository.

ok bye
