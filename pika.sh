#!/bin/bash
# Hide Termux welcome message
touch ~/.hushlogin

# Function to change themes
change_theme() {
if [[ $themes -eq 1 ]]; then
cat > $HOME/.termux/colors.properties << EOF
background=#300a24
foreground=#ffffff
cursor=#ffffff

color0=#2E3436
color1=#CC0000
color2=#4E9A06
color3=#C4A000
color4=#3465A4
color5=#75507B
color6=#06989A
color7=#D3D7CF

color8=#555753
color9=#EF2929
color10=#8AE234
color11=#FCE94F
color12=#729FCF
color13=#AD7FA8
color14=#34E2E2
color15=#EEEEEC
EOF
elif [[ $themes -eq 2 ]]; then
cat > $HOME/.termux/colors.properties << EOF
background=#0e1019
foreground=#fffaf4
cursor=#fffaf4

color0=#232323
color1=#ff000f
color2=#8ce10b
color3=#ffb900
color4=#008df8
color5=#6d43a6
color6=#00d8eb
color7=#ffffff
color8=#444444
color9=#ff2740
color10=#abe15b
color11=#ffd242
color12=#0092ff
color13=#9a5feb
color14=#67fff0
color15=#ffffff
EOF
elif [[ $themes -eq 3 ]]; then
cat > $HOME/.termux/colors.properties << EOF
background=#263238
foreground=#eceff1

color0=#263238
color8=#37474f
color1=#ff9800
color9=#ffa74d
color2=#8bc34a
color10=#9ccc65
color3=#ffc107
color11=#ffa000
color4=#03a9f4
color12=#81d4fa
color5=#e91e63
color13=#ad1457
color6=#009688
color14=#26a69a
color7=#cfd8dc
color15=#eceff1
EOF
elif [[ $themes -eq 4 ]]; then
cat > $HOME/.termux/colors.properties << EOF
foreground=#f8f8f2
cursor=#f8f8f2
background=#282a36
color0=#000000
color8=#4d4d4d
color1=#ff5555
color9=#ff6e67
color2=#50fa7b
color10=#5af78e
color3=#f1fa8c
color11=#f4f99d
color4=#bd93f9
color12=#caa9fa
color5=#ff79c6
color13=#ff92d0
color6=#8be9fd
color14=#9aedfe
color7=#bfbfbf
color15=#e6e6e6
EOF
elif [[ $themes -eq 5 ]]; then
cat > $HOME/.termux/colors.properties << EOF
foreground=#fff
background=#010101
cursor=#e5e5e5
color0=#1b1d1e
color1=#f92672
color2=#82b414
color3=#fd971f
color4=#4e82aa
color5=#8c54fe
color6=#465457
color7=#ccccc6
color8=#505354
color9=#ff5995
color10=#b6e354
color11=#feed6c
color12=#0c73c2
color13=#9e6ffe
color14=#899ca1
color15=#f8f8f2
EOF
elif [[ $themes -eq 6 ]]; then
cat > $HOME/.termux/colors.properties << EOF
foreground=#d0d0d0
background=#000000
cursor=#d0d0d0
color0=#000000
color1=#ff0000
color2=#33ff00
color3=#ff0099
color4=#0066ff
color5=#cc00ff
color6=#00ffff
color7=#d0d0d0
color8=#808080
color9=#ff0000
color10=#33ff00
color11=#ff0099
color12=#0066ff
color13=#cc00ff
color14=#00ffff
color15=#ffffff
EOF
else
echo "Choose a valid number!"; exit 1
fi
}

enable_features() {
sed -i 's/# terminal-transcript-rows = [0-9]\+/ terminal-transcript-rows = 40000/' "$HOME/.termux/termux.properties"
sed -i 's/# terminal-cursor-blink-rate = [0-9]\+/ terminal-cursor-blink-rate = 500/' "$HOME/.termux/termux.properties"
sed -i 's/# terminal-cursor-style = .\+/ terminal-cursor-style = underline/' "$HOME/.termux/termux.properties"
sed -i 's/# use-black-ui = .\+/ use-black-ui = true/' "$HOME/.termux/termux.properties"
sed -i 's/# bell-character = ignore/ bell-character = ignore/' "$HOME/.termux/termux.properties"
sed -i 's/# shortcut\(.\+\)/ shortcut.\1/g' "$HOME/.termux/termux.properties"
}

etc='/data/data/com.termux/files/usr/etc'
if ! [[ -d "${HOME}/backup/" ]]; then
mkdir "$HOME/backup/"
fi

if [[ -f "${etc}/bash.bashrc" ]]; then
echo "File bash.bashrc exists, restoring..."; mv "${etc}/bash.bashrc" "$HOME/backup/old_bash.bashrc" && echo "Successfully restored: $HOME/backup/old_bash.bashrc"
fi

echo -en "Themes: \n 1. Ubuntu\n 2. Argonaut\n 3. Material\n 4. Dracula\n 5. Nancy\n 6. Isotope\n Choose (1-6): "; read themes
echo -n "Enter your name: "; read usr_name

change_theme
enable_features

cat > "${etc}/bash.bashrc" << EOF
user_name="${usr_name}"
editor="nano"


export GREP_COLOR="1;32"
export MANPAGER="less -R --use-color -Dd+g -Du+b"

# EDITOR
export EDITOR=\$editor
export SUDO_EDITOR=\$editor
export VISUAL="vim"

# USER
export USER=\$user_name
export ETC="/data/data/com.termux/files/usr/etc"


sym="✧〄✧" # symbol of prompt
bar_cr="34" # color of bars
name_cr="37" # color of user & host
end_cr="37" # color of prompt end
dir_cr="36" # color of current directory

PS1='\[\033[0;\${bar_cr}m\]┌──(\[\033[1;\${name_cr}m\]\${user_name}\[\e[31m\]\${sym}\[\e[0m\]\[\e[93m\]\D{%H:%M:%S}\[\e[0m\]\[\033[0;\${bar_cr}m\])-[\[\033[0;\${dir_cr}m\]\w\[\033[0;\${bar_cr}m\]]
\[\033[0;\${bar_cr}m\]└─\[\033[1;\${end_cr}m\]>>\[\033[0m\] '

if [[ -x /usr/bin/dircolors ]]; then
    test -r ~/.dircolors && eval "\$(dircolors -b ~/.dircolors)" || eval "\$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias diff='diff --color=auto'
    alias ip='ip -color'
fi

# Banner for SHAHADAT
echo '███████╗██╗  ██╗ █████╗ ██╗  ██╗ █████╗ ██████╗  █████╗ ████████╗    '
echo '██╔════╝██║  ██║██╔══██╗██║  ██║██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝    '
echo '███████╗███████║███████║███████║███████║██║  ██║███████║   ██║       '
echo '╚════██║██╔══██║██╔══██║██╔══██║██╔══██║██║  ██║██╔══██║   ██║       '
echo '███████║██║  ██║██║  ██║██║  ██║██║  ██║██████╔╝██║  ██║   ██║       '
echo '╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═════╝ ╚═╝  ╚═╝   ╚═╝       '
EOF
