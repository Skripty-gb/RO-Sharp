# Instructiuni Instalare RO-Sharp + Extensie VS Code

## 1. Instalare RO-Sharp

### Windows
1. Descarca `interpretor.py`, `install-windows.bat`
2. Pune-le in acelasi folder
3. Ruleaza `install-windows.bat` ca Administrator
4. Redeschide terminalul
5. Testeaza: `rop --ver`

### Linux / Mac
1. Descarca `interpretor.py` si `install-linux-mac.sh`
2. Pune-le in acelasi folder
3. Ruleaza:
```bash
bash install-linux-mac.sh
source ~/.bashrc
```
4. Testeaza: `rop --ver`

### Cerinte
- Python 3.x instalat
- Pentru GUI: tkinter (vine cu Python pe Windows/Mac, pe Linux: `sudo apt install python3-tk` sau `sudo pacman -S tk`)

---

## 2. Extensie VS Code

### Metoda 1 — Instalare manuala (recomandata)
```bash
# Linux/Mac
unzip ro-sharp-vscode.zip
cp -r ro-sharp-vscode ~/.vscode/extensions/ro-sharp
```

Pe Windows copiaza folderul `ro-sharp-vscode` in:
```
C:\Users\<nume>\.vscode\extensions\ro-sharp
```

Reporneste VS Code.

### Metoda 2 — Compilare si instalare cu vsce

**Arch Linux:**
```bash
sudo pacman -S nodejs npm
```

**Ubuntu/Debian:**
```bash
sudo apt install nodejs npm
```

**Windows/Mac:**
Descarca Node.js de la https://nodejs.org

**Apoi pe orice sistem:**
```bash
cd ro-sharp-vscode
npm install -g @vscode/vsce
vsce package
code --install-extension ro-sharp-1.1.0.vsix
```

---

## 3. Rulare fisiere .rop in VS Code

Dupa instalarea extensiei, deschide un fisier `.rop` si:
- Apasa **F5** sau butonul **▶** din bara de titlu
- Sau apasa `Ctrl+Shift+B` daca ai `tasks.json` configurat

### Configurare tasks.json (optional)
Creeaza `.vscode/tasks.json` in folderul proiectului:
```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Run RO-Sharp",
      "type": "shell",
      "command": "python3 ~/.ROSharp/interpretor.py ${file}",
      "group": {
        "kind": "build",
        "isDefault": true
      },
      "presentation": {
        "reveal": "always",
        "panel": "shared"
      }
    }
  ]
}
```

Pe Windows schimba comanda cu:
```json
"command": "python \"%USERPROFILE%\\.ROSharp\\interpretor.py\" ${file}"
```

---

## 4. Dezinstalare

```bash
rop --delete-rop
```

Sau manual:
```bash
# Linux/Mac
rm -rf ~/.ROSharp
# Sterge aliasul din ~/.bashrc

# Windows
# Sterge folderul %USERPROFILE%\.ROSharp
# Ruleaza uninstall-windows.bat
```
