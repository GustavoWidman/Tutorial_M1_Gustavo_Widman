extends Node

# Estas variáveis serão usadas para indicar se as teclas de movimento estão sendo pressionadas ou não.
var leftPress = false
var rightPress = false
var upPress = false
var midPress = false

# Esta variável é usada para verificar se é possível pressionar a tecla central (botão do meio do mouse).
# Ela é inicializada com o valor true, o que significa que o botão pode ser pressionado no início do jogo.
var midPressable = true
