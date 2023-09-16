# CraftOS-PC Tweaks

Quality of live tweaks for [craftos-pc] headless. \
Tweaks:

- Color Output
  - TODO: Phoenix Support (because why not)
- Disable word wrapping
  - TODO: Phoenix Support (because why not)
- TODO: Unicode mapping

Individual tweaks can currently be disabled by removing their lua script inside [./lua](./lua/).
**Disabling some tweaks might break something because they are made to work together.**
TODO: maybe allow disabling tweaks using CraftOS' [settings] API.

TODO: craftos-pc-tweaks as CCEmuX CraftOS-PC plugin ?

## Usage

<details open>

  <summary>The tweaks can be applied by adding the following arguments after the craftos command:</summary>

### Enable headless renderer mode

```bash
--headless
```

_Outputs only text straight to stdout_

### Enable single window mode

```bash
--single
```

_Forces all screen output to a single window_

### Mount your root file system

```bash
--mount-ro /=./src
```

_Change the path (`./src`) accordingly._

### Apply tweaks

```bash
--mount-ro /rom/autorun=./lua
```

_Change the path (`./lua`) accordingly._

</details>

### GUI applications / Data folder

Don't try to load any GUI applications, it won't work!
You might want to change your data folder or your computer ID in order to not load anything you don't want to load.

You could use `--id <id>` to change the computer you're using, or `--directory <dir>` in order to change the directory where [craftos-pc] stores files.

### Example

```bash
craftos --id 42 --headless --single --mount-ro /=./src --mount-ro /rom/autorun=./lua
```

#### Output

```bash
CraftOS 1.8
Hello, world!
```

## CraftOS settings

**It is important to set the setting `bios.use_multishell` to `false` in order to ensure proper logging.** Additionally, setting `motd.enable` to `false` is recommended, although not necessary. Disabling the MOTD will reduce the number of messages displayed during startup.

Here is an example of how to properly configure the [settings] file:

```conf
{
    ["motd.enable"] = false,
    ["bios.use_multishell"] = false
}
```

[craftos-pc]: https://github.com/MCJack123/craftos2
[settings]: https://tweaked.cc/module/settings.html
