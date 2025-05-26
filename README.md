# Dotfiles para entorno Windows

Este repositorio contiene la configuración personal que uso en mi entorno de Windows.

## Requisitos

Antes de empezar, asegúrate de tener instalado:

- [Git](https://git-scm.com/)
- [PowerShell 7](https://learn.microsoft.com/en-us/powershell/)
- [Windows Terminal](https://aka.ms/terminal)
- [Chocolatey](https://chocolatey.org/) (gestor de paquetes principal junto con winget)
- [Scoop](https://scoop.sh/) (opcional, para instalar algunas utilidades como [ouch](https://github.com/ouch-org/ouch?tab=readme-ov-file#installation))

## Instalación

### 1. Clona el repositorio como *bare*

```powershell
git clone --bare https://github.com/jpenedou/dotfileswin.git $HOME\.dotfiles
```

### 2. Define un alias para usar el repositorio

Puedes añadir esto a tu perfil de PowerShell (`$PROFILE`):

```powershell
function dotfiles {
    param([string[]]$Args)
    git --git-dir=$HOME\.dotfiles --work-tree=$HOME @Args
}
```

O simplemente usarlo temporalmente así:

```powershell
function dotfiles { git --git-dir=$HOME\.dotfiles --work-tree=$HOME @args }
```

### 3. Oculta los archivos no rastreados que puedan interferir

```powershell
dotfiles config --local status.showUntrackedFiles no
```

### 4. Extrae los archivos del repositorio en tu `$HOME`

**Importante:** si tienes archivos que podrían entrar en conflicto (como `.gitconfig`, `.profile`, etc.), haz una copia de seguridad antes de continuar.

```powershell
dotfiles checkout
```

Si da errores por archivos ya existentes, muévelos o elimínalos antes de reintentar. Si estás seguro puedes usar -f para forzar el checkout.

## 🧰 Herramientas

| Herramienta              | Descripción                                                                                         |
|--------------------------|-----------------------------------------------------------------------------------------------------|
| [**Windows Terminal**](https://aka.ms/terminal) | Terminal moderna con pestañas y perfiles personalizables                          |
| [**WezTerm**](https://wezfurlong.org/wezterm/)        | Emulador de terminal GPU-accelerated, altamente configurable                         |
| [**PowerShell**](https://learn.microsoft.com/en-us/powershell/) | Shell moderna para automatización y scripting en Windows                   |
| [**LazyVim**](https://lazyvim.github.io/)             | Distribución de Neovim enfocada en productividad                                       |
| [**Visual Studio Code**](https://code.visualstudio.com/) | Editor de código fuente ligero con extensiones y depuración                       |
| [**Yazi**](https://yazi-rs.github.io/)                | Explorador de archivos en terminal, rápido y minimalista                              |

---
