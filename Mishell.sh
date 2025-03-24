
#!/bin/bash

# Definir colores ANSI
GREEN="\e[32m"
BLUE="\e[34m"
CYAN="\e[36m"
YELLOW="\e[33m"
RED="\e[31m"
BOLD="\e[1m"
RESET="\e[0m"

# Encabezado con animación
function show_header {
    clear
    echo -e "${BLUE}======================================"
    echo -e "       🚀 Bienvenido a Mi Shell 🚀"
    echo -e "======================================${RESET}"
    sleep 0.5
}

# Función para mostrar el menú de ayuda
function show_help {
    echo -e "${CYAN}Comandos disponibles:${RESET}"
    echo -e "${YELLOW}  install <ruta1> [<ruta2> ...]${RESET} - Crea directorios y archivos en las rutas dadas"
    echo -e "${YELLOW}  uninstall <ruta1> [<ruta2> ...]${RESET} - Elimina las rutas especificadas"
    echo -e "${YELLOW}  game${RESET} - Juega un minijuego de adivinanza"
    echo -e "${YELLOW}  time${RESET} - Muestra la fecha y la hora actual"
    echo -e "${YELLOW}  web${RESET} - Abre la web en Lynx"
    echo -e "${YELLOW}  art${RESET} - Muestra un dibujito ASCII"
    echo -e "${YELLOW}  history${RESET} - Muestra el historial de comandos"
    echo -e "${YELLOW}  exit${RESET} - Salir de la shell interactiva"
}

