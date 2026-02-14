<video src="https://github.com/HazAT/pi-ghostty/raw/master/assets/demo.mp4" autoplay loop muted playsinline width="100%"></video>

# pi-ghostty

A [Pi](https://github.com/badlogic/pi) extension that brings Ghostty's native terminal features to life while you work. See at a glance what Pi is doing — which model is active, what tool is running, and whether things succeeded or failed.

## Features

**Dynamic window title** — Shows your project directory and current model at a glance. Session name is included when set:
```
π my-project · claude-sonnet-4
π my-project · my-session · claude-sonnet-4
```

**Animated spinner** — A braille spinner animates in the title bar while the agent is working, so you know Pi is thinking even when the tab is in the background:
```
⠹ π my-project · claude-sonnet-4
```

**Tool tracking** — When a tool executes, the title swaps the model name for the active tool so you can see exactly what Pi is doing:
```
⠹ π my-project · bash
⠹ π my-project · read
⠹ π my-project · edit
```

**Native progress bar** — Uses Ghostty's built-in OSC 9;4 progress indicator:
- 🔵 **Indeterminate pulse** while the agent is thinking or running tools
- 🟢 **Green completion flash** (100%) when the agent finishes successfully
- 🔴 **Red error bar** when a tool execution fails (visible for 3 seconds)

## Requirements

- [Ghostty](https://ghostty.org) 1.2+ (for native progress bar support)
- [Pi](https://github.com/badlogic/pi) coding agent

## Install

```bash
pi install git:github.com/HazAT/pi-ghostty
```

Or try it without installing:

```bash
pi -e git:github.com/HazAT/pi-ghostty
```

## How it works

The extension hooks into Pi's lifecycle events and writes [OSC escape sequences](https://ghostty.org/docs/vt) directly to `/dev/tty`, bypassing Pi's TUI to avoid any rendering interference.

| Pi Event | Title | Progress Bar |
|----------|-------|-------------|
| `session_start` | Set initial title | — |
| `model_select` | Update model name | — |
| `agent_start` | Start spinner | Indeterminate pulse |
| `tool_execution_start` | Show tool name | — |
| `tool_execution_end` (error) | — | Mark error |
| `agent_end` (success) | Stop spinner | Green 100% → clear |
| `agent_end` (error) | Show "error" | Red bar → clear (3s) |
| `session_shutdown` | — | Clear |

## License

MIT