# Función para instalar
function install {
    if [ $# -eq 0 ]; then
        echo -e "${RED}Error: Debes especificar al menos una ruta.${RESET}"
        return 1
    fi
    for ruta in "$@"; do
        mkdir -p "$ruta" && touch "$ruta/archivo.txt"
        echo -e "${GREEN}Directorio y archivo creados en $ruta${RESET}"
    done
}

# Función para desinstalar
function uninstall {
    if [ $# -eq 0 ]; then
        echo -e "${RED}Error: Debes especificar al menos una ruta.${RESET}"
        return 1
    fi
    for ruta in "$@"; do
        rm -rf "$ruta"
        echo -e "${RED}Eliminado: $ruta${RESET}"
    done
}

# Minijuego de adivinanza
function game {
    numero=$((RANDOM % 10 + 1))
    intento=-1
    echo -e "${CYAN}Adivina el número (1-10):${RESET}"
    while [[ $intento -ne $numero ]]; do
        read -p "Introduce tu número: " intento
        if ! [[ "$intento" =~ ^[0-9]+$ ]]; then
            echo -e "${RED}Por favor, introduce un número válido.${RESET}"
            continue
        fi
        if [[ $intento -lt $numero ]]; then
            echo -e "${YELLOW}Más alto.${RESET}"
        elif [[ $intento -gt $numero ]]; then
            echo -e "${YELLOW}Más bajo.${RESET}"
        else
            echo -e "${GREEN}¡Correcto!${RESET}"
        fi
    done
}

# Mostrar fecha y hora
function show_time {
    echo -e "${CYAN}Fecha y hora actual:${RESET} $(date)"
}

# Abrir un archivo local en Lynx o mostrarlo con cat si Lynx no está disponible
function web {
    read -p "Introduce la ruta del archivo que quieres abrir: " archivo

    # Verifica si el archivo existe
    if [ ! -f "$archivo" ]; then
        echo -e "${RED}Error: El archivo no existe.${RESET}"
        return 1
    fi

    # Si Lynx está instalado, usarlo para mostrar el archivo, de lo contrario usar cat
    if command -v lynx >/dev/null 2>&1; then
        lynx "$archivo"
    else
        echo -e "${YELLOW}Lynx no está instalado. Mostrando el archivo con cat:${RESET}"
        cat "$archivo"
    fi
}


# Mostrar arte ASCII
function art {
    echo -e "
88XX@8@@S888888S@S8@X@88@8888X@X8888X@8@888@888@888@@@S@8X8888X
8X@8@@88@@88@8X@X@8@88X@8@@888t8t8X888888X@88@888X8@88@8888X888
88X888X@8@@@8X88@88@8@8@88@8@  S88@@@8@X8X888@888888X@88@@88@88
XS8@8888@88@@88XX@88@888@X@t;8 %:88888@8SXS88@8@@888888@8X888X8
8@8@@88@8@8@8@8@8@8@@88@8@t 8@ SS t8X88888@8@8@8@@@@XX8888X8S@S
8888888@888X@8@88@8XX888888.8 .t.@tt8@@888X@8@88X@X@8@8@X88X@@@
@8@8@888@88@88@888888@88.88@S  SX8;88S88@8@88@8@888X@8@8@8@8888
88888888@8@8@88X8@X88.t8  t@88: 8S8%.X888t8S8888@8888@8888@8XXX
8X@8888888XXXXX8S88.;8t8  ..8XSS8@:8888@.88.t@8X@@XXXX8S8888@88
88@XX8S8X8@888S88.%X88S%.  8.8@8S:.X8.8S88@8%%88@@8@8@@8XX8SS88
8S@S@88888@8@8%8 %t 88X@8;   .%;8;: t888S@8.8t;8S88@888@X@@8@X8
@@88XXXX@@8@888:X.t888888X8 8  S888@@@888@88@;X @@@@8@8888X@X@X
@8@8@8@88XX@88X.:8:@888SXX@8 8.@@:X888.@88@@:;:X888888@88X@8888
X@8@88@88@8.8 t88S888S8: ;@X@;888%X8t S@8@8@S8.t;;;8;88S8888@8@
8@XX888888  88@SX@88888t  :X8X%.;88: :8S@888888 S8 ttS888@8X@@X
@8@8X8S;88.X;:8@@8X8@88t  t;8SSX8@..88.S88X8@8SS  88X;8@8888X@8
88X8@XS8 :@8888888888@8;    tS88S :8:8t@@8@8@@8S88 :t ;;8@@8888
8@88@@8.@ t;SS8S88@S@8X% 8  .%S::;8: 8%8888S8@8S8888 88.;SXX@@8
8@@X@X@  8: 8888888@88@88.  . 8;8.88;8S88@88888@@88@8 t88X88@8@
8XX@8@S8:888.S88@88888888X8  %@.@:.%;8@X888888888::.t@8S8X88888
@88@X888@8 t.%;tS@S88888X888   88X88@@X888888@t t%8.%S888@X888@
X888@@888888@ X:t%@@8888888@X8 @8tS@8@88888@8t S@8.88@88@88@88@
@X88@S8@X88S8:8;:t8S@@8888888@88S8S@8888888@88t;:%@XX8X888@8X@@
X@888@@@8@8@X8888  8X8S88888@X888888888@88X8.%8 XX@8@8888X@888@
8X@8@8@888@88@@8:8%%8;88888888@88888888@X88tX8 88S88X@X8@@888@8
@@8888X8@8@8888X8@:@ %@8X888888@888888@8X8:8 X@888888X8S@8@8888
@@S8X8X88@8@@88X8888:tS8888%88@888@888@@:;.8.X888S88X8888XX8@8@
88888888@88888@@8@X88@888888X8XX@@888888:88S888S88@888@88X8X@@8
88@@8@88X888XXX8@@@8888888X88@8888S88888@@888@88888@8X@@8X888S8
88@@XX@8@8888X8S@8@88888@8@88S88@8X8@88X8@88@8XX@XX8888@888@X8X
8@@8@8@8@8@@@888X@8@@8@888@8SX888X@8@8@88@8X8S@@888X888X@8@8@88
88@@@X@@8X8@@88@8X@8@8@@888X888@8t@888@@88X@@@88@X88X@888@8888X
@8@888X88@888@@88888@@8@888@XX@8XS@8X88@888@8X8@@8@888X@XX8S888
8X88@888888X8888X8@8888@8888@88X@88S@X@8@X88@@88@@8X8@8@8@@8XS8
@88@X@XS8@8888@888888X88@888@888X@XXS@8@8@888X888X888@888@@888@
X8@@8@888@88@88888X8@@@88@@888S8888X@8@8@8@8@8888@@88@@8@8X88XX⠀
    "
}

# Shell interactiva
function interactive_shell {
    show_header
    echo -e "${CYAN}Bienvenido a la shell interactiva. Escribe 'help' para ver los comandos.${RESET}"
    HISTFILE=~/.shell_history
    touch "$HISTFILE"
    while true; do
        echo -ne "${BOLD}${BLUE}shell> ${RESET}"
        read input

        # Si el usuario presiona "Enter" sin escribir nada, vuelve a mostrar el prompt
        if [[ -z "$input" ]]; then
            continue
        fi

        echo "$input" >> "$HISTFILE"
        set -- $input
        comando=$1
        shift
        case "$comando" in
            install) install "$@" ;;
            uninstall) uninstall "$@" ;;
            game) game ;;
            time) show_time ;;
            about) about ;;
            art) art ;;
            help) show_help ;;
            history) nl -ba "$HISTFILE" ;;
            exit) echo -e "${GREEN}Saliendo...${RESET}"; break ;;
            *)
                if command -v "$comando" > /dev/null; then
                    "$comando" "$@"
                else
                    echo -e "${RED}Comando no encontrado: $comando${RESET}"
                fi
            ;;
        esac
    done
}

# Ejecutar comandos fuera de la shell interactiva
if [[ $# -gt 0 ]]; then
    comando=$1
    shift
    case "$comando" in
        install) install "$@" ;;
        uninstall) uninstall "$@" ;;
        game) game ;;
        time) show_time ;;
        about) about ;;
        art) art ;;
        help) show_help ;;
        history) nl -ba ~/.shell_history ;;
        exit) echo -e "${GREEN}Saliendo...${RESET}"; exit 0 ;;
        *)
            if command -v "$comando" > /dev/null; then
                "$comando" "$@"
            else
                echo -e "${RED}Comando no encontrado: $comando${RESET}"
            fi
        ;;
    esac
    exit 0
fi

# Iniciar la shell interactiva si no se pasaron argumentos
interactive_shell
